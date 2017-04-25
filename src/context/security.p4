/*
 * security metadata
 */
header_type security_metadata_t {
    fields {
        ipsg_enabled : 1;                      /* is ip source guard feature enabled */
        ipsg_check_fail : 1;                   /* ipsg check failed */
    }
}

metadata security_metadata_t security_metadata;