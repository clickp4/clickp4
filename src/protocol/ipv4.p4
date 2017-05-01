#ifndef IPv4_PROTO
#define IPv4_PROTO

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

header_type ipv4_t {
    fields {
        version : 4;
        ihl : 4;
        diffserv : 8;
        total_len : 16;
        identification : 16;
        flags : 3;
        frag_offset : 13;
        ttl : 8;
        proto : 8;
        checksum : 16;
        src_addr : 32;
        dst_addr: 32;
    }
}

header ipv4_t ipv4;

parser parse_ipv4 {
    extract(ipv4);
    return select(ipv4.proto) {
#ifdef TCP_PROTO
    IP_PROTO_TCP : parse_tcp;
#endif

#ifdef UDP_PROTO
    IP_PROTO_UDP : parse_udp;
#endif 

#ifdef ICMP_PROTO
    IP_PROTO_ICMP : parse_icmp;
#endif 

    default : ingress;
    }
}


#define CHECK_IPv4_PROTO(X) ipv4.proto == IP_PROTO_##X

#endif
