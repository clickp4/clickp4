#ifndef SECURITY_CONTEXT
#define SECURITY_CONTEXT

#define SEC_STATE_UNCONCERN  0
#define SEC_STATE_PASS	     1
#define SEC_STATE_DENY		 2
#define SEC_STATE_ALERT		 3


header_type security_metadata_t {
    fields {
        ipsg_enabled : 1;                      /* is ip source guard feature enabled */
        ipsg_check_fail : 1;                   /* ipsg check failed */
        drop_flag : 1;
        // 
        state : 6;
    }
}

metadata security_metadata_t security_metadata;

#endif