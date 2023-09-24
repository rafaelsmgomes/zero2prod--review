from lukemathwalker/cargo-chef:latest-rust-1.72-slim-bullseye as chef
workdir /app 
run apt update && apt install lld clang -y
env CARGO_CHEF_GLIBC=2.29

from chef as planner
copy . .
run cargo chef prepare --recipe-path recipe.json

from chef as builder
copy --from=planner /app/recipe.json recipe.json
run cargo chef cook --release --recipe-path recipe.json
copy . .
env SQLX_OFFLINE true
run cargo build --release --bin zero2prod-review


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
