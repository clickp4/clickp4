# Modules of ClickP4

We have developed tens of modules for ClickP4. Some of them are ported from the switch repository. Some of them are newly added by us. And some of them are ported from the switch repository of P4.


## Sample

A sample module for ClickP4.

## L2 switch

A layer 2 switch prototype.

Parameters:
#### L2\_SWITCH\_LEARN
```
Enable source ethernet address learning.
DEFAULT: TRUE
```

#### L2\_SWITCH\_SMAC\_TABLE\_SIZE
```
The table size of smac.
DEFAULT: 1024
```

#### L2\_SWITCH\_SMAC\_TABLE\_SIZE
```
The table size of dmac.
DEFAULT: 1024
```

## L3 switch

A layer 3 switch prototype.

Parameters:
#### L3\_SWITCH\_CHECKSUM
```
Enable l3 checksum.
DEFAULT: TRUE
```

#### L3\_SWITCH\_TABLE\_SIZE
```
The table size of l3 switch.
DEFAULT: 1024
```

#### L3\_SWITCH\_BYPASS
```
Enable packets to bypass l3_switch when the security components set the security flag to DENY.
DEFAULT: TRUE
```

## Simple meter

A meter prototype.

Parameters:

#### SIMPLE\_METER\_TYPE
```
Data type of the meter.
DEFAULT: bytes
```

#### SIMPLE\_METER\_TABLE\_SIZE
```
Tbale size of the meter.
DEFAULT: 1024
```

## Condition

This module acts like 'switch' in the C language.

## If

This module acts like 'if' in the C language.

## While
This module acts like 'while' in the C language.

## For
This module acts like 'for' in the C language.

