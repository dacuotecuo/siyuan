git fetch origin && git merge origin/master

cd kernel
# 清理缓存
go clean -modcache

# 客户端依赖这个内核
go build --tags "fts5" -o ../app/kernel/SiYuan-Kernel

cd ../app
pnpm install && pnpm rebuild

pnpm run build
pnpm run dist