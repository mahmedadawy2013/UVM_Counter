class sequence_item  extends uvm_sequence_item  ;
/*Register To The Factory Using object utils */
`uvm_object_utils(sequence_item)

/* declaration of the input output signals */
// This is the base transaction object Container that will be used 
// in the environment to initiate new transactions and // capture transactions at DUT interface
rand  bit                    rst               ;
rand  bit                    load              ;
rand  bit                    up                ;
rand  bit                    down              ;
randc bit [3:0]              in                ;
      bit                    high              ;
      bit                    low               ;
      bit [3:0]              count             ;

/* declaration of the Constraints for input output signals */

function  new(string name = "SEQUENCE_ITEM ");
    super.new(name) ; 
endfunction

/* Function to display the transaction at any time*/

function void display_Sequence_item(input string name = "SEQUENCE ITEM" ); 

    $display ("*************** This is the %0P **********************",name)  ;  
    $display (" load       = %0d    rst         =   %0d  ", load      , rst      ) ; 
    $display (" up         = %0d    in          =   %0d  ", up        , in       ) ; 
    $display (" down       = %0d    count       =   %0d  ", down      , count    ) ; 
    $display (" high       = %0d    low         =   %0d  ", high      , low      ) ; 
    $display ("**********************************************************")   ;
    
endfunction   

endclass
    

	  