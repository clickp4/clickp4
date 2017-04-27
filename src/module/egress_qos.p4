/**
 * P4 39
 * ClickP4 41
 * Modified 2
 */
#define MODULE egress_qos
/*****************************************************************************/
/* Egress QOS Map                                                            */
/*****************************************************************************/
#ifndef QOS_DISABLE
action set_mpls_exp_marking(exp) {
    modify_field(l3_metadata.lkp_dscp, exp);
}

action set_ip_dscp_marking(dscp) {
    modify_field(l3_metadata.lkp_dscp, dscp);
}

action set_vlan_pcp_marking(pcp) {
    modify_field(l2_metadata.lkp_pcp, pcp);
}

table egress_qos_map {
    reads {
        qos_metadata.egress_qos_group: ternary;
        qos_metadata.lkp_tc: ternary;
        //meter_metadata.packet_color : ternary;
    }
    actions {
        nop;
        set_mpls_exp_marking;
        set_ip_dscp_marking;
        set_vlan_pcp_marking;
    }
    size: EGRESS_QOS_MAP_TABLE_SIZE;
}
#endif /* QOS_DISABLE */

MODULE_INGRESS(egress_qos) {
#ifndef QOS_DISABLE
    if (DO_LOOKUP(QOS)) {
        apply(egress_qos_map);
    }
#endif /* QOS_DISABLE */
}
#undef MODULE