class driver extends uvm_driver #(sequence_item);
/**************************************************************************
* Dont Forget To make the Class parametrized with th sequence Item 
* to avoid the error at TLM Synchornization 
**************************************************************************/
/*Register To The Factory Using componenet utils */

`uvm_component_utils(driver)

virtual intf driv_intf   ;
sequence_item t_drive    ; 

function  new(string name = "DRIVER ", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("DRIVER","WE Are Compiling The Driver",UVM_NONE);
    /***************************************************************************
    * if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",driv_intf))
    * if the name isnt my_vif u will not recieve the interface 
    * the name must match the sent interface with the same name 
    ***************************************************************************/
    if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",driv_intf))
        `uvm_info("DRIVER","ERROR INSIDE DRIVER",UVM_NONE);
    t_drive = sequence_item::type_id::create("t_drive");
    
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 
    `uvm_info("DRIVER","WE ARE RUNNING THE DRIVER",UVM_NONE);
    forever begin 
    seq_item_port.get_next_item(t_drive)             ; 
    @(negedge driv_intf.clk)
    t_drive.display_Sequence_item("DRIVER")           ;
    `uvm_info("DRIVER","Drive has insert the data into the DUT ",UVM_NONE) ;
    driv_intf.rst    = t_drive.rst        ; 
    driv_intf.load   = t_drive.load       ;
    driv_intf.up     = t_drive.up         ;  
    driv_intf.down   = t_drive.down       ; 
    driv_intf.in     = t_drive.in         ;
    seq_item_port.item_done()             ; 
    end 
endtask 


endclass