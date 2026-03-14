class result_monitor extends uvm_component;
    `uvm_component_utils(result_monitor)

    uvm_analysis_port #(result_data) ap;

    function void build_phase(uvm_phase phase);
        virtual alu_bfm bfm;
        if(!uvm_config_db#(virtual alu_bfm)::get(null, "", "bfm", bfm)) 
            $fatal("Failed to get BFM");
        bfm.rslt_monitor_h = this;
        ap = new("ap", this);
    endfunction : build_phase

    function void write_to_monitor(logic [31:0] Q, logic Zero, logic Neg, logic Overflow);
        result_data rslt;
        rslt.Q = Q;
        rslt.Zero = Zero;
        rslt.Neg = Neg;
        rslt.Overflow = Overflow;
        ap.write(rslt);
    endfunction : write_to_monitor

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
endclass : result_monitor