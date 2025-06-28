# Routing Protocol Simulation Toolkit (Upgraded)

Simulates simplified BGP and OSPF routing behavior using Linux network namespaces and virtual Ethernet pairs.
Supports packet tracing, route table validation, and FRRouting-style decision logic.

## Features
- Linux-based simulation using `ip netns` and `veth`
- BGP and OSPF simulators in C
- Python analysis script for route convergence
- Packet capture via tcpdump and .pcap output
- Routing table validation
- Simulated BGP behavior similar to FRRouting

## Getting Started
```bash
sudo ./scripts/setup_topology.sh
make
sudo ip netns exec R1 ./bgp_sim
sudo ip netns exec R2 ./bgp_sim
sudo ./scripts/analyze_routes.py
```

## Teardown
```bash
sudo ./scripts/teardown_topology.sh
```

## License
MIT
