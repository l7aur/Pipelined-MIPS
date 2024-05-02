library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity program_counter is
  Port( 
    clk: in std_logic;
    reset: in std_logic;
    new_address: in std_logic_vector(15 downto 0);
    out_address: out std_logic_vector(15 downto 0)
  );
end program_counter;

architecture Behavioral of program_counter is

signal aux: std_logic_vector(15 downto 0) := x"0000"; --starting address

begin
    update_address: process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                aux <= x"0000";
            else
                aux <= new_address;
            end if;
        end if;
    end process;
    out_address <= aux;
end Behavioral;
