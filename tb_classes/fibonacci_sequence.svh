class fibonacci_sequence extends uvm_sequence #(sequence_item);
   `uvm_object_utils(fibonacci_sequence);

   function new(string name = "fibonacci");
      super.new(name);
   endfunction : new


   task body();
      logic [31:0] n_minus_2 = 0;
      logic [31:0] n_minus_1 = 1;
      sequence_item command;
      
      command = sequence_item::type_id::create("command");

      `uvm_info("FIBONACCI", " Fib(01) = 00", UVM_MEDIUM);
      `uvm_info("FIBONACCI", " Fib(02) = 01", UVM_MEDIUM);
      for(int ff = 3; ff<=14; ff++) begin
         start_item(command);
         command.A = n_minus_2;
         command.B = n_minus_1;
         command.Opcode = ALU_ADD;
         finish_item(command);
         n_minus_2 = n_minus_1;
         n_minus_1 = command.Q;
         `uvm_info("FIBONACCI", $sformatf("Fib(%02d) = %02d", ff, n_minus_1),
                  UVM_MEDIUM);
      end 
   endtask : body
endclass : fibonacci_sequence