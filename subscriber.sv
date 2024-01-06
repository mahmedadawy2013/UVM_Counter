class subscriber extends uvm_component ;
`uvm_component_utils(subscriber)
uvm_analysis_imp #(sequence_item,subscriber) subs_mail ; 
sequence_item t_sub    ; 
int covered            ;
int total              ; 


covergroup groub1 ; 
UP_C :coverpoint t_sub.up {
    bins tr_up = ( [0:1] => 1 )  ;
}
DOWN_C :coverpoint t_sub.down {
    bins tr_dw = ( [0:1] => 1 )  ;
}
COUNT :coverpoint t_sub.count {
    bins Overflow_U =  (15  => 0)    ;
    bins Overflow_D =  (0  => 15 )   ;  
}

CROSS_OVERFLOW : cross  UP_C  , COUNT , DOWN_C {
    bins UC = binsof(UP_C.tr_up)   &&  binsof(COUNT.Overflow_U )         ; 
    bins DC = binsof(DOWN_C.tr_dw) &&  binsof(COUNT.Overflow_D)          ; 
    ignore_bins IG  = binsof( UP_C.tr_up   ) && binsof(COUNT.Overflow_D) ; 
    ignore_bins IG2 = binsof( DOWN_C.tr_dw ) && binsof(COUNT.Overflow_U) ;
    ignore_bins IG3 = binsof( DOWN_C.tr_dw ) && binsof(UP_C.tr_up )      ;

}
HIGH : coverpoint t_sub.high {
    bins HI = {1} iff (t_sub.count == 15) ; 
}
LOW : coverpoint t_sub.low {
    bins LO = {1} iff (t_sub.count == 0)  ; 
}
UP   : coverpoint t_sub.up   ;
DOWN : coverpoint t_sub.down ;
LOAD : coverpoint t_sub.load ;

CROSS_PRIORITY : cross UP, DOWN, LOAD {
    
}
endgroup

function  new(string name = "SUBSCRIBER", uvm_component parent = null);
    super.new(name,parent) ; 
    groub1 = new()         ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SUBSCRIBER","WE Are Compiling The Subscriber",UVM_NONE);
    subs_mail = new("subs_mail",this) ; 

endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("SUBSCRIBER","WE ARE RUNNING THE SUBSCRIBER",UVM_NONE);

endtask 

task write (sequence_item t_subs);
    t_subs.display_Sequence_item("SUBSCRIBER") ; 
    t_sub = t_subs                             ; 
    groub1.sample()                            ; 
endtask


task display_coverage_percentage() ; 
    $display("The Coverage is :%0P ",groub1.get_coverage(covered,total));
    $display("The covered  is :%0P ",covered);
    $display("The total    is :%0P ",total);
endtask

endclass