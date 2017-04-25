/**
 * P4 97
 * ClickP4 99
 * Modified 3
 */
#define MODULE mpls
#if !defined(TUNNEL_DISABLE) && !defined(MPLS_DISABLE)
/*****************************************************************************/
/* MPLS lookup/forwarding                                                    */
/*****************************************************************************/
action terminate_eompls(bd, tunnel_type) {
    modify_field(tunnel_metadata.tunnel_terminate, TRUE);
    modify_field(tunnel_metadata.ingress_tunnel_type, tunnel_type);
    modify_field(ingress_metadata.bd, bd);

    modify_field(l2_metadata.lkp_mac_type, inner_ethernet.etherType);
}

action terminate_vpls(bd, tunnel_type) {
    modify_field(tunnel_metadata.tunnel_terminate, TRUE);
    modify_field(tunnel_metadata.ingress_tunnel_type, tunnel_type);
    modify_field(ingress_metadata.bd, bd);

    modify_field(l2_metadata.lkp_mac_type, inner_ethernet.etherType);
}

#ifndef IPV4_DISABLE
action terminate_ipv4_over_mpls(vrf, tunnel_type) {
    modify_field(tunnel_metadata.tunnel_terminate, TRUE);
    modify_field(tunnel_metadata.ingress_tunnel_type, tunnel_type);
    modify_field(l3_metadata.vrf, vrf);

    modify_field(l2_metadata.lkp_mac_sa, ethernet.srcAddr);
    modify_field(l2_metadata.lkp_mac_da, ethernet.dstAddr);
    modify_field(l3_metadata.lkp_ip_type, IPTYPE_IPV4);
    modify_field(l2_metadata.lkp_mac_type, inner_ethernet.etherType);
    modify_field(l3_metadata.lkp_ip_version, inner_ipv4.version);
#ifdef QOS_DISABLE
    modify_field(l3_metadata.lkp_dscp, inner_ipv4.diffserv);
#endif /* QOS_DISABLE */
}
#endif /* IPV4_DISABLE */

#ifndef IPV6_DISABLE
action terminate_ipv6_over_mpls(vrf, tunnel_type) {
    modify_field(tunnel_metadata.tunnel_terminate, TRUE);
    modify_field(tunnel_metadata.ingress_tunnel_type, tunnel_type);
    modify_field(l3_metadata.vrf, vrf);

    modify_field(l2_metadata.lkp_mac_sa, ethernet.srcAddr);
    modify_field(l2_metadata.lkp_mac_da, ethernet.dstAddr);
    modify_field(l3_metadata.lkp_ip_type, IPTYPE_IPV6);
    modify_field(l2_metadata.lkp_mac_type, inner_ethernet.etherType);
    modify_field(l3_metadata.lkp_ip_version, inner_ipv6.version);
#ifdef QOS_DISABLE
    modify_field(l3_metadata.lkp_dscp, inner_ipv6.trafficClass);
#endif /* QOS_DISABLE */
}
#endif /* IPV6_DISABLE */

action terminate_pw(ifindex) {
    modify_field(ingress_metadata.egress_ifindex, ifindex);

    modify_field(l2_metadata.lkp_mac_sa, ethernet.srcAddr);
    modify_field(l2_metadata.lkp_mac_da, ethernet.dstAddr);
}

action forward_mpls(nexthop_index) {
    modify_field(l3_metadata.fib_nexthop, nexthop_index);
    modify_field(l3_metadata.fib_nexthop_type, NEXTHOP_TYPE_SIMPLE);
    modify_field(l3_metadata.fib_hit, TRUE);

    modify_field(l2_metadata.lkp_mac_sa, ethernet.srcAddr);
    modify_field(l2_metadata.lkp_mac_da, ethernet.dstAddr);
}

table mpls {
    reads {
        tunnel_metadata.mpls_label: exact;
        inner_ipv4: valid;
        inner_ipv6: valid;
    }
    actions {
        terminate_eompls;
        terminate_vpls;
#ifndef IPV4_DISABLE
        terminate_ipv4_over_mpls;
#endif /* IPV4_DISABLE */
#ifndef IPV6_DISABLE
        terminate_ipv6_over_mpls;
#endif /* IPV6_DISABLE */
        terminate_pw;
        forward_mpls;
    }
    size : MPLS_TABLE_SIZE;
}
#endif /* TUNNEL_DISABLE && MPLS_DISABLE */

MODULE_INGRESS(mpls) {
#if !defined(TUNNEL_DISABLE) && !defined(MPLS_DISABLE)
    apply(mpls);
#endif /* TUNNEL_DISABLE && MPLS_DISABLE */
}
#undef MODULE