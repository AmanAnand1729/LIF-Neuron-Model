`timescale 1ns / 1ps

module lif_neuron_tb();
    
    reg clk;
    reg reset;
    reg spike_in;
    wire spike_out;
    
    // Instantiate the LIF neuron module
    lif_neuron uut (
        .clk(clk),
        .reset(reset),
        .spike_in(spike_in),
        .spike_out(spike_out)
    );

    // Generate clock signal
    always #5 clk = ~clk; // 10ns clock period
    
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        spike_in = 0;
        #10 reset = 0; // Release reset
        
        // Apply input spikes
        #10 spike_in = 1; #10 spike_in = 0;
        #10 spike_in = 1; #10 spike_in = 0;
        #10 spike_in = 1; #10 spike_in = 0;
        #10 spike_in = 1; #10 spike_in = 0;
        #10 spike_in = 1; #10 spike_in = 0;
        #10 spike_in = 1; #10 spike_in = 0;
        
        #50; // Wait to observe leakage and firing
        $stop; // End simulation
    end

endmodule
