FROM stevenmburns/cocotb_base:2020Jan19 as cocotb_image

RUN bash -c "source $venv/bin/activate && git clone https://github.com/bespoke-silicon-group/basejump_stl.git && git clone https://github.com/cocotb/cocotb && cd cocotb && pip install -e . && cd - && git clone https://github.com/themperek/cocotb-test.git && cd cocotb-test && pip install -e . && cd -"

RUN bash -c "source $venv/bin/activate && pip install coverage coverage-badge"

COPY pbt /pbt

WORKDIR /pbt
