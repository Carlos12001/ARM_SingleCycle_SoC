module	ARM_InstructionMemory
	#(parameter BusWidth			= 32,
				InstrMemSize		= 64)
	(input logic[(BusWidth - 1):0]	i_Address,
	output logic[(BusWidth - 1):0]	o_Instr);

	//	Instruction Memory Array
	logic[(BusWidth - 1):0]			InstructionMemory[(InstrMemSize -1):0];

	//	Memory Initialisation
	initial
	begin
		$readmemh("C:/Users/carlo/Desktop/random/ARM_SingleCycle_SoC/src/ARM_Program.dat", InstructionMemory);
	end


	assign o_Instr = InstructionMemory[i_Address[31:2]];

endmodule


module	ARM_DataMemory
	#(parameter	BusWidth	= 32,
				DataMemSize	= 64)
	(input logic					i_CLK,// i_RESET,

	//	Write Control
	input logic						i_Write_Enable,

	input logic[(BusWidth - 1):0]	i_Address,

	//	Data Control
	input logic[(BusWidth - 1):0]	i_Write_Data,
	output logic[(BusWidth - 1):0]	o_Read_Data);

	//int i;
	//	RAM Array
	logic[(BusWidth - 1):0]			RAM[(DataMemSize - 1):0];


	//	Write logic
	always_ff	@(posedge i_CLK)//, posedge i_RESET)
	begin
		if (i_Write_Enable)	RAM[i_Address[(BusWidth - 1):2]] <= i_Write_Data;
	end

	assign o_Read_Data = RAM[i_Address[(BusWidth - 1):2]];

endmodule