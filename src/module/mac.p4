/**
 * P4 97
 * ClickP4 99
 * Modified 10
 */
#define MODULE mac
#ifndef L2_DISABLE
/*****************************************************************************/
/* Source MAC lookup                                                         */
/*****************************************************************************/
action smac_miss() {
    modify_field(l2_metadata.l2_src_miss, TRUE);
}

action smac_hit(ifindex) {
    bit_xor(l2_metadata.l2_src_move, ingress_metadata.ifindex, ifindex);
}

table smac {
    reads {
        ingress_metadata.bd : exact;
        SRC_MAC : exact;
    }
    actions {
        nop;
        smac_miss;
        smac_hit;
    }
    size : MAC_TABLE_SIZE;
}

/*****************************************************************************/
/* Destination MAC lookup                                                    */
/*****************************************************************************/
action dmac_hit(ifindex) {
    modify_field(ingress_metadata.egress_ifindex, ifindex);
    bit_xor(l2_metadata.same_if_check, l2_metadata.same_if_check, ifindex);
}

action dmac_multicast_hit(mc_index) {
    modify_field(intrinsic_metadata.mcast_grp, mc_index);
#ifdef FABRIC_ENABLE
    modify_field(fabric_metadata.dst_device, FABRIC_DEVICE_MULTICAST);
#endif /* FABRIC_ENABLE */
}

action dmac_miss() {
    modify_field(ingress_metadata.egress_ifindex, IFINDEX_FLOOD);
#ifdef FABRIC_ENABLE
    modify_field(fabric_metadata.dst_device, FABRIC_DEVICE_MULTICAST);
#endif /* FABRIC_ENABLE */
}

action dmac_redirect_nexthop(nexthop_index) {
    modify_field(l2_metadata.l2_redirect, TRUE);
    modify_field(l2_metadata.l2_nexthop, nexthop_index);
    modify_field(l2_metadata.l2_nexthop_type, NEXTHOP_TYPE_SIMPLE);
}

action dmac_redirect_ecmp(ecmp_index) {
    modify_field(l2_metadata.l2_redirect, TRUE);
    modify_field(l2_metadata.l2_nexthop, ecmp_index);
    modify_field(l2_metadata.l2_nexthop_type, NEXTHOP_TYPE_ECMP);
}

action dmac_drop() {
    drop();
}

table dmac {
    reads {
        ingress_metadata.bd : exact;
        DST_MAC : exact;
    }
    actions {
#ifdef OPENFLOW_ENABLE
        openflow_apply;
        openflow_miss;
#endif /* OPENFLOW_ENABLE */
        nop;
        dmac_hit;
        dmac_multicast_hit;
        dmac_miss;
        dmac_redirect_nexthop;
        dmac_redirect_ecmp;
        dmac_drop;
    }
    size : MAC_TABLE_SIZE;
    support_timeout: true;
}
#endif /* L2_DISABLE */

MODULE_INGRESS(mac) {
#ifndef L2_DISABLE
    //if (DO_LOOKUP(SMAC_CHK) and
    //    (ingress_metadata.port_type == PORT_TYPE_NORMAL)) {
        apply(smac);
    //}
    //if (DO_LOOKUP(L2)) {
        apply(dmac);
    //}
#endif /* L2_DISABLE */
}
#undef MODULE