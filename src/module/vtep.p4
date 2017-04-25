/**
 * VTEP
 * P4 98
 * CLickP4 108
 * Modified 9
 */
#define MOUDLE vtep
#ifndef TUNNEL_DISABLE
/*****************************************************************************/
/* IPv4 source and destination VTEP lookups                                  */
/*****************************************************************************/
action set_tunnel_termination_flag() {
    modify_field(tunnel_metadata.tunnel_terminate, TRUE);
}

action set_tunnel_vni_and_termination_flag(tunnel_vni) {
    modify_field(tunnel_metadata.tunnel_vni, tunnel_vni);
    modify_field(tunnel_metadata.tunnel_terminate, TRUE);
}
action src_vtep_hit(ifindex) {
    modify_field(ingress_metadata.ifindex, ifindex);
}

#ifndef IPV4_DISABLE
table ipv4_dest_vtep {
    reads {
        l3_metadata.vrf : exact;
        ipv4.dstAddr : exact;
        tunnel_metadata.ingress_tunnel_type : exact;
    }
    actions {
        nop;
        set_tunnel_termination_flag;
        set_tunnel_vni_and_termination_flag;
    }
    size : DEST_TUNNEL_TABLE_SIZE;
}

table ipv4_src_vtep {
    reads {
        l3_metadata.vrf : exact;
        ipv4.srcAddr : exact;
        tunnel_metadata.ingress_tunnel_type : exact;
    }
    actions {
        on_miss;
        src_vtep_hit;
    }
    size : IPV4_SRC_TUNNEL_TABLE_SIZE;
}
#endif /* IPV4_DISABLE */


#ifndef IPV6_DISABLE
/*****************************************************************************/
/* IPv6 source and destination VTEP lookups                                  */
/*****************************************************************************/
table ipv6_dest_vtep {
    reads {
        l3_metadata.vrf : exact;
        ipv6.dstAddr : exact;
        tunnel_metadata.ingress_tunnel_type : exact;
    }
    actions {
        nop;
        set_tunnel_termination_flag;
        set_tunnel_vni_and_termination_flag;
    }
    size : DEST_TUNNEL_TABLE_SIZE;
}

table ipv6_src_vtep {
    reads {
        l3_metadata.vrf : exact;
        ipv6.srcAddr : exact;
        tunnel_metadata.ingress_tunnel_type : exact;
    }
    actions {
        on_miss;
        src_vtep_hit;
    }
    size : IPV6_SRC_TUNNEL_TABLE_SIZE;
}
#endif /* IPV6_DISABLE */
#endif /* TUNNEL_DISABLE */

control process_ipv4_vtep {
#if !defined(TUNNEL_DISABLE) && !defined(IPV4_DISABLE)
    apply(ipv4_src_vtep) {
        src_vtep_hit {
            apply(ipv4_dest_vtep);
        }
    }
#endif /* TUNNEL_DISABLE && IPV4_DISABLE */
}

control process_ipv6_vtep {
#if !defined(TUNNEL_DISABLE) && !defined(IPV6_DISABLE)
    apply(ipv6_src_vtep) {
        src_vtep_hit {
            apply(ipv6_dest_vtep);
        }
    }
#endif /* TUNNEL_DISABLE && IPV6_DISABLE */
}

MODULE_INGRESS(vtep) {
    if (valid(ipv4)) {
        process_ipv4_vtep();
    } else if (valid(ipv6)) {
        process_ipv6_vtep();
    }
}
#undef MODULE