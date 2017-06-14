#define MODULE l3_switch

/* Context Dependency */
#if L3_SWITCH_BYPASS == 1
#ifndef SECURITY_CONTEXT
#include "../context/security.p4"
#endif
#endif

/* Module parameter  */
#ifndef L3_SWITCH_TABLE_SIZE 
#define L3_SWITCH_TABLE_SIZE 1024
#endif

#ifndef L3_SWITCH_CHECKSUM
#define L3_SWITCH_CHECKSUM 1
#endif

#ifndef L3_SWITCH_BYPASS 
#define L3_SWITCH_BYPASS 1
#endif

#if L3_SWITCH_CHECKSUM == 1
field_list ipv4_checksum_list {
        ipv4.version;
        ipv4.ihl;
        ipv4.diffserv;
        ipv4.total_len;
        ipv4.identification;
        ipv4.flags;
        ipv4.frag_offset;
        ipv4.ttl;
        ipv4.proto;
        ipv4.src_addr;
        ipv4.dst_addr;
}

field_list_calculation ipv4_checksum {
    input {
        ipv4_checksum_list;
    }
    algorithm : csum16;
    output_width : 16;
}

calculated_field ipv4.checksum  {
    verify ipv4_checksum;
    update ipv4_checksum;
}
#endif

/**
 * Private metadata
 */
header_type l3_switch_metadata_t {
    fields {
        nhop_ipv4 : 32;
    }
}
metadata l3_switch_metadata_t l3_switch_metadata;

action set_nhop(nhop_ipv4) {
    modify_field(l3_switch_metadata.nhop_ipv4, nhop_ipv4);
    add_to_field(ipv4.ttl, -1);
}

table ipv4_nhop {
    reads {
        ipv4.dst_addr : lpm;
    }
    actions {
        set_nhop;
        //block;
    }
    size: L3_SWITCH_TABLE_SIZE;
}

action set_dmac(dmac, port) {
    modify_field(ethernet.dst_addr, dmac);
    forward(port);
}

table forward_table {
    reads {
        l3_switch_metadata.nhop_ipv4 : exact;
    }
    actions {
        set_dmac;
    }
    size: L3_SWITCH_TABLE_SIZE;
}

action set_smac(smac) {
    modify_field(ethernet.src_addr, smac);
}

table send_frame {
    reads {
        standard_metadata.egress_spec: exact;
    }
    actions {
        set_smac;
        block_;
    }
    size: L3_SWITCH_TABLE_SIZE;
}
///////////////////////////

#ifndef IF_TBL_SZ
#define IF_TBL_SZ 512
#endif

action if_branch(state, bitmap) {
    SET_CLICK_STATE(state);
    SET_CLICK_BITMAP(bitmap);
}

table if_small {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
         if_branch;
    }
    size : IF_TBL_SZ;
}

table if_equal {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
        if_branch;
    } 
    size : IF_TBL_SZ;
}

table if_large {
    reads {
        click_metadata.click_id : exact;
    }
    actions {
         if_branch;
    }
    size : IF_TBL_SZ;
}

action sub() {
    // add_to_field(if_metadata.right, 255);
    subtract_from_field(if_metadata.left, if_metadata.right);
}

table if_sub {
    actions {
        sub;
    }
}
///////////////////////////
MODULE_INGRESS(l3_switch) {
#if L3_SWITCH_BYPASS == 1
    if (security_metadata.state != SEC_STATE_DENY) {
#endif
        if(valid(ipv4)) {
            if (ipv4.ttl != 0) {
                apply(ipv4_nhop);
                apply(forward_table);
                apply(send_frame);
            }
        }

#if L3_SWITCH_BYPASS == 1
    }
#endif
}

#undef L3_SWITCH_TABLE_SIZE
#undef L3_SWITCH_TBL_SIZE
#undef MODULE
