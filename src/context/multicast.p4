#ifndef __CLICK_CONTEXT_MULTICAST__
#define __CLICK_CONTEXT_MULTICAST__

/*
 * Multicast processing
 */
#define BD_BIT_WIDTH 16
header_type multicast_metadata_t {
    fields {
        ipv4_mcast_key_type : 1;               /* 0 bd, 1 vrf */
        ipv4_mcast_key : BD_BIT_WIDTH;         /* bd or vrf value */
        ipv6_mcast_key_type : 1;               /* 0 bd, 1 vrf */
        ipv6_mcast_key : BD_BIT_WIDTH;         /* bd or vrf value */
        outer_mcast_route_hit : 1;             /* hit in the outer multicast table */
        outer_mcast_mode : 2;                  /* multicast mode from route */
        mcast_route_hit : 1;                   /* hit in the multicast route table */
        mcast_bridge_hit : 1;                  /* hit in the multicast bridge table */
        ipv4_multicast_enabled : 1;            /* is ipv4 multicast enabled on BD */
        ipv6_multicast_enabled : 1;            /* is ipv6 multicast enabled on BD */
        igmp_snooping_enabled : 1;             /* is IGMP snooping enabled on BD */
        mld_snooping_enabled : 1;              /* is MLD snooping enabled on BD */
        bd_mrpf_group : BD_BIT_WIDTH;          /* rpf group from bd lookup */
        mcast_rpf_group : BD_BIT_WIDTH;        /* rpf group from mcast lookup */
        mcast_mode : 2;                        /* multicast mode from route */
        multicast_route_mc_index : 16;         /* multicast index from mfib */
        multicast_bridge_mc_index : 16;        /* multicast index from igmp/mld snoop */
        inner_replica : 1;                     /* is copy is due to inner replication */
        replica : 1;                           /* is this a replica */
#ifdef FABRIC_ENABLE
        mcast_grp : 16;
#endif /* FABRIC_ENABLE */
    }
}

metadata multicast_metadata_t multicast_metadata;

#endif