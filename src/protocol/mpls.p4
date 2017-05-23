#ifndef MPLS_PROTO
#define MPLS_PROTO


header_type mpls_t {
    fields {
        label : 20;
        exp : 3;
        bos : 1;
        ttl : 8;
    }
}


header mpls_t mpls;

parser parse_mpls {
	extract(mpls);
	return ingress;
}

#endif