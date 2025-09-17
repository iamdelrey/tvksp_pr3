#!/usr/bin/env sh
echo "User: $(id -u):$(id -g)"
echo "WORKDIR: $(pwd)"
echo "ENV FOO=${FOO}"
echo "Contents of /app/bundle:"
ls -la /app/bundle
echo "Message:"
cat /app/bundle/hello.txt

[ -n "${1:-}" ] && echo "CMD arg: $1"
