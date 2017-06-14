#define MODULE l2_switch

/* Module parameters */
#ifndef L2_SWITCH_LEARN
#define L2_SWITCH_LEARN 0
#endif 

#ifndef L2_SWITCH_SMAC_TABLE_SIZE
#define L2_SWITCH_SMAC_TABLE_SIZE 1024
#endif

#ifndef L2_SWITCH_DMAC_TABLE_SIZE
#define L2_SWITCH_DMAC_TABLE_SIZE 1024
#endif

#if L2_SWITCH_LEARN == 1
field_list mac_learn_digest {
	standard_metadata.ingress_port;
    ethernet.src_addr;
}

action mac_learn(receiver) {
    generate_digest(receiver, mac_learn_digest);
}

table smac {
    reads {
        ethernet.src_addr : exact;
    }
    actions {
        nop;
        mac_learn;
    }
    size : L2_SWITCH_SMAC_TABLE_SIZE;
}
#endif

table dmac {
    reads {
        ethernet.dst_addr : exact;
    }
    actions {
    	forward;
    	flood;
    }
    size : L2_SWITCH_DMAC_TABLE_SIZE;
}

MODULE_INGRESS(l2_switch) {
#if L2_SWITCH_LEARN == 1
    apply(smac);
#endif
    apply(dmac);
}

#undef L2_SWITCH_SMAC_TABLE_SIZE
#undef L2_SWITCH_DMAC_TABLE_SIZE
#undef L2_SWITCH_LEARN