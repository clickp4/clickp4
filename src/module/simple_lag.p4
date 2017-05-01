#define MODULE simple_lag

/* Module parameter */
#ifndef SIMPLE_LAG_HASH_WIDTH
#define SIMPLE_LAG_HASH_WIDTH 16
#endif

#ifndef SIMPLE_LAG_HASH_ALG
#define SIMPLE_LAG_HASH_ALG identity
#endif

#ifndef SIMPLE_LAG_HASH_FIELDS
#define SIMPLE_LAG_HASH_FIELDS hash_metadata.hash1
#endif

field_list simple_lag_hash_fields {
    SIMPLE_LAG_HASH_FIELDS;
}

field_list_calculation simple_lag_hash {
    input {
        lag_hash_fields;
    }
    algorithm : SIMPLE_LAG_HASH_ALG;
    output_width : SIMPLE_LAG_HASH_WIDTH;
}

action_selector simple_lag_selector {
    selection_key : lag_hash;
    selection_mode : fair;
}

action set_lag_port(port) {
    modify_field(standard_metadata.egress_spec, port);
}

action set_lag_miss() {
}

action_profile lag_action_profile {
    actions {
        set_lag_miss;
        set_lag_port;
    }
    size : LAG_GROUP_TABLE_SIZE;
    dynamic_action_selection : simple_lag_selector;
}

table simple_lag_group {
    reads {
        standard_metadata.egress_spec : exact;
    }
    action_profile: lag_action_profile;
    size : LAG_SELECT_TABLE_SIZE;
}

MODULE_INGRESS(simple_lag) {
    apply(simple_lag_group);
}

#undef MODULE