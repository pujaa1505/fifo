module fifo(clk,reset,data_in,r,w,data_out,full,empty);
input clk,reset,r,w;
input [7:0]data_in;
output reg[7:0]data_out;
output full,empty;
reg [3:0] fifo_count;
reg [2:0] read_count=0,write_count=0;
reg [7:0] fifo_memory[0:7];
assign empty=(fifo_count==0)?1:0;
assign full=(fifo_count==8)?1:0;
initial data_out=8'b0;
always@(posedge clk)
begin
if(reset)
begin
read_count<=0;
write_count<=0;
end
else if(w==1 && !full)
begin
fifo_memory[write_count]<=data_in;
write_count<=write_count+1;
end
else if(r==1 && !empty)
begin
data_out<=fifo_memory[read_count];
read_count<=read_count+1;
end
end
always@(posedge clk)
begin
if(reset)
fifo_count<=0;
else
begin
case({w,r})
2'b00:fifo_count<=fifo_count;
2'b01:fifo_count<=(fifo_count==0)?0:fifo_count-1;
2'b10:fifo_count<=(fifo_count==8)?8:fifo_count+1;
2'b11:fifo_count<=fifo_count;
endcase
end
end
endmodule

