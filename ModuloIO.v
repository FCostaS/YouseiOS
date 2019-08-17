module ModuloIO(Clock,Reset,Switches,Set,HaltIAS,OpIO,Endereco,DadosSaida,detector_out,DataIO,OutputData);
	input OpIO,HaltIAS,Set,Clock,Reset;
	input [31:0] Endereco,DadosSaida;
	input [12:0] Switches;
	output wire [31:0] DataIO;
	output reg [31:0] OutputData;
	
	reg [1:0] state;
	reg current_state, next_state;
	parameter  A=1'b0, B=1'b1;
	
	assign DataIO = {{19{1'B0}},Switches};
	output reg detector_out;

	always@(posedge Clock)
	begin
		if(OpIO == 1'B1)
		begin
			if(~HaltIAS)
			begin
				OutputData = DadosSaida;
			end

		end
	end

	always @(negedge Clock)
	begin
	 if(Reset==0) 
		current_state <= A;
		 else
		 current_state <= next_state;
	end 

	
	always @(current_state,HaltIAS,Set)
	begin
	 case(current_state) 
		 A:begin
		  if(HaltIAS==0)
				next_state <= A;
		  else
			next_state <= B;
		 end
		 B:begin
		  if(Set==1)
			next_state <= B;
		  else
			next_state <= A;
		 end
		 default: next_state <= A;
	 endcase
	end

	always @(current_state)
	begin 
	 case(current_state) 
		 A:  detector_out <= 0;
		 B:  detector_out <= 1;
	 endcase
	end
	
	
endmodule
