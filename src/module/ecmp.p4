#ifndef MODULE
#define MODULE ecmp
/**
 * ECMP Module
 * A simple ecmp feature.
 */

/**
 * ECMP module parameters and their default values.
 */
#ifndef ECMP_HASH_ALG
#define ECMP_HASH_ALG bmv2_hash
#endif 

#ifndef ECMP_HASH_WIDTH
#define ECMP_HASH_WIDTH 64
#endif

#ifndef ECMP_HASH_FIELDS 

#ifdef L4_METADATA
#define ECMP_HASH_FIELDS \
    ipv4.src_addr; \
    ipv4.dst_addr; \
    ipv4.proto;    \
    l4_metadata.src_port;  \
    l4_metadata.dst_port;
#else
#define ECMP_HASH_FIELDS \
    ipv4.src_addr; \
    ipv4.dst_addr; \
    ipv4.proto;    \
    tcp.src_port;  \
    tcp.dst_port;  \
    udp.src_port;  \
    udp.dst_port;
#endif
#endif

header_type ecmp_metadata_t {
    fields {
        group_id : 16;
        selector : 16;
    }
}

metadata ecmp_metadata_t ecmp_metadata;

field_list ecmp_hash_fields {
    ECMP_HASH_FIELDS
}

field_list_calculation ecmp_hash {
    input {
        ecmp_hash_fields;
    }
    algorithm : ECMP_HASH_ALG;
    output_width : ECMP_HASH_WIDTH;
}

action ecmp_group(id, sz) {
    modify_field(ecmp_metadata.group_id, id);
    modify_field_with_hash_based_offset(ecmp_metadata.selector, 0, ecmp_hash, sz);
}

table ecmp_tbl {
    reads {
        standard_metadata.ingress_port : ternary;
        ethernet.dst_addr : ternary;
        ethernet.src_addr : ternary;
        ethernet.eth_type : ternary;
    }
    actions {
        forward;
        ecmp_group;
        send_to_cpu;
        block;
    }
    support_timeout: true;
}

table ecmp_group_table {
    reads {
        ecmp_metadata.group_id : exact;
        ecmp_metadata.selector : exact;
    }
    actions {
        forward;
    }
}

MODULE_INGRESS(ecmp) {
    apply(ecmp_tbl) {
        ecmp_group {
            apply(ecmp_group_table);
        }
    }
}

#undef ECMP_HASH_ALG
#undef ECMP_HASH_FIELDS
#undef ECMP_HASH_WIDTH
#undef MODULE
#endif