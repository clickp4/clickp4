#ifndef SCTP_PROTO
#define SCTP_PROTO

header_type sctp_t {
    fields {
        src_port : 16;
        dst_port : 16;
        verifTag : 32;
        checksum : 32;
    }
}

header scpt_t sctp;

parser parse_sctp {
	extract(sctp);
	return ingress;
}

#endif