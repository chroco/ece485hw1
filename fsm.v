module TrainState(SW,DA,DB,RESET,SR,Clock);

input RESET, Clock;
input [4:1] SR;

output [3:1] SW;
output [1:0] DA, DB;

reg [3:1] SW;
reg [1:0] DA, DB;

parameter
	Ago   = 4'b0001,
	Bgo   = 4'b0010,
	Astop = 4'b0100,
	Bstop = 4'b1000;

reg [3:0] State, NextState;

always @(posedge Clock)
begin
	if (RESET) 
		State <= Bgo;
	else
		State <= NextState;
end

always @(State)
begin
case (State)
	Ago: 
		begin
		SW = 3'b000;
		DA = 2'b01;
		DB = 2'b01;
		end
	Bgo: 
		begin
		SW = 3'b011;
		DA = 2'b01;
		DB = 2'b01;
		end
	Astop: 
		begin
		SW = 3'b011;
		DA = 2'b00;
		DB = 2'b01;
		end
	Bstop: 
		begin
		SW = 3'b000;
		DA = 2'b01;
		DB = 2'b00;
		end
endcase
end

always @(State or SR[4] or SR[3] or SR[1] or SR[2])
begin
case (State) 
	Ago:
		begin
		if (SR[2] && ~SR[4])
			NextState = Bstop;
		else if (SR[2] && SR[4])
			NextState = Bgo;
		end
	Bgo:
		begin
		if (SR[1] && ~SR[3])
			NextState = Astop;
		else if ((SR[1] && SR[2]) || (SR[1] && ~SR[2] && ~SR[3]))
			NextState = Bstop;
		else if ((SR[1] && SR[3]) || (SR[1] && ~SR[2]))
			NextState = Ago;
		end
	Astop:
		begin
		if(SR[3])
			NextState = Ago;
		end
	Bstop:
		begin
		if(SR[4])
			NextState = Bgo;
		end
endcase
end

endmodule
