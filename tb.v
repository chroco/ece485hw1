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
	$monitor($time, "%b %b %b %b %b\n",SR, SW, DA, DB );
end
endmodule


/*
reg [6:0] i;
	begin
		for(i=7'b000_0000;i<7'b100_0000;i=i+7'b000_0001)begin
			SR[1]=i[1];SR[2]=i[2];SR[3]=i[3];SR[4]=i[4];SR[5]=i[5];RESET=i[6];
			#30;
			$display(SW[3],SW[2],SW[1],DA[0],DB[0]);
		end
		$finish();
	end
//*/
