# RTL Design of a UART Packetizer with Asynchronous FIFO and FSM-Based Control

## 📖 Project Overview

This project implements a **UART Packetizer** using **Verilog HDL** by integrating an **Asynchronous FIFO**, an **FSM-based Controller**, and a **UART Transmitter**. The design enables reliable serial data transmission between different clock domains while ensuring efficient packet handling and synchronization.

The project follows a modular RTL design approach, where each functional block is implemented as an independent Verilog module. The complete design was simulated, synthesized, and verified using **Xilinx Vivado**.

---

## ✨ Features

- RTL design implemented in **Verilog HDL**
- 16-depth **Asynchronous FIFO** for clock domain crossing
- FSM-based controller for packet management
- UART transmitter for serial communication
- Configurable baud rate generation
- Modular and synthesizable architecture
- Functional simulation and waveform verification
- Synthesis, timing, and utilization analysis

---

## 📂 Project Structure

```
UART_Packetizer/
│
├── Documentation/
├── Reports/
│   ├── Synthesis_Report.txt
│   ├── Timing_Summary.txt
│   └── Utilization_Report.txt
│
├── Simulation_Code_Files/
├── Source_Code_Files/
│   ├── asynchronous_fifo.v
│   ├── baud_time.v
│   ├── clockdivide.v
│   ├── fsm.v
│   ├── memory.v
│   ├── read_operation.v
│   ├── synch.v
│   ├── top.v
│   ├── top_design.v
│   ├── top_fifo.v
│   ├── uart.v
│   └── write_operation.v
│
├── Waveforms_and_Schematic_Design/
├── Introduction.txt
├── Project_Summary.txt
└── README.md
```

---

## 🛠️ Tools Used

- **Language:** Verilog HDL
- **EDA Tool:** Xilinx Vivado
- **Simulation:** Vivado Simulator
- **Version Control:** Git & GitHub

---

## 📌 Modules

- Asynchronous FIFO
- FIFO Memory
- Read Operation
- Write Operation
- Synchronizer
- FSM Controller
- UART Transmitter
- Baud Rate Generator
- Clock Divider
- Top Module

---

## 🎯 Applications

- UART-based Communication Systems
- Clock Domain Crossing (CDC)
- FPGA-Based Embedded Systems
- Digital Communication Interfaces
- ASIC and FPGA RTL Design

---

## 📈 Learning Outcomes

- RTL Design using Verilog HDL
- UART Protocol Implementation
- Asynchronous FIFO Design
- Finite State Machine (FSM) Design
- Clock Domain Crossing (CDC)
- Functional Verification
- RTL Synthesis and Timing Analysis

---

## 👨‍💻 Author

**Surya Teja**
Interested in RTL Design, Digital Design Verification, FPGA Design, and VLSI.
