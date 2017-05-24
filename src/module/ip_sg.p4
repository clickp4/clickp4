/**
 * P4 47
 * ClickP4 49+1
 * Modified 3+2+4
 */
#define MODULE ip_sg
#ifndef IPSG_DISABLE
/*****************************************************************************/
/* IP Source Guard                                                           */
/*****************************************************************************/
action ipsg_miss() {
    modify_field(security_metadata.ipsg_check_fail, TRUE);
}

table ipsg_permit_special {
    reads {
        ipv4.proto : ternary;
        udp.dst_port : ternary;
        tcp.dst_port : ternary;
        IPv4_DST_ADDR : ternary;
    }
    actions {
        ipsg_miss;
    }
    size : IPSG_PERMIT_SPECIAL_TABLE_SIZE;
}

table ipsg {
    reads {
        ingress_metadata.ifindex : exact;
        ingress_metadata.bd : exact;
        SRC_MAC : exact;
        IPv4_SRC_ADDR : exact;
    }
    actions {
        on_miss;
    }
    size : IPSG_TABLE_SIZE;
}
#endif /* IPSG_DISABLE */

MODULE_INGRESS(ip_sg) {
#ifndef IPSG_DISABLE
    /* l2 security features */
    if ((ingress_metadata.port_type == PORT_TYPE_NORMAL) and
        (security_metadata.ipsg_enabled == TRUE)) {
        apply(ipsg) {
            on_miss {
                apply(ipsg_permit_special);
            }
        }
    }
#endif /* IPSG_DISABLE */
}
#endif