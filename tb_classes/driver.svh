class driver extends uvm_component;
    `uvm_component_utils(driver)

    virtual alu_bfm bfm;

    uvm_get_port #(command_data) cmd_port;

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual alu_bfm)::get(this, "", "bfm", bfm)) begin
            `uvm_fatal("BFM_NOT_FOUND", "Driver did not find BFM in config db")
        end
        cmd_port = new("cmd_port", this);
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        command_data cmd;
        result_data rslt;
        forever begin : command_loop
            cmd_port.get(cmd);
            bfm.send_op(cmd.Opcode, cmd.A, cmd.B, rslt.Q, rslt.Zero, rslt.Neg, rslt.Overflow);
        end : command_loop
    endtask : run_phase

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
endclass : driver