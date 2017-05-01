#define MODULE l2_switch

/* Module parameter */
#ifndef L2_SWITCH_LEARN
#define L2_SWITCH_LEARN 1
#endif 

#ifndef MAC_LEARN_RECEIVER
#define MAC_LEARN_RECEIVER 1
#endif


#if L2_SWITCH_LEARN == 1
field_list mac_learn_digest {
	standard_metadata.ingress_port;
    ethernet.src_addr;
}

action mac_learn() {
    generate_digest(MAC_LEARN_RECEIVER, mac_learn_digest);
}


table smac {
    reads {
        ethernet.src_addr : exact;
    }
    actions {
        nop;
        mac_learn;
    }
    size : MAC_TABLE_SIZE;
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
    size : MAC_TABLE_SIZE;
}

MODULE_INGRESS(l2_switch) {
#if L2_SWITCH_LEARN == 1
    apply(smac);
#endif
    
    apply(dmac);
}

#undef L2_SWITCH_LEARN
#undef MODULE