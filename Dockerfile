# Created by Ashley Watmough - M8WAT
# Maintainer of XLX178 Multi-Mode Reflector - https://xlx.buxton.radio/
#
# Date First Created: 2024-05-19
# Date Last Modified: 2026-02-17
#
# This is my Dockerfile to create an AMBEserver Docker image. It is created in
# two stages to create a smaller final image without the need to "clean-up" the
# AMBEserver source code or installed compilation tools.

# Stage 1 - Download the source code and compile the executable.

FROM alpine:latest as builder

WORKDIR /root/

RUN apk add build-base && \
    wget https://raw.githubusercontent.com/M8WAT/AMBEserver/main/AMBEserver.c && \
    gcc -o AMBEserver AMBEserver.c

# Stage 2 - Pull the compiled executable from builder & expose UDP port 2460.

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /root/AMBEserver /root/AMBEserver

EXPOSE 2460/udp

ENTRYPOINT /root/AMBEserver
