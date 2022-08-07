// Code your design here
//parallel shift register
module PLShift_reg(Data,en,rst,clk,load,Ones,Q);
  input [7:0] Data;
  input en,rst,clk,load;
  output reg[3:0] Ones;
  output reg[7:0] Q;

  //internal signal
   integer i;
   wire[3:0] Ones_temp; //for temporary storage of count of ones

   assign Ones_temp =Data[0]+Data[1]+Data[2]+Data[3]+Data[4]+Data[5]+Data[6]+Data[7];

   always @(posedge clk or posedge rst)
     begin
       if(rst) //if reset
         begin
           Q = 0;
           Ones = 0;
         end
       else if (!en) //if not enabled
         begin
           Q = 0;
           Ones = 0;
         end
       else if (load) //if load
         begin
           Q = Data;
           Ones = 0;
         end
       else if (!load)//if not load then count
         begin
           Q = Data;
           Ones = Ones_temp;
         end
     end
endmodule

//modfication to 7 segment

module PLShift_reg_SSeg(Data,en,rst,clk,load,Seg_Out,Q);
  
  input [7:0] Data;
  input en,rst,clk,load;
  output[3:0] Seg_Out;
  output[7:0] Q;
  reg[3:0] Ones=4'b0000;
  reg [7:0] C_Anode_seg;
  
  always@(posedge clk or rst)
    begin
      if(rst)
        Ones = 0;
      else
        Ones = Ones;
    end
  always@(Ones)
    case(Ones)
      4'b0000 : C_Anode_seg<=8'b11000000;
      4'b0001 : C_Anode_seg<=8'b11111001;
      4'b0010 : C_Anode_seg<=8'b10100100;
      4'b0011 : C_Anode_seg<=8'b10110000;
      4'b0100 : C_Anode_seg<=8'b10011001;
      4'b0101 : C_Anode_seg<=8'b10010010;
      4'b0110 : C_Anode_seg<=8'b10000010;
      4'b0111 : C_Anode_seg<=8'b11111000;
      4'b1000 : C_Anode_seg<=8'b10000000;
      4'b1001 : C_Anode_seg<=8'b10010000;
      4'b1010 : C_Anode_seg<=8'b10001000;
      4'b1011 : C_Anode_seg<=8'b10000011;
      4'b1100 : C_Anode_seg<=8'b11000110;
      4'b1101 : C_Anode_seg<=8'b10100001;
      4'b1110 : C_Anode_seg<=8'b10000110;
      4'b0011 : C_Anode_seg<=8'b10001110;
     
      default : C_Anode_seg<=8'b11111111;
    endcase
  
  assign Seg_Out = C_Anode_seg;

endmodule
