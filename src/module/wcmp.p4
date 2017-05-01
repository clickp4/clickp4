#define MODULE wcmp

/* Module parameter. */
//-----------------------------
#ifndef WCMP_SELECTOR_WIDTH
#define WCMP_SELECTOR_WIDTH 64
#endif

#ifndef WCMP_HASH_ALG
#define WCMP_HASH_ALG bmv2_hash
#endif 

#ifndef WCMP_HASH_WIDTH
#define WCMP_HASH_WIDTH 64
#endif

#ifndef WCMP_HASH_FIELDS
#define WCMP_HASH_FIELDS \
    ipv4.src_addr; \
    ipv4.dst_addr; \
    ipv4.proto;    \ 
    tcp.src_port;  \
    tcp.dst_port;  \
    udp.src_port;  \
    udp.dst_port
#endif

//---------------------------

header_type wcmp_meta_t {
    fields {
        group_id : 16;
        n_bits: 8;
        selector : WCMP_SELECTOR_WIDTH;
    }
}

metadata wcmp_meta_t wcmp_meta;

field_list wcmp_hash_fields {
	WCMP_HASH_FIELDS;
}

field_list_calculation wcmp_hash {
    input {
        wcmp_hash_fields;
    }
    algorithm : WCMP_HASH_ALG;
    output_width : WCMP_HASH_WIDTH;
}

action wcmp_group(id) {
    modify_field(wcmp_meta.group_id, id);
    modify_field_with_hash_based_offset(wcmp_meta.n_bits, 2, wcmp_hash, (WCMP_SELECTOR_WIDTH - 2));
}

action wcmp_set_selector() {
    modify_field(wcmp_meta.selector,
                 (((1 << wcmp_meta.n_bits) - 1) << (WCMP_SELECTOR_WIDTH - wcmp_meta.numBits)));
}

table wcmp_tbl {
    reads {
        standard_metadata.ingress_port : ternary;
        ethernet.dst_addr : ternary;
        ethernet.src_addr : ternary;
        ethernet.eth_type : ternary;
    }
    actions {
        forward;
        wcmp_group;
        send_to_cpu;
        block;
    }
    support_timeout: true;
}

table wcmp_set_selector_table {
    actions {
        wcmp_set_selector;
    }
}

table wcmp_group_table {
    reads {
        wcmp_meta.group_id : exact;
        wcmp_meta.selector : lpm;
    }
    actions {
        set_egress_port;
    }
}

MODULE_INGRESS(wcmp) {
    apply(wcmp_tbl) {
        wcmp_group {
            apply(wcmp_set_selector_table) {
                wcmp_set_selector {
                    apply(wcmp_group_table);
                }
            }
        }
    }
}

#undef WCMP_SELECTOR_WIDTH
#undef MODULE