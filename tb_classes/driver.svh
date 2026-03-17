class driver extends uvm_driver #(sequence_item);
    `uvm_component_utils(driver)

    virtual alu_bfm bfm;

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual alu_bfm)::get(this, "*", "bfm", bfm)) begin
            `uvm_fatal("BFM_NOT_FOUND", "Driver did not find BFM in config db")
        end

    endfunction : build_phase

    task run_phase(uvm_phase phase);
        sequence_item cmd;

        forever begin : command_loop
            seq_item_port.get_next_item(cmd);
            bfm.send_op(cmd.Opcode, cmd.A, cmd.B, cmd.Q, cmd.Zero, cmd.Neg, cmd.Overflow);
            seq_item_port.item_done();
        end : command_loop
    endtask : run_phase

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
endclass : driver