# AMBEserver Docker Image

This is my AMBEserver Docker Image / Container to allow usage along side AMBED server for XLXD

It is based on the "latest" Alpine image and is created in two stages to create a smaller final image without the need to "clean-up" the AMBEserver source code or installed compilation tools used in the Stage 1 builder image.

Stage 2 of the build also uses the "latest Alpline image, pulls the AMBEserver binary from the builder and exposes UDP port 2460.


## How to Use

Clone this repository to your desired location:

    git clone https://github.com/M8WAT/AMBEserver.git

Open the folder:

    cd AMBEserver

Create the container:

    docker compose up -d


# My Use Case

I have a port forward setup in my router that allows connection to the AMBEserver container from David's (PA7LIM) [Peanut](https://www.pa7lim.nl/peanut/) server. This then links [XLX178](https://xlx.buxton.radio/) to Peanut Gateway XLX178A


# Create Your Own Docker Image

This is not necessary, but if you would like to create your own Docker image you must:

Clone this repository to your desired location:

    git clone https://github.com/M8WAT/AMBEserver.git

Open the folder:

    cd AMBEserver

Edit the Dockerfile as required and then build the image replacing the tag elements as necessary:

    docker build -t <YOURDOCKERUSERNAME>/<IMAGENAME>:<VERSION>

Example:

    docker build -t m8wat/ambeserver:latest