library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity extension_unit is
    Port (
    ext_op: in std_logic;
    data_in: in std_logic_vector(6 downto 0);
    data_out: out std_logic_vector(15 downto 0)
    );
end extension_unit;

architecture Behavioral of extension_unit is

begin
    process(ext_op, data_in)
    begin
        if ext_op = '0' then
            data_out <= x"00" & '0'& data_in;
        else 
            data_out(15) <= data_in(6);
            data_out(14) <= data_in(6);
            data_out(13) <= data_in(6);
            data_out(12) <= data_in(6);
            data_out(11) <= data_in(6);
            data_out(10) <= data_in(6);
            data_out(9) <= data_in(6);
            data_out(8) <= data_in(6);
            data_out(7) <= data_in(6);
            data_out(6 downto 0) <= data_in(6 downto 0);
        end if;
    end process;
end Behavioral;
