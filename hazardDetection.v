
module hazardDetection(input id_ex_memread1, input add_shift_bar, input [2:0] id_ex_regRd_load_5, input [2:0] if_id_regRd_add_6, input [2:0] if_id_regRm_shift, 
input [2:0] if_id_rn1, input [2:0] if_id_rd1, input memRead, input memWrite,
output reg id_ex_control_value, output reg pc_write, output reg if_id_write);
    always@(id_ex_memread1 or add_shift_bar or id_ex_regRd_load_5 or if_id_regRd_add_6 or if_id_regRm_shift)
    begin
        if (id_ex_memread1==1 && ( (add_shift_bar==1 && (id_ex_regRd_load_5==if_id_regRd_add_6)) || (add_shift_bar==0 && (id_ex_regRd_load_5==if_id_regRm_shift)) ) )
            begin
                id_ex_control_value=1;
                pc_write=0;
                if_id_write=0;
            end
      else if(id_ex_memread1==1 && ( ((memRead | memWrite)&&(id_ex_regRd_load_5 == if_id_rn1)) | ( memWrite && (id_ex_regRd_load_5 == if_id_rd1) ) ))
            begin
                id_ex_control_value=1;
                pc_write=0;
                if_id_write=0;
            end
         
        else
            begin
                id_ex_control_value=0;
                pc_write=1;
                if_id_write=1;
            end  
    end
endmodule
