#!/bin/bash

while getopts ":s:t:d:c:" opt; do
  case $opt in
    s) suite_name="$OPTARG"
    ;;
    t) test_name="$OPTARG"
    ;;
    d) directory="$OPTARG"
    ;;
    c) count="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

# Set default directory if not provided
directory=${directory:-protocol}

# Construct the go test command
go_test_command="go test --tags=gowaku_no_rln --mod=vendor"
[ -n "$suite_name" ] && go_test_command+=" -run $suite_name"
[ -n "$test_name" ] && go_test_command+=" -testify.m $test_name"
go_test_command+=" -v -timeout=0 -failfast -count=${count:-1} | tee /tmp/output.txt"

# Change to the specified directory
cd /home/cammellos/documents/programming/status/status-go/$directory || exit

# Create a watchman trigger
nix-shell ~/.config/nix-shells/watch-status-go-test.nix --command "find /home/cammellos/documents/programming/status/status-go -name '*.go' -not -path './vendor/*' | entr -r $go_test_command"
