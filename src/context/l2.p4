/*
 * Layer-2 processing
 */

header_type l2_metadata_t {
    fields {
        lkp_mac_sa : 48;
        lkp_mac_da : 48;
        lkp_pkt_type : 3;
        lkp_mac_type : 16;
        lkp_pcp: 3;

        l2_nexthop : 16;                       /* next hop from l2 */
        l2_nexthop_type : 2;                   /* ecmp or nexthop */
        l2_redirect : 1;                       /* l2 redirect action */
        l2_src_miss : 1;                       /* l2 source miss */
        l2_src_move : IFINDEX_BIT_WIDTH;       /* l2 source interface mis-match */
        stp_group: 10;                         /* spanning tree group id */
        stp_state : 3;                         /* spanning tree port state */
        bd_stats_idx : 16;                     /* ingress BD stats index */
        learning_enabled : 1;                  /* is learning enabled */
        port_vlan_mapping_miss : 1;            /* port vlan mapping miss */
        same_if_check : IFINDEX_BIT_WIDTH;     /* same interface check */
    }
}

metadata l2_metadata_t l2_metadata;