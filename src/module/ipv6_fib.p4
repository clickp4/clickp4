#if !defined(L3_DISABLE) && !defined(IPV6_DISABLE)
/*****************************************************************************/
/* IPv6 FIB lookup                                                           */
/*****************************************************************************/
/*
 * Actions are defined in l3.p4 since they are
 * common for both ipv4 and ipv6
 */

/*
 * Table: Ipv6 LPM Lookup
 * Lookup: Ingress
 * Ipv6 route lookup for longest prefix match entries
 */
table ipv6_fib_lpm {
    reads {
        l3_metadata.vrf : exact;
        ipv6_metadata.lkp_ipv6_da : lpm;
    }
    actions {
        on_miss;
        fib_hit_nexthop;
        fib_hit_ecmp;
    }
    size : IPV6_LPM_TABLE_SIZE;
}

/*
 * Table: Ipv6 Host Lookup
 * Lookup: Ingress
 * Ipv6 route lookup for /128 entries
 */
table ipv6_fib {
    reads {
        l3_metadata.vrf : exact;
        ipv6_metadata.lkp_ipv6_da : exact;
    }
    actions {
        on_miss;
        fib_hit_nexthop;
        fib_hit_ecmp;
    }
    size : IPV6_HOST_TABLE_SIZE;
}
#endif /* L3_DISABLE && IPV6_DISABLE */

control process_ipv6_fib {
#if !defined(L3_DISABLE) && !defined(IPV6_DISABLE)
    /* fib lookup */
    apply(ipv6_fib) {
        on_miss {
            apply(ipv6_fib_lpm);
        }
    }
#endif /* L3_DISABLE && IPV6_DISABLE */
}