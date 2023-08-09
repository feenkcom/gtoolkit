FROM ubuntu:latest as ubuntu-gtbase
# This build prepares ubuntu for GToolkit, installing required libraries.

LABEL authors="feenk"
LABEL maintainer="feenk <admin@feenk.com>"

# Install required applications
# Source: https://octopus.com/blog/using-ubuntu-docker-image
RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
# Install libraries for libSkia.so
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y libfreetype6 libx11-6 libgl1 libegl1 libfontconfig1 \
  && rm -rf /var/lib/apt/lists/*

# Create working directory
RUN mkdir "/gtoolkit"
WORKDIR "/gtoolkit/"


FROM ubuntu-gtbase as gtoolkit
# This build includes all necessary GToolkit executable, data, documentation files.

# Copy basic Pharo run script. You want to replace the run.st file with our own version
COPY gtoolkit/run.st /gtoolkit/

# Copy Pharo sources, VM (lib, bin), Pharo image and changes
COPY *.sources /gtoolkit/
COPY lib /gtoolkit/lib/
COPY bin /gtoolkit/bin/
COPY GlamorousToolkit.changes /gtoolkit/
COPY GlamorousToolkit.image /gtoolkit/

# Copy documentation
COPY gt-extra /gtoolkit/gt-extra/

ENTRYPOINT [ "./bin/GlamorousToolkit-cli", "GlamorousToolkit.image", "st", "run.st" ]
