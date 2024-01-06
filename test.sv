class test extends uvm_test;
`uvm_component_utils(test)
environment            environment_instance                ; 
reset_sequence         reset_sequence_instance             ;
overflow_up_sequence   overflow_up_sequence_instance       ;
overflow_down_sequence overflow_down_sequence_instance     ;
normal_sequence        normal_sequence_instance            ;
virtual intf           test_intf                           ;

function  new(string name = "TEST ", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("TEST","WE Are Compiling The TEST",UVM_NONE)                                                          ;
    environment_instance              = environment::type_id::create("environment_instance",this)                   ; 
    reset_sequence_instance           = reset_sequence::type_id::create("reset_sequence_instance")                  ;
    overflow_up_sequence_instance     = overflow_up_sequence::type_id::create("overflow_up_sequence_instance")      ;
    overflow_down_sequence_instance   = overflow_down_sequence::type_id::create("overflow_down_sequence_instance")  ;
    normal_sequence_instance          = normal_sequence::type_id::create("normal_sequence_instance")                ;
    if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",test_intf))
        `uvm_info("Test","ERROR INSIDE Test",UVM_NONE);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    phase.raise_objection(this,"STARTING TEST") ; 
        `uvm_info("TEST","WE ARE RUNNING THE TEST ",UVM_NONE)
        reset_sequence_instance.start(environment_instance.agent_instance.sequencer_instance)         ;
        overflow_up_sequence_instance.start(environment_instance.agent_instance.sequencer_instance)   ;
        overflow_down_sequence_instance.start(environment_instance.agent_instance.sequencer_instance) ;
        repeat (100) begin 
        normal_sequence_instance.start(environment_instance.agent_instance.sequencer_instance)        ;
        end 
        @(negedge test_intf.clk) 
        environment_instance.scoreboard_instance.display_test_cases_report()   ; 
        environment_instance.subscriber_inscance.display_coverage_percentage() ;
    phase.drop_objection(this,"FINSHING TEST")  ; 
endtask 

endclass