From rust:1.72-slim-bullseye AS builder

workdir /app 
run apt update && apt install lld clang -y
copy . .
env SQLX_OFFLINE true
run cargo build --release

FROM debian:bullseye-slim AS runtime
workdir /app 
run apt-get update -y \
    && apt-get install -y --no-install-recommends openssl ca-certificates \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
copy --from=builder /app/target/release/zero2prod-review zero2prod-review
copy configuration configuration
env APP_ENVIRONMENT production
entrypoint ["./zero2prod-review"]
