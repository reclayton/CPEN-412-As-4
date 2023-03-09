module tb_dramController();

			logic Clock = 0;								// used to drive the state machine- stat changes occur on positive edge
			logic Reset_L;     						// active low reset 
			logic unsigned [31:0] Address;		// address bus from 68000
			logic unsigned [15:0] DataIn;			// data bus in from 68000
			logic UDS_L;								// active low signal driven by 68000 when 68000 transferring data over data bit 15-8
			logic LDS_L; 								// active low signal driven by 68000 when 68000 transferring data over data bit 7-0
			logic DramSelect_L;     				// active low signal indicating dram is being addressed by 68000
			logic WE_L;  								// active low write signal, otherwise assumed to be read
			logic AS_L;									// Address Strobe
			
			logic unsigned[15:0] DataOut; 				// data bus out to 68000
			logic SDram_CKE_H;								// active high clock enable for dram chip
			logic SDram_CS_L;								// active low chip select for dram chip
			logic SDram_RAS_L;								// active low RAS select for dram chip
			logic SDram_CAS_L;								// active low CAS select for dram chip		
			logic SDram_WE_L;								// active low Write enable for dram chip
			logic unsigned [12:0] SDram_Addr;			// 13 bit address bus dram chip	
			logic unsigned [1:0] SDram_BA;				// 2 bit bank address
			//logic unsigned [15:0] SDram_DQ;			// 16 bit bi-directional data lines to dram chip

			logic Dtack_L;									// Dtack back to CPU at end of bus cycle
			logic ResetOut_L;								// reset out to the CPU
	
			// Use only if you want to simulate dram controller state (e.g. for debugging)
			logic [4:0] DramState;

    // expected maximum time
    // 19200 pixels + 10 spare 
    parameter MAX_TIME = 19210;
    integer timestamp;


    M68kDramController_Verilog dut(.*);
    
    always #1 Clock = ~Clock; // create clock with period 2 

    initial begin 
        // reset
        @(negedge Clock) 
          Reset_L = 0;
          DramSelect_L = 1;
          AS_L = 1;
        @(negedge Clock) Reset_L = 1;
        wait(DramState == 5);
        #10;
        
        @(negedge Clock) 
          Address = 32'hA1FCB8;
          DataIn = 16'h55AA;
        
        //check write
        @(negedge Clock)
          DramSelect_L = 0;
          AS_L = 0;
          WE_L = 0;
          #2;
        @(negedge Clock)
          assert(DramState == 5'd15);
          assert(SDram_Addr == 13'b1010_0001_1111_1);
          assert(SDram_BA == 2'b00);
          assert(Dtack_L == 1);
        @(negedge Clock) 
          UDS_L = 0;
          assert(Dtack_L == 1);
        @(negedge Clock)
          assert(DramState == 5'd16);
          assert(SDram_Addr == 11'b1100_1011_100);
          assert(SDram_BA == 2'b00);
          assert(Dtack_L == 0);

        @(negedge Clock)
          assert(DramState == 5'd17);
          assert(Dtack_L == 0);
        @(negedge Clock)
          assert(DramState == 5'd17);
          UDS_L = 1;
        
        @(negedge Clock) AS_L = 1;
        @(negedge Clock)
          assert(DramState == 5'd05);
          WE_L = 1;
        @(negedge Clock)
          AS_L = 0;
          WE_L = 1;
        
        @(negedge Clock) 
          assert(DramState == 5'd14);
        @(negedge Clock) 
          assert(DramState == 5'd18);
          assert(SDram_Addr == 11'b1100_1011_100);
          assert(SDram_BA == 2'b00);
        
        wait(DramState == 5'd5);
    $stop;
    end  
endmodule: tb_dramController