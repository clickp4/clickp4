#ifndef ARP_PROTO

#define ARP_PROTO

header_type arp_t {
    fields {
        hwType : 16;
        protoType : 16;
        hwAddrLen : 8;
        protoAddrLen : 8;
        opcode : 16;
        srcHwAddr : 48;
        srcProtoAddr : 32;
        dstHwAddr : 48;
        dstProtoAddr : 32;
    }
}

header arp_t arp;

parser parse_arp {
	extract(arp);
	return ingress;
}


#undef