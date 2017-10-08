module TrainState(SW,DA,DB,RESET,SR,Clock);

input RESET, Clock;
input [4:1] SR;

output [3:1] SW;
output [1:0] DA, DB;

reg [3:1] SW;
reg [1:0] DA, DB;

parameter
	Ago   = 7'b0000101,
	Bgo   = 7'b0110101,
	Astop = 7'b0110001,
	Bstop = 7'b0000100;

reg [6:0] State, NextState;

always @(State)
begin
case (State)
	Ago: 
		begin
/*
		SW[3:1] = 3'b000;
		DA[1:0] = 2'b01;
		DB[1:0] = 2'b01;
//*/
		SW = 3'b000;
		DA = 2'b01;
		DB = 2'b01;
	end
	Bgo: 
		begin
		SW[3:1] = 3'b011;
		DA[1:0] = 2'b01;
		DB[1:0] = 2'b01;
		end
	Astop: 
		begin
		SW[3:1] = 3'b011;
		DA[1:0] = 2'b00;
		DB[1:0] = 2'b01;
		end
	Bstop: 
		begin
		SW[3:1] = 3'b000;
		DA[1:0] = 2'b01;
		DB[1:0] = 2'b00;
		end
endcase
end

always @(posedge Clock)
begin
	if (RESET) State = Bgo;
end

always @(State)
begin
case (State) 
	Ago:
		if (RESET) begin
			NextState = Bgo;
		end else if (SR[2] && ~SR[4]) begin
			NextState = Bstop;
		end	else if (SR[2] && SR[4]) begin
			NextState = Bgo;
		end
	Bgo:
		if (RESET) begin
			NextState = Bgo;
		end else if (SR[1] && ~SR[3])begin
			NextState = Astop;
		end else if ((SR[1] && SR[2]) || (SR[1] && ~SR[2] && ~SR[3])) begin
			NextState = Bstop;
		end else if ((SR[1] && SR[3]) || (SR[1] && ~SR[2])) begin
			NextState = Ago;
		end
	Astop:
		if (RESET) begin
			NextState = Bgo;
		end else if(SR[3]) begin
			NextState = Ago;
		end
	Bstop:
		if (RESET) begin
			NextState = Bgo;
		end else if(SR[4]) begin
			NextState = Bgo;
		end
endcase
end

endmodule
