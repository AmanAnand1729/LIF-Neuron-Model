# LIF-Neuron-Model
FPGA based implementation of Leaky Integrate-and-Fire Neuron model
This project implements a Leaky Integrate-and-Fire (LIF) neuron model using Verilog on the Spartan-7 XC7S50 FPGA (Boolean Board). The model simulates basic spiking neuron behavior by integrating input stimuli, applying leakage over time, and generating a spike when the membrane potential crosses a threshold. It also features:

1. Real-time simulation of membrane potential dynamics
2. Spike generation and reset mechanism
3. 7-segment display output for membrane potential and spike count
4. Support modules: binary-to-BCD conversion, debounce, and edge detection
5. Designed and tested in Vivado with simulation support
   
Ideal for neuromorphic computing experiments and educational purposes in spiking neural networks (SNNs).

