class alu_sequence extends uvm_sequence #(alu_sequence_item);

   alu_sequence_item command;
   
   task body();
      $fatal(1,"You cannot use alu_sequence directly. You must override it");
   endtask : body

endclass : yalu_sequence