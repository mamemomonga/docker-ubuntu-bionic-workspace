#!/bin/bash
set -eu

echo "# generated at $(date +'%Y-%m-%d %H:%M:%S')" > .env
echo "HGID=$(id -g)" >> .env
echo "HUID=$(id -u)" >> .env

cat .env
