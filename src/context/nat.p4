#ifndef __CLICK_CONTEXT_NAT__
#define __CLICK_CONTEXT_NAT__
/*
 * NAT processing
 */
#define NAT_MODE_NONE 0
header_type nat_metadata_t {
    fields {
        ingress_nat_mode : 2;          /* 0: none, 1: inside, 2: outside */
        egress_nat_mode : 2;           /* nat mode of egress_bd */
        nat_nexthop : 16;              /* next hop from nat */
        nat_nexthop_type : 2;          /* ecmp or nexthop */
        nat_hit : 1;                   /* fwd and rewrite info from nat */
        nat_rewrite_index : 14;        /* NAT rewrite index */
        update_checksum : 1;           /* update tcp/udp checksum */
        update_inner_checksum : 1;     /* update inner tcp/udp checksum */
        l4_len : 16;                   /* l4 length */
    }
}

metadata nat_metadata_t nat_metadata;

#endif