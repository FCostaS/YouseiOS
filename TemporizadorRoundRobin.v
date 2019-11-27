module TemporizadorRoundRobin(
	input clk, reset, Atv_Temp, Block,
	input [4:0] PID_in,
	output reg [4:0] PID_out
);

	reg [5:0] Count;
	parameter Quantum = 6'B111110; // Quantum de 63 instruçoes

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
	always @ (state or PID_in) begin
		case (state)
			S0:
			begin
				PID_out <= 5'B00000;
			end
			S1:
			begin
				PID_out <= PID_in;
			end
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

