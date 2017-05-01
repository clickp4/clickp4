#ifndef VXLAN_PROTO
#define VXLAN_PROTO

header_type vlan_t {
    fields {
        pcp : 3;
        cfi : 1;
        vid : 12;
        eth_type : 16;
    }
}

header vlan_t vlan;

parser parse_vlan {
    extract(vlan);
    return select(vlan.eth_type) {
#ifdef IPv4_PROTO
        ETH_TYPE_IPv4 : parse_ipv4;
#endif

#ifdef IPv6_PROTO
        ETH_TYPE_IPv6 : parse_ipv6;
#endif

        default : ingress;
    }
}

#endif