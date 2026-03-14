class env extends uvm_env;
    `uvm_component_utils(env)

    base_tester base_tester_h;
    coverage coverage_h;
    scoreboard scoreboard_h;
    command_monitor cmd_monitor_h;
    result_monitor rslt_monitor_h;

    function void build_phase(uvm_phase phase);
        base_tester_h = base_tester::type_id::create("base_tester_h", this);
        coverage_h = coverage::type_id::create("coverage_h", this);
        scoreboard_h = scoreboard::type_id::create("scoreboard_h", this);
        cmd_monitor_h = command_monitor::type_id::create("cmd_monitor_h", this);
        rslt_monitor_h = result_monitor::type_id::create("rslt_monitor_h", this);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        rslt_monitor_h.ap.connect(scoreboard_h.rslt_fifo.analysis_export);
        cmd_monitor_h.ap.connect(scoreboard_h.cmd_fifo.analysis_export);
        cmd_monitor_h.ap.connect(coverage_h.analysis_export);
    endfunction : connect_phase

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

endclass : env