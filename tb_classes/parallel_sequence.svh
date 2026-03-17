class parallel_sequence extends uvm_sequence #(uvm_sequence_item);
    `uvm_object_utils(parallel_sequence);

    protected short_random_sequence short_random;
    protected fibonacci_sequence fibonacci;

    function new(string name = "parallel_sequence");
        super.new(name);
        fibonacci = fibonacci_sequence::type_id::create("fibonacci");
        short_random = short_random_sequence::type_id::create("short_random");
    endfunction : new

    task body();
        fork
        fibonacci.start(m_sequencer);
        short_random.start(m_sequencer);
        join
    endtask : body
endclass : parallel_sequence