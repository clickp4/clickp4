#ifndef ETHERNET_PROTO
#define ETHERNET_PROTO

#define ETH_TYPE_BF_FABRIC    0x9000
#define ETH_TYPE_VLAN         0x8100
#define ETH_TYPE_QINQ         0x9100
#define ETH_TYPE_MPLS         0x8847
#define ETH_TYPE_IPv4         0x0800
#define ETH_TYPE_IPv6         0x86dd
#define ETH_TYPE_ARP          0x0806
#define ETH_TYPE_RARP         0x8035
#define ETH_TYPE_NSH          0x894f
#define ETH_TYPE_ETHERNET     0x6558
#define ETH_TYPE_ROCE         0x8915
#define ETH_TYPE_FCOE         0x8906
#define ETH_TYPE_TRILL        0x22f3
#define ETH_TYPE_VNTAG        0x8926
#define ETH_TYPE_LLDP         0x88cc
#define ETH_TYPE_LACP         0x8809


header_type ethernet_t {
    fields {
        dst_addr : 48;
        src_addr : 48;
        eth_type : 16;
    }
}

header ethernet_t ethernet;

parser parse_ethernet {
    extract(ethernet);
    return select(ethernet.eth_type) {
#ifdef IPv4_PROTO
        ETH_TYPE_IPv4 : parse_ipv4;
#endif

#ifdef IPv6_PROTO
        ETH_TYPE_IPv6 : parse_ipv6;
#endif

#ifdef VLAN_PROTO
        ETH_TYPE_VLAN : parse_vlan;
#endif

#ifdef MPLS_PROTO
		ETH_TYPE_MPLS : parse_mpls;
#endif

#ifdef ARP_PROTO
        ETH_TYPE_ARP : parse_arp;
#endif


        default : ingress;
    }
}

#define CHECK_ETH_TYPE(X) ethernet.eth_type == ETH_TYPE_##X

#endif