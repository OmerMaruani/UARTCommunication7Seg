# UART Communication: Raspberry Pi 4 to FPGA (7-Segment)

## 📝 Project Description
This project establishes a serial communication link between a **Raspberry Pi 4** and an **FPGA board**. 

A Python script running on the Raspberry Pi sends data via UART. The FPGA receives this data, processes it through a custom-built UART controller, and decodes the ASCII characters to display them in real-time on a **4-digit 7-segment display**. This project demonstrates hardware-software integration, precise timing for baud rate generation, and modular Verilog design.

---

## 🖼️ System Visuals

### 1. Block Diagram Architecture
This diagram illustrates the internal logic of the FPGA, including the UART receiver, the decoder, and the 7-segment driver.

<p align="center">
  <img src="Images/UARTCommunicationFPGA.png" width="700" alt="Block Diagram">
</p>

### 2. Running System
The image below shows the hardware setup: The Raspberry Pi 4 monitor sending data and the FPGA board displaying the result.

<p align="center">
  <img src="Images/UARTCommunicationFPGARaspberryPi4.png" width="700" alt="Hardware Setup">
</p>

---

## 📂 Project Structure

```text
UARTCommunication7Seg/
├── Verilog/
│   ├── sim/                    # Simulation folder
│   │   └── *.do                # ModelSim scripts for testbenches
|   |
│   ├── src/                    # Verilog Source Files
│   │   ├── uart_controller.v   # Main UART system controller
│   │   ├── Rx_module.v         # UART Receiver logic
│   │   ├── Tx_module.v         # UART Transmitter logic
│   │   ├── baud_gen.v          # Baud rate generator (timing)
│   │   ├── ascii_to_7seg.v     # ASCII to 7-Segment conversion logic
│   │   ├── decoder.v           # System decoder
│   │   └── counter.v           # General purpose counter
|   |
│   └── par/                    # Place and Route (Quartus settings)
|   |
├── Python/
│   └── UART.py                 # UART Communication script for Raspberry Pi 4
└── README.md
```

## 🎥 Demo Video
<!-- Paste your video link or HTML code here -->





