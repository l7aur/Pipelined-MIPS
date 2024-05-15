library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register1 is
    Port(
    clk: in std_logic;
    reset: in std_logic;
  
    adder_in: in std_logic_vector(15 downto 0);
    instruction_in: in std_logic_vector(15 downto 0);
  
    adder_out: out std_logic_vector(15 downto 0);
    instruction_out: out std_logic_vector(15 downto 0)
  );
end register1;

architecture Behavioral of register1 is

begin
    process(clk, reset)
        begin
        if rising_edge(clk) then
            if reset = '1' then
                adder_out <= x"0000";
                instruction_out <= x"0000";
            else
                adder_out <= adder_in;
                instruction_out <= instruction_in;
            end if;
        end if;
    end process;

end Behavioral;
