# Experiment integrating basejump_stl, cocotb, cocotb-test, and hypothesis

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
