module TemporizadorRoundRobin(
	input clk, reset, Atv_Temp, Block,
	output reg SO_Kernel
);

	reg [5:0] Count;
	parameter Quantum = 6'B010100;

	always @ (posedge clk)
	begin
	
		if(~state)
			Count <= 0;
		else if(Block)
			Count <= Count; // Bloqueio contador
		else
			Count <= Count + 6'B000001;
	
	end
	
	// Declare state register
	reg state;

	// Declare states
	parameter S0 = 1'B0, S1 = 1'B1;

	// Output depends only on the state
	always @ (state) begin
		case (state)
			S0:
				SO_Kernel = 1'b0;
			S1:
				SO_Kernel = 1'b1;
			default:
				SO_Kernel = 1'b0;
		endcase
	end

	// Determine the next state
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			state <= S0;
		else
			case (state)
				S0:
				begin
					if(Atv_Temp)
						state <= S1;
					else
						state <= S0;
				end
				S1:
				begin
					if (Count < Quantum)
						state <= S1;
					else
						state <= S0;
				end
				
				default:
				begin
					state <= S0;
				end
				
			endcase
	end
endmodule

