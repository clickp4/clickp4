#define MODULE simple_loose_urpf


header_type urpf_metadata_t {
    fields {
        src_intf  : 9; // Src interfaces
    }
}

metadata urpf_metadata_t urpf_metadata;

action urpf_setup(port) {
    modify_field(urpf_metadata.src_intf, port);
}

action urpf_deny() {
    block();
}

action urpf_permit() {
    // What if
}

action urpf_alert() {
    // What if
}

table loose_urpf {
    reads {
        ipv4.src_addr : lpm;
    }
    actions {
        on_miss;
        urpf_setup;
    }
}

table urpf_permit {
    actions {
        urpf_permit;
    }
}

table urpf_deny {
    actions {
        urpf_deny;
    }
}

table urpf_alert {
    actions {
        urpf_alert;
    }
}

MODULE_INGRESS(simple_loose_urpf) {
    if (valid(ipv4)) {
        apply(loose_urpf) {
            on_miss {
                apply(urpf_alert);
            }
            urpf_setup {
                if (standard_metadata.ingress_port == urpf_metadata.src_intf) {
                    apply(urpf_permit);
                } 
                else {
                    apply(urpf_deny);
                }
            }
        }
    }
}

#undef MODULE
