/**
 * A sample module for ClickP4
 */

#ifndef MODULE
#define MODULE sample

table sample {
    actions {
        nop;
    }
}

MODULE_INGRESS(sample) {
    apply(sample);
}

#undef MODULE