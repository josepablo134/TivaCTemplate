$ENV:OPENOCD_PATH="D:\opt\openocd-v0.12.0-i686-w64-mingw32\"
$ENV:BOARD="ti_ek-tm4c123gxl.cfg"
# $ENV:BOARD="ti_ek-tm4c1294xl.cfg"

echo "Loading file $ENV:OPENOCD_PATH/share/openocd/scripts/board/$ENV:BOARD"

openocd -f "$ENV:OPENOCD_PATH/share/openocd/scripts/board/$ENV:BOARD"
