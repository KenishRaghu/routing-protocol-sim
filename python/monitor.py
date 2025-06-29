#!/usr/bin/env python3
"""Simple performance monitor"""

import time
import psutil
import json
import sys

def monitor_simulation(duration=30):
    print(f"Monitoring for {duration} seconds...")
    data = []
    start_time = time.time()

    while time.time() - start_time < duration:
        cpu = psutil.cpu_percent()
        memory = psutil.virtual_memory().percent

        data.append({
            'timestamp': time.time() - start_time,
            'cpu_percent': cpu,
            'memory_percent': memory
        })

        print(f"CPU: {cpu:5.1f}% | Memory: {memory:5.1f}%")
        time.sleep(1)

    with open('monitor_results.json', 'w') as f:
        json.dump(data, f, indent=2)

    avg_cpu = sum(d['cpu_percent'] for d in data) / len(data)
    avg_mem = sum(d['memory_percent'] for d in data) / len(data)

    print(f"\nMonitoring Summary:")
    print(f"  Average CPU: {avg_cpu:.1f}%")
    print(f"  Average Memory: {avg_mem:.1f}%")
    print(f"  Data saved: monitor_results.json")

if __name__ == "__main__":
    duration = int(sys.argv[1]) if len(sys.argv) > 1 else 30
    monitor_simulation(duration)
