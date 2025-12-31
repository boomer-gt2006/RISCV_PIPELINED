# 🧠 RISC-V 5-Stage Pipelined Processor (RV32I)

## 📌 Overview
This project implements a **5-stage pipelined RISC-V processor** compliant with the **RV32I base integer instruction set**.  
The processor is designed using **SystemVerilog**, following a modular and scalable architecture suitable for academic learning, simulation, and future extensions.

The design emphasizes:
- Clear separation of pipeline stages
- Correct handling of data and control hazards
- Clean RTL suitable for synthesis and simulation

---

## 🏗️ Pipeline Architecture

The processor follows the classic **5-stage RISC pipeline**:

| Stage | Name | Description |
|-----|-----|------------|
| IF | Instruction Fetch | Fetch instruction from instruction memory |
| ID | Instruction Decode | Decode instruction and read register file |
| EX | Execute | ALU operations, branch evaluation |
| MEM | Memory Access | Load/store operations |
| WB | Write Back | Write results back to register file |

---

## 🔁 Pipeline Registers
- IF/ID  
- ID/EX  
- EX/MEM  
- MEM/WB  

Each pipeline register is implemented explicitly to ensure correct stage isolation and timing behavior.

---

## ⚙️ Supported Instruction Set (RV32I)

### Arithmetic & Logical
- `ADD`, `SUB`
- `AND`, `OR`, `XOR`
- `SLT`
- `ADDI`

### Memory Access
- `LW`
- `SW`

### Control Flow
- `BEQ`
- `BNE`
- `JAL`
- `JALR`

---

## 🚦 Hazard Handling

### ✅ Data Hazards
- A unified **Hazard Unit** handles:
  - Data forwarding (EX → EX, MEM → EX)
  - Load-use hazard detection
- Pipeline stalling is introduced when forwarding is insufficient

### ✅ Control Hazards
- Branch decision made in **EX stage**
- Pipeline flushing on taken branches and jumps

---

## 🧩 Major Modules

| Module | Description |
|------|------------|
| `riscv_top` | Top-level processor module |
| `controller` | Main control unit |
| `alu` | Arithmetic Logic Unit |
| `regfile` | 32×32 Register File |
| `hazard_unit` | Hazard detection, stalling, and forwarding logic |
| `extend` | Immediate value generation and sign extension |
| `pc` | Program counter logic |

---

## 🧪 Simulation & Verification
- Written entirely in **SystemVerilog**
- Testbenches verify:
  - Individual components (ALU, register file)
  - End-to-end pipeline execution
- Compatible with:
  - **Vivado Simulator**
  - **ModelSim / Questa**

---

## 🛠️ Tools Used
- **SystemVerilog**
- **Vivado**
- **Git & GitHub**

---

## 🚀 Future Work
- Support for:
  - Multiply/Divide (RV32M)
  - CSR instructions
- Branch prediction
- Instruction and data caches
- Pipeline performance analysis
- FPGA synthesis and timing closure

---

## 🎓 Educational Value
This project is ideal for understanding:
- RISC-V ISA fundamentals
- Five-stage pipeline design
- Hazard detection, stalling, and forwarding
- Control path vs data path separation
- RTL design best practices

---

## 📜 License
This project is open-source and intended for educational use.
