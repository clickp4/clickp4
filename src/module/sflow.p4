
#define MODULE sflow
#ifdef SFLOW_ENABLE
action sflow_ing_session_enable(rate_thr, session_id)
{
    /* take_sample(sat) = rate_thr + take_sample(initialized from RNG) */
    /* if take_sample == max_val, sample will be take in the subsequent table-action */
    add(ingress_metadata.sflow_take_sample, rate_thr, 
                                ingress_metadata.sflow_take_sample);
    modify_field(sflow_metadata.sflow_session_id, session_id);
}

table sflow_ingress {
    /* Table to determine ingress port based enablement */
    /* This is separate from ACLs so that this table can be applied */
    /* independent of ACLs */
    reads {
        ingress_metadata.ifindex    : ternary;
        ipv4_metadata.lkp_ipv4_sa   : ternary;
        ipv4_metadata.lkp_ipv4_da   : ternary;
        sflow                       : valid;    /* do not sflow an sflow frame */
    }
    actions {
        nop; /* default action */
        sflow_ing_session_enable;
    }
    size : SFLOW_INGRESS_TABLE_SIZE;
}

field_list sflow_cpu_info {
    cpu_info;
    sflow_metadata.sflow_session_id;
    i2e_metadata.mirror_session_id;
    ingress_metadata.egress_ifindex;
}

action sflow_ing_pkt_to_cpu(sflow_i2e_mirror_id ) {
    modify_field(i2e_metadata.mirror_session_id, sflow_i2e_mirror_id);
    clone_ingress_pkt_to_egress(sflow_i2e_mirror_id, sflow_cpu_info);
}

table sflow_ing_take_sample {
    /* take_sample > MAX_VAL_31 and valid sflow_session_id => take the sample */
    reads {
        ingress_metadata.sflow_take_sample : ternary;
        sflow_metadata.sflow_session_id : exact;
    }
    actions {
        nop;
        sflow_ing_pkt_to_cpu;
    }

    size: MAX_SFLOW_SESSIONS;
}
#endif /*SFLOW_ENABLE */

MODULE_INGRESS(sflow) {
#ifdef SFLOW_ENABLE
    apply(sflow_ingress);
    apply(sflow_ing_take_sample);
#endif
}
#undef MODULE