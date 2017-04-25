/**
 * P4 65
 * ClickP4 67
 * Modified 5
 */
#define MODULE ingress_qos
/*****************************************************************************/
/* Ingress QOS Map                                                           */
/*****************************************************************************/
#ifndef QOS_DISABLE
action set_ingress_tc_and_color(tc, color) {
    modify_field(qos_metadata.lkp_tc, tc);
    modify_field(meter_metadata.packet_color, color);
}

action set_ingress_tc(tc) {
    modify_field(qos_metadata.lkp_tc, tc);
}

action set_ingress_color(color) {
    modify_field(meter_metadata.packet_color, color);
}

table ingress_qos_map_dscp {
    reads {
        qos_metadata.ingress_qos_group: ternary;
        l3_metadata.lkp_dscp: ternary;
    }

    actions {
        nop;
        set_ingress_tc;
        set_ingress_color;
        set_ingress_tc_and_color;
    }

    size: DSCP_TO_TC_AND_COLOR_TABLE_SIZE;
}

table ingress_qos_map_pcp {
    reads {
        qos_metadata.ingress_qos_group: ternary;
        l2_metadata.lkp_pcp: ternary;
    }

    actions {
        nop;
        set_ingress_tc;
        set_ingress_color;
        set_ingress_tc_and_color;
    }

    size: PCP_TO_TC_AND_COLOR_TABLE_SIZE;
}

#endif /* QOS_DISABLE */

control process_ingress_qos_map {
#ifndef QOS_DISABLE
    if (DO_LOOKUP(QOS)) {
        if (qos_metadata.trust_dscp == TRUE) {
            apply(ingress_qos_map_dscp);
        } else {
            if (qos_metadata.trust_pcp == TRUE) {
                apply(ingress_qos_map_pcp);
            }
        }
    }
#endif /* QOS_DISABLE */
}
#undef /*****************************************************************************/
/* Ingress QOS Map                                                           */
/*****************************************************************************/
#ifndef QOS_DISABLE
action set_ingress_tc_and_color(tc, color) {
    modify_field(qos_metadata.lkp_tc, tc);
    modify_field(meter_metadata.packet_color, color);
}

action set_ingress_tc(tc) {
    modify_field(qos_metadata.lkp_tc, tc);
}

action set_ingress_color(color) {
    modify_field(meter_metadata.packet_color, color);
}

table ingress_qos_map_dscp {
    reads {
        qos_metadata.ingress_qos_group: ternary;
        l3_metadata.lkp_dscp: ternary;
    }

    actions {
        nop;
        set_ingress_tc;
        set_ingress_color;
        set_ingress_tc_and_color;
    }

    size: DSCP_TO_TC_AND_COLOR_TABLE_SIZE;
}

table ingress_qos_map_pcp {
    reads {
        qos_metadata.ingress_qos_group: ternary;
        l2_metadata.lkp_pcp: ternary;
    }

    actions {
        nop;
        set_ingress_tc;
        set_ingress_color;
        set_ingress_tc_and_color;
    }

    size: PCP_TO_TC_AND_COLOR_TABLE_SIZE;
}

#endif /* QOS_DISABLE */

MODULE_INGRESS(ingress_qos) {
#ifndef QOS_DISABLE
    //if (DO_LOOKUP(QOS)) {
        if (qos_metadata.trust_dscp == TRUE) {
            apply(ingress_qos_map_dscp);
        } else {
            if (qos_metadata.trust_pcp == TRUE) {
                apply(ingress_qos_map_pcp);
            }
        }
    //}
#endif /* QOS_DISABLE */
}
#undef MODULE