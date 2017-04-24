/**
 * Outer multicast
 * P4      197
 * ClickP4 199
 * Modified 4
 */
#define MODULE outer_multicast
#if !defined(TUNNEL_DISABLE) && !defined(MULTICAST_DISABLE)
action outer_multicast_rpf_check_pass() {
    modify_field(tunnel_metadata.tunnel_terminate, TRUE);
    //modify_field(l3_metadata.outer_routed, TRUE); // TODO
}

table outer_multicast_rpf {
    reads {
        multicast_metadata.mcast_rpf_group : exact;
        multicast_metadata.bd_mrpf_group : exact;
    }
    actions {
        nop;
        outer_multicast_rpf_check_pass;
    }
    size : OUTER_MCAST_RPF_TABLE_SIZE;
}
#endif /* !TUNNEL_DISABLE && !MULTICAST_DISABLE */

control process_outer_multicast_rpf {
#if !defined(OUTER_PIM_BIDIR_OPTIMIZATION)
    /* outer mutlicast RPF check - sparse and bidir */
    if (multicast_metadata.outer_mcast_route_hit == TRUE) {
        apply(outer_multicast_rpf);
    }
#endif /* !OUTER_PIM_BIDIR_OPTIMIZATION */
}


/*****************************************************************************/
/* Outer IP mutlicast lookup actions                                         */
/*****************************************************************************/
#if !defined(TUNNEL_DISABLE) && !defined(MULTICAST_DISABLE)
action outer_multicast_bridge_star_g_hit(mc_index) {
    modify_field(intrinsic_metadata.mcast_grp, mc_index);
    modify_field(tunnel_metadata.tunnel_terminate, TRUE);
#ifdef FABRIC_ENABLE
    modify_field(fabric_metadata.dst_device, FABRIC_DEVICE_MULTICAST);
#endif /* FABRIC_ENABLE */
}

action outer_multicast_bridge_s_g_hit(mc_index) {
    modify_field(intrinsic_metadata.mcast_grp, mc_index);
    modify_field(tunnel_metadata.tunnel_terminate, TRUE);
#ifdef FABRIC_ENABLE
    modify_field(fabric_metadata.dst_device, FABRIC_DEVICE_MULTICAST);
#endif /* FABRIC_ENABLE */
}

action outer_multicast_route_sm_star_g_hit(mc_index, mcast_rpf_group) {
    modify_field(multicast_metadata.outer_mcast_mode, MCAST_MODE_SM);
    modify_field(intrinsic_metadata.mcast_grp, mc_index);
    modify_field(multicast_metadata.outer_mcast_route_hit, TRUE);
    bit_xor(multicast_metadata.mcast_rpf_group, mcast_rpf_group,
            multicast_metadata.bd_mrpf_group);
#ifdef FABRIC_ENABLE
    modify_field(fabric_metadata.dst_device, FABRIC_DEVICE_MULTICAST);
#endif /* FABRIC_ENABLE */
}

action outer_multicast_route_bidir_star_g_hit(mc_index, mcast_rpf_group) {
    modify_field(multicast_metadata.outer_mcast_mode, MCAST_MODE_BIDIR);
    modify_field(intrinsic_metadata.mcast_grp, mc_index);
    modify_field(multicast_metadata.outer_mcast_route_hit, TRUE);
#ifdef OUTER_PIM_BIDIR_OPTIMIZATION
    bit_or(multicast_metadata.mcast_rpf_group, mcast_rpf_group,
           multicast_metadata.bd_mrpf_group);
#else
    modify_field(multicast_metadata.mcast_rpf_group, mcast_rpf_group);
#endif
#ifdef FABRIC_ENABLE
    modify_field(fabric_metadata.dst_device, FABRIC_DEVICE_MULTICAST);
#endif /* FABRIC_ENABLE */
}

action outer_multicast_route_s_g_hit(mc_index, mcast_rpf_group) {
    modify_field(intrinsic_metadata.mcast_grp, mc_index);
    modify_field(multicast_metadata.outer_mcast_route_hit, TRUE);
    bit_xor(multicast_metadata.mcast_rpf_group, mcast_rpf_group,
            multicast_metadata.bd_mrpf_group);
#ifdef FABRIC_ENABLE
    modify_field(fabric_metadata.dst_device, FABRIC_DEVICE_MULTICAST);
#endif /* FABRIC_ENABLE */
}
#endif /* !TUNNEL_DISABLE && !MULTICAST_DISABLE */


/*****************************************************************************/
/* Outer IPv4 multicast lookup                                               */
/*****************************************************************************/
#if  !defined(TUNNEL_DISABLE) && !defined(MULTICAST_DISABLE) && !defined(IPV4_DISABLE)
table outer_ipv4_multicast_star_g {
    reads {
        multicast_metadata.ipv4_mcast_key_type : exact;
        multicast_metadata.ipv4_mcast_key : exact;
        ipv4.dstAddr : ternary;
    }
    actions {
        nop;
        outer_multicast_route_sm_star_g_hit;
        outer_multicast_route_bidir_star_g_hit;
        outer_multicast_bridge_star_g_hit;
    }
    size : OUTER_MULTICAST_STAR_G_TABLE_SIZE;
}

table outer_ipv4_multicast {
    reads {
        multicast_metadata.ipv4_mcast_key_type : exact;
        multicast_metadata.ipv4_mcast_key : exact;
        ipv4.srcAddr : exact;
        ipv4.dstAddr : exact;
    }
    actions {
        nop;
        on_miss;
        outer_multicast_route_s_g_hit;
        outer_multicast_bridge_s_g_hit;
    }
    size : OUTER_MULTICAST_S_G_TABLE_SIZE;
}
#endif /* !TUNNEL_DISABLE && !MULTICAST_DISABLE && !IPV4_DISABLE */

control process_outer_ipv4_multicast {
#if  !defined(TUNNEL_DISABLE) && !defined(MULTICAST_DISABLE) && !defined(IPV4_DISABLE)
    /* check for ipv4 multicast tunnel termination  */
    apply(outer_ipv4_multicast) {
        on_miss {
            apply(outer_ipv4_multicast_star_g);
        }
    }
#endif /* !TUNNEL_DISABLE && !MULTICAST_DISABLE && !IPV4_DISABLE */
}


/*****************************************************************************/
/* Outer IPv6 multicast lookup                                               */
/*****************************************************************************/
#if !defined(TUNNEL_DISABLE) && !defined(MULTICAST_DISABLE) && !defined(IPV6_DISABLE)
table outer_ipv6_multicast_star_g {
    reads {
        multicast_metadata.ipv6_mcast_key_type : exact;
        multicast_metadata.ipv6_mcast_key : exact;
        ipv6.dstAddr : ternary;
    }
    actions {
        nop;
        outer_multicast_route_sm_star_g_hit;
        outer_multicast_route_bidir_star_g_hit;
        outer_multicast_bridge_star_g_hit;
    }
    size : OUTER_MULTICAST_STAR_G_TABLE_SIZE;
}

table outer_ipv6_multicast {
    reads {
        multicast_metadata.ipv6_mcast_key_type : exact;
        multicast_metadata.ipv6_mcast_key : exact;
        ipv6.srcAddr : exact;
        ipv6.dstAddr : exact;
    }
    actions {
        nop;
        on_miss;
        outer_multicast_route_s_g_hit;
        outer_multicast_bridge_s_g_hit;
    }
    size : OUTER_MULTICAST_S_G_TABLE_SIZE;
}
#endif /* !TUNNEL_DISABLE && !MULTICAST_DISABLE && !IPV6_DISABLE */

control process_outer_ipv6_multicast {
#if !defined(TUNNEL_DISABLE) && !defined(MULTICAST_DISABLE) && !defined(IPV6_DISABLE)
    /* check for ipv6 multicast tunnel termination  */
    apply(outer_ipv6_multicast) {
        on_miss {
            apply(outer_ipv6_multicast_star_g);
        }
    }
#endif /* !TUNNEL_DISABLE && !MULTICAST_DISABLE && !IPV6_DISABLE */
}


/*****************************************************************************/
/* Process outer IP multicast                                                */
/*****************************************************************************/
MODULE_INGRESS(outer_multicast) {
#if !defined(TUNNEL_DISABLE) && !defined(MULTICAST_DISABLE)
    if (valid(ipv4)) {
        process_outer_ipv4_multicast();
    } else {
        if (valid(ipv6)) {
            process_outer_ipv6_multicast();
        }
    }
    process_outer_multicast_rpf();
#endif /* !TUNNEL_DISABLE && !MULTICAST_DISABLE */
}
#undef MODULE