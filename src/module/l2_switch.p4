#define MODULE l2_switch

MODULE_ACTION(l2_switch, forward)(port) {
    modify_field(standard_metadata.egress_spec, port);
}

MODULE_TABLE(l2_switch, dmac) {
    
    reads {
        ethernet.src_addr : exact;
    }

    actions {
        APPLY_ACTION(l2_switch, forward);
    }

}

MODULE_INGRESS(l2_switch) {
    APPLY_TABLE(l2_switch, dmac);
}

#undef MODULE