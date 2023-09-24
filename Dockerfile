From rust:1.72

workdir /app 

run apt update && apt install lld clang -y

copy . .
env SQLX_OFFLINE true
run cargo build --release
env APP_ENVIRONMENT production

entrypoint ["./target/release/zero2prod-review"]
