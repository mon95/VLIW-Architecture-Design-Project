module final(input clk, input reset, output [31:0] A, output [31:0] B);
  
  //wires for mem wb
  wire p3_memWrite, p3_regWrite1, p3_regWrite2;
  wire [31:0] p3_memOut, p3_aluOut;
  wire p3_overflow, p3_carry, p3_neg, p3_zero;
  wire p3_NFlagWrite, p3_ZFlagWrite, p3_CFlagWrite, p3_VFlagWrite;
  wire [2:0] p3_writeReg1, p3_writeReg2;
  
  wire [31:0] pcOut, pc_adderOut, IR;
  
  //wires for IF/ID pipeline
  wire [31:0] p0_pc, p0_intr;
  //wires for RegFile
  wire [31:0] regOut1, regOut2, regOut3, regOut4;
  
  //wires for Ctrl Ckt
  wire [1:0] pc_in, aluOp;
  wire regWrite1, regWrite2, branch,  jump,  add_shift_bar, memRead, memWrite, IF_Flush;
  wire EPCWrite1, EPCWrite2, causeWrite1, causeWrite2, exception1, exception2;
  wire NFlagWrite1, NFlagWrite2, ZFlagWrite1, ZFlagWrite2, CFlagWrite1, CFlagWrite2, VFlagWrite1, VFlagWrite2;
  
  //wires for sexts, lshifts, imms
  wire [31:0] t0, memOffset, shiftImm, addImm;
  
  //wires for branch, jump
  wire [31:0] t1, t2, bAddress, jAddress, bvalue, PC1;
  wire [31:0] PC2;
  
  
  //wires for id_ex pipeline
  wire p1_regWrite1, p1_regWrite2, p1_add_shift_bar, p1_memRead, p1_memWrite;
  wire [1:0] p1_aluOp;
  wire p1_EPCWrite1, p1_EPCWrite2, p1_CauseWrite1, p1_CauseWrite2, p1_NFlagWrite1, p1_NFlagWrite2, p1_ZFlagWrite1, p1_ZFlagWrite2, p1_CFlagWrite1, p1_CFlagWrite2, p1_VFlagWrite1, p1_VFlagWrite2;
  wire [31:0] p1_p0_pc, p1_regOut1, p1_regOut2, p1_regOut3, p1_regOut4;
  wire [2:0] p1_writeReg1, p1_writeReg2, p1_writeReg3, p1_rn1, p1_rn2;
  wire [31:0] p1_memOffset, p1_shiftImm, p1_addImm;
  
wire  hd_stall, PC_write, if_id_write;
  
  //wires for Alu operations
  
  wire overflow_mem, carry_mem;
  wire [31:0] adder_out;
  
  wire [31:0] mux_aluIn1, mux_aluIn2, aluOut;
  wire overflow_r, carry_r, neg_r, zero_r;
  
  
  //wires for Flag register values
  wire OVERFLOW;
  
  //RegWrite of PC must be changed to output from HD Unit.
  
  wire [31:0] PC_final;
  
  wire [1:0] pc_in_sel;
  
  mux2to1_2bit mux_pc_in(pc_in, 2'b11, overflow_mem | overflow_r, pc_in_sel);
  
  mux4to1_32bit mux_pc(pc_adderOut, PC1, PC2, 32'd60, pc_in_sel, PC_final);
  
  register32bit_n PC( clk, reset, PC_write, 1'b1, PC_final, pcOut );
  
  adder PC_add(pcOut, 32'b0000_0000_0000_0000_0000_0000_0000_0100, pc_adderOut);
  
  Mem IM( clk, reset, 1'b0, 1'b1, pcOut, 32'b0000_0000_0000_0000_0000_0000_0000_0000, IR );
  
  //RegWrite of IF_ID must be changed to output from HD Unit.
  //flush made 0 for testing.
  IF_ID if_id( clk, reset, if_id_write, 1'b1, IF_Flush | overflow_mem | overflow_r | exception1 | exception2, pc_adderOut, IR, p0_pc, p0_intr);
  
  registerFile RegFile(clk, reset, p3_regWrite1, p3_regWrite2, p0_intr[15:13], p0_intr[12:10], p0_intr[31:29], p0_intr[23:21], 
	p3_writeReg1, p3_writeReg2, p3_memOut, p3_aluOut, regOut1, regOut2, regOut3, regOut4 );
	
	//registerFile RegFile(clk, reset, regWrite1, regWrite2, p0_intr[15:13], p0_intr[12:10], p0_intr[31:29], p0_intr[23:21], 
	//3'b001, 3'b011, 32'b0000_0000_0000_0000_0000_0000_0000_0100, 32'b0000_0000_0000_0000_0000_0000_0000_0001, regOut1, regOut2, regOut3, regOut4 );

  ctrlCkt Ctrlckt( p0_intr[25:16], p0_intr[9:0], pc_in, regWrite1, regWrite2, 
  branch,  jump,  add_shift_bar, aluOp, memRead, memWrite, IF_Flush, 
  EPCWrite1, EPCWrite2, causeWrite1, causeWrite2, exception1, exception2, 
  NFlagWrite1, NFlagWrite2, ZFlagWrite1, ZFlagWrite2, CFlagWrite1, CFlagWrite2, VFlagWrite1, VFlagWrite2);
  
  //hazard

  hazardDetection hd(p1_memRead, add_shift_bar, p1_writeReg1, p0_intr[23:21], p0_intr[31:29],
  p0_intr[15:13], p0_intr[12:10], memRead, memWrite,
  hd_stall, PC_write, if_id_write);

  //memOffset
  signExt5to32 sext_1( p0_intr[9:5], t0);
  leftshift32_2 lshift_1(t0, memOffset);  
  
  //Shift Imm
  signExt5to32 sext_2( p0_intr[25:21], shiftImm);
  
  //Add Imm
  signExt8to32 sext_3( p0_intr[31:24], addImm);
  
  //Branch address
  signExt8to32 sext_4( p0_intr[15:8], t1);
  leftshift32_2 lshift_2(t1, bAddress);
  
  //Jump address
  signExt11to32 sext_5( p0_intr[15:5], t2);
  leftshift32_2 lshift_3(t2, jAddress);

  adder branch_add(p0_pc, bAddress, bvalue);
  //adder jump_add(p0_pc, jAddress, PC2);
  
  assign PC2 = {p0_pc[31:28],jAddress[27:0]};
  
  //give select to mux
  mux2to1_32bit branch_mux(p0_pc, bvalue, branch & OVERFLOW , PC1);
  
  //Muxes to make control signals 0.
  
  wire mux_regWrite1, mux_regWrite2, mux_memRead, mux_memWrite, mux_NFlagWrite1, mux_NFlagWrite2, mux_ZFlagWrite1, mux_ZFlagWrite2, mux_CFlagWrite1, mux_CFlagWrite2, mux_VFlagWrite1, mux_VFlagWrite2; 
  //wire ctrl_sel_1 = exception1 | exception1 | overflow | HD; need to set this as select signal. for testing sel = 0;
  mux2to1_1bit ctrl_mux_1(regWrite1, 1'b0, hd_stall | exception1 | exception2  | overflow_r | overflow_mem, mux_regWrite1);
  mux2to1_1bit ctrl_mux_2(regWrite2, 1'b0, hd_stall | exception1 | exception2 |overflow_mem | overflow_r , mux_regWrite2);
  mux2to1_1bit ctrl_mux_3(memRead, 1'b0, hd_stall | exception1 | exception2 |overflow_mem | overflow_r, mux_memRead);
  mux2to1_1bit ctrl_mux_4(memWrite, 1'b0, hd_stall | exception1 | exception2 |overflow_mem | overflow_r, mux_memWrite);
  mux2to1_1bit ctrl_mux_5(NFlagWrite1, 1'b0, hd_stall | exception1 | exception2 |overflow_mem | overflow_r, mux_NFlagWrite1);
  mux2to1_1bit ctrl_mux_6(NFlagWrite2, 1'b0, hd_stall | exception1 | exception2 |overflow_mem | overflow_r, mux_NFlagWrite2);
  mux2to1_1bit ctrl_mux_7(ZFlagWrite1, 1'b0, hd_stall | exception1 | exception2 |overflow_mem | overflow_r, mux_ZFlagWrite1);
  mux2to1_1bit ctrl_mux_8(ZFlagWrite2, 1'b0, hd_stall | exception1 | exception2 |overflow_mem | overflow_r, mux_ZFlagWrite2);
  mux2to1_1bit ctrl_mux_9(CFlagWrite1, 1'b0, hd_stall | exception1 | exception2 |overflow_mem | overflow_r, mux_CFlagWrite1);
  mux2to1_1bit ctrl_mux_10(CFlagWrite2, 1'b0, hd_stall | exception1 | exception2 |overflow_mem | overflow_r, mux_CFlagWrite2);
  mux2to1_1bit ctrl_mux_11(VFlagWrite1, 1'b0, hd_stall | exception1 | exception2 |overflow_mem | overflow_r, mux_VFlagWrite1);
  mux2to1_1bit ctrl_mux_12(VFlagWrite2, 1'b0, hd_stall | exception1 | exception2 |overflow_mem | overflow_r, mux_VFlagWrite2);


  
  ID_EX if_ex(clk, reset, 1'b1, 1'b1, mux_regWrite1, mux_regWrite2, add_shift_bar, aluOp, mux_memRead, mux_memWrite, 
  EPCWrite1, EPCWrite2, CauseWrite1, CauseWrite2, mux_NFlagWrite1, mux_NFlagWrite2, mux_ZFlagWrite1, mux_ZFlagWrite2, mux_CFlagWrite1, mux_CFlagWrite2, mux_VFlagWrite1, mux_VFlagWrite2, 
  p0_pc, regOut1, regOut2, regOut3, regOut4,
  p0_intr[15:13], p0_intr[31:29],
  p0_intr[12:10],  p0_intr[23:21],  p0_intr[28:26], memOffset, shiftImm, addImm,
  p1_regWrite1, p1_regWrite2, p1_add_shift_bar, p1_aluOp, p1_memRead, p1_memWrite, 
  p1_EPCWrite1, p1_EPCWrite2, p1_CauseWrite1, p1_CauseWrite2, p1_NFlagWrite1, p1_NFlagWrite2, p1_ZFlagWrite1, p1_ZFlagWrite2, p1_CFlagWrite1, p1_CFlagWrite2, p1_VFlagWrite1, p1_VFlagWrite2,
  p1_p0_pc, p1_regOut1, p1_regOut2, p1_regOut3, p1_regOut4,
  p1_rn1, p1_rn2,
  p1_writeReg1, p1_writeReg2, p1_writeReg3, p1_memOffset, p1_shiftImm, p1_addImm);
  
  
  
  //Writing into EPC and cause register
  
  wire [31:0] EPC;
  register32bit_n EPC_reg( clk, reset, p1_EPCWrite1 | p1_EPCWrite2 | overflow_mem | overflow_r, 1'b1, p1_p0_pc, EPC );
  
  wire cause_value;
  wire CAUSE;
  mux2to1_1bit mux_Cause(1'b0, 1'b1, overflow_mem | overflow_r, cause_value);
  register1bit CAUSE_reg( clk, reset, p1_CauseWrite1 | p1_CauseWrite2 | overflow_mem | overflow_r, 1'b1, cause_value, CAUSE );

  //Forwarding
  
  //wires for ex_mem pipeline
  wire p2_regWrite1, p2_regWrite2, p2_memRead, p2_memWrite;
  wire p2_NFlagWrite, p2_ZFlagWrite, p2_CFlagWrite, p2_VFlagWrite, p2_Overflow, p2_Carry, p2_Neg, p2_Zero;
  wire [31:0] p2_adderOut, p2_AluOut, p2_str;
  wire [2:0] p2_writeReg1, p2_muxOut;
  
  //wires for forarding
  wire [31:0] mux_fwdc, mux_fwda, mux_fwdb, mux_fwdd;
  wire [2:0] fwdc, fwda, fwdb, fwdd;
  mux4to1_32bit FwdC(p1_regOut1, p2_AluOut, p3_aluOut, p3_memOut, fwdc, mux_fwdc);
  mux4to1_32bit FwdA(p1_regOut3, p2_AluOut, p3_aluOut, p3_memOut, fwda, mux_fwda);
  mux4to1_32bit FwdB(p1_regOut4, p2_AluOut, p3_aluOut, p3_memOut, fwdb, mux_fwdb);
  mux4to1_32bit FwdD(p1_regOut2, p2_AluOut, p3_aluOut, p3_memOut, fwdd, mux_fwdd);
  
  
  //adder_mem Adder_mem(p1_regOut1, p1_memOffset, overflow_mem, carry_mem, adder_out);
  adder_mem Adder_mem(mux_fwdc, p1_memOffset, overflow_mem, carry_mem, adder_out);
  
  //Forwarding muxes need to be added;
  
  //mux2to1_32bit mux_alu1(p1_regOut3, p1_addImm, p1_add_shift_bar, mux_aluIn1);
  //mux2to1_32bit mux_alu2(p1_shiftImm, p1_regOut4, p1_add_shift_bar, mux_aluIn2);
  
  mux2to1_32bit mux_alu1(mux_fwda, p1_addImm, p1_add_shift_bar, mux_aluIn1);
  mux2to1_32bit mux_alu2(p1_shiftImm, mux_fwdb, p1_add_shift_bar, mux_aluIn2);
  
  alu ALU(mux_aluIn1, mux_aluIn2, p1_aluOp, overflow_r, carry_r, neg_r, zero_r, aluOut);
  
  //Choose correct write register for r type
  wire [2:0] p1_muxOut;
  mux2to1_3bit mux_writeReg(p1_writeReg3, p1_writeReg2, p1_add_shift_bar, p1_muxOut);
  
  
  //Muxes to make control signals zero
  wire mux_p1_regWrite1, mux_p1_regWrite2, mux_p1_memRead, mux_p1_memWrite, NFlagWrite, ZFlagWrite, CFlagWrite, VFlagWrite;
  
  //select bit to be made equal to overflow wire ie or of both overflows
  mux2to1_1bit ctrl1_mux_1(p1_regWrite1, 1'b0, overflow_mem | overflow_r, mux_p1_regWrite1);
  mux2to1_1bit ctrl1_mux_2(p1_regWrite2, 1'b0, overflow_mem | overflow_r, mux_p1_regWrite2);
  mux2to1_1bit ctrl1_mux_3(p1_memRead, 1'b0, overflow_mem | overflow_r, mux_p1_memRead);
  mux2to1_1bit ctrl1_mux_4(p1_memWrite, 1'b0, overflow_mem | overflow_r, mux_p1_memWrite);
  mux2to1_1bit ctrl1_mux_5(p1_NFlagWrite1 | p1_NFlagWrite2, 1'b0, overflow_mem | overflow_r, NFlagWrite);
  mux2to1_1bit ctrl1_mux_6(p1_ZFlagWrite1 | p1_ZFlagWrite2, 1'b0, overflow_mem | overflow_r, ZFlagWrite);
  mux2to1_1bit ctrl1_mux_7(p1_CFlagWrite1 | p1_CFlagWrite2, 1'b0, overflow_mem | overflow_r, CFlagWrite);
  //mux2to1_1bit ctrl1_mux_8(p1_VFlagWrite1 | p1_VFlagWrite2, 1'b0, overflow_mem | overflow_r, VFlagWrite);

  
  EX_MEM ex_mem(clk, reset, 1'b1, 1'b1, mux_p1_regWrite1, mux_p1_regWrite2, mux_p1_memRead, mux_p1_memWrite,
  NFlagWrite,  ZFlagWrite,  CFlagWrite, p1_VFlagWrite1 | p1_VFlagWrite2,  overflow_mem | overflow_r,  carry_mem | carry_r,  neg_r,  zero_r,  
  adder_out, aluOut,  mux_fwdd,  p1_writeReg1,  p1_muxOut,
	p2_regWrite1, p2_regWrite2, p2_memRead, p2_memWrite, p2_NFlagWrite, p2_ZFlagWrite,  
	p2_CFlagWrite, p2_VFlagWrite, p2_Overflow, p2_Carry, p2_Neg, p2_Zero,
	p2_adderOut, p2_AluOut, p2_str, p2_writeReg1, p2_muxOut );

  
  //Data Mem
  wire [31:0] memOut;
  DataMem Data_mem(clk, reset, p2_memWrite, p2_memRead, p2_adderOut, p2_str, memOut );
  
  wire Neg, Zero;
  compareAndSetFlag cmp(memOut, p2_Neg, p2_Zero, Neg, Zero);
  
  
  
  MEM_WB mem_wb( clk, reset, 1'b1, 1'b1, p2_memWrite, p2_regWrite1, p2_regWrite2,
  p2_Overflow, p2_Carry, Neg , Zero,
  p2_NFlagWrite, p2_ZFlagWrite, p2_CFlagWrite, p2_VFlagWrite, 
  memOut, p2_AluOut, 
  p2_writeReg1, p2_muxOut,
  p3_memWrite, p3_regWrite1, p3_regWrite2, 
  p3_overflow, p3_carry, p3_neg, p3_zero, 
  p3_NFlagWrite, p3_ZFlagWrite, p3_CFlagWrite, p3_VFlagWrite,
  p3_memOut, p3_aluOut, 
  p3_writeReg1, p3_writeReg2);
  
  Forwarding fwd_ckt(p2_regWrite2, p2_muxOut, p1_writeReg2, p1_rn2, p1_rn1, 
	p3_regWrite2, p3_writeReg2, p3_writeReg1, p1_writeReg1, 
	fwda, fwdb, fwdc, fwdd);
	
	
	wire NEGATIVE, ZERO, CARRY;
	
	register1bit_flag Overflow_reg( clk, reset, p3_VFlagWrite, 1'b1, p3_overflow, OVERFLOW );
	register1bit_flag Negative_reg( clk, reset, p3_NFlagWrite, 1'b1, p3_neg, NEGATIVE );
	register1bit_flag Zero_reg( clk, reset, p3_ZFlagWrite, 1'b1, p3_zero, ZERO );
	register1bit_flag Carry_reg( clk, reset, p3_CFlagWrite, 1'b1, p3_carry, CARRY );
					
 assign A = p3_memOut;
 assign B = p3_aluOut;
 
endmodule
