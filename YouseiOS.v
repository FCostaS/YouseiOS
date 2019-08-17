module YouseiOS(Clock50M,Reset,Type,Set,Swap,Switches,Output);

	input Clock50M,Reset,Set,Swap,Type;
	input [12:0] Switches;
	output wire [31:0] Output;
	
	Processador CPU(Clock50M,Reset,Type,Set,Swap,Switches,Output);

endmodule
