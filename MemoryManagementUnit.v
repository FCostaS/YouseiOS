module MemoryManagementUnit(
		input BiosSign,
		input [31:0] LogicalAddrress, Page,
		output reg [31:0] FisicalAddress
	);
	
	reg [31:0] Shift;
	
	always@(Page or BiosSign)
	begin
		if(BiosSign)
			Shift <= 32'B0; // Nao ha deslocamento com shift ativado
		else
			Shift <= {16'B0, Page[31:16]};
	end
	
	always@(LogicalAddrress or Shift)
	begin
	
		FisicalAddress <= LogicalAddrress + Shift - 1;
		
	end	
	
endmodule
	