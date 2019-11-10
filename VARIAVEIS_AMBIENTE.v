module VARIAVEIS_AMBIENTE(
	input clk, reset, SavePage,
	input [31:0] Instrucao,
	output reg [4:0] PID_out, MSG_OUT,
	output reg MSG_Sign, Page_Update
	);

	parameter EMIT_MSG    = 6'B011010,
				 ROUND_ROBIN = 6'B011011,
				 SET_PID     = 6'B011100,
				 CREATE_FILE = 6'B011101;
	
	wire [5:0] Opcode;
	wire SO_Kernel;
	reg [4:0] PID;
	reg Temporizer;
	
	initial 
	begin : INIT
		PID <= 5'b00000; /* Indico que a BIOS esta ativa */
	end

	assign Opcode = Instrucao[31:26];

	always @ (posedge clk)
	begin
	
		if(SavePage || (Opcode == CREATE_FILE))
		begin
			Page_Update <= 1'B1;
		end
			else
				Page_Update <= 1'B0;
		
		case(Opcode)
		
		SET_PID:
		begin
			PID        <= Instrucao[4:0];
			Temporizer <= 1'B0;
			MSG_Sign   <= 1'B0;
		end
		
		EMIT_MSG:
		begin
			MSG_OUT    <= Instrucao[4:0];
			MSG_Sign   <= 1'B1;
			Temporizer <= 1'B0;
		end
		
		ROUND_ROBIN:
		begin
			Temporizer <= 1'B1;
			MSG_Sign   <= 1'B0;
		end
		
		default:
		begin
			Temporizer <= 1'B0;
			MSG_Sign   <= 1'B0;
		end
		
	endcase
	
	end
	
	// Escolha entre modo Kernel e modo usuario
	always @(*)
	begin
	
		if(SO_Kernel)
			PID_out <= 5'B00000;
		else
			PID_out <= PID;
			
	end
	
	TemporizadorRoundRobin TRR(.clk(clk), .reset(reset), .Atv_Temp(Temporizer), .SO_Kernel(SO_Kernel));


endmodule
