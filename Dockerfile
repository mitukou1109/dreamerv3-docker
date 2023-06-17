FROM nvidia/cuda:11.4.3-cudnn8-devel-ubuntu20.04

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=graphics,utility,compute \
    LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

RUN apt-mark hold libcudnn8* libnccl*
RUN apt-get update && apt-get upgrade -y

# Install python3 and pip3
RUN apt-get install -y python3 python3-pip

# Setup for dreamerv3

# python requirements
WORKDIR /tmp
COPY requirements.txt .
RUN pip install --upgrade pip \
 && pip install -r requirements.txt

# dreamerv3 repository
WORKDIR /workspace
RUN apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/danijar/dreamerv3.git