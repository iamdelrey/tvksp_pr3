#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "== Build base =="
docker build -t task1-demo .

echo -e "\n== Run =="
docker run --rm -p 9090:9090 task1-demo custom-arg | sed -n '1,200p'

echo -e "\n== Inspect =="
echo "User => $(docker image inspect task1-demo --format '{{.Config.User}}')"
echo "Exposed => $(docker image inspect task1-demo --format '{{json .Config.ExposedPorts}}')"
echo "Volumes => $(docker image inspect task1-demo --format '{{json .Config.Volumes}}')"
echo "Workdir => $(docker image inspect task1-demo --format '{{.Config.WorkingDir}}')"
echo "Labels => $(docker image inspect task1-demo --format '{{json .Config.Labels}}')"

echo -e "\n== VOLUME write test =="
mkdir -p _data_test
docker run --rm -v "$(pwd)/_data_test:/data" task1-demo sh -lc 'echo ok > /data/test.txt'
cat _data_test/test.txt

echo -e "\n== ONBUILD test =="
cat > /tmp/child.Dockerfile <<'EOF'
FROM task1-demo
RUN echo "child build ok"
EOF
docker build -t task1-child -f /tmp/child.Dockerfile .
echo "OK"
