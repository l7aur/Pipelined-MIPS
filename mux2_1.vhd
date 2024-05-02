library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_1 is
  Generic(
    BUS_SIZE: POSITIVE := 16
  );
  Port(
       field_0: in std_logic_vector(BUS_SIZE - 1 downto 0);
       field_1: in std_logic_vector(BUS_SIZE - 1 downto 0);
       selection_signal: in std_logic;
       output: out std_logic_vector(BUS_SIZE -1 downto 0)
       );
end mux2_1;

architecture Behavioral of mux2_1 is

begin
    output <= field_0 when (selection_signal = '0') else field_1; 
end Behavioral;
