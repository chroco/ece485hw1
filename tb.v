/*
	Chad Coates
	ECE 485
	Homework 1
	October 8, 2017

	tb.v

	A fun little testbench to help crash imaginary trains
	on an imaginary track! 
	
	Adapted from the TBird example
//*/

module TestTrainState;

reg RESET,Clock;
reg [4:1] SR;

wire [3:1] SW;
wire [1:0] DA, DB;

parameter TRUE   = 1'b1;
parameter FALSE  = 1'b0;
parameter CLOCK_TIMES  = 20;
parameter CLOCK_WIDTH  = CLOCK_TIMES/2;
parameter IDLE_CLOCKS  = 1;
parameter TIMES = 1;

TrainState ts(SW,DA,DB,RESET,SR,Clock);
initial
begin
	$display("               Clock RESET    SR   SW  DA  DB");
	$monitor($time, "     %b  %b  %b  %b  %b",RESET,SR,SW,DA,DB);
end

initial
begin
	Clock = FALSE;
	forever #CLOCK_WIDTH Clock = ~Clock;
end

// Generate RESET signal for IDLE_CLOCKS cycle

initial
begin
	RESET = TRUE;
	repeat (IDLE_CLOCKS) @(negedge Clock);
	RESET = FALSE;
end

// Generate stimulus after waiting for reset
initial
begin
	// test all possible transitions
	repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0001;repeat (TIMES) @(negedge Clock); // Init -> Ago
	{SR} = 4'b1000;repeat (TIMES) @(negedge Clock); // Ago -> Init
	{SR} = 4'b0001;repeat (TIMES) @(negedge Clock); // Init -> Ago
	
	{RESET} = 1'b1;repeat (TIMES) @(negedge Clock); // RESET
	{RESET} = 1'b0;repeat (TIMES) @(negedge Clock); // RESET

	{SR} = 4'b0010;repeat (TIMES) @(negedge Clock); // Init -> Bgo
	{SR} = 4'b0100;repeat (TIMES) @(negedge Clock); // Bgo -> Init
	{SR} = 4'b0010;repeat (TIMES) @(negedge Clock); // Init -> Bgo
	{SR} = 4'b1010;repeat (TIMES) @(negedge Clock); // Bgo -> Ago

	{SR} = 4'b0010;repeat (TIMES) @(negedge Clock); // Ago -> Bstop
	{SR} = 4'b1000;repeat (TIMES) @(negedge Clock); // Bstop -> Bgo
	{SR} = 4'b0001;repeat (TIMES) @(negedge Clock); // Bgo -> Astop
	{SR} = 4'b0100;repeat (TIMES) @(negedge Clock); // Astop -> Ago
	
	{SR} = 4'b0101;repeat (TIMES) @(negedge Clock); // Ago -> Bgo
	{SR} = 4'b0100;repeat (TIMES) @(negedge Clock); // Bgo -> Init
	
	{SR} = 4'b0011;repeat (TIMES) @(negedge Clock); // Init -> Astop
	{SR} = 4'b0100;repeat (TIMES) @(negedge Clock); // Astop -> Ago
	{SR} = 4'b1000;repeat (TIMES) @(negedge Clock); // Ago -> Init
	$finish;
end

endmodule
/*
	transitions
	{RESET} = 1'b1;repeat (TIMES) @(negedge Clock); // RESET

	{SR} = 4'b0001;repeat (TIMES) @(negedge Clock); // Init -> Ago
	{SR} = 4'b0010;repeat (TIMES) @(negedge Clock); // Init -> Bgo
	{SR} = 4'b0011;repeat (TIMES) @(negedge Clock); // Init -> Astop

	{SR} = 4'b1000;repeat (TIMES) @(negedge Clock); // Ago -> Init
	{SR} = 4'b0010;repeat (TIMES) @(negedge Clock); // Ago -> Bstop
	{SR} = 4'b0101;repeat (TIMES) @(negedge Clock); // Ago -> Bgo

	{SR} = 4'b0100;repeat (TIMES) @(negedge Clock); // Bgo -> Init
	{SR} = 4'b0001;repeat (TIMES) @(negedge Clock); // Bgo -> Astop
	{SR} = 4'b1010;repeat (TIMES) @(negedge Clock); // Bgo -> Ago

	{SR} = 4'b1000;repeat (TIMES) @(negedge Clock); // Bstop -> Bgo
	
	{SR} = 4'b0100;repeat (TIMES) @(negedge Clock); // Astop -> Ago
//*/


