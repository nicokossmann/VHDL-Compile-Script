#!/bin/bash

# Zuerst chmod +x gmake.sh
# Zum Ausführen: ./gmake.sh {VHDL-Datei} {VHDL-Testbench} {Entity-Name}

P1="$1"
P2="${2:-"$1_tb"}"
P3="${3:-"$1_tb"}"
P4="${4:-waveform}"
P5="${5:-200}"

if [ -e "$P1.vhd" ]; then
    ghdl -a "$P1.vhd"
elif [ -e "$P1.vhdl" ]; then
    ghdl -a "$P1.vhdl"
else
    echo "$P1.vhd or $P1.vhdl does not exist!"
fi

if [ -e "$P2.vhd" ]; then
    ghdl -a "$P2.vhd"
    ghdl -e "$P3"
    ghdl -r "$P3" --vcd="$P4.vcd" --stop-time="$P5"ns
    gtkwave "$P4.vcd"
elif [ -e "$P2.vhdl" ]; then
    ghdl -a "$P2.vhdl"
    ghdl -e  "$P3"
    ghdl -r "$P3" --vcd="$P4.vcd" --stop-time="$P5"ns
    gtkwave "$P4.vcd"
else
    echo "$P2.vhd or $P2.vhdl does not exist!"
fi