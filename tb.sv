module tb ()  ;

    import uvm_pkg::*   ;  
    import pack1::*     ;
    intf intf1()        ; 

    counter COUNTER (
        .clk   (intf1.clk  ) ,
        .rst   (intf1.rst  ) ,
        .load  (intf1.load ) ,
        .up    (intf1.up   ) ,
        .down  (intf1.down ) ,
        .in    (intf1.in   ) ,
        .high  (intf1.high ) ,
        .low   (intf1.low  ) ,
        .count (intf1.count) 
    ); 

    initial begin 
        intf1.clk = 1 ; 
    end  

    always  begin
       #5 intf1.clk= ~ intf1.clk; 
    end

    initial begin
        uvm_config_db #(virtual intf)::set(null,"*","my_vif",intf1) ; 
        run_test("test") ; 
    end 
endmodule