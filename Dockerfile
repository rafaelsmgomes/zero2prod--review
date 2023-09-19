From rust:1.59.0

workdir /app 

run apt update && apt install lld clang -y

copy . .
run cargo build --release

entrypoint ["./target/release/zero2prod"]
