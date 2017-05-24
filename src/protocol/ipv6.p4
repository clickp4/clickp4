#ifndef IPv6_PROTO

#define IPv6_PROTO

#ifndef IPv4_PROTO

#define IP_PROTO_ICMP              1
#define IP_PROTO_IGMP              2
#define IP_PROTO_IPV4              4
#define IP_PROTO_TCP               6
#define IP_PROTO_UDP               17
#define IP_PROTO_IPv6              41
#define IP_PROTO_GRE               47
#define IP_PROTO_IPSEC_ESP         50
#define IP_PROTO_IPSEC_AH          51
#define IP_PROTO_ICMPV6            58
#define IP_PROTO_EIGRP             88
#define IP_PROTO_OSPF              89
#define IP_PROTO_PIM               103
#define IP_PROTO_VRRP              112

#endif

header_type ipv6_t {
    fields {
        version : 4;
        traffic_class : 8;
        flow_label : 20;
        payload_len : 16;
        next_hdr : 8;
        hop_limit : 8;
        src_addr : 128;
        dst_addr : 128;
    }
}

header ipv6_t ipv6;


parser parse_ipv6 {
    extract(ipv6);
    return select(ipv6.next_hdr) {
#ifdef TCP_RPTOTO
        IP_PROTO_TCP : parse_tcp;
#endif

#ifdef UDP_PROTO
        IP_PROTO_UDP : parse_udp;
#endif 
    
        default : ingress;
    }
}


#endif