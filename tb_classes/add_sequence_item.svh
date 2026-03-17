class add_sequence_item extends sequence_item;
    `uvm_object_utils(add_sequence_item)
        
    function new(input string name = "add_sequence_item");
        super.new(name);
    endfunction 

    constraint add_only {Opcode == ALU_ADD;}
endclass : add_sequence_item