interface  intf #(parameter WIDTH = 4 ) () ;

    bit                    clk               ;
    bit                    rst               ;
    bit                    load              ;
    bit                    up                ;
    bit                    down              ;
    bit [WIDTH-1:0]        in                ;
    bit                    high              ;
    bit                    low               ;
    bit [WIDTH-1:0]        count             ;
    
endinterface