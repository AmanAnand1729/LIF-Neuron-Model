# FPGA-Based Leaky Integrate-and-Fire (LIF) Neuron Model

This project implements a digital model of a Leaky Integrate-and-Fire (LIF) neuron using Verilog HDL on a Spartan-7 XC7S50 FPGA (Boolean Board). The LIF model emulates the behavior of biological neurons by integrating input stimuli, applying leakage over time, and generating a spike when a threshold is reached.

## 🔬 Project Objectives

- Simulate LIF neuron behavior in real-time on FPGA hardware.
- Display membrane potential and spike count on dual 7-segment displays.
- Build and simulate a spiking neural model using only digital logic components.
- Develop reusable Verilog modules for BCD conversion, debouncing, and edge detection.

## 🧠 Key Features

- **Membrane Potential Integration**: Accumulates input signal until threshold.
- **Leak Mechanism**: Applies decay over time to simulate biological leakage.
- **Spike Generation**: Fires a spike when potential exceeds threshold.
- **Reset Mechanism**: Resets potential after spike event.
- **Display Support**: Real-time output of membrane potential and spike count on 7-segment displays.

## 📁 Project Structure

```bash
.
├── src/
│   ├── 01.lif_neuron_simulation.v  # Basic LIF neuron logic for simulation
│   ├── 03.lif_neuron.v             #Final code for FPGA with button debounce and spike edge detection
│
├── testbench/
│   ├── 02.testbench.v              # Testbench for simulation
│
├── constraints/
│   ├── const.xdc                   # XDC constraints for Spartan-7
│
├── 00.README.md                    # Project overview and instructions
