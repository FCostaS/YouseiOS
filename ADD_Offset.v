module ADD_Offset(Endereco,Offset,OutADD);
	input [31:0] Endereco,Offset;
	output[31:0] OutADD;
	
	assign OutADD = Endereco + Offset;
	
endmodule
