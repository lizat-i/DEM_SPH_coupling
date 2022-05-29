#Start from the official Ubuntu Bionic(18.04 LTS) image
FROM ubuntu:bionic

# During building the image Frontend is non-interactive, set TZ to avoid interactiv input request
ENV TZ=Europe/Bruessels
ARG DEBIAN_FRONTEND=noninteractive

# install and source necessary stuff
RUN apt-get --yes -qq update \
 && apt-get --yes -qq upgrade \
 && apt-get --yes -qq install \
    git \
    openmpi-bin \
    libopenmpi-dev \
    libvtk6.3 \
    libvtk6-dev 
 #  create new user called from :
RUN useradd --user-group --create-home --shell /bin/bash DEM_user ;\
    echo "DEM_user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# clone the repo, build it set environment variables 
RUN git clone https://github.com/lizat-i/LIGGGHTS-PUBLIC.git    ; \
    cd LIGGGHTS-PUBLIC/src/                                     ; \
    make auto                                                    

#   link exexutable and make it accesible for the whole environment                     
RUN ln -s /LIGGGHTS-PUBLIC/src/lmp_auto /home/DEM_user/liggghts  ;\
    export PATH="/home/DEM_user:$PATH"
