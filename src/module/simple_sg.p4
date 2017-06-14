#define MODULE simple_sg

/* Context Dependency */
#ifndef SECURITY_CONTEXT
#include "../context/security.p4"
#endif


/* Module parameter */
//-----------------------------
#ifndef SIMPLE_SG_UDP_PERMIT
#define SIMPLE_SG_UDP_PERMIT 1
#endif

#ifndef SIMPLE_SG_TCP_PERMIT
#define SIMPLE_SG_TCP_PERMIT 1
#endif

#ifndef SIMPLE_SG_RESULT
#define SIMPLE_SG_RESULT 1
#endif

#ifndef SIMPLE_SG_INLINE_DROP 
#define SIMPLE_SG_INLINE_DROP 1
#endif
//-----------------------------

action sg_miss() {
#if SIMPLE_SG_RESULT == 0
    modify_field(security_metadata.state, SEC_STATE_ALERT);
#else 
    modify_field(security_metadata.state, SEC_STATE_DENY);
#endif
}

table ipv4_permit_special {
    reads {
        ipv4.dst_addr : ternary;

#if SIMPLE_SG_UDP_PERMIT == 1  
        udp 		  : valid;
        udp.src_port  : ternary;
        udp.dst_port  : ternary;
#endif

#if SIMPLE_SG_TCP_PERMIT == 1
        tcp 	      : valid; 
        tcp.src_port  : ternary;
        tcp.dst_port  : ternary;
#endif
        
    }
    actions {
        sg_miss;
    }
    size : 1024;
}

table ipv4_sg {
    reads {
        standard_metadata.ingress_port : exact;
        ethernet.src_addr : exact;
        ipv4.src_addr : exact;
    }
    actions {
        nop;
        on_miss;
    }
    size : 1024;
}

table ipv6_permit_special {
    reads {
        ipv6.dst_addr : ternary;

#if SIMPLE_SG_UDP_PERMIT == 1  
        udp 		  : valid;
        udp.src_port  : ternary;
        udp.dst_port  : ternary;
#endif

#if SIMPLE_SG_TCP_PERMIT == 1
        tcp 	      : valid; 
        tcp.src_port  : ternary;
        tcp.dst_port  : ternary;
#endif
        
    }
    actions {
        sg_miss;
    }
    size : 1024;
}

table ipv6_sg {
    reads {
        standard_metadata.ingress_port : exact;
        ethernet.src_addr : exact;
        ipv6.src_addr : exact;
    }
    actions {
        nop;
        on_miss;
    }
    size : 1024;
}

table sg_inline_drop {
	actions {
		block_;
	}
}

MODULE_INGRESS(simple_sg) {
	if (CHECK_ETH_TYPE(IPv4)){
        apply(ipv4_sg) {
            on_miss {
                apply(ipv4_permit_special);
            }
        }
    } 
    else if (CHECK_ETH_TYPE(IPv6)) {
    	apply(ipv6_sg) {
            on_miss {
                apply(ipv6_permit_special);
            }
        }
    }

#if SIMPLE_SG_INLINE_DROP == 1
	if (security_metadata.state == SEC_STATE_DENY) {
		apply(sg_inline_drop);
	}
#endif

}

#undef SIMPLE_SG_INLINE_DROP
#undef SIMPLE_SG_TCP_PERMIT
#undef SIMPLE_SG_RESULT
#undef SIMPLE_SG_UDP_PERMIT
#undef MODULE