#define MODULE simple_acl


/* Context Dependency */
#ifndef SECURITY_CONTEXT
#include "../context/security.p4"
#endif


#ifndef SIMPLE_ACL_TBL_SIZE
#define SIMPLE_ACL_TBL_SIZE 1024
#endif

#ifndef SIMPLE_ACL_TCP
#define SIMPLE_ACL_TCP 1
#endif

#ifndef SIMPLE_ACL_UDP
#define SIMPLE_ACL_UDP 1
#endif

#ifndef SIMPLE_ACL_RESULT
#define SIMPLE_ACL_RESULT 1
#endif

#ifndef SIMPLE_ACL_INLINE_DROP
#define SIMPLE_ACL_INLINE_DROP 1
#endif

action simple_acl_deny () {
    block_();

#if SIMPLE_ACL_RESULT == 0
    modify_field(security_metadata.state, SEC_STATE_ALERT);
#else 
    modify_field(security_metadata.state, SEC_STATE_DENY);
#endif

}

table ipv4_acl {
    reads {
        standard_metadata.ingress_port : ternary;
        ipv4.src_addr : ternary;
        ipv4.dst_addr : ternary;
        ipv4.proto    : ternary;

#if SIMPLE_ACL_TCP == 1
        tcp           : valid;
        tcp.src_port  : ternary;
        tcp.dst_port  : ternary;
        tcp.flags     : ternary;
#endif

#if SIMPLE_ACL_UDP == 1
        udp           : valid;
        udp.src_port  : ternary;
        udp.dst_port  : ternary;
#endif
    }
    actions {
        nop;
        simple_acl_deny;
    }
    size : SIMPLE_ACL_TBL_SIZE;
}

table ipv6_acl {
    reads {
        standard_metadata.ingress_port : ternary;
        
        ipv6.src_addr : ternary;
        ipv6.dst_addr : ternary;
        ipv6.next_hdr : ternary;

#if SIMPLE_ACL_TCP == 1
        tcp           : valid;
        tcp.src_port  : ternary;
        tcp.dst_port  : ternary;
        tcp.flags     : ternary;
#endif
#if SIMPLE_ACL_UDP == 1
        udp           : valid;
        udp.src_port  : ternary;
        udp.dst_port  : ternary;
#endif
    }
    actions {
        nop;
        simple_acl_deny;
    }
    size : SIMPLE_ACL_TBL_SIZE;
}


#if SIMPLE_ACL_INLINE_DROP == 1
table simple_acl_inline_drop {
    actions {
        block_;
    }
}
#endif

MODULE_INGRESS(simple_acl) {
    
    if (security_metadata.state != SEC_STATE_DENY) {
        if (ETH_TYPE == ETH_TYPE_IPv4) {
            apply(ipv4_acl);
        } 
        else if (ETH_TYPE == ETH_TYPE_IPv6) {
            apply(ipv6_acl);
        }
    }

#if SIMPLE_ACL_INLINE_DROP == 1
    if (security_metadata.state == SEC_STATE_DENY) {
        apply(simple_acl_inline_drop);
    }
#endif

}

#undef SIMPLE_ACL_TBL_SIZE
#undef SIMPLE_ACL_UDP
#undef SIMPLE_ACL_TCP
#undef MODULE