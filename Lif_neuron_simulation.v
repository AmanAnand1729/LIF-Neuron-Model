module lif_neuron (
    input clk,              
    input reset,            
    input spike_in,         
    output reg spike_out    
);

    reg [7:0] potential;     
    parameter THRESHOLD = 100;  
    parameter LEAK = 1;         
    parameter INCREMENT = 20;   

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            potential <= 0;
            spike_out <= 0;
        end else begin
            // Integrate input spike
            if (spike_in)
                potential <= potential + INCREMENT-LEAK;

            // Apply leakage
//            if (potential > LEAK)
//                potential <= potential - LEAK;
//            else
//                potential <= 0;

            // Check if threshold is reached
            if (potential >= THRESHOLD) begin
                spike_out <= 1;
                potential <= 0; // Reset after firing
            end else begin
                spike_out <= 0;
            end
        end
        
        // Debug statement to print values at each clock cycle
        $display("Time=%0t, Potential=%d, SpikeOut=%b, SpikeIn=%b", $time, potential, spike_out, spike_in);
    end

endmodule