#!/bin/bash
echo "=== Routing Protocol Benchmark ==="
python3 python/monitor.py 60 &
MONITOR_PID=$!

echo "Running benchmarks (monitoring in background)..."

echo "BGP Benchmark:"
for nodes in 5 10 15; do
    echo -n "  $nodes nodes: "
    result=$(timeout 30 ./routing_sim bgp $nodes 2>/dev/null | grep "Convergence Time" | grep -o '[0-9]\+')
    if [ -n "$result" ]; then
        echo "${result}ms"
    else
        echo "failed"
    fi
done

echo "OSPF Benchmark:"
for nodes in 5 10 15; do
    echo -n "  $nodes nodes: "
    result=$(timeout 30 ./routing_sim ospf $nodes 2>/dev/null | grep "Convergence Time" | grep -o '[0-9]\+')
    if [ -n "$result" ]; then
        echo "${result}ms"
    else
        echo "failed"
    fi
done

kill $MONITOR_PID 2>/dev/null
wait $MONITOR_PID 2>/dev/null

echo ""
echo "Benchmark complete. Check monitor_results.json for system performance."
