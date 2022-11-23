# Experiment integrating basejump_stl, cocotb, cocotb-test, and hypothesis

[![CircleCI](https://circleci.com/gh/stevenmburns/cocotb-basejump_stl.svg?style=svg)](https://circleci.com/gh/stevenmburns/cocotb-basejump_stl)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/a05d3b1dcd264ff4adb4da7b3bdabb64)](https://www.codacy.com/manual/stevenmburns/cocotb-basejump_stl?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=stevenmburns/cocotb-basejump_stl&amp;utm_campaign=Badge_Grade)

You'll need to install these other packages.
```bash
python3 -m venv .venv
source .venv/bin/activate

pip install --upgrade pip
pip install wheel
pip install pytest
pip install hypothesis

git clone https://github.com/bespoke-silicon-group/basejump_stl.git
(cd basejump_stl; git checkout dfc54ccbf7e3b9ffe84c6d5e446c08041bf6db7a)

git clone https://github.com/cocotb/cocotb
(cd cocotb; pip install -e .)

git clone https://github.com/themperek/cocotb-test.git
(cd cocotb-test; pip install -e .)

git clone https://github.com/verilator/verilator.git
git checkout v4.106
mkdir verilator_install
cd verilator
autoconf
./configure --prefix=`realpath ../verilator_install`
make -j 8
make install
```
Add `verilator_install/bin` to your PATH.

git clone https://github.com/steveicarus/iverilog.git
mkdir iverilog_install
cd iverilog
autoconf
./configure --prefix=`realpath ../iverilog_install`
make -j 8
make install
```
Add `iverilog_install/bin` to your PATH.

To run, then try:
```bash
cd pbt/tests
cocotb-clean
SIM=verilator pytest -vv
```

## Standalone tests (just using cocotb-test)
```bash
cd standalone
cocotb-clean
SIM=verilator pytest -vv
cocotb-clean
SIM=icarus pytest -vv -k dff
cocotb-clean
SIM=icarus pytest -vv -k AluMMX
```


## Docker

```bash
docker build . -f Dockerfile.base -t cocotb_base

docker build . -t cocotb_image

docker run -it cocotb_image bash -c "source /opt/venv/bin/activate && cd /pbt && SIM=verilator pytest"
```
