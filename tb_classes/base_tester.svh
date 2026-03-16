virtual class base_tester extends uvm_component;
    `uvm_component_utils(base_tester)

    virtual alu_bfm bfm;

    uvm_put_port #(command_data) cmd_port;

    function void build_phase(uvm_phase phase);
        cmd_port = new("cmd_port", this);
    endfunction : build_phase

    pure virtual function alu_op_e get_op();

    pure virtual function [31:0] get_data();

    task run_phase(uvm_phase phase);
        command_data cmd;

        phase.raise_objection(this);
        repeat (10000) begin : test_loop
            cmd.A = get_data();
            cmd.B = get_data();
            cmd.Opcode = get_op();

            cmd_port.put(cmd);             
        end : test_loop
        #100; 
        phase.drop_objection(this);
    endtask : run_phase


    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
endclass : base_tester