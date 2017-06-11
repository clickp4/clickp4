#!/bin/bash

SWITCH_DIR=/home/netarchlab/bmv2/targets/simple_switch
CONTROLLER_IP='101.6.30.157'
CONTROLLER_PORT=40123
INTF_1='-i 1@eth12'
INTF_2='-i 2@eth13'
INTF_S1_2='-i 2@s1-eth2'
INTF_S2_1='-i 1@s2-eth1'
INTF_S2_2='-i 2@s2-eth2'
INTF_S3_1='-i 1@s3-eth1'
INTF_S3_2='-i 2@s3-eth2'
INTF_S4_1='-i 1@s4-eth1'
INTF_S4_2='-i 2@s4-eth2'
INTF_S5_1='-i 1@s5-eth1'

LOG='-L off'

cd $SWITCH_DIR

for i in `seq 1`
do
{
    sudo ./simple_switch clickp4.json $INTF_1 $INTF_S1_2 $LOG --thrift-port 9090
} &
done

for i in `seq 1`
do
{
    sudo ./simple_switch clickp4.json $INTF_S2_1 $INTF_S2_2 $LOG --thrift-port 9091
} &
done

sudo ./simple_switch clickp4.json $INTF_S3_1 $INTF_2 $LOG --thrift-port 9092