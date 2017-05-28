#ifndef __CLICK_CONTEXT_QOS__
#define __CLICK_CONTEXT_QOS__

header_type qos_metadata_t {
    fields {
        priority : 7;
        ingress_qos_group: 5;
        tc_qos_group: 5;
        egress_qos_group: 5;
        lkp_tc: 8;
        trust_dscp: 1;
        trust_pcp: 1;
    }
}

metadata qos_metadata_t qos_metadata;

#endif