module apb_slave(p_ready,
                 p_slv_err,
                 p_r_data,
                 p_clk,
                 p_reset_n,
                 p_w_data,
                 p_write,
                 p_enable,
                 p_sel,
                 p_addr);

input p_clk,
      p_reset_n,
      p_write,
      p_enable,
      p_sel;
input [31:0]p_w_data;
input [1:0]p_addr;

output  p_ready;
output reg p_slv_err;
output reg[31:0]p_r_data;

reg [1:0]state,next_state;
reg [31:0]memory[3:0];

parameter Fixed_value=32'd19;
parameter idle=2'b00;
parameter setup=2'b01;
parameter access=2'b10;

//=======================================================//
//                  state machine                        //
//=======================================================//
always @(posedge p_clk or negedge p_reset_n)
begin
if(!p_reset_n)
   state<=idle;
else
  state<=next_state;
end

always @(*)
  begin
  case(state)
  idle: if(p_sel==1&&p_enable==0) next_state<=setup;
        else next_state<=idle;

  setup: if(p_sel==0) next_state<=idle;
         else next_state<=access;

  access: if(p_sel==0&&p_enable==0) next_state<=idle;
          else if (p_sel==1&&p_enable==0) next_state<=setup;
          else next_state<=access;
  endcase
  end



//=======================================================//
//                  P_ready generation                   //
//=======================================================//
assign p_ready=(p_enable==1)?1:0;

//=======================================================//
//                  write transfer                       //
//=======================================================//
always @(*)//written in combo block
begin
  begin
  if(state==setup&&p_write==1&&p_addr!=2'b11)
     memory[p_addr]<=p_w_data;
  else if(state==setup&&p_write==1&&p_addr==2'b11)
     memory[p_addr]<=Fixed_value;
  end
end


//=======================================================//
//                  read transfer                        //
//=======================================================//
always @(*)//written in combo block
begin
 if(!p_reset_n)
  p_r_data<=0;
 else
  begin
  if(state==setup&&p_write==0)
     p_r_data<= memory[p_addr];
  end
end


//=======================================================//
//                  Memory Specifications                //
//=======================================================//
always @(*)
begin
 if(state==setup)
 begin
 case({p_addr,p_write})
 3'b000: p_slv_err=0; //read only
 3'b001: p_slv_err=1; //read only with write high
 3'b010: p_slv_err=1; //write only with read high
 3'b011: p_slv_err=0; //write only
 3'b100: p_slv_err=0; //read_write
 3'b101: p_slv_err=0; //read_write
 3'b110: p_slv_err=0; //fixed read
 3'b111: p_slv_err=1; //fixed write
 endcase
 end
 else p_slv_err=0;
end


endmodule
