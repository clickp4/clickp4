#ifndef VXLAN_PROTO
#define VXLAN_PROTO

header_type vxlan_t {
    fields {
        flags : 8;
        reserved : 24;
        vni : 24;
        reserved2 : 8;
    }
}

header vxlan_t vxlan;

parser parse_vxlan {
    extract(vxlan);
    extract(inner_ethernet);
    return parse_inner_ethernet;
}

parser parse_inner_ethernet {
    extract(inner_ethernet);
    return select(inner_ethernet.eth_type) {
#ifdef IPv4_PROTO
        ETH_TYPE_IPv4 : parse_inner_ipv4;
#endif

#ifdef IPv6_PROTO
        ETH_TYPE_IPv6 : parse_inner_ipv6;
#endif
        default : ingress;
    }
}

parser parse_inner_ipv4 {
    extract(inner_ipv4);
    return select(inner_ipv4.proto) {
        IP_PROTO_TCP : parse_inner_tcp; 
        IP_PROTO_UDP : parse_inner_udp;
        default : ingress;
    }
}

parser parse_inner_ipv6 {
    extract(inner_ipv6);
    return select(inner_ipv6.next_hdr) {
        IP_PROTO_TCP : parse_inner_tcp; 
        IP_PROTO_UDP : parse_inner_udp;
        default : ingress;
    }
}

parser parse_inner_tcp {
    extract(inner_tcp);
    return ingress;
}

parser parse_inner_udp {
    extract(inner_udp);
    return ingress;
}



#endif