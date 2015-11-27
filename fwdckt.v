module Forwarding (input Ex_Mem_Regwrite, input [2:0] Ex_Mem_RegRd_2, input [2:0] Id_Ex_RegRd2, input [2:0] Id_Ex_RegRn2, input [2:0] Id_Ex_RegRn1, 
					input Mem_Wb_Regwrite, input [2:0] Mem_Wb_RegRd_3, input [2:0] Mem_Wb_RegRd_3_ld_wb, input [2:0] Id_Ex_RegRd1, output reg [1:0] FwdA, output reg [1:0] FwdB,
					output reg [1:0] FwdC, output reg [1:0] FwdD);
					
	always @(Ex_Mem_Regwrite or Ex_Mem_RegRd_2 or Id_Ex_RegRd2 or Id_Ex_RegRn2 or Id_Ex_RegRn1 or Mem_Wb_Regwrite or Mem_Wb_RegRd_3 or Id_Ex_RegRd1)
		
		begin
			if(Ex_Mem_Regwrite && Ex_Mem_RegRd_2 != 3'b000 && Ex_Mem_RegRd_2 == Id_Ex_RegRd2)
				FwdB=2'b01;
			else if(Mem_Wb_Regwrite && Mem_Wb_RegRd_3 != 3'b000 && Mem_Wb_RegRd_3 == Id_Ex_RegRd2)
				FwdB=2'b10;
			else if(Mem_Wb_Regwrite && Mem_Wb_RegRd_3 != 3'b000 && Mem_Wb_RegRd_3_ld_wb == Id_Ex_RegRd2)  //Check this
		    FwdB = 2'b11;
			else		
				FwdB=2'b00;

				
			if(Ex_Mem_Regwrite && Ex_Mem_RegRd_2 != 3'b000 && Ex_Mem_RegRd_2 == Id_Ex_RegRn2)
				FwdA=2'b01;
			else if(Mem_Wb_Regwrite && Mem_Wb_RegRd_3 != 3'b000 && Mem_Wb_RegRd_3 == Id_Ex_RegRn2)
				FwdA=2'b10;
		  else if(Mem_Wb_Regwrite && Mem_Wb_RegRd_3 != 3'b000 && Mem_Wb_RegRd_3_ld_wb == Id_Ex_RegRn2)  //Check this
		    FwdA = 2'b11;
			else
				FwdA=2'b00;

				
			if(Ex_Mem_Regwrite && Ex_Mem_RegRd_2 != 3'b000 && Ex_Mem_RegRd_2 == Id_Ex_RegRn1)
				FwdC=2'b01;
			else if(Mem_Wb_Regwrite && Mem_Wb_RegRd_3 != 3'b000 && Mem_Wb_RegRd_3 == Id_Ex_RegRn1)
				FwdC=2'b10;
		  else if(Mem_Wb_Regwrite && Mem_Wb_RegRd_3 != 3'b000 && Mem_Wb_RegRd_3_ld_wb == Id_Ex_RegRn1)  //Check this
		    FwdC = 2'b11;
			else
				FwdC=2'b00;

				
			if(Ex_Mem_Regwrite && Ex_Mem_RegRd_2 != 3'b000 && Ex_Mem_RegRd_2 == Id_Ex_RegRd1)
				FwdD=2'b01;
			else if(Mem_Wb_Regwrite && Mem_Wb_RegRd_3 != 3'b000 && Mem_Wb_RegRd_3 == Id_Ex_RegRd1)
				FwdD=2'b10;
			else if(Mem_Wb_Regwrite && Mem_Wb_RegRd_3 != 3'b000 && Mem_Wb_RegRd_3_ld_wb == Id_Ex_RegRd1)  //Check this
		    FwdD = 2'b11;
			else
				FwdD=2'b00;

		end
endmodule
