#!/bin/bash

export DRAGON_HOME=$(pwd)
export PYTHONDONTWRITEBYTECODE=1

alias dragon_mk="make -C $DRAGON_HOME/sim/cocotb/test"
