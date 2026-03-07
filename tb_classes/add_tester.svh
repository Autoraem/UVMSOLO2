class add_tester extends random_tester;
    `uvm_component_utils(add_tester)

    function alu_op_e get_op();
        return alu_op_e'(ALU_ADD);
    endfunction : get_op

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : add_tester