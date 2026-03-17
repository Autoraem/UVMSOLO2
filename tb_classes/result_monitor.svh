class result_monitor extends uvm_component;
    `uvm_component_utils(result_monitor)

    virtual alu_bfm bfm;

    uvm_analysis_port #(result_transaction) ap;

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual alu_bfm)::get(null, "", "bfm", bfm)) 
            `uvm_fatal("RSLT_MONITOR", "Result Monitor did not find BFM in config db")
        bfm.rslt_monitor_h = this;
        ap = new("ap", this);
    endfunction : build_phase

    function void write_to_monitor(logic [31:0] Q, logic Zero, logic Neg, logic Overflow);
        result_transaction rslt;
        rslt = new("result_transaction");   
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