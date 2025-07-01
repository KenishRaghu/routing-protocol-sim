#!/bin/bash
echo "=== Running Routing Protocol Tests from test_cases.txt ==="
make clean && make

if [ ! -f "./routing_sim" ]; then
    echo "Build failed!"
    exit 1
fi

RESULTS="test_results.json"
echo "[" > $RESULTS

while read -r protocol nodes description; do
    [[ "$protocol" =~ ^#.*$ || -z "$protocol" ]] && continue

    echo "Testing $protocol with $nodes nodes... ($description)"
    timeout 10 ./routing_sim $protocol $nodes > test_output.txt 2>&1

    if grep -q "converged" test_output.txt; then
        conv_time=$(grep "Convergence Time" test_output.txt | grep -o '[0-9]\+')
        echo "  ✓ $protocol converged in ${conv_time}ms"
        echo "  {\"protocol\": \"$protocol\", \"nodes\": $nodes, \"description\": \"$description\", \"converged\": true, \"convergence_ms\": $conv_time}," >> $RESULTS
    else
        echo "  ✗ $protocol failed to converge"
        echo "  {\"protocol\": \"$protocol\", \"nodes\": $nodes, \"description\": \"$description\", \"converged\": false}," >> $RESULTS
    fi
done < tests/test_cases.txt

sed -i '$ s/,$//' $RESULTS
echo "]" >> $RESULTS

echo ""
echo "Results saved to: $RESULTS"
echo "Run analysis: python3 python/analyzer.py $RESULTS"
rm -f test_output.txt
