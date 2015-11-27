
module ctrlCkt( input [9:0] opcode_rtype, input [9:0] opcode_memtype, output reg [1:0] pc_in, output reg regWrite1, output reg regWrite2, 
output reg branch, output reg jump, output reg add_shift_bar, output reg[1:0] aluOp, output reg memRead, output reg memWrite, output reg IF_Flush, 
output reg EPCWrite1, output reg EPCWrite2, output reg causeWrite1, output reg causeWrite2, output reg exception1, output reg exception2, 
output reg NFlagWrite1, output reg NFlagWrite2, output reg ZFlagWrite1, output reg ZFlagWrite2, output reg CFlagWrite1, output reg CFlagWrite2, output reg VFlagWrite1, output reg VFlagWrite2);
  
  reg[1:0] pc_in1;
  reg[1:0] pc_in2;

 always@(opcode_rtype or opcode_memtype)
  begin
      
      case(opcode_memtype[4:0])  
        5'b10001:     //ldr instr
          begin
            pc_in1 = 2'b00;
            regWrite1 = 1'b1;
            branch = 0;
            jump = 0;
                        
            memRead = 1'b1;
            memWrite = 1'b0;
            
            IF_Flush = 1'b0;
            EPCWrite1 = 1'b0;
            causeWrite1 = 1'b0;
            exception1 = 1'b0;
            
            NFlagWrite1 = 1'b1;
            ZFlagWrite1 = 1'b1;
            CFlagWrite1 = 1'b1;
            VFlagWrite1 = 1'b1;
          end
          
         5'b10000:  //str instr
          begin
            pc_in1 = 2'b00;
            regWrite1 = 1'b0;
            branch = 0;
            jump = 0;
                        
            memRead = 1'b0;
            memWrite = 1'b1;
            
            IF_Flush = 1'b0;
            EPCWrite1 = 1'b0;
            causeWrite1 = 1'b0;
            exception1 = 1'b0;
            
            NFlagWrite1 = 1'b0;
            ZFlagWrite1 = 1'b0;
            CFlagWrite1 = 1'b1;
            VFlagWrite1 = 1'b1;
          end 
        
        5'b11100: // j instr
          begin 
            pc_in1 = 2'b10;
            regWrite1 = 1'b0;
            branch = 0;
            jump = 1;
                        
            memRead = 1'b0;
            memWrite = 1'b0;
            
            IF_Flush = 1'b1;
            EPCWrite1 = 1'b0;
            causeWrite1 = 1'b0;
            exception1 = 1'b0;
            
            NFlagWrite1 = 1'b0;
            ZFlagWrite1 = 1'b0;
            CFlagWrite1 = 1'b0;
            VFlagWrite1 = 1'b0;
          end
        
          
        5'b11011: //branch instr
          begin
            pc_in1 = 2'b01;
            regWrite1 = 1'b0;
            branch = 1;
            jump = 0;
                        
            memRead = 1'b0;
            memWrite = 1'b0;
            
            IF_Flush = 1'b1;
            case(opcode_memtype[7:5])
              3'b001:
              begin
                EPCWrite1 = 1'b0;
                causeWrite1 = 1'b0;
                exception1 = 1'b0;
              end
              
              default:
              begin
                pc_in1 = 2'b11;
                EPCWrite1 = 1'b1;
                causeWrite1 = 1'b1;
                exception1 = 1'b1;
              end
            endcase
            
            NFlagWrite1 = 1'b0;
            ZFlagWrite1 = 1'b0;
            CFlagWrite1 = 1'b0;
            VFlagWrite1 = 1'b0;
          end
          
          5'b00000:
          begin
                pc_in1 = 2'b00;
                VFlagWrite1 = 1'b0;
                IF_Flush = 1'b0; 
                exception1 = 1'b0; 
                NFlagWrite1 = 1'b0;
                ZFlagWrite1 = 1'b0;
                CFlagWrite1 = 1'b0;
                EPCWrite1 = 1'b0;
                causeWrite1 = 1'b0;             
          end      
          
          default:
          begin
            pc_in1 = 2'b11;
            IF_Flush = 1'b0;
            EPCWrite1 = 1'b1;
            causeWrite1 = 1'b1;
            exception1 = 1'b1;
          end
        
      endcase  
      
      case(opcode_rtype[4:0])
        5'b00100:     //add rd = rd + imm
          begin
            pc_in2 = 2'b00;
            regWrite2 = 1'b1;
            
            add_shift_bar = 1'b1;
            
            aluOp = 2'b00;
         
            EPCWrite2 = 1'b0;
            causeWrite2 = 1'b0;
            exception2 = 1'b0;
            
            NFlagWrite2 = 1'b1;
            ZFlagWrite2 = 1'b1;
            CFlagWrite2 = 1'b1;
            VFlagWrite2 = 1'b1;
          end
          
        5'b00101:     //sub rd = rd - imm
          begin
            pc_in2 = 2'b00;
            regWrite2 = 1'b1;
            
            add_shift_bar = 1'b1;
            
            aluOp = 2'b01;
         
            EPCWrite2 = 1'b0;
            causeWrite2 = 1'b0;
            exception2 = 1'b0;
            
            NFlagWrite2 = 1'b1;
            ZFlagWrite2 = 1'b1;
            CFlagWrite2 = 1'b1;
            VFlagWrite2 = 1'b1;
          end
          
        5'b00010:     //shift : rd = rn >> imm
          begin
            pc_in2 = 2'b00;
            regWrite2 = 1'b1;
            
            add_shift_bar = 1'b0;
            
            aluOp = 2'b10;
         
            EPCWrite2 = 1'b0;
            causeWrite2 = 1'b0;
            exception2 = 1'b0;
            
            NFlagWrite2 = 1'b1;
            ZFlagWrite2 = 1'b1;
            CFlagWrite2 = 1'b1;
            VFlagWrite2 = 1'b0;
          end
        
        5'b01000:     //neg rd = -rn
          begin
            pc_in2 = 2'b00;
            regWrite2 = 1'b1;
            
            add_shift_bar = 1'b0;
            
            aluOp = 2'b11;
            
            case(opcode_rtype[9:5])
              5'b00110: 
              begin
                EPCWrite2 = 1'b0;
                causeWrite2 = 1'b0;
                exception2 = 1'b0;
              end
              
              default:
              begin
                EPCWrite2 = 1'b1;
                causeWrite2 = 1'b1;
                exception2 = 1'b1;
              end
            endcase         
            
            NFlagWrite2 = 1'b1;
            ZFlagWrite2 = 1'b1;
            CFlagWrite2 = 1'b1;
            VFlagWrite2 = 1'b1;
              
          end  
          
          5'b00000:
          begin
                pc_in2 = 2'b00;
                VFlagWrite2 = 1'b0;
                exception2 = 1'b0;     
                NFlagWrite2 = 1'b0;
                ZFlagWrite2 = 1'b0;
                CFlagWrite2 = 1'b0;    
                EPCWrite2 = 1'b0;
                causeWrite2 = 1'b0;
          end
          
          default:
              begin
                pc_in2 = 2'b11;
                EPCWrite2 = 1'b1;
                causeWrite2 = 1'b1;
                exception2 = 1'b1;
              end
        
      endcase
                                          
      pc_in = pc_in1 | pc_in2;
      
  end
endmodule