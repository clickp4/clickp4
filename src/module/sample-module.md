# How to write and run a sample module for ClickP4

## Create your module source file in the [module](.) folder

```bash
touch src/module/sample.p4
```

## Add the module ingress

Open sample.p4, and fill in below code.

```
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
```

## Register the sample module in the configuration file

```bash
% echo 'sample'>config/modules
```

## Compile the P4 program

```bash
$ make compile
```

## Run ClickP4 with the sample module
```bash
$ make run
```
