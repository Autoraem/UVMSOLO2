class add_transaction extends command_transaction;
    `uvm_object_utils(add_transaction)
    
    constraint add_only {
        Opcode == ALU_ADD;
    }

    function new(string name = "add_transaction");
        super.new(name);
    endfunction : new
endclass : add_transaction