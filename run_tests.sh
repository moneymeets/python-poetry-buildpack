#!/usr/bin/env bash

set -u

echo "Running test suite..."

pushd test || exit 1

test_error=""

for test_case in test-* ; do
    bash "$(basename "$test_case")" || test_error=1
done

popd || true

if [ -z "$test_error" ] ; then
    echo "Test suite passed!"
    exit 0
else
    echo "Test suite failed!" >&2
    exit 1
fi
