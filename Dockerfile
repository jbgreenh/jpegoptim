# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake g++ make libjpeg-dev

## Add source code to the build stage.
ADD . /jpegoptim
WORKDIR /jpegoptim

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN ./configure && make && make strip

# Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /jpegoptim/jpegoptim /

