# Pipelined MIPS
Project for the Computer Architecture course
- The hard-coded instructions implement the generation of the Fibonacci sequence.
- The numbers are displayed in hexadecimal.
- The output of the computations is saved in the location 1 in the data memory (RAM/ only the last switch from left to right should be turned on).
- There is no overflow protection.
- From left to right the switches do:
    - 1 to 3: select between
      - Display data memory contents if 000.
      - Dispaly contents of a register if 001.
      - Display the instruction to be executed in the next clock cycle if 010.
      - Display the program counter state if 011.
      - Display the address to the data memory for the next clock cycle if 100.
      - Display the second operand that is entering the ALU in the next clock cycle if 101/110/111.
    - 4 to 6: select between registers
      - Register 0 if 000.
      - Register 1 if 001.
      - Register 2 if 010.
      - Register 3 if 011.
      - Register 4 if 100.
      - Register 5 if 101.
      - Register 6 if 110.
      - Register 7 if 111.
    - 7 acts as the reset switch: takes the MIPS back to the initial stage.
    - 8 does nothing
    - 9 to 16 selects the address in the data memory whose contents are displayed.
      
_Note 1: The bus sizes of this MIPS processor allow for a data memory and an instruction memory of up to 65536 (2^16) locations. This design is limited to 256 locations because there is no need for such a huge space of addresses and my computer found the design somehow unsinthesizable (too big of a number)._

_Note 2: For the processor to work in a full 16-bit mode the roles of the switches has to be modified (all 16 switches would be needed to navigate through a memory of size 2^16 for example)._

![image](https://github.com/l7aur/Single-Cycle-MIPS/assets/81981519/8b40b451-72f8-4635-ad34-fe9172a5d8d4)

![Screenshot 2024-04-21 112104](https://github.com/l7aur/Single-Cycle-MIPS/assets/81981519/660ba878-d82e-4da9-af25-46823d64db49)



