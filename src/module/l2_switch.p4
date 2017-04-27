#define MODULE l2_switch

table dmac {
    
    reads {
        DST_MAC : exact;
    }

    actions {
        forward;
    }

}

MODULE_INGRESS(l2_switch) {
    apply(dmac);
}

#undef MODULE