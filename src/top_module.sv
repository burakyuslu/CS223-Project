`timescale 1ns / 1ps

// Author: Burak Yigit Uslu
module top_module( input [3:0] digitValue, // value that is to be written inside the digit
input [1:0] digLocation, // specify the location of the digit
input enWrite, // enables writing the values to the specified digits
input clk, // the clock
input [2:0] regSelection, // select the register
input regLoad, // load the value into the selected register
input startGame, // starts part-3-game
input reset, // ends part 3, clears all the loaded values in all the registers!
input button1, button2, button3, button4, // buttons used in the third part
output reg [15:0] regContent, // contents of the selected register
output logic a, b, c, d, e, f, g, dp, // 7 seg
output [3:0] an, // 7 seg
output logic[7:0] rowsOut, // converter
output logic shcp, stcp, mr, oe, ds // converter
);
    logic [15:0] value_16_1;
    logic gameStarted;
    logic gameFinished;
    logic [15:0] counter;
    
    initial
    begin
        gameStarted = 0;
        gameFinished = 0;
    end
    
    // start game logic
    always_comb
    begin
        if(startGame)
        begin
            gameStarted = 1;
            gameFinished = 0;
        end
        else if(reset)
        begin
            gameStarted = 0;
            gameFinished = 0;
        end
    end
        
    // begin part-1
    // a 4 digit number is LL-LM-RM-RR
    logic [3:0] digValueLL; // value left left (leftmost)
    logic [3:0] digValueLM; // value left middle (middle to the left)
    logic [3:0] digValueRM; // value right middle (middle to the right)
    logic [3:0] digValueRR; // value right right (rightmost value)
    
    // update the actual||stored value obtained via switches if enWrite == 1
    always_comb
    begin
        if(enWrite )
        begin
            if(digLocation == 2'b11)
            begin
                digValueLL <= digitValue;
            end
            if(digLocation == 2'b10)
            begin
                digValueLM <= digitValue;
            end
            if(digLocation == 2'b01)
            begin
                digValueRM <= digitValue;
            end
            if(digLocation == 2'b00)
            begin
                digValueRR <= digitValue;       
            end
        end
    end
    
    always_comb
    begin
            value_16_1 [15:12] = digValueLL;
            value_16_1 [11:8] = digValueLM;
            value_16_1 [7:4] = digValueRM;
            value_16_1 [3:0] = digValueRR;
    end
    // end part-1
    
    // begin part-2
    reg [15:0] reg_0_top;
    reg [15:0] reg_1_top;
    reg [15:0] reg_2_top;
    reg [15:0] reg_3_top;
    
    reg_module reg_mod1(reset, regLoad, value_16_1, regSelection, counter, regContent, reg_0_top, reg_1_top, reg_2_top, reg_3_top);
    
     SevSeg_4digit display1( clk, digValueRR, digValueRM, digValueLM, digValueLL,  a, b, c, d, e, f, g, dp, an); 
    // end part-2
    
    // begin part-3    
    logic [7:0][7:0]led_matrix;
    game game1(clk, startGame, reset, button1, button2, button3, button4, reg_0_top, reg_1_top, reg_2_top, reg_3_top, counter, led_matrix, gameFinished);
    
    // display the LED condition obtained from the leds on the beti board
    converter dispBeti( clk, led_matrix, rowsOut, shcp, stcp, mr, oe, ds); 
    // end part-3
endmodule
