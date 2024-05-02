library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_1 is
  Port(
    clk: in std_logic;
    reset: in std_logic;
    slot_1_in: in std_logic_vector(15 downto 0);
    slot_2_in: in std_logic_vector(15 downto 0);
    slot_1_out: out std_logic_vector(15 downto 0);
    slot_2_out: out std_logic_vector(15 downto 0)
  );
end register_1;

architecture Behavioral of register_1 is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                slot_1_out <= x"0000";
                slot_2_out <= x"0000";
            else
                slot_1_out <= slot_1_in;
                slot_2_out <= slot_2_in;
            end if;
        end if;
    end process;

end Behavioral;
