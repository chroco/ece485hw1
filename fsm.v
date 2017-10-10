/*
	Chad Coates
	ECE 485
	Homework 1
	October 8, 2017

	fsm.v

	A fun little fsm for preventing 2 trains from
	colliding on a shared piece of track

	Adapted from the TBird example
//*/

module TrainState(SW,DA,DB,RESET,SR,Clock);

input RESET, Clock;
input [4:1] SR;

output [3:1] SW;
output [1:0] DA, DB;

reg [3:1] SW;
reg [1:0] DA, DB;

parameter
	Init	= 5'b00001,
	Ago   = 5'b00010,
	Bgo   = 5'b00100,
	Astop = 5'b01000,
	Bstop = 5'b10000;

reg [4:0] State, NextState;

always @(posedge Clock)
begin
	if (RESET) 
		State <= Init;
	else
		State <= NextState;
end

always @(State)
begin
case (State)
	Init: begin // o_0
		SW = 3'b011;
		DA = 2'b01;
		DB = 2'b01;
		end
	Ago: begin
		SW = 3'b000;
		DA = 2'b01;
		DB = 2'b01;
		end
 // Init and Bgo have the same output
	Bgo: begin // o_0
		SW = 3'b011;
		DA = 2'b01;
		DB = 2'b01;
		end
	Astop: begin
		SW = 3'b011;
		DA = 2'b00;
		DB = 2'b01;
		end
	Bstop: begin
		SW = 3'b000;
		DA = 2'b01;
		DB = 2'b00;
		end
endcase
end

always @(State or SR)//[4] or SR[3] or SR[1] or SR[2])
begin
	case (State) 
		Init: begin 
			if (SR[1] && !SR[2])
				NextState = Ago;
			else if (SR[1] && SR[2])
				NextState = Astop;
			else if (!SR[1] && SR[2])	
				NextState = Bgo;
			end
		Ago: begin
			if (SR[1] && SR[3])
				NextState = Bgo;
			else if (SR[2] && !SR[4])
				NextState = Bstop;
			else if (SR[4])
				NextState = Init;
			end
		Bgo: begin
			if (SR[2] && SR[4])
				NextState = Ago;
			else if (SR[1] && !SR[3])
				NextState = Astop;
			else if (SR[3])
				NextState = Init;
			end
		Astop: begin
			if(SR[3])
				NextState = Ago;
			end
		Bstop: begin
			if(SR[4])
				NextState = Bgo;
			end
	endcase
end

endmodule
