library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register4 is
    Port(
    clk: in std_logic;
    reset: in std_logic;
  
    write_back_in: in std_logic_vector(1 downto 0);
    for_mux_1_in: in std_logic_vector(15 downto 0);
    for_mux_2_in: in std_logic_vector(15 downto 0);
    for_write_address_in: in std_logic_vector(2 downto 0);
  
    write_back_out: out std_logic_vector(1 downto 0);
    for_mux_1_out: out std_logic_vector(15 downto 0);
    for_mux_2_out: out std_logic_vector(15 downto 0);
    for_write_address_out: out std_logic_vector(2 downto 0)
  );
end register4;

architecture Behavioral of register4 is

begin
    process(clk)
        begin
        if rising_edge(clk) then
            if reset = '1' then
                write_back_out <= "00";
                for_mux_1_out <= x"0000";
                for_mux_2_out <= x"0000";
                for_write_address_out <= "000";
            else
                write_back_out <= write_back_in;
                for_mux_1_out <= for_mux_1_in;
                for_mux_2_out <= for_mux_1_in;
                for_write_address_out <= for_write_address_in;
            end if;
        end if;
    end process;

end Behavioral;
