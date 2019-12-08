module ProccessControlBlock(
		input clk,
		input [4:0] PID,
		input [31:0] PC_in,
		output wire [31:0] PC_out
);
	
	reg [31:0] Contexto_PC [10:0];
	
	always@(posedge clk)
	begin
		Contexto_PC[PID] = PC_in;
		//PC_out = Contexto_PC[PID];
	end
	
	assign PC_out = Contexto_PC[PID];
	
endmodule
