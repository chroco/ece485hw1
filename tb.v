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
parameter CYCLE = 1;

TrainState ts(SW,DA,DB,RESET,SR,Clock);
initial
begin
//	$display();
	$monitor($time, " %b %b %b %b %b",RESET ,SR, SW, DA, DB);
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
//*
	repeat (CYCLE) @(negedge Clock);
//	{RESET} = 1'b1;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0001;repeat (CYCLE) @(negedge Clock);
//	$display(" %b %b %b %b %b",RESET ,SR, SW, DA, DB);
	{SR} = 4'b0100;repeat (CYCLE) @(negedge Clock);
//	$display(" %b %b %b %b %b",RESET ,SR, SW, DA, DB);
	{SR} = 4'b1010;repeat (CYCLE) @(negedge Clock);
//	$display(" %b %b %b %b %b",RESET ,SR, SW, DA, DB);
//*/
/*
	repeat (CYCLE) @(negedge Clock);
	{RESET} = 1'b1;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0000;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0001;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0010;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0011;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0100;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0101;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0110;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0111;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0100;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0101;repeat (CYCLE) @(negedge Clock);
	{SR} = 4'b0111;repeat (CYCLE) @(negedge Clock);
//*/
//	$stop;
	$finish;
end

endmodule
