#define MODULE vlan

action vlan_decap() {
	modify_field(ethernet.eth_type, vlan.eth_type);
	remove_header(vlan);
}

action vlan_encap(pcp, cfi, vfi) {
	add_header(vlan);
	modify_field(vlan.eth_type, ethernet.eth_type);
	modify_field(vlan.cfi, cfi);
	modify_field(vlan.pcp, pcp);
	modify_field(vlan.vfi, vfi);
	modify_field(ethernet.eth_type, ETH_TYPE_VLAN);
}

table egress_port_domain {
	reads {
		standard_metadata.egress_spec : exact;
	}
	actions {
		nop;
		on_miss;
	}
}

table vlan_filter{
	reads {
		vlan.vfi : exact;
		standard_metadata.egress_spec : exact;
	}
	actions {
		block;
		vlan_decap;
	}
}

table vlan {
	reads {
		ethernet.src_addr : exact;
	}
	actions {
		vlan_encap;
		on_miss;
	}	
	
}

MODULE_INGRESS(vlan) {
	apply(vlan) {
		on_miss {
			apply(port_domain) {
				on_miss {
					apply(vlan_filter);
				}
			}
		}
	}
}

#endif