class reset_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(reset_sequence)
/*Create an instance from the sequence item to be the transaction data*/
sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      start_item(t)                          ;
        t.randomize() with {t.rst == 0 ; }   ; 
        t.display_Sequence_item("SEQUENCE")  ;
      finish_item(t)                         ; 
endtask

endclass

class overflow_up_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(overflow_up_sequence)
/*Create an instance from the sequence item to be the transaction data*/
sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      start_item(t)                                 ;
        t.randomize() with {t.rst inside { 1'b1 }   ;
                            t.load == 1             ;                    
                            t.in   == 15            ; 
                            t.down == 0             ; 
                            t.up == 0               ;  }      ;
        t.display_Sequence_item("SEQUENCE")         ;
      finish_item(t)                                ;
      start_item(t)                                   ;
        t.randomize() with {t.rst inside { 1'b1 }     ;
                              t.load == 0             ;                    
                              t.down == 0             ; 
                              t.up == 1               ;  }      ;
        t.display_Sequence_item("SEQUENCE")           ;
      finish_item(t)                                  ; 
endtask

endclass

class overflow_down_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(overflow_down_sequence)
/*Create an instance from the sequence item to be the transaction data*/
sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      start_item(t)                                 ;
        t.randomize() with {t.rst inside { 1'b1 }   ;
                            t.load == 1             ;                    
                            t.in   == 0             ; 
                            t.down == 0             ; 
                            t.up   == 0             ;  }      ;
        t.display_Sequence_item("SEQUENCE")         ;
      finish_item(t)                                ;
      start_item(t)                                 ;
        t.randomize() with {t.rst inside { 1'b1 }   ;
                              t.load == 0           ;                    
                              t.down == 1           ; 
                              t.up   == 0           ;  }      ;
        t.display_Sequence_item("SEQUENCE")         ;
      finish_item(t)                                ; 
endtask

endclass

class normal_sequence extends uvm_sequence;
/*Register To The Factory Using object utils */
`uvm_object_utils(normal_sequence)
/*Create an instance from the sequence item to be the transaction data*/
sequence_item t ; 

function  new(string name = "SEQUENCE ");
    super.new(name) ; 
endfunction

/* Pre body and body called by the start function which has been called from the test */

/* pre body function to act like the build phase  */
task pre_body();
    /*Create a handle from the sequence item to be the transaction data*/
    t = sequence_item::type_id::create("t") ; 
endtask
/* body function to act like the run phase  */
task body();
      start_item(t)                          ;
        t.randomize() with {t.rst == 1 ; }   ; 
        t.display_Sequence_item("SEQUENCE")  ;
      finish_item(t)                         ; 
endtask

endclass