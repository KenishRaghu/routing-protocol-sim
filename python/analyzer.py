#!/usr/bin/env python3
"""Simple routing protocol analyzer"""

import sys
import json
import matplotlib.pyplot as plt
from datetime import datetime

def analyze_convergence(data):
    times = [d['convergence_ms'] for d in data if d.get('converged')]
    if not times:
        print("No convergence data found")
        return

    print(f"Convergence Analysis:")
    print(f"  Average: {sum(times)/len(times):.1f} ms")
    print(f"  Min: {min(times)} ms")
    print(f"  Max: {max(times)} ms")
    print(f"  Tests: {len(times)}")

    plt.figure(figsize=(8, 5))
    plt.hist(times, bins=10, alpha=0.7)
    plt.title('Convergence Time Distribution')
    plt.xlabel('Time (ms)')
    plt.ylabel('Count')
    plt.savefig('convergence_analysis.png')
    print("Plot saved: convergence_analysis.png")

def compare_protocols(bgp_data, ospf_data):
    bgp_times = [d['convergence_ms'] for d in bgp_data if d.get('converged')]
    ospf_times = [d['convergence_ms'] for d in ospf_data if d.get('converged')]

    print(f"\nProtocol Comparison:")
    if bgp_times:
        print(f"  BGP avg: {sum(bgp_times)/len(bgp_times):.1f} ms ({len(bgp_times)} tests)")
    if ospf_times:
        print(f"  OSPF avg: {sum(ospf_times)/len(ospf_times):.1f} ms ({len(ospf_times)} tests)")

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 analyzer.py <results.json>")
        return

    try:
        with open(sys.argv[1], 'r') as f:
            data = json.load(f)

        print("=== Routing Protocol Analysis ===")
        analyze_convergence(data)

        bgp_data = [d for d in data if d.get('protocol') == 'bgp']
        ospf_data = [d for d in data if d.get('protocol') == 'ospf']

        if bgp_data and ospf_data:
            compare_protocols(bgp_data, ospf_data)

    except FileNotFoundError:
        print(f"File not found: {sys.argv[1]}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
