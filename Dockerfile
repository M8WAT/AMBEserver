# AMBEserver Docker Image by Ash, 2E0WAT.
# First Created: 2024-06-19
# Last Modified: 2026-02-18
#
# This Docker image is created in two stages.
#
# The first stage does the crux of the work, installing the required tools to
# compile the source code before downloading and compiling the AMBEserver source
# code.
#
# The second stage then "starts again" with a fresh image. It installs the
# package used by the healthcheck script and pulls over the AMBEserver
# executable from the stage 1 "builder" image. It then exposes UDP port 2460
# before importing the healthcheck script and setting its parameters.
#
# The image is based on Alpine rather than Ubuntu. This reduces the image size
# dramatically:
#   Ubuntu      = ~467MB
#   Alpine      = ~220MB
#   2 Stage     = ~  9MB
#   Healthcheck = ~ 11MB
#
# Note - The layout of this file has been kept to 80cols wide wherever possible
# to aid editing on mobile devices.

################################### Stage 1 ####################################

# Select Docker Image to Build On
FROM alpine:latest AS builder

# Set Base Directory
WORKDIR /root/

# Install Compilation Tools, Download the AMBEserver Source Code and Compile the
# Executable
RUN apk add build-base && \
    wget https://raw.githubusercontent.com/2e0wat/AMBEserver/main/AMBEserver.c && \
    gcc -o AMBEserver AMBEserver.c

################################### Stage 2 ####################################

# Select Docker Image to Build On
FROM alpine:latest

# Install Package Used by Healthcheck
RUN apk add lsof

# Fetch AMBEserver executable from Builder
COPY --from=builder /root/AMBEserver /root/AMBEserver

# Expose AMBEserver Transcoding Port
EXPOSE 2460/udp

# Import Healthcheck Script
COPY scripts/ /

# Set Healthcheck Parameters - Checks Container is Listening on UDP Port 2460
HEALTHCHECK --interval=10s --timeout=2s --retries=10 CMD /healthcheck.sh || exit 1

ENTRYPOINT ["/root/AMBEserver"]

##################################### End ######################################
