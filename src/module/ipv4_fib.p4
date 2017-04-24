
#if !defined(L3_DISABLE) && !defined(IPV4_DISABLE)
/*****************************************************************************/
/* IPv4 FIB lookup                                                           */
/*****************************************************************************/
table ipv4_fib {
    reads {
        l3_metadata.vrf : exact;
        ipv4_metadata.lkp_ipv4_da : exact;
    }
    actions {
        on_miss;
        fib_hit_nexthop;
        fib_hit_ecmp;
    }
    size : IPV4_HOST_TABLE_SIZE;
}

table ipv4_fib_lpm {
    reads {
        l3_metadata.vrf : exact;
        ipv4_metadata.lkp_ipv4_da : lpm;
    }
    actions {
        on_miss;
        fib_hit_nexthop;
        fib_hit_ecmp;
    }
    size : IPV4_LPM_TABLE_SIZE;
}
#endif /* L3_DISABLE && IPV4_DISABLE */

control process_ipv4_fib {
#if !defined(L3_DISABLE) && !defined(IPV4_DISABLE)
    /* fib lookup */
    apply(ipv4_fib) {
        on_miss {
            apply(ipv4_fib_lpm);
        }
    }
#endif /* L3_DISABLE && IPV4_DISABLE */
}