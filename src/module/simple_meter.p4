#ifndef MODULE
#define MODULE simple_meter

action meter_deny() {
    drop();
}

action meter_permit() {
}

#ifndef STATS_DISABLE
counter meter_stats {
    type : packets;
    direct : meter_action;
}
#endif /* STATS_DISABLE */

table meter_action {
    reads {
        meter_metadata.packet_color : exact;
        meter_metadata.meter_index : exact;
    }

    actions {
        meter_permit;
        meter_deny;
    }
    size: METER_ACTION_TABLE_SIZE;
}

meter meter_index {
    type : bytes;
    direct : meter_index;
    result : meter_metadata.packet_color;
}

table meter_index {
    reads {
        meter_metadata.meter_index: exact;
    }
    actions {
        nop;
    }
    size: METER_INDEX_TABLE_SIZE;
}
#endif /* METER_DISABLE */

control process_meter_index {
#ifndef METER_DISABLE
    if (DO_LOOKUP(METER)) {
        apply(meter_index);
    }
#endif /* METER_DISABLE */
}

control process_meter_action {
    if (DO_LOOKUP(METER)) {
        apply(meter_action);
    }
}

#undef 