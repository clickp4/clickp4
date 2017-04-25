#ifndef __CLICK_CONTEXT_ACL__
#define __CLICK_CONTEXT_ACL__

/*
 * ACL metadata
 */
header_type acl_metadata_t {
    fields {
        acl_deny : 1;                          /* ifacl/vacl deny action */
        racl_deny : 1;                         /* racl deny action */
        acl_nexthop : 16;                      /* next hop from ifacl/vacl */
        racl_nexthop : 16;                     /* next hop from racl */
        acl_nexthop_type : 2;                  /* ecmp or nexthop */
        racl_nexthop_type : 2;                 /* ecmp or nexthop */
        acl_redirect :   1;                    /* ifacl/vacl redirect action */
        racl_redirect : 1;                     /* racl redirect action */
        if_label : 16;                         /* if label for acls */
        bd_label : 16;                         /* bd label for acls */
        acl_stats_index : 14;                  /* acl stats index */
        egress_if_label : 16;                  /* if label for egress acls */
        egress_bd_label : 16;                  /* bd label for egress acls */
        ingress_src_port_range_id : 8;         /* ingress src port range id */
        ingress_dst_port_range_id : 8;         /* ingress dst port range id */
        egress_src_port_range_id : 8;          /* egress src port range id */
        egress_dst_port_range_id : 8;          /* egress dst port range id */
    }
}

header_type i2e_metadata_t {
    fields {
        ingress_tstamp    : 32;
        mirror_session_id : 16;
    }
}

metadata acl_metadata_t acl_metadata;
metadata i2e_metadata_t i2e_metadata;

/*****************************************************************************/
/* ACL Actions                                                               */
/*****************************************************************************/
action acl_deny(acl_stats_index, acl_meter_index, acl_copy_reason,
                nat_mode, ingress_cos, tc, color) {
    modify_field(acl_metadata.acl_deny, TRUE);
    modify_field(acl_metadata.acl_stats_index, acl_stats_index);
    modify_field(meter_metadata.meter_index, acl_meter_index);
    modify_field(fabric_metadata.reason_code, acl_copy_reason);
    modify_field(nat_metadata.ingress_nat_mode, nat_mode);
#ifndef QOS_DISABLE
    modify_field(intrinsic_metadata.ingress_cos, ingress_cos);
    modify_field(qos_metadata.lkp_tc, tc);
    modify_field(meter_metadata.packet_color, color);
#endif /* QOS_DISABLE */

}

action acl_permit(acl_stats_index, acl_meter_index, acl_copy_reason,
                  nat_mode, ingress_cos, tc, color) {
    modify_field(acl_metadata.acl_stats_index, acl_stats_index);
    modify_field(meter_metadata.meter_index, acl_meter_index);
    modify_field(fabric_metadata.reason_code, acl_copy_reason);
    modify_field(nat_metadata.ingress_nat_mode, nat_mode);
#ifndef QOS_DISABLE
    modify_field(intrinsic_metadata.ingress_cos, ingress_cos);
    modify_field(qos_metadata.lkp_tc, tc);
    modify_field(meter_metadata.packet_color, color);
#endif /* QOS_DISABLE */
}

field_list i2e_mirror_info {
    i2e_metadata.ingress_tstamp;
    i2e_metadata.mirror_session_id;
}

field_list e2e_mirror_info {
    i2e_metadata.ingress_tstamp;
    i2e_metadata.mirror_session_id;
}

action acl_mirror(session_id, acl_stats_index, acl_meter_index, nat_mode,
                  ingress_cos, tc, color) {
    modify_field(i2e_metadata.mirror_session_id, session_id);
    clone_ingress_pkt_to_egress(session_id, i2e_mirror_info);
    modify_field(acl_metadata.acl_stats_index, acl_stats_index);
    modify_field(meter_metadata.meter_index, acl_meter_index);
    modify_field(nat_metadata.ingress_nat_mode, nat_mode);
#ifndef QOS_DISABLE
    modify_field(intrinsic_metadata.ingress_cos, ingress_cos);
    modify_field(qos_metadata.lkp_tc, tc);
    modify_field(meter_metadata.packet_color, color);
#endif /* QOS_DISABLE */
}

action acl_redirect_nexthop(nexthop_index, acl_stats_index, acl_meter_index,
                            acl_copy_reason, nat_mode,
                            ingress_cos, tc, color) {
    modify_field(acl_metadata.acl_redirect, TRUE);
    modify_field(acl_metadata.acl_nexthop, nexthop_index);
    modify_field(acl_metadata.acl_nexthop_type, NEXTHOP_TYPE_SIMPLE);
    modify_field(acl_metadata.acl_stats_index, acl_stats_index);
    modify_field(meter_metadata.meter_index, acl_meter_index);
    modify_field(fabric_metadata.reason_code, acl_copy_reason);
    modify_field(nat_metadata.ingress_nat_mode, nat_mode);
#ifndef QOS_DISABLE
    modify_field(intrinsic_metadata.ingress_cos, ingress_cos);
    modify_field(qos_metadata.lkp_tc, tc);
    modify_field(meter_metadata.packet_color, color);
#endif /* QOS_DISABLE */
}

action acl_redirect_ecmp(ecmp_index, acl_stats_index, acl_meter_index,
                         acl_copy_reason, nat_mode,
                         ingress_cos, tc, color) {
    modify_field(acl_metadata.acl_redirect, TRUE);
    modify_field(acl_metadata.acl_nexthop, ecmp_index);
    modify_field(acl_metadata.acl_nexthop_type, NEXTHOP_TYPE_ECMP);
    modify_field(acl_metadata.acl_stats_index, acl_stats_index);
    modify_field(meter_metadata.meter_index, acl_meter_index);
    modify_field(fabric_metadata.reason_code, acl_copy_reason);
    modify_field(nat_metadata.ingress_nat_mode, nat_mode);
#ifndef QOS_DISABLE
    modify_field(intrinsic_metadata.ingress_cos, ingress_cos);
    modify_field(qos_metadata.lkp_tc, tc);
    modify_field(meter_metadata.packet_color, color);
#endif /* QOS_DISABLE */
}

/*****************************************************************************/
/* RACL actions                                                              */
/*****************************************************************************/
action racl_deny(acl_stats_index, acl_copy_reason,
                 ingress_cos, tc, color) {
    modify_field(acl_metadata.racl_deny, TRUE);
    modify_field(acl_metadata.acl_stats_index, acl_stats_index);
    modify_field(fabric_metadata.reason_code, acl_copy_reason);
#ifndef QOS_DISABLE
    modify_field(intrinsic_metadata.ingress_cos, ingress_cos);
    modify_field(qos_metadata.lkp_tc, tc);
    modify_field(meter_metadata.packet_color, color);
#endif /* QOS_DISABLE */
}

action racl_permit(acl_stats_index, acl_copy_reason,
                   ingress_cos, tc, color) {
    modify_field(acl_metadata.acl_stats_index, acl_stats_index);
    modify_field(fabric_metadata.reason_code, acl_copy_reason);
#ifndef QOS_DISABLE
    modify_field(intrinsic_metadata.ingress_cos, ingress_cos);
    modify_field(qos_metadata.lkp_tc, tc);
    modify_field(meter_metadata.packet_color, color);
#endif /* QOS_DISABLE */
}

action racl_redirect_nexthop(nexthop_index, acl_stats_index,
                             acl_copy_reason,
                             ingress_cos, tc, color) {
    modify_field(acl_metadata.racl_redirect, TRUE);
    modify_field(acl_metadata.racl_nexthop, nexthop_index);
    modify_field(acl_metadata.racl_nexthop_type, NEXTHOP_TYPE_SIMPLE);
    modify_field(acl_metadata.acl_stats_index, acl_stats_index);
    modify_field(fabric_metadata.reason_code, acl_copy_reason);
#ifndef QOS_DISABLE
    modify_field(intrinsic_metadata.ingress_cos, ingress_cos);
    modify_field(qos_metadata.lkp_tc, tc);
    modify_field(meter_metadata.packet_color, color);
#endif /* QOS_DISABLE */
}

action racl_redirect_ecmp(ecmp_index, acl_stats_index,
                          acl_copy_reason,
                          ingress_cos, tc, color) {
    modify_field(acl_metadata.racl_redirect, TRUE);
    modify_field(acl_metadata.racl_nexthop, ecmp_index);
    modify_field(acl_metadata.racl_nexthop_type, NEXTHOP_TYPE_ECMP);
    modify_field(acl_metadata.acl_stats_index, acl_stats_index);
    modify_field(fabric_metadata.reason_code, acl_copy_reason);
#ifndef QOS_DISABLE
    modify_field(intrinsic_metadata.ingress_cos, ingress_cos);
    modify_field(qos_metadata.lkp_tc, tc);
    modify_field(meter_metadata.packet_color, color);
#endif /* QOS_DISABLE */
}
#endif

