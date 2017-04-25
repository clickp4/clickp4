/**
 * P4 35 
 * ClickP4 37
 * Modified 3
 */
#define MODULE mac_learning
#ifndef L2_DISABLE
/*****************************************************************************/
/* MAC learn notification                                                    */
/*****************************************************************************/
field_list mac_learn_digest {
    ingress_metadata.bd;
    l2_metadata.lkp_mac_sa;
    ingress_metadata.ifindex;
}

action generate_learn_notify() {
    generate_digest(MAC_LEARN_RECEIVER, mac_learn_digest);
}

table learn_notify {
    reads {
        l2_metadata.l2_src_miss : ternary;
        l2_metadata.l2_src_move : ternary;
        l2_metadata.stp_state : ternary;
    }
    actions {
        nop;
        generate_learn_notify;
    }
    size : LEARN_NOTIFY_TABLE_SIZE;
}
#endif /* L2_DISABLE */

control process_mac_learning {
#ifndef L2_DISABLE
    if (l2_metadata.learning_enabled == TRUE) {
        apply(learn_notify);
    }
#endif /* L2_DISABLE */
}
#undef MODULE