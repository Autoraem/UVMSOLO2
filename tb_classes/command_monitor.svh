class command_monitor extends uvm_component;
    `uvm_component_utils(command_monitor)

    uvm_analysis_port #(command_data) ap;

    function void build_phase(uvm_phase phase);
        virtual alu_bfm bfm;

        if(!uvm_config_db#(virtual alu_bfm)::get(null, "", "bfm", bfm)) 
            $fatal("Failed to get BFM");

        bfm.cmd_monitor_h = this;

        ap = new("ap", this);
    endfunction : build_phase

    function void write_to_monitor(logic [31:0] A, logic [31:0] B, alu_op_e Opcode);
        command_data cmd;
        cmd.A = A;
        cmd.B = B;
        cmd.Opcode = Opcode;
        ap.write(cmd);
    endfunction : write_to_monitor

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : command_monitor
