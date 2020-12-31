#!/usr/bin/env bash

set -u

total_tests="$(cat test/test-* | grep -c "run_test")"

echo "1..$total_tests"

pushd test > /dev/null || exit 1

test_error=""

for test_case in test-* ; do
    bash "$(basename "$test_case")" || test_error=1
done

popd > /dev/null || true

if [ -n "$test_error" ] ; then
    echo "# there are failed tests!" >&2
    exit 1
fi
