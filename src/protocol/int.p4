#ifndef INT_PROTO
#define INT_PROTO

header_type int_t {
    fields {
        ver                     : 2;
        rep                     : 2;
        c                       : 1;
        e                       : 1;
        rsvd1                   : 5;
        ins_cnt                 : 5;
        max_hop_cnt             : 8;
        total_hop_cnt           : 8;
        instruction_mask_0003   : 4;   // split the bits for lookup
        instruction_mask_0407   : 4;
        instruction_mask_0811   : 4;
        instruction_mask_1215   : 4;
        rsvd2                   : 16;
    }
}

header int_t int;

header_type int_switch_id_header_t {
    fields {
        bos                 : 1;
        switch_id           : 31;
    }
}

header_type int_ingress_port_id_header_t {
    fields {
        bos                 : 1;
        ingress_port_id_1   : 15;
        ingress_port_id_0   : 16;
    }
}

header_type int_hop_latency_header_t {
    fields {
        bos                 : 1;
        hop_latency         : 31;
    }
}

header_type int_q_occupancy_header_t {
    fields {
        bos                 : 1;
        q_occupancy1        : 7;
        q_occupancy0        : 24;
    }
}

header_type int_ingress_tstamp_header_t {
    fields {
        bos                 : 1;
        ingress_tstamp      : 31;
    }
}

header_type int_egress_port_id_header_t {
    fields {
        bos                 : 1;
        egress_port_id      : 31;
    }
}

header_type int_q_congestion_header_t {
    fields {
        bos                 : 1;
        q_congestion        : 31;
    }
}

header_type int_egress_port_tx_utilization_header_t {
    fields {
        bos                         : 1;
        egress_port_tx_utilization  : 31;
    }
}

header_type int_value_t {
    fields {
        bos         : 1;
        val         : 31;
    }
}

header int_value_t int_value;


#endif