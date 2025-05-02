module lif_neuron_top (
    input clk,             // Clock input (100 MHz)
    input reset_btn,       // Button J2
    input spike_btn,       // Button J5
    output spike_led,      // LED G1
    output clean_spike_led, // LED E2
    output spike_edge_led, // LED F1
    output [7:0] potential_leds // Optional: debug potential
);

    wire clean_reset, clean_spike;
    wire spike_edge;
    wire spike_out;
    wire [7:0] potential;

    // Debounce for both reset and spike
    debounce db_reset (
        .clk(clk),
        .noisy_in(reset_btn),
        .clean_out(clean_reset)
    );

    debounce db_spike (
        .clk(clk),
        .noisy_in(spike_btn),
        .clean_out(clean_spike)
    );

    // Edge detector for spike
    reg prev_spike;
    always @(posedge clk)
        prev_spike <= clean_spike;

    assign spike_edge = clean_spike & ~prev_spike;

    // LIF Neuron
    lif_neuron neuron (
        .clk(clk),
        .reset(clean_reset),
        .spike_in(spike_edge),
        .spike_out(spike_out),
        .potential(potential)
    );

    // Hold spike LED for visibility (~100ms)
    reg [23:0] spike_timer;
    always @(posedge clk) begin
        if (spike_out)
            spike_timer <= 24'd10_000_000;  // ~100 ms at 100 MHz
        else if (spike_timer > 0)
            spike_timer <= spike_timer - 1;
    end
    assign spike_led = (spike_timer > 0);

    // Debug LEDs
    assign clean_spike_led = clean_spike;
    assign spike_edge_led = spike_edge;
    assign potential_leds = potential;

endmodule
module lif_neuron (
    input clk,
    input reset,
    input spike_in,
    output reg spike_out,
    output reg [7:0] potential
);

    parameter THRESHOLD = 100;
    parameter INCREMENT = 20;
    parameter LEAK = 1;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            potential <= 0;
            spike_out <= 0;
        end else begin
            if (spike_in)
                potential <= potential + INCREMENT - LEAK;

            if (potential >= THRESHOLD) begin
                spike_out <= 1;
                potential <= 0;
            end else begin
                spike_out <= 0;
            end
        end
    end
endmodule
module debounce (
    input clk,
    input noisy_in,
    output reg clean_out
);
    reg [19:0] counter = 0;
    reg stable_state = 0;

    parameter THRESHOLD = 200_000; // ~2ms

    always @(posedge clk) begin
        if (noisy_in != stable_state) begin
            counter <= counter + 1;
            if (counter >= THRESHOLD) begin
                stable_state <= noisy_in;
                counter <= 0;
            end
        end else begin
            counter <= 0;
        end

        clean_out <= stable_state;
    end
endmodule