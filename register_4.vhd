library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_4 is
  Port(
  clk: in std_logic;
  reset: in std_logic;
  write_back_in: in std_logic_vector(1 downto 0);
  slot_1_in: in std_logic_vector(15 downto 0);
  slot_2_in: in std_logic_vector(15 downto 0);
  slot_3_in: in std_logic_vector(2 downto 0);
  
  write_back_out: out std_logic_vector(1 downto 0);
  slot_1_out: out std_logic_vector(15 downto 0);
  slot_2_out: out std_logic_vector(15 downto 0);
  slot_3_out: out std_logic_vector(2 downto 0)
  );
end register_4;

architecture Behavioral of register_4 is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                write_back_out <= "00";
                slot_1_out <= x"0000";
                slot_2_out <= x"0000";
                slot_3_out <= "000";
            else
                write_back_out <= write_back_in;
                slot_1_out <= slot_1_in;
                slot_2_out <= slot_2_in;
                slot_3_out <= slot_3_in;
            end if;
        end if;
    end process;

end Behavioral;
