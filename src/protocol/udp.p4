#ifndef UDP_PROTO
#define UDP_PROTO
header_type udp_t {
    fields {
        src_port : 16;
        dst_port : 16;
        length_ : 16;
        checksum : 16;
    }
}


header udp_t udp;


parser parse_udp {
    extract(udp);
    return ingress;
}

#endif