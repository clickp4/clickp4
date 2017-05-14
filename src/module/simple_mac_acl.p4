#define MODULE simple_mac_acl 

/* Context Dependency */
#ifndef SECURITY_CONTEXT
#include "../context/security.p4"
#endif


#ifndef SIMPLE_ACL_TBL_SIZE
#define SIMPLE_ACL_TBL_SIZE 1024
#endif

#ifndef SIMPLE_MAC_ACL_DST
#define SIMPLE_MAC_ACL_DST 1
#endif

#ifndef SIMPLE_MAC_ACL_SRC
#define SIMPLE_MAC_ACL_SRC 1
#endif

#ifndef SIMPLE_MAC_ACL_TYPE
#define SIMPLE_MAC_ACL_TYPE 1
#endif


#ifndef SIMPLE_ACL_INLINE_DROP
#define SIMPLE_ACL_INLINE_DROP 1
#endif

action simple_mac_acl_deny () {
#if SIMPLE_ACL_INLINE_DROP == 1
    block();
#endif
    modify_field(security_metadata.state, SEC_STATE_DENY);
}

action simple_mac_acl_deny () {
    modify_field(security_metadata.state, SEC_STATE_ALERT);
}

action simple_mac_acl_permit () {
    modify_field(security_metadata.state, SEC_STATE_PASS);
}

table simple_mac_acl {
    reads {
        ethernet.src_addr : ternary;
        ethernet.dst_addr : ternary;
        ethernet.eth_type : ternary;
    }
    actions {
        nop;
        simple_mac_acl_deny;
        simple_mac_acl_permit;
    }
    size : SIMPLE_ACL_TBL_SIZE;
}

MODULE_INGRESS(simple_mac_acl) {
    apply(simple_mac_acl);
}
#undef MODULE