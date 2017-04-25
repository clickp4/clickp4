/**
 * P4 28 
 * ClickP4 30
 * Modified 3
 */
#define MODULE spanning_tree
#ifndef L2_DISABLE
/*****************************************************************************/
/* Spanning tree lookup                                                      */
/*****************************************************************************/
action set_stp_state(stp_state) {
    modify_field(l2_metadata.stp_state, stp_state);
}

table spanning_tree {
    reads {
        ingress_metadata.ifindex : exact;
        l2_metadata.stp_group: exact;
    }
    actions {
        set_stp_state;
    }
    size : SPANNING_TREE_TABLE_SIZE;
}
#endif /* L2_DISABLE */

MODULE_INGRESS(spanning_tree) {
#ifndef L2_DISABLE
    if ((ingress_metadata.port_type == PORT_TYPE_NORMAL) and
        (l2_metadata.stp_group != STP_GROUP_NONE)) {
        apply(spanning_tree);
    }
#endif /* L2_DISABLE */
}
#undef MODULE