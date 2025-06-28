#!/bin/bash

# Setup network namespaces and virtual interfaces
ip netns add R1
ip netns add R2

ip link add veth-R1 type veth peer name veth-R2
ip link set veth-R1 netns R1
ip link set veth-R2 netns R2

ip netns exec R1 ip addr add 10.0.0.1/24 dev veth-R1
ip netns exec R2 ip addr add 10.0.0.2/24 dev veth-R2

ip netns exec R1 ip link set dev veth-R1 up
ip netns exec R2 ip link set dev veth-R2 up

ip netns exec R1 ip link set lo up
ip netns exec R2 ip link set lo up


# Start tcpdump in background to capture packets in R1 namespace
ip netns exec R1 tcpdump -i veth-R1 -w traces/bgp_traffic.pcap &
echo "[*] tcpdump started in R1 (writing to traces/bgp_traffic.pcap)"
echo "[*] Topology setup complete"
