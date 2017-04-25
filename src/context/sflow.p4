#ifdef SFLOW_ENABLE
header_type sflow_meta_t {
    fields {
        sflow_session_id        : 16;
    }
}
metadata sflow_meta_t sflow_metadata;

counter sflow_ingress_session_pkt_counter {
    type : packets;
    direct : sflow_ingress;
    saturating;
}

/* ----- egress processing ----- */
action sflow_pkt_to_cpu(reason_code) {
    /* This action is called from the mirror table in the egress pipeline */
    /* Add sflow header to the packet */
    /* sflow header sits between cpu header and the rest of the original packet */
    /* The reasonCode in the cpu header is used to identify the */
    /* presence of the cpu header */
    /* pkt_count(sample_pool) on a given sflow session is read directly by CPU */
    /* using counter read mechanism */
    add_header(fabric_header_sflow);
    modify_field(fabric_header_sflow.sflow_session_id,
                 sflow_metadata.sflow_session_id);
    modify_field(fabric_header_sflow.sflow_egress_ifindex,
                 ingress_metadata.egress_ifindex);
    modify_field(fabric_metadata.reason_code, reason_code);
}
#endif