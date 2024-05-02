library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder is
  Port (
        operator_1: in std_logic_vector(15 downto 0);
        operator_2: in std_logic_vector(15 downto 0);
        result: out std_logic_vector(15 downto 0)
  );
end adder;

architecture Behavioral of adder is

begin
    result <= operator_1 + operator_2;
end Behavioral;
