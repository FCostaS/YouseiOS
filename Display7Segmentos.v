module Display7Segmentos(entrada,saida);
	// entrada: W[3]-X[2]-Y[1]-Z[0]
	// saida: a[6]-b[5]-c[4]-d[3]-e[2]-f[1]-g[0]
	input [3:0] entrada;
	output [6:0] saida;
	reg [6:0] saida;

	always@(entrada)
	begin
		case(entrada)
			4'b0000: begin saida = ~ 7'b1111110; end
			4'b0001: begin saida = ~ 7'b0110000; end
			4'b0010: begin saida = ~ 7'b1101101; end
			4'b0011: begin saida = ~ 7'b1111001; end
			4'b0100: begin saida = ~ 7'b0110011; end
			4'b0101: begin saida = ~ 7'b1011011; end
			4'b0110: begin saida = ~ 7'b1011111; end
			4'b0111: begin saida = ~ 7'b1110000; end
			4'b1000: begin saida = ~ 7'b1111111; end
			4'b1001: begin saida = ~ 7'b1111011; end
			default: begin saida = ~ 7'b0000000; end
		endcase
	end
endmodule
