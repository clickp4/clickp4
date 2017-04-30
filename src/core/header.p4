#ifndef __CLICK_HEADER__
#define __CLICK_HEADER__

#include "header_type.p4"

#define ETH_TYPE_ARP    0x0806
#define ETH_TYPE_IPv4   0x0800
#define ETH_TYPE_IPv6   0x86DD
#define ETH_TYPE_MPLS   0x8847
#define ETH_TYPE_VLAN   0x9100

#define IP_PROTO_TCP    6
#define IP_PROTO_UDP    17

header ethernet_t ethernet;
header ipv4_t ipv4;
header ipv6_t ipv6;
header vlan_t vlan;
header tcp_t tcp;
header udp_t udp;


#endif
