#
# Dockerfile to create AMBEserver Docker image.
#
# Created by Ash (M8WAT)
# Last Modified: 2026-02-17
#
# The image is created in two stages. This allows for a smaller final image.
#

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
