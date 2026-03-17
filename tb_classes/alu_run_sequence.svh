class runall_sequence extends alu_sequence;
   `uvm_object_utils(alu_runall_sequence);

   random_sequence random;
   
   task body();
      random = random_sequence::type_id::create("random");

      random.start(m_sequencer);
   endtask : body
endclass : alu_runall_sequence