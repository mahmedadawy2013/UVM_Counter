class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
uvm_analysis_imp #(sequence_item,scoreboard) score_mail ; 
int passed_test_cases     ;
int failed_test_cases     ;
static int golden_counter ; 
static int golden_high    ; 
static int golden_low     ; 

function  new(string name = "SCOREBOARD", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SCOREBOARD","WE Are Compiling The Scoreboard",UVM_NONE);
    score_mail = new("score_mail",this) ; 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("SCOREBOARD","WE ARE RUNNING THE SCOREBOARD",UVM_NONE);

endtask 

task write (sequence_item t_score);
    t_score.display_Sequence_item("SCOREBOARD") ; 
    /**************************************  Reset Test Case ********************************************/
    if (t_score.rst == 0) begin 
    golden_counter = 0 ; 
    golden_high    = (golden_counter == 15) ? 1 : 0 ; 
    golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
    if ( t_score.count == golden_counter && t_score.low == golden_low && t_score.high == golden_high  )
        begin 
        $display("Reset Test Case Passed At time : %0P",$realtime()) ; 
        passed_test_cases++  ; 
        end
        else  begin
        $display("Reset Test Case Failed At time : %0P",$realtime()) ; 
        failed_test_cases++ ; 
        end
    end  
    /*****************************************************************************************************/
    /**************************************  Load Test Case ********************************************/
    else if (t_score.load == 1) begin 
        golden_counter = t_score.in ; 
        golden_high    = (golden_counter == 15) ? 1 : 0 ; 
        golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
    if ( t_score.count == golden_counter && t_score.low == golden_low && t_score.high == golden_high  )
        begin 
        $display("Load Test Case Passed At time : %0P",$realtime()) ; 
        passed_test_cases++  ; 
        end
        else  begin
        $display("Load Test Case Failed At time : %0P",$realtime()) ; 
        failed_test_cases++ ; 
        end
    end  
    /***************************************************************************************************/
    /**************************************  DOWN Test Case ********************************************/
    else if (t_score.down == 1) begin 
    if (golden_counter == 0 ) begin
        golden_counter = 15 ; 
        golden_high    = (golden_counter == 15) ? 1 : 0 ; 
        golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
    end else begin 
        golden_counter--   ; 
        golden_high    = (golden_counter == 15) ? 1 : 0 ; 
        golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
    end 
    if ( t_score.count == golden_counter && t_score.low == golden_low && t_score.high == golden_high  )
        begin 
        $display("DOWN Test Case Passed At time : %0P",$realtime()) ; 
        passed_test_cases++  ; 
        end
        else  begin
        $display("DOWN Test Case Failed At time : %0P",$realtime()) ; 
        failed_test_cases++ ; 
        end
    end  
    /*************************************************************************************************/
    /**************************************  UP Test Case ********************************************/
    else if (t_score.up == 1) begin 
    if (golden_counter == 15 ) begin
        golden_counter = 0 ; 
        golden_high    = (golden_counter == 15) ? 1 : 0 ; 
        golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
    end else begin 
        golden_counter++   ; 
        golden_high    = (golden_counter == 15) ? 1 : 0 ; 
        golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
    end 
    if ( t_score.count == golden_counter && t_score.low == golden_low && t_score.high == golden_high  )
        begin 
        $display("UP Test Case Passed At time : %0P",$realtime()) ; 
        passed_test_cases++  ; 
        end
        else  begin
        $display("UP Test Case Failed At time : %0P",$realtime()) ; 
        failed_test_cases++ ; 
        end
    end
    /****************************************************************************************************/
    /**************************************  idle Test Case ********************************************/
    else begin 
        if ( t_score.count == golden_counter && t_score.low == golden_low && t_score.high == golden_high  )
        begin 
        $display("Idle Test Case Passed At time : %0P",$realtime()) ; 
        passed_test_cases++  ; 
        end
        else  begin
        $display("Idle Test Case Failed At time : %0P",$realtime()) ; 
        failed_test_cases++ ; 
        end
    end   
    /*****************************************************************************************************/
endtask 

task display_test_cases_report () ;

    $display("The Number of Passed test cases is :%0P " , passed_test_cases ) ; 
    $display("The Number of Failed test cases is :%0P " , failed_test_cases ) ; 
  
endtask 
endclass