/**
 * P4 57
 * ClickP4 59
 * Modified 7
 */
#define MODULE lag
/*****************************************************************************/
/* LAG lookup/resolution                                                     */
/*****************************************************************************/
field_list lag_hash_fields {
    hash_metadata.hash2;
}

field_list_calculation lag_hash {
    input {
        lag_hash_fields;
    }
    algorithm : identity;
    output_width : LAG_BIT_WIDTH;
}

action_selector lag_selector {
    selection_key : lag_hash;
    selection_mode : fair;
}

#ifdef FABRIC_ENABLE
action set_lag_remote_port(device, port) {
    modify_field(fabric_metadata.dst_device, device);
    modify_field(fabric_metadata.dst_port, port);
}
#endif /* FABRIC_ENABLE */

action set_lag_port(port) {
    modify_field(standard_metadata.egress_spec, port);
}

action set_lag_miss() {
}

action_profile lag_action_profile {
    actions {
        set_lag_miss;
        set_lag_port;
#ifdef FABRIC_ENABLE
        set_lag_remote_port;
#endif /* FABRIC_ENABLE */
    }
    size : LAG_GROUP_TABLE_SIZE;
    dynamic_action_selection : lag_selector;
}

table lag_group {
    reads {
        standard_metadata.egress_spec : exact;
    }
    action_profile: lag_action_profile;
    size : LAG_SELECT_TABLE_SIZE;
}

MODULE_INGRESS(lag) {
    apply(lag_group);
}
#undef MODULE