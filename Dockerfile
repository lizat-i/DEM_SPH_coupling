#Start from the official Ubuntu Bionic(18.04 LTS) image
FROM ubuntu:bionic

# During building the image Frontend is non-interactive, set TZ to avoid interactiv input request
ENV TZ=Europe/Bruessels
ARG DEBIAN_FRONTEND=noninteractive

# install and source necessary stuff
RUN apt-get update && apt-get install -y \
    git \
    openmpi-bin \    
    libopenmpi-dev \
    libvtk6.3 \
    libvtk6-dev \
    && rm -rf /var/lib/apt/lists/*

# clone the repo, build it set environment variables 
RUN git clone https://github.com/lizat-i/LIGGGHTS-PUBLIC.git    ; \
    cd LIGGGHTS-PUBLIC/src/                                     ; \
    make auto                                                   ; \
    ln -s /LIGGGHTS-PUBLIC/src/lmp_auto /bin/liggghts           
