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
#ifdef L4_METADATA
    set_metadata(l4_metadata.src_port, udp.src_port);
    set_metadata(l4_metadata.dst_port, udp.dst_port);
    set_metadata(l4_metadata.l4_type, L4_TYPE_UDP);
#endif
    return ingress;
}

#endif