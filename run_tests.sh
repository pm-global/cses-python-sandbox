#!/bin/bash
cd "$(dirname "$0")" || exit 1

SOLUTION="solution.py"
PASSED=0
FAILED=0

for f in $(printf '%s\n' tests/*.in | sort -V); do
    name="$(basename "$f" .in)"
    expected="tests/${name}.out"
    actual=$(mktemp)

    pypy3 "$SOLUTION" < "$f" > "$actual" 2>&1

    if diff -q "$actual" "$expected" > /dev/null 2>&1; then
        echo "✓ $name"
        ((PASSED++))
    else
        echo "✗ $name"
        exp_lines=$(wc -l < "$expected")
        exp_chars=$(wc -c < "$expected")
        act_lines=$(wc -l < "$actual")
        act_chars=$(wc -c < "$actual")
        echo "  Expected: $exp_lines lines, $exp_chars bytes"
        echo "  Got:      $act_lines lines, $act_chars bytes"

        # Show first difference context
        if [ "$act_chars" -lt 200 ]; then
            echo "  Got: $(head -c 200 "$actual")"
        else
            echo "  Got (first 100 chars): $(head -c 100 "$actual")..."
        fi
        if [ "$exp_chars" -lt 200 ]; then
            echo "  Exp: $(head -c 200 "$expected")"
        else
            echo "  Exp (first 100 chars): $(head -c 100 "$expected")..."
        fi
        ((FAILED++))
    fi
    rm -f "$actual"
done

TOTAL=$((PASSED + FAILED))
echo ""
echo "$PASSED/$TOTAL passed"
[ "$FAILED" -gt 0 ] && echo "$FAILED failed"
