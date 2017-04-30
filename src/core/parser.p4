#ifndef __CLICK_PARSER__
#define __CLICK_PARSER__


#include "header.p4"

parser start {
    return parse_ethernet;
}

parser parse_ethernet {
    extract(ethernet);
    return select(ethernet.eth_type) {
        ETH_TYPE_IPv4 : parse_ipv4;
        ETH_TYPE_IPv6 : parse_ipv6;
        ETH_TYPE_VLAN : parse_vlan;
        default : ingress;
    }
}

parser parse_ipv4 {
    extract(ipv4);
    return select(ipv4.proto) {
        IP_PROTO_TCP : parse_tcp;
        IP_PROTO_UDP : parse_udp;
        default : ingress;
    }
}

parser parse_ipv6 {
    extract(ipv6);
    return select(ipv6.next_hdr) {
        IP_PROTO_TCP : parse_tcp;
        IP_PROTO_UDP : parse_udp;
        default : ingress;
    }
}

parser parse_vlan {
    extract(vlan);
    return select(vlan.eth_type) {
        ETH_TYPE_IPv4 : parse_ipv4;
        ETH_TYPE_IPv6 : parse_ipv6;
        default : ingress;
    }
}

parser parse_tcp {
    extract(tcp);
    return ingress;
}

parser parse_udp {
    extract(udp);
    return ingress;
}

#endif
