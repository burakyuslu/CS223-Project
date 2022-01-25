`timescale 1ns / 1ps

/*
NOT USED IN THE FINAL RELEASE
*/

module displayer_7seg(
 input clk,
 input enWrite,
 input [1:0] digLoc,
 input [3:0] digValue,
 input [15:0] counter,
 input gameStarted, 
 input gameFinished,
 output a, b, c, d, e, f, g, dp, an   
    );
    logic value1, value2, value3, value4;
    logic blinkSignal;
    
    assign blink = blinkSignal;
    
    always_ff@( posedge clk)
    begin
        if( enWrite)
        begin
            if( gameStarted == 0 && gameFinished == 0)
            begin
                if( digLoc == 2'b00)
                begin
                    value1 = digValue;
                end
                if( digLoc == 2'b01)
                begin
                    value2 = digValue;
                end
                if( digLoc == 2'b10)
                begin
                    value3 = digValue;
                end
                if( digLoc == 2'b11)
                begin
                    value4 = digValue;
                end
            end
         end
         
         if( gameStarted == 1)
         begin
            value1 = counter[3:0];
            value2 = counter[7:3];
            value3 = counter[11:8];
            value4 = counter[15:12];
         end
         
         if( gameFinished)
         begin
            blinkSignal = ~blinkSignal;
         end
     end
    
    SevSeg_4digit display1( clk, value1, value2, value3, value4,  a, b, c, d, e, f, g, dp, an); 
    
endmodule
