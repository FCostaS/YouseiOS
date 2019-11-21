module MUX_MemoryShift(
	input Syscall_Sign,
	input [31:0] EnderecoLogico,Deslocamento,
	output reg [31:0] Out_Deslocamento
	);
	
	always @(EnderecoLogico or Deslocamento or Syscall_Sign)
	begin
		if(Syscall_Sign)
			Out_Deslocamento <= EnderecoLogico;
		else
			Out_Deslocamento <= EnderecoLogico + Deslocamento;	
	end
	
	
endmodule
