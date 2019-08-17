module Mux_4(ReadData,DataIO,Resultado,Mem2Reg,M2R);
	input [31:0] ReadData,DataIO,Resultado;
	input [1:0] Mem2Reg;
	output reg [31:0] M2R;


	always@(ReadData or DataIO or Resultado or Mem2Reg)
	begin
		if( Mem2Reg == 2'B00 ) // D1||D2 0:1
		begin
			M2R = ReadData;
		end
			else if ( Mem2Reg == 2'B01 )
			begin
				M2R = DataIO;
			end
				else if( Mem2Reg == 2'B10 )
				begin
					M2R = Resultado;
				end
					else
					begin
						M2R = 32'B0;
					end
	end

endmodule
