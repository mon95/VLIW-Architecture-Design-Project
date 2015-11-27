module atestbench;
	reg clk;
	reg reset;
	wire [31:0] A, B;
	final uut (.clk(clk), .reset(reset), .A(A), .B(B));

	always
	#10 clk=~clk;
	
	initial
	begin
		clk=0; reset=1;
		#25  reset=0;	
		
		#500 $finish; 
	end
endmodule

