library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instruction_memory is
  Port ( 
  address: in std_logic_vector(15 downto 0);
  data_out: out std_logic_vector(15 downto 0)
  );
end instruction_memory;

architecture Behavioral of instruction_memory is
type memory_array is array(0 to 255) of std_logic_vector(15 downto 0);
--type memory_array is array(0 to 65535) of std_logic_vector(15 downto 0); --to big to synthesize, but can be addressable by this design
constant memory_content: memory_array := (
    0 => B"010_000_001_0000001",    --4081      --load register1 with contents from ram address 1
    1 => B"010_000_010_0000010",    --4102      --load register2 with contents from ram address 2
    2 => B"000_001_010_011_0000",   --0530      --add register1 and register2 and save in register3
    3 => B"011_000_010_0000001",    --6101      --store contents of register2 at memory address 1
    4 => B"011_000_011_0000010",    --6182      --store contents of register3 at memory address 2
    5 => B"010_000_011_0000001",    --4181      --load register3 with contents from ram address 1
    6 => B"100_100_011_0000001",    --9181      --branch to instruction +1 (+1) if maximum number reached
    7 => B"111_0000000000000",      --E000      --jump to address 0 in instruction_memory (here)
    8 => B"011_000_101_0000001",    --6281      --store contents of register5 at memory address 1
    others => x"FFFF"  
);
begin
    data_out <= memory_content(TO_INTEGER(UNSIGNED(address)));
end Behavioral;
