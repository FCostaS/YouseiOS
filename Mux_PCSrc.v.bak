module Mux_PCSrc(Zero,Desvio,ResultadoSoma,OutADD,InputPC);
	input [31:0] OutADD,ResultadoSoma;
	input Zero,Desvio;
	output reg [31:0] InputPC;

	always@(Zero or OutADD or ResultadoSoma or Desvio)
	begin
		if( (Zero == 1'B0) || (Desvio == 1'B0) ) // OutADD||ResultadoSoma 0:1
		begin
			InputPC = OutADD;
		end
			else
			begin
				InputPC = ResultadoSoma;
			end
	end

endmodule
