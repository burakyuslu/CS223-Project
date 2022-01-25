`timescale 1ns / 1ps

module reg_module(
input reset,
input load, // enables load
input [15:0] ldValue, // value to load into the register
input [2:0] regSelection, // select 1 of the 4 registers
input [15:0] counter,
output reg [15:0] regContent, // contents of the selected register
// the 4 register values
output reg [15:0] reg_0,
output reg [15:0] reg_1,
output reg [15:0] reg_2,
output reg [15:0] reg_3
 );
 
    always_comb
    begin
        // if load is enabled, load the data into the register 
        if( load)
        begin
            if( regSelection == 3'b000)
            begin
                reg_0 = ldValue;
            end
            if( regSelection == 3'b001)
            begin
                reg_1 = ldValue;
            end
            if( regSelection == 3'b010)
            begin
                reg_2 = ldValue;
            end
            if( regSelection == 3'b011)
            begin
                reg_3 = ldValue;
            end
        end
        if( reset)
        begin
            reg_0 = 0;
            reg_1 = 0;
            reg_2 = 0;
            reg_3 = 0;
        end
       
       // display the contents of the selected register
       if( regSelection == 3'b000)
        begin
            regContent = reg_0;
        end
        else if( regSelection == 3'b001)
        begin
            regContent = reg_1;
        end
        else if( regSelection == 3'b010)
        begin
            regContent = reg_2;
        end
        else if( regSelection == 3'b011)
        begin
            regContent = reg_3;
        end
        else
        begin
            regContent = counter;
        end
    end
 
endmodule
