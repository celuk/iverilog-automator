`timescale 1ns / 1ps

module tb_isim_sifrele(

    );
    
    reg [63:0] tb_isim=0;
    wire [7:0] tb_sifre;
    
    isim_sifrele uut2_c(.isim(tb_isim), .sifre(tb_sifre));
    
    real total_passed = 0;
    real total_failed = 0;
    
    initial begin
      tb_isim={8'd84,8'd79,8'd66,8'd66,8'd32,8'd69,8'd84,8'd85}; #10;
      if(tb_sifre == 8'hce) begin
        total_passed = total_passed + 1;
      end
      else begin
        total_failed = total_failed + 1;
      end
      
      tb_isim={8'd97,8'd108,8'd112,8'd101,8'd114,8'd101,8'd110,8'd32}; #10;
      if(tb_sifre == 8'ha3) begin
        total_passed = total_passed + 1;
      end
      else begin
        total_failed = total_failed + 1;
      end
      
      tb_isim={8'd98,8'd111,8'd108,8'd97,8'd116,8'd032,8'd032,8'd32}; #10;
      if(tb_sifre == 8'h97) begin
        total_passed = total_passed + 1;
      end
      else begin
        total_failed = total_failed + 1;
      end
      
      tb_isim={8'd49,8'd57,8'd49,8'd50,8'd48,8'd49,8'd48,8'd48}; #10;  
      if(tb_sifre == 8'hb4) begin
        total_passed = total_passed + 1;
      end
      else begin
        total_failed = total_failed + 1;
      end
      
      tb_isim={8'd48,8'd52,8'd48,8'd50,8'd50,8'd48,8'd50,8'd50}; #10; 
      if(tb_sifre == 8'h5b) begin
        total_passed = total_passed + 1;
      end
      else begin
        total_failed = total_failed + 1;
      end
     
      $display("Testbench Point: %.0f", 20*total_passed/(total_passed + total_failed));
     
      if(total_passed == 5)
     	  $display("ALL PASSED!");
      else begin
        $display("Total Passed: %d", total_passed);
        $display("Total Failed: %d", total_failed);
      end
    end
endmodule
