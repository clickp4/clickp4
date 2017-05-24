#! /bin/bash 
sudo ethtool -K peth1 gro off
sudo ethtool -K peth1 lro off
sudo ethtool -K peth1 tso off
sudo ethtool -K peth1 gso off

sudo ethtool -K peth2 gro off
sudo ethtool -K peth2 lro off
sudo ethtool -K peth2 tso off
sudo ethtool -K peth2 gso off

sudo ip netns exec h1 ethtool -K veth1 gro off
sudo ip netns exec h1 ethtool -K veth1 gso off
sudo ip netns exec h1 ethtool -K veth1 lro off
sudo ip netns exec h1 ethtool -K veth1 tso off
sudo ip netns exec h2 ethtool -K veth2 gro off
sudo ip netns exec h2 ethtool -K veth2 gso off
sudo ip netns exec h2 ethtool -K veth2 lro off
sudo ip netns exec h2 ethtool -K veth2 tso off