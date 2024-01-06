FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    ninja-build \
    cmake \
    clang \
    libmicrohttpd-dev \
    && apt-get clean

RUN mkdir /app
WORKDIR /app
COPY . /app

RUN cmake -B build . -GNinja && ninja -C build
