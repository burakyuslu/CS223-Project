`timescale 1ns / 1ps

module game(
input logic clk,
input logic start,
input logic reset,
input button1, button2, button3, button4, // buttons that trigger the next state for the buttons of the specific group
// 4 registers that will be used to initialize the leds
input logic [15:0] reg_0,
input logic [15:0] reg_1,
input logic [15:0] reg_2,
input logic [15:0] reg_3,
output logic [15:0] counter,
output logic [7:0][7:0] matrix_LEDs,
output logic gameFinished
);
    logic [7:0][7:0] matrix_CellGroups;
    logic [15:0] tempCounter;
        
    // initialize the matrix for the cell groups
    // the matrix is initialized accoring to my student number 21801745
    logic [7:0][7:0] matrix_G1 = {{1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1},
    {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1},
    {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1},
    {1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1}};
    
    logic [7:0][7:0] matrix_G2 = {{1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0},
    {1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0},
    {1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0},
    {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0}};
    
    logic [7:0][7:0] matrix_G3 = {{1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1},
    {1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0},
    {1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0},
    {1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0}};
    
    logic [7:0][7:0] matrix_G4 = {{1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0},
    {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1},
    {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
    {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1},
    {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}};
    
    logic blinkSig;
    timerBlink blinker( clk, blinkSig);

    // variables required to process only 1 time (1-time-checking-logic)
    logic buttonChecker1;
    logic buttonChecker2;
    logic buttonChecker3;
    logic buttonChecker4;
    
    // initialize the leds & update according to button presses
    always_ff@( posedge clk)
    begin
        static logic button1State = button1;
        static logic button2State = button2;
        static logic button3State = button3;
        static logic button4State = button4;
        static logic startPressed = start;
        
        if( button1State == 0)
        begin
            buttonChecker1 = 1;
        end
        if( button2State == 0)
        begin
            buttonChecker2 = 1;
        end 
        if( button3State == 0)
        begin
            buttonChecker3 = 1;
        end 
        if( button4State == 0)
        begin
            buttonChecker4 = 1;
        end         
        
        if( (startPressed || reset))
        begin
            counter = 15'b0;
        end
        
        if( (startPressed || reset))
        begin
            static int  regIndex = 0;
            // initialize the first quadrant using reg_0
            for( int row = 0; row < 4; row++)
            begin
                for( int col = 0; col < 4; col++)
                begin
                    matrix_LEDs[row][col] = reg_0[regIndex];
                    regIndex++;
                end
            end
            
            // initialize the second quadrant using reg_1
            regIndex = 0;
            for( int row = 4; row < 8; row++)
            begin
                for( int col = 0; col < 4; col++)
                begin
                    matrix_LEDs[row][col] = reg_1[regIndex];
                    regIndex++;
                end
            end
            
            // initialize the second quadrant using reg_2
            regIndex = 0;
            for( int row = 0; row < 4; row++)
            begin
                for( int col = 4; col < 8; col++)
                begin
                    matrix_LEDs[row][col] = reg_2[regIndex];
                    regIndex++;
                end
            end
            
            // initialize the second quadrant using reg_3
            regIndex = 0;
            for( int row = 4; row < 8; row++)
            begin
                for( int col = 4; col < 8; col++)
                begin
                    matrix_LEDs[row][col] = reg_3[regIndex];
                    regIndex++;
                end
            end
         end

        if( gameFinished == 0)
        begin
            tempCounter = counter;
        end
        
        // blink if game over
        if( gameFinished)
        begin
            if( blinkSig)
            begin
                for(int i = 0; i <= 15; i++)
                begin
                    if( tempCounter[i] == 1)
                    begin
                        counter[i] = ~counter[i];
                    end
                end
            end
        end
         
        // update according to the button pushes
        if(button1State)
        begin
            if(buttonChecker1)
            begin
                counter++; 
                buttonChecker1 = 0;

                // find the group-1 cells  
                for( int row = 0; row <= 7; row++)
                begin
                    for( int col = 0; col <= 7; col++)
                    begin
                        if( matrix_G1 [row] [col] == 1) // found a group-1 cell
                        begin
                            // check & update according to rules
                            //  up = 1, left = 1, right = 1, down = 0
                            if( (   (matrix_LEDs [row] [((col + 1) % 8)] == 1) &&
                                    (matrix_LEDs [((row  + 7) % 8)] [col] == 1) &&
                                    (matrix_LEDs [((row + 1) % 8)] [col] == 1) &&
                                    (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                            begin 
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 1, left = 1, right = 0, down = 0
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) &&
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 1) &&
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 1, left = 0, right = 1, down = 0
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) &&
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 0) &&
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 1) &&
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 1, left = 0, right = 0, down = 1
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) &&
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 0) &&
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 0, left = 1, right = 0, down = 1
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 0) && 
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 1) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 0, left = 0, right = 0, down = 0
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 0) &&
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 0) &&
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            else
                            begin
                                matrix_LEDs[row] [col] = 0;
                            end
                        end
                    end
                end
            end  
        end
        
        else if(button2State)
        begin
            if(buttonChecker2)
            begin
                buttonChecker2 = 0;
                counter++;
                // find the group-2 cells
                for( int row = 0; row <= 7; row++)
                begin
                    for( int col = 0; col <= 7; col++)
                    begin
                        if( matrix_G2 [row] [col] == 1) // found a group-2 cell
                        begin
                            // check & update according to rules
                            //  up = 1, left = 1, right = 1, down = 0
                            if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) &&
                                    (matrix_LEDs [((row  + 7) % 8)] [col] == 1) &&
                                    (matrix_LEDs [((row + 1) % 8)] [col] == 1) &&  
                                    (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 1, left = 1, right = 0, down = 0
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) && 
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 1) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 1, left = 0, right = 1, down = 0
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) && 
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 0) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 1) &&  
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 1, left = 0, right = 0, down = 1
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) && 
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 0) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 0, left = 1, right = 0, down = 1
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 0) && 
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 1) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 0, left = 0, right = 0, down = 0
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 0) && 
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 0) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            else
                            begin
                                matrix_LEDs[row] [col] = 0;
                            end
                        end
                    end
                end
            end  
        end
        
        if(button3State)
        begin
            if(buttonChecker3)
            begin
                buttonChecker3 = 0;
                counter++;
                // find the group-3 cells
                for( int row = 0; row <= 7; row++)
                begin
                    for( int col = 0; col <= 7; col++)
                    begin
                        if( matrix_G3 [row] [col] == 1) // found a group-3 cell
                        begin
                            // check & update according to rules
                            //  up = 1, left = 1, right = 1, down = 0
                            if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) && 
                                    (matrix_LEDs [((row  + 7) % 8)] [col] == 1) && 
                                    (matrix_LEDs [((row + 1) % 8)] [col] == 1) &&  
                                    (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 1, left = 1, right = 0, down = 0
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) && 
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 1) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 1, left = 0, right = 1, down = 0
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) && 
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 0) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 1) &&  
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 1, left = 0, right = 0, down = 1
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) && 
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 0) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 0, left = 1, right = 0, down = 1
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 0) && 
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 1) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            //  up = 0, left = 0, right = 0, down = 0
                            else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 0) && 
                                        (matrix_LEDs [((row + 7) % 8)] [col] == 0) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                            begin
                                matrix_LEDs[row] [col] = 1;
                            end
                            else
                            begin
                                matrix_LEDs[row] [col] = 0;
                            end
                        end
                    end
                end
            end  
        end
        
        if(button4State)
        begin
            if( buttonChecker4)
            begin
                buttonChecker4 = 0;
                counter++;
                // find the group-4 cells
                for( int row = 0; row <= 7; row++)
                    begin
                        for( int col = 0; col <= 7; col++)
                        begin
                            if( matrix_G4 [row] [col] == 1) // found a group-4 cell
                            begin
                                // check & update according to rules
                                //  up = 1, left = 1, right = 1, down = 0
                                if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) &&
                                        (matrix_LEDs [((row  + 7) % 8)] [col] == 1) && 
                                        (matrix_LEDs [((row + 1) % 8)] [col] == 1) &&  
                                        (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                                begin
                                    matrix_LEDs[row] [col] = 1;
                                end
                                //  up = 1, left = 1, right = 0, down = 0
                                else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) && 
                                            (matrix_LEDs [((row + 7) % 8)] [col] == 1) && 
                                            (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                            (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                                begin
                                    matrix_LEDs[row] [col] = 1;
                                end
                                //  up = 1, left = 0, right = 1, down = 0
                                else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) && 
                                            (matrix_LEDs [((row + 7) % 8)] [col] == 0) && 
                                            (matrix_LEDs [((row + 1) % 8)] [col] == 1) &&  
                                            (matrix_LEDs [row] [((col + 7) % 8)] == 0) ) )
                                begin
                                    matrix_LEDs[row] [col] = 1;
                                end
                                //  up = 1, left = 0, right = 0, down = 1
                                else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 1) && 
                                            (matrix_LEDs [((row + 7) % 8)] [col] == 0) && 
                                            (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                            (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                                begin
                                    matrix_LEDs[row] [col] = 1;
                                end
                                //  up = 0, left = 1, right = 0, down = 1
                                else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 0) && 
                                            (matrix_LEDs [((row + 7) % 8)] [col] == 1) && 
                                            (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                            (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                                begin
                                    matrix_LEDs[row] [col] = 1;
                                end
                                //  up = 0, left = 0, right = 0, down = 0
                                else if( ( (matrix_LEDs [row] [((col + 1) % 8)] == 0) && 
                                            (matrix_LEDs [((row + 7) % 8)] [col] == 0) && 
                                            (matrix_LEDs [((row + 1) % 8)] [col] == 0) &&  
                                            (matrix_LEDs [row] [((col + 7) % 8)] == 1) ) )
                                begin
                                    matrix_LEDs[row] [col] = 1;
                                end
                                else
                                begin
                                    matrix_LEDs[row] [col] = 0;
                                end
                            end
                        end
                    end
                end  
            end
    end
    
    logic [7:0][7:0] emptyMatrix;
    initial
    begin
        emptyMatrix = {{1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
        {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
        {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
        {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
        {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
        {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
        {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0},
        {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}};
    end
    
    always_ff@(posedge clk)
    begin
        if ( (matrix_LEDs == emptyMatrix))
        begin
            gameFinished = 1;
        end
        else
        begin
            gameFinished = 0;
        end
    end
endmodule
