#!/bin/bash
echo "=== Running Routing Protocol Tests ==="
make clean && make

if [ ! -f "./routing_sim" ]; then
    echo "Build failed!"
    exit 1
fi

RESULTS="test_results.json"
echo "[" > $RESULTS

test_bgp() {
    echo "Testing BGP with $1 nodes..."
    timeout 10 ./routing_sim bgp $1 > test_output.txt 2>&1

    if grep -q "converged" test_output.txt; then
        conv_time=$(grep "Convergence Time" test_output.txt | grep -o '[0-9]\+')
        echo "  ✓ BGP converged in ${conv_time}ms"
        echo "  {\"protocol\": \"bgp\", \"nodes\": $1, \"converged\": true, \"convergence_ms\": $conv_time}," >> $RESULTS
    else
        echo "  ✗ BGP failed to converge"
        echo "  {\"protocol\": \"bgp\", \"nodes\": $1, \"converged\": false}," >> $RESULTS
    fi
}

test_ospf() {
    echo "Testing OSPF with $1 nodes..."
    timeout 10 ./routing_sim ospf $1 > test_output.txt 2>&1

    if grep -q "converged" test_output.txt; then
        conv_time=$(grep "Convergence Time" test_output.txt | grep -o '[0-9]\+')
        echo "  ✓ OSPF converged in ${conv_time}ms"
        echo "  {\"protocol\": \"ospf\", \"nodes\": $1, \"converged\": true, \"convergence_ms\": $conv_time}," >> $RESULTS
    else
        echo "  ✗ OSPF failed to converge"
        echo "  {\"protocol\": \"ospf\", \"nodes\": $1, \"converged\": false}," >> $RESULTS
    fi
}

test_bgp 3
test_bgp 5
test_bgp 8
test_ospf 3
test_ospf 5
test_ospf 8

sed -i '$ s/,$//' $RESULTS
echo "]" >> $RESULTS

echo ""
echo "Results saved to: $RESULTS"
echo "Run analysis: python3 python/analyzer.py $RESULTS"
rm -f test_output.txt
