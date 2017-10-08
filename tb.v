module TestTrainState;
reg RESET,Clock;
reg [4:1] SR;
wire [3:1] SW;
wire [1:0] DA, DB;

parameter TRUE   = 1'b1;
parameter FALSE  = 1'b0;
parameter CLOCK_CYCLE  = 20;
parameter CLOCK_WIDTH  = CLOCK_CYCLE/2;
parameter IDLE_CLOCKS  = 2;

TrainState ts(SW,DA,DB,RESET,SR,Clock);
initial
begin
//	$display();
	$monitor($time, " %b %b %b %b %b",RESET, SR, SW, DA, DB );
end

initial
begin
	Clock = FALSE;
	forever #CLOCK_WIDTH Clock = ~Clock;
end

// Generate RESET signal for two cycles

initial
begin
	RESET = TRUE;
	repeat (IDLE_CLOCKS) @(negedge Clock);
	RESET = FALSE;
end

// Generate stimulus after waiting for reset

initial
begin
	//repeat (6) @(negedge Clock); {RESET,SR} = 5'b10000;
	repeat (50) @(negedge Clock); {RESET,SR} = 5'b00001;
	repeat (50) @(negedge Clock); {RESET,SR} = 5'b00010;
	repeat (50) @(negedge Clock); {RESET,SR} = 5'b00011;
	repeat (50) @(negedge Clock); {RESET,SR} = 5'b00100;
	repeat (50) @(negedge Clock); {RESET,SR} = 5'b00101;
	repeat (50) @(negedge Clock); {RESET,SR} = 5'b00110;
	repeat (50) @(negedge Clock); {RESET,SR} = 5'b00111;
	//repeat (6) @(negedge Clock); {RESET,SR} = 5'b00100;
	//repeat (6) @(negedge Clock); {RESET,SR} = 5'b00101;
	//repeat (6) @(negedge Clock); {RESET,SR} = 5'b10111;
end

endmodule
