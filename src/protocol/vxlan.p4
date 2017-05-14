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
    extarct(inner_ethernet);
    return parse_inner_ethernet;
}


parser parse_inner_ethernet {
    extarct(inner_ethernet);
    
    return parse_inner_ipv4;
}

parser parse_inner_ipv4 {
    extract(inner_ipv4);
}

parser parser_inner

#endif