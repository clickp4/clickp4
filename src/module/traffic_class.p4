    /**
 * P4 39
 * ClickP4 41
 * Modified 3
 */

 #define MODULE traffic_class
/*****************************************************************************/
/* Queuing                                                                   */
/*****************************************************************************/

#ifndef QOS_DISABLE
action set_icos(icos) {
    modify_field(intrinsic_metadata.ingress_cos, icos); 
}

action set_queue(qid) {
    modify_field(intrinsic_metadata.qid, qid); 
}

action set_icos_and_queue(icos, qid) {
    modify_field(intrinsic_metadata.ingress_cos, icos); 
    modify_field(intrinsic_metadata.qid, qid); 
}

table traffic_class {
    reads {
        qos_metadata.tc_qos_group: ternary;
        qos_metadata.lkp_tc: ternary;
    }

    actions {
        nop;
        set_icos;
        set_queue;
        set_icos_and_queue;
    }
    size: QUEUE_TABLE_SIZE;
}
#endif /* QOS_DISABLE */

MODULE_INGRESS(traffic_class) {
#ifndef QOS_DISABLE
    apply(traffic_class);
#endif /* QOS_DISABLE */
}
#undef traffic_class