class random_tester extends base_tester;
    `uvm_component_utils(random_tester)

    function alu_op_e get_op();
        return alu_op_e'($urandom_range(ALU_ADD, ALU_SLTU));
    endfunction : get_op

    function [31:0] get_data();
        int choice;
        choice = $urandom_range(0,3); 
        case(choice)
            0: return '0;        
            1: return '1;       
            default: return $random; 
        endcase
    endfunction : get_data
    
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : random_tester