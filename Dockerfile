#
# Base container starts here
#
FROM ubuntu:18.04 as cocotb_base

#
# Set required environment variables
#
ENV http_proxy=$http_proxy
ENV https_proxy=$https_proxy

# Update packages
RUN apt-get update && apt-get install -yq \
    # Python dependencies
    python3 \
    python3-pip \
    python3-venv \
    g++ \
    cmake \
    git \
    vim \
    curl \
    build-essential autoconf flex bison \
&&    apt-get clean

# Create Virtual Env
ENV venv=/opt/venv

RUN python3 -m venv $venv

RUN bash -c "source $venv/bin/activate && pip install --upgrade pip && pip install wheel pytest pytest-timeout hypothesis"

RUN bash -c "git clone https://github.com/verilator/verilator.git && cd verilator && autoconf && ./configure  && make -j 8 && make test && make install"

RUN bash -c "source $venv/bin/activate && git clone https://github.com/bespoke-silicon-group/basejump_stl.git && git clone https://github.com/cocotb/cocotb && cd cocotb && pip install -e . && cd - && git clone https://github.com/themperek/cocotb-test.git && cd cocotb-test && pip install -e . && cd -"

COPY pbt /pbt

WORKDIR /pbt