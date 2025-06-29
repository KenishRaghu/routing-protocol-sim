# Routing Protocol Simulation Toolkit

Simple toolkit to simulate BGP and OSPF routing protocols.

## Quick Start

```bash
# Build
make

# Run BGP simulation
./routing_sim bgp 5

# Run OSPF simulation  
./routing_sim ospf 8

# Run tests
make test

# Performance analysis
python3 python/analyzer.py test_results.json
```

## Features

- BGP and OSPF protocol simulation
- Convergence time measurement
- Python analysis tools
- Automated testing scripts
- Performance monitoring

Built with C, Python, and shell scripting for Linux environments.
