/**
 * IP ACL
 * P4 73
 * ClickP4 75
 * Modified 11+1+1
 */
#define MODULE ip_acl
#ifndef IPV4_DISABLE
table ip_acl {
    reads {
        acl_metadata.if_label : ternary;
        acl_metadata.bd_label : ternary;

        IPv4_SRC_ADDR : ternary;
        IPv4_DST_ADDR : ternary;
        IPv4_PROTO : ternary;
        acl_metadata.ingress_src_port_range_id : exact;
        acl_metadata.ingress_dst_port_range_id : exact;

        tcp.flags : ternary;
        ipv4.ttl : ternary;
    }
    actions {
        nop;
        acl_deny;
        acl_permit;
        acl_redirect_nexthop;
        acl_redirect_ecmp;
#ifndef MIRROR_DISABLE
        acl_mirror;
#endif /* MIRROR_DISABLE */
    }
    size : 1024;
}
#endif /* IPV4_DISABLE */

#ifndef IPV6_DISABLE
table ipv6_acl {
    reads {
        acl_metadata.if_label : ternary;
        acl_metadata.bd_label : ternary;

        IPv6_SRC_ADDR : ternary;
        IPv6_DST_ADDR : ternary;
        IPv6_NEXT_HDR : ternary;
        acl_metadata.ingress_src_port_range_id : exact;
        acl_metadata.ingress_dst_port_range_id : exact;

        tcp.flags : ternary;
        ipv6.ttl : ternary;
    }
    actions {
        nop;
        acl_deny;
        acl_permit;
        acl_redirect_nexthop;
        acl_redirect_ecmp;
#ifndef MIRROR_DISABLE
        acl_mirror;
#endif /* MIRROR_DISABLE */
    }
    size : 1024;
}
#endif /* IPV6_DISABLE */

MODULE_INGRESS(ip_acl) {
    if (DO_LOOKUP(ACL)) {
        if (ETH_TYPE == ETH_TYPE_IPv4) {
#ifndef IPV4_DISABLE
            apply(ip_acl);
#endif /* IPV4_DISABLE */
        } else {
            if (ETH_TYPE == ETH_TYPE_IPv6) {
#ifndef IPV6_DISABLE
                apply(ipv6_acl);
#endif /* IPV6_DISABLE */
            }
        }
    }
}
#undef MODULE