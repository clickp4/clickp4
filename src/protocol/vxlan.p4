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

#endif