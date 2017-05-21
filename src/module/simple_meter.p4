ifndef MODULE
#define MODULE simple_meter

#ifndef SIMPLE_METER_TABLE_SIZE
#define SIMPLE_METER_TABLE_SIZE 1024
#endif

#ifndef SIMPLE_METER_TYPE
#define SIMPLE_METER_TYPE bytes
#endif

action meter_deny() {
    drop();
}

table simple_meter_action {
    reads {
        meter_metadata.packet_color : exact;
        meter_metadata.meter_index : exact;
    }
    actions {
        nop;
        meter_deny;
    }
    size: METER_ACTION_TABLE_SIZE;
}

meter meter_index {
    type : bytes;
    direct : meter_index;
    result : meter_metadata.packet_color;
}

table simple_meter_index {
    reads {
        meter_metadata.meter_index: exact;
    }
    actions {
        nop;
    }
    size: SIMPLE_METER_TABLE_SIZE;
}

MODULE_INGRESS(simple_meter) {
    apply(simple_meter_index);
    apply(simple_meter_action);
}

#undef MODULE