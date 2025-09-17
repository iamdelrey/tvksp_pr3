#!/usr/bin/env bash
set -euo pipefail

echo "Сборка и запуск произведены. Автор: Anton Stepanov"

exec java -jar /app/app.jar
