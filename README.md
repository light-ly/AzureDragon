# AzureDragon
A RISC-V 5-stage pipeline Core(Doing)

The repo is a simple rtl run and sim example with cocotb Now.  

## Install Tools

```
# python version should little than python 3.12
pip install cocotb
# ubuntu
sudo apt install gtkwave
```

## Prepare env

1. clone this repo

```
git clone https://github.com/light-ly/AzureDragon.git
```

2. go into work dir and init env

```
cd AzureDragon && source azure_dragon.sh
```

## Simulation

sim support **verilaor with cocotb** and **vcs**

### verilator with cocotb

1. compile and run test

```
dragon_mk
# or sim with waveform
dragon_mk WAVES=1
```

Simulation log will output on terminal.If first time you dont use WAVES, you should clean and excute the command again.

2. see waveform

```
dragon_mk show_wave
```

### vcs (TODO)
