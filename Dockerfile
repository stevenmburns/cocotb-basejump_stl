FROM stevenmburns/cocotb_base:v5.002p as cocotb_image

# Environment variable venv is set in cocotb_base

RUN bash -c "source ${venv:?}/bin/activate && git clone https://github.com/bespoke-silicon-group/basejump_stl.git && git clone https://github.com/cocotb/cocotb && cd cocotb && pip install -e . && cd - && git clone https://github.com/themperek/cocotb-test.git && cd cocotb-test && pip install -e . && cd -"

RUN bash -c "source ${venv:?}/bin/activate && pip install coverage coverage-badge"

COPY pbt /pbt
COPY standalone /standalone

WORKDIR /standalone
