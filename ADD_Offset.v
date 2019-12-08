module ADD_Offset(Endereco,Offset,OutADD);
	input [31:0] Endereco,Offset;
	output reg[31:0] OutADD;
	
	always @ (Endereco or Offset)
	begin
		OutADD <= Endereco + Offset;
	end
	
endmodule
