library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_2 is
  Port(
    clk: in std_logic;
    reset: in std_logic;
    slot_1_in: in std_logic_vector(15 downto 0);
    slot_2_in: in std_logic_vector(3 downto 0);
    slot_3_in: in std_logic_vector(2 downto 0);
    slot_4_in: in std_logic_vector(2 downto 0);
    extension_in: in std_logic_vector(15 downto 0);
    register_file_1_in: in std_logic_vector(15 downto 0);
    register_file_2_in: in std_logic_vector(15 downto 0);
    write_back_in: in std_logic_vector(1 downto 0);
    memory_in: in std_logic_vector(1 downto 0);
    execution_in: in std_logic_vector(2 downto 0);
    
    slot_1_out: out std_logic_vector(15 downto 0);
    slot_2_out: out std_logic_vector(3 downto 0);
    slot_3_out: out std_logic_vector(2 downto 0);
    slot_4_out: out std_logic_vector(2 downto 0);
    extension_out: out std_logic_vector(15 downto 0);
    register_file_1_out: out std_logic_vector(15 downto 0);
    register_file_2_out: out std_logic_vector(15 downto 0);
    write_back_out: out std_logic_vector(1 downto 0);
    memory_out: out std_logic_vector(1 downto 0);
    execution_out: out std_logic_vector(2 downto 0)
  );
end register_2;

architecture Behavioral of register_2 is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                slot_1_out <= x"0000";
                slot_2_out <= "0000";
                slot_3_out <= "000";
                slot_4_out <= "000";
                extension_out <= x"0000";
                register_file_1_out <= x"0000";
                register_file_2_out <= x"0000";
                write_back_out <= "00";
                memory_out <= "00";
                execution_out <= "000";
            else
                slot_1_out <= slot_1_in;
                slot_2_out <= slot_2_in;
                slot_3_out <= slot_3_in;
                slot_4_out <= slot_4_in;
                extension_out <= extension_in;
                register_file_1_out <= register_file_1_in;
                register_file_2_out <= register_file_2_in;
                write_back_out <= write_back_in;
                memory_out <= memory_in;
                execution_out <= execution_in;
            end if;
        end if;
    end process;

end Behavioral;
