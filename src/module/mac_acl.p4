/**
 * L2 ACL
 * P4 30
 * ClickP4 31
 * Modified 8
 */
#define MODULE mac_acl 
#ifndef L2_DISABLE
table mac_acl {
    reads {
        acl_metadata.if_label : ternary;
        acl_metadata.bd_label : ternary;

        SRC_MAC : ternary;
        DST_MAC : ternary;
        ETH_TYPE : ternary;
    }
    actions {
        nop;
        acl_deny;
        acl_permit;
        acl_redirect_nexthop;
        acl_redirect_ecmp;
#ifndef MIRROR_DISABLE
        acl_mirror;
#endif /* MIRROR_DISABLE */
    }
    size : 1024;
}
#endif /* L2_DISABLE */

MODULE_INGRESS(mac_acl) {
#ifndef L2_DISABLE
    apply(mac_acl);
#endif /* L2_DISABLE */
}
#undef MODULE