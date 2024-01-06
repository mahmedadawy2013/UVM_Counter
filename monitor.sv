class monitor extends uvm_monitor;

/*Register To The Factory Using componenet utils */
`uvm_component_utils(monitor)
virtual intf moni_intf                      ;
sequence_item t_mon                         ; 
uvm_analysis_port #(sequence_item) mon_mail ;

function  new(string name = "MONITOR", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("MONITOR","WE Are Compiling The Monitor",UVM_NONE);
    /***************************************************************************
    * if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",moni_intf))
    * if the name isnt my_vif u will not recieve the interface 
    * the name must match the sent interface with the same name 
    ***************************************************************************/
    if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",moni_intf))
        `uvm_info("MONITOR","ERROR INSIDE MONITOR",UVM_NONE);
    t_mon = sequence_item::type_id::create("t_mon")         ; 
    mon_mail = new("mon_mail",this)                         ; 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("MONITOR","WE ARE RUNNING THE MONITOR",UVM_NONE)                    ;
    `uvm_info("MONITOR","Monitor Starting To Recieve Data From the DUT",UVM_NONE) ;
    forever  begin 
      $display("Monitor Is Waiting For Packet ......")    ;                                     
      @(posedge moni_intf.clk)
      #1 
      t_mon.rst           = moni_intf.rst     ;    
      t_mon.load          = moni_intf.load    ; 
      t_mon.up            = moni_intf.up      ;  
      t_mon.down          = moni_intf.down    ; 
      t_mon.in            = moni_intf.in      ;
      t_mon.high          = moni_intf.high    ;
      t_mon.low           = moni_intf.low     ; 
      t_mon.count         = moni_intf.count   ; 
      t_mon.display_Sequence_item("Monitor")              ;        
      `uvm_info("MONITOR","Monitor has Recieveed the data from the DUT",UVM_NONE) ;
      mon_mail.write(t_mon)                               ;  

    end 


endtask 


endclass