module TestTrainState;
reg RESET,Clock;
reg [4:1] SR;
wire [3:1] SW;
wire [1:0] DA, DB;

parameter TRUE   = 1'b1;
parameter FALSE  = 1'b0;
parameter CLOCK_TIMES  = 20;
parameter CLOCK_WIDTH  = CLOCK_TIMES/2;
parameter IDLE_CLOCKS  = 2;
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

// Generate RESET signal for two cycles

initial
begin
	RESET = TRUE;
	repeat (IDLE_CLOCKS) @(negedge Clock);
	RESET = FALSE;
end

// Generate stimulus after waiting for reset

reg [4:0] i;
initial
begin
//*
	repeat (TIMES) @(negedge Clock);
//	{RESET} = 1'b1;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0001;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0100;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0010;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b1000;repeat (TIMES) @(negedge Clock);

	{SR} = 4'b0001;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0100;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b1010;repeat (TIMES) @(negedge Clock);

	{SR} = 4'b0101;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b1010;repeat (TIMES) @(negedge Clock);
	
	{SR} = 4'b0001;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b1010;repeat (TIMES) @(negedge Clock);
//*/
	
/*
	repeat (TIMES) @(negedge Clock);
//	{RESET} = 1'b1;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0001;repeat (TIMES) @(negedge Clock);
//	$display(" %b %b %b %b %b",RESET ,SR, SW, DA, DB);
	{SR} = 4'b0100;repeat (TIMES) @(negedge Clock);
//	$display(" %b %b %b %b %b",RESET ,SR, SW, DA, DB);
	{SR} = 4'b1010;repeat (TIMES) @(negedge Clock);
//	$display(" %b %b %b %b %b",RESET ,SR, SW, DA, DB);
//*/
/*
	repeat (TIMES) @(negedge Clock);
	for(i=5'b0_0000;i<5'b1_0000;i=i+1'b1)
	begin
	{SR} = i[3:0];repeat (TIMES) @(negedge Clock);
	end
//*/
/*
	repeat (TIMES) @(negedge Clock);
//	{RESET} = 1'b1;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0000;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0001;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0010;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0011;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0100;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0101;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0110;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0111;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0100;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0101;repeat (TIMES) @(negedge Clock);
	{SR} = 4'b0111;repeat (TIMES) @(negedge Clock);
//*/
//	$stop;
	$finish;
end

endmodule
