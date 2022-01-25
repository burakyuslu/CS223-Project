`timescale 1ns / 1ps

module timerBlink( 
input logic clk, 
output logic tick
);
    int a = 50000000;
    int periodNS  = a;
    
    always @( posedge clk)
    begin
        periodNS--;
        if( periodNS == 0)
        begin
            tick = ~tick;
            periodNS = a;
        end
    end

endmodule
