#! /bin/bash

$BOARD="ti_ek-tm4c123gxl.cfg"
# $BOARD="ti_ek-tm4c1294xl.cfg"

openocd -f /usr/share/openocd/scripts/board/$BOARD
