FROM alpine:latest

RUN apk add \
    bash \
    ca-certificates \
    curl \
    git \
    openssl \
    tar \
    wget \
    zlib \
    && \
    rm -rf /var/cache/apk/*

RUN git clone https://github.com/paritytech/substrate-archive.git /substrate-archive

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup toolchain install nightly
RUN rustup override set nightly
RUN rustup target add wasm32-unknown-unknown --toolchain nightly

WORKDIR /substrate-archive

RUN cargo build --release --bin polkadot-archive
