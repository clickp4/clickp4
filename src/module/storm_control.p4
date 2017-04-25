/**
 * P4 67
 * ClickP4 69
 * Modified 4
 */
#define MODULE storm_control
#ifndef STORM_CONTROL_DISABLE
/*****************************************************************************/
/* Storm control                                                             */
/*****************************************************************************/
#ifndef STATS_DISABLE
counter storm_control_stats {
    type : packets;
    direct : storm_control_stats;
}

table storm_control_stats {
    reads {
        meter_metadata.packet_color: exact;
        standard_metadata.ingress_port : exact;
    }
    actions {
        nop;
    }
    size: STORM_CONTROL_STATS_TABLE_SIZE;
}
#endif /* STATS_DISABLE */

#ifndef METER_DISABLE
meter storm_control_meter {
    type : bytes;
    static : storm_control;
    result : meter_metadata.packet_color;
    instance_count : STORM_CONTROL_METER_TABLE_SIZE;
}
#endif /* METER_DISABLE */

action set_storm_control_meter(meter_idx) {
#ifndef METER_DISABLE
    execute_meter(storm_control_meter, meter_idx,
                  meter_metadata.packet_color);
    modify_field(meter_metadata.meter_index, meter_idx);
#endif /* METER_DISABLE */
}

table storm_control {
    reads {
        standard_metadata.ingress_port : exact;
        l2_metadata.lkp_pkt_type : ternary;
    }
    actions {
        nop;
        set_storm_control_meter;
    }
    size : STORM_CONTROL_TABLE_SIZE;
}
#endif /* STORM_CONTROL_DISABLE */

MODULE_INGRESS(storm_control) {
#ifndef STORM_CONTROL_DISABLE
    if (ingress_metadata.port_type == PORT_TYPE_NORMAL) {
        apply(storm_control);
    }
    process_storm_control_stats();
#endif /* STORM_CONTROL_DISABLE */
}

control process_storm_control_stats {
#ifndef STORM_CONTROL_DISABLE
#ifndef STATS_DISABLE
    apply(storm_control_stats);
#endif /* STATS_DISABLE */
#endif /* STORM_CONTROL_DISABLE */
}
#undef MODULE