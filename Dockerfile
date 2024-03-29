# Generate recipe file for dependencies
FROM lukemathwalker/cargo-chef:latest-rust-1.73.0 as chef
WORKDIR /app
RUN apt update && apt install lld clang -y

# Build Dependencies
FROM chef as planner
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

# Builder Image
FROM chef as builder
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
COPY . .
RUN cargo build --release --bin axum-web

# Running Image
FROM debian:stable-slim
WORKDIR /app
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends openssl ca-certificates \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/target/release/axum-web /app/axum-web
RUN chmod +x axum-web
EXPOSE 3000
CMD ["./axum-web"]