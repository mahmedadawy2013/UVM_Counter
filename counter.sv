module counter #( parameter WIDTH = 4 ) 
(
    input wire clk                 ,
    input wire rst                 ,
    input wire load                ,
    input wire up                  ,
    input wire down                , 
    input wire [WIDTH-1:0] in      , 
    output wire high               ,
    output wire low                ,
    output reg [WIDTH-1:0]count  

);
always @(posedge clk or negedge rst ) begin

    if (!rst) begin

        count <= 'b0 ; 

    end else begin 
    
        if (load) begin
            count <= in             ;
        end else if (down) begin
            count <= count -1       ;  
        end else if (up) begin
            count <= count +1       ; 
        end
    end 
    
end  



assign high = (count == 15           ) ? 1 : 0 ;
assign low  = (count == 0            ) ? 1 : 0 ;

endmodule