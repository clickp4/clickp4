/**
 * P4 47
 * ClickP4 49
 * Modified 3
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
        l3_metadata.lkp_ip_proto : ternary;
        l3_metadata.lkp_l4_dport : ternary;
        ipv4_metadata.lkp_ipv4_da : ternary;
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
        l2_metadata.lkp_mac_sa : exact;
        ipv4_metadata.lkp_ipv4_sa : exact;
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