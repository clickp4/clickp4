/**
 * Mac learning
 */
#define MODULE simple_ml
#define MAC_LEARN_RECEIVER 0


#ifndef LEARN_NOTIFY_TABLE_SIZE
#define LEARN_NOTIFY_TABLE_SIZE 1024
#endif

field_list mac_learn_digest {
    ethernet.src_addr;
    standard_metadata.ingress_port;
}

action generate_learn_notify() {
    generate_digest(MAC_LEARN_RECEIVER, mac_learn_digest);
}

table mac_learn {
    reads {
        ethernet.src_addr : exact;
    }
    actions {
        nop;
        generate_learn_notify;
    }
    size : LEARN_NOTIFY_TABLE_SIZE;
}

MODULE_INGRESS(simple_ml) {
    apply(mac_learn);
}
#undef MODULE