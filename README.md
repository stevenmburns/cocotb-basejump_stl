# Experiment integrating basejump_stl, cocotb, cocotb-test, and hypothesis

[![CircleCI](https://circleci.com/gh/stevenmburns/cocotb-basejump_stl.svg?style=svg)](https://circleci.com/gh/stevenmburns/cocotb-basejump_stl)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/a05d3b1dcd264ff4adb4da7b3bdabb64)](https://www.codacy.com/manual/stevenmburns/cocotb-basejump_stl?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=stevenmburns/cocotb-basejump_stl&amp;utm_campaign=Badge_Grade)

You'll need to install these other packages.
```bash
python3 -m venv cocotb-env
source cocotb-env/bin/activate

pip install --upgrade pip
pip install wheel
pip install pytest
pip install hypothesis

git clone https://github.com/bespoke-silicon-group/basejump_stl.git

git clone https://github.com/cocotb/cocotb
(cd cocotb; pip install -e .)

git clone https://github.com/themperek/cocotb-test.git
(cd cocotb-test; pip install -e .)

git clone https://github.com/verilator/verilator.git
mkdir verilator_install
cd verilator
autoconf
./configure --prefix=`realpath ../verilator_install`
make -j 8
make install
```
Add `verilator_install/bin` to your PATH.

To run, then try:
```bash
SIM=verilator pytest
```
## Or with docker

```bash
docker build . -t cocotb_image

docker run -it cocotb_image bash -c "source /opt/venv/bin/activate && cd /pbt && SIM=verilator pytest"
```
