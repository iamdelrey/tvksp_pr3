#!/usr/bin/env sh
set -eu
echo "User: $(id -u):$(id -g)"
echo "WORKDIR: $(pwd)"
echo "ENV FOO=${FOO}"
echo "Contents of /app/bundle:"
ls -la /app/bundle
echo "Message:"
if [ "$(head -c3 /app/bundle/hello.txt | od -An -t x1 | tr -d ' \n')" = "efbbbf" ]; then
  tail -c +4 /app/bundle/hello.txt | tr -d '\r'
else
  tr -d '\r' < /app/bundle/hello.txt
fi
[ -n "${1:-}" ] && echo "CMD arg: $1"
