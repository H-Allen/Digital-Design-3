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
ExecStep $xv_path/bin/xsim counter_TB_behav -key {Behavioral:sim_1:Functional:counter_TB} -tclbatch counter_TB.tcl -view /home/s2524342/Documents/Digital -log simulate.log
