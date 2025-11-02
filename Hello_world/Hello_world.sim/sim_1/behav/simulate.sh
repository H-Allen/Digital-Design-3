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
ExecStep $xv_path/bin/xsim Hello_world_TB_behav -key {Behavioral:sim_1:Functional:Hello_world_TB} -tclbatch Hello_world_TB.tcl -log simulate.log
