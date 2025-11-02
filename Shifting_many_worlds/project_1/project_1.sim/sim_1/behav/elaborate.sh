#!/bin/sh -f
xv_path="/opt/Xilinx/Vivado/2015.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto bd3c001d05bc4a1dbaf424c54c32aebb -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot Shift_reg2d_TB_behav xil_defaultlib.Shift_reg2d_TB xil_defaultlib.glbl -log elaborate.log
