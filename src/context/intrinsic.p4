#ifndef __CLICK_CONTEXT_INTRINSIC__
#define __CLICK_CONTEXT_INTRINSIC__
header_type ingress_intrinsic_metadata_t {
    fields {
        resubmit_flag : 1;              // flag distinguishing original packets
                                        // from resubmitted packets.

        ingress_global_timestamp : 48;     // global timestamp (ns) taken upon
                                        // arrival at ingress.

        mcast_grp : 16;                 // multicast group id (key for the
                                        // mcast replication table)

        deflection_flag : 1;            // flag indicating whether a packet is
                                        // deflected due to deflect_on_drop.
        deflect_on_drop : 1;            // flag indicating whether a packet can
                                        // be deflected by TM on congestion drop

        enq_congest_stat : 2;           // queue congestion status at the packet
                                        // enqueue time.

        deq_congest_stat : 2;           // queue congestion status at the packet
                                        // dequeue time.

        mcast_hash : 13;                // multicast hashing

        egress_rid : 16;                // Replication ID for multicast

        lf_field_list : 32;             // Learn filter field list

        priority : 3;                   // set packet priority

        ingress_cos: 3;                 // ingress cos

        packet_color: 2;                // packet color

        qid: 5;                         // queue id
    }
}
metadata ingress_intrinsic_metadata_t intrinsic_metadata;

header_type queueing_metadata_t {
    fields {
        enq_timestamp : 48;
        enq_qdepth : 16;                // queue depth at the packet enqueue
                                        // time.
        deq_timedelta : 32;
        deq_qdepth : 16;
    }
}
metadata queueing_metadata_t queueing_metadata;

#define _ingress_global_tstamp_         intrinsic_metadata.ingress_global_timestamp
#define modify_field_from_rng(_d, _w)   modify_field_rng_uniform(_d, 0, (1<<(_w))-1)

action deflect_on_drop(enable_dod) {
    modify_field(intrinsic_metadata.deflect_on_drop, enable_dod);
}

#define PKT_INSTANCE_TYPE_NORMAL 0
#define PKT_INSTANCE_TYPE_INGRESS_CLONE 1
#define PKT_INSTANCE_TYPE_EGRESS_CLONE 2
#define PKT_INSTANCE_TYPE_COALESCED 3
#define PKT_INSTANCE_TYPE_INGRESS_RECIRC 4
#define PKT_INSTANCE_TYPE_REPLICATION 5
#define PKT_INSTANCE_TYPE_RESUBMIT 6

#define pkt_is_mirrored \
    ((standard_metadata.instance_type != PKT_INSTANCE_TYPE_NORMAL) and \
     (standard_metadata.instance_type != PKT_INSTANCE_TYPE_REPLICATION))

#define pkt_is_not_mirrored \
    ((standard_metadata.instance_type == PKT_INSTANCE_TYPE_NORMAL) or \
     (standard_metadata.instance_type == PKT_INSTANCE_TYPE_REPLICATION))
#endif

/* METADATA */
header_type ingress_metadata_t {
    fields {
        ingress_port : 9;                      /* input physical port */
        ifindex : IFINDEX_BIT_WIDTH;           /* input interface index */
        egress_ifindex : IFINDEX_BIT_WIDTH;    /* egress interface index */
        port_type : 2;                         /* ingress port type */

        outer_bd : BD_BIT_WIDTH;               /* outer BD */
        bd : BD_BIT_WIDTH;                     /* BD */

        drop_flag : 1;                         /* if set, drop the packet */
        drop_reason : 8;                       /* drop reason */
        control_frame: 1;                      /* control frame */
        bypass_lookups : 16;                   /* list of lookups to skip */
        sflow_take_sample : 32 (saturating);
    }
}

header_type egress_metadata_t {
    fields {
        bypass : 1;                            /* bypass egress pipeline */
        port_type : 2;                         /* egress port type */
        payload_length : 16;                   /* payload length for tunnels */
        smac_idx : 9;                          /* index into source mac table */
        bd : BD_BIT_WIDTH;                     /* egress inner bd */
        outer_bd : BD_BIT_WIDTH;               /* egress inner bd */
        mac_da : 48;                           /* final mac da */
        routed : 1;                            /* is this replica routed */
        same_bd_check : BD_BIT_WIDTH;          /* ingress bd xor egress bd */
        drop_reason : 8;                       /* drop reason */
        ifindex : IFINDEX_BIT_WIDTH;           /* egress interface index */
    }
}

metadata ingress_metadata_t ingress_metadata;
metadata egress_metadata_t egress_metadata;