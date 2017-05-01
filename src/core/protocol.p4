#ifndef __CLICK_PROTOCOL__
#define __CLICK_PROTOCOL__

#include "../protocol/udp.p4"
#include "../protocol/tcp.p4"
#include "../protocol/ipv6.p4"
#include "../protocol/ipv4.p4"
#include "../protocol/ethernet.p4"


parser start {
	return parse_ethernet;
}

#endif
