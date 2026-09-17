#!/bin/sh

set -e

git switch dev
git fetch origin
git merge origin/master

cd kernel

# 客户端依赖这个内核
go build --tags "fts5" -o ../app/kernel/SiYuan-Kernel

cd ../app
pnpm install
pnpm rebuild

pnpm run build

case "$(uname -s):$(uname -m)" in
  Darwin:arm64)
    pnpm run dist-darwin-arm64
    ;;
  Darwin:x86_64|Darwin:amd64)
    pnpm run dist-darwin
    ;;
  Linux:aarch64|Linux:arm64)
    pnpm run dist-linux-arm64
    ;;
  Linux:x86_64|Linux:amd64)
    pnpm run dist-linux
    ;;
  *)
    echo "Unsupported build platform: $(uname -s) $(uname -m)" >&2
    exit 1
    ;;
esac
