module SistemaDeArquivos
(
	input	clk, SavePage,
	input [4:0] PID,
	input [31:0] PageInfo,
	output reg [31:0] LocalData,
	output wire [31:0] Page_out
);

	reg [31:0] Paginas[10:0];
	reg [4:0] PID_Add;
	
	always @ (PID)
	begin
		
		LocalData <= 50 * PID;
	
	end

	always @ (posedge clk)
	begin
		
		if(SavePage)
		begin
			Paginas[PID_Add] = PageInfo; // Empilha pagina
			PID_Add = PID_Add + 5'd1;
		end
		
	end
	
	assign Page_out = Paginas[PID];


endmodule
