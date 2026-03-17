class short_random_sequence extends uvm_sequence #(sequence_item);
    `uvm_object_utils(short_random_sequence);
   
    sequence_item command;

    function new(string name = "short_random_sequence");
        super.new(name);
    endfunction : new
   
    task body();
        repeat (14) begin : short_random_loop
            command = sequence_item::type_id::create("command");
            start_item(command);
            assert(command.randomize());
            finish_item(command);
    `uvm_info("SHORT RANDOM", $sformatf("random command: %s", command.convert2string), UVM_MEDIUM)
        end : short_random_loop
    endtask : body
endclass : short_random_sequence