module VARIAVEIS_AMBIENTE(
	input clk, reset, SavePage,
	input [31:0] Instrucao,
	input [4:0] PID_Data,
	output wire [4:0] PID_out, 
	output reg [4:0] MSG_OUT,
	output reg MSG_Sign, Page_Update, MemWrite
	);

	parameter EMIT_MSG    = 6'B011010,
				 ROUND_ROBIN = 6'B011011,
				 SET_PID     = 6'B011100,
				 CREATE_FILE = 6'B011101,
				 KERNEL_SWAP = 6'B100001,
				 INPUT       = 6'B001000,
				 HD_READ     = 6'B011111,
				 END_FILE    = 6'B010110;
	
	wire [5:0] Opcode;
	reg [4:0] PID;
	reg Temporizer, reset_RR, Block_Temporizer;
	
	initial 
	begin : INIT
		PID <= 5'b00000; /* Indico que a BIOS esta ativa */
	end

	assign Opcode = Instrucao[31:26];

	always @ (posedge clk)
	begin
	
		case(Opcode)
		
		SET_PID:
		begin
			PID        <= PID_Data;
			Temporizer <= 1'B1;
			MSG_Sign   <= 1'B0;
			reset_RR   <= 1'B0;
			MemWrite   <= 1'B0;
		end
		
		EMIT_MSG:
		begin
			MSG_OUT    <= Instrucao[4:0];
			MSG_Sign   <= 1'B1;
			Temporizer <= 1'B0;
			reset_RR   <= 1'B0;
			MemWrite   <= 1'B0;
		end
		
		ROUND_ROBIN:
		begin
			MSG_OUT    <= 5'B00000;
			Temporizer <= 1'B1;
			MSG_Sign   <= 1'B0;
			reset_RR   <= 1'B0;
			MemWrite   <= 1'B0;
		end
		
		KERNEL_SWAP:
		begin
			MSG_OUT    <= 5'B00000;
			Temporizer <= 1'B0;
			MSG_Sign   <= 1'B0;
			reset_RR   <= 1'B1;
			MemWrite   <= 1'B0;
		end
		
		HD_READ:
		begin
			MSG_OUT    <= 5'B00000;
			Temporizer <= 1'B0;
			MSG_Sign   <= 1'B0;
			reset_RR   <= 1'B0;
			MemWrite   <= 1'B1;
		end
		
		default:
		begin
			MSG_OUT    <= 5'B00000;
			Temporizer <= 1'B0;
			MSG_Sign   <= 1'B0;
			reset_RR   <= 1'B0;
			MemWrite   <= 1'B0;
		end
		
	endcase

	end
	
	// Atualizacao da Pagina
	always @ (SavePage or Opcode)
	begin
		if(SavePage || (Opcode == CREATE_FILE))
		begin
			Page_Update <= 1'B1;
		end
			else
				Page_Update <= 1'B0;
	end
	
	// Escolha entre modo Kernel e modo usuario
	always @(Opcode or Temporizer)
	begin	
			
		if(Opcode == INPUT)
			Block_Temporizer <= 1'B1;
		else
			Block_Temporizer <= 1'B0;
			
	end
	
	TemporizadorRoundRobin TRR(.clk(clk), .reset(reset_RR), .Atv_Temp(Temporizer), .Block(Block_Temporizer), .PID_in(PID) , .PID_out(PID_out));


endmodule
