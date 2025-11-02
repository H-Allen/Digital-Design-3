`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Simulation of Hello_world module
//Status of OUT follows the change of IN
//////////////////////////////////////////////////////////////////////////////////


module Hello_world_TB(
        );
        
    //inputs 
    reg IN;
    
    //outputs
    wire OUT;
    
    //instantiate the unit under test
    Hello_world uut (
        .IN(IN),
        .OUT(OUT)
    );
    
    //Activities of out test bench
    initial begin
        //wait 100ns for global reset to finish
        #100
        //initialise the inputs
        IN = 0;
        //something interesting
        #500 IN = 1;
     end
    

endmodule
