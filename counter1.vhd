library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity counter1 is
    Port (
    clk: in std_logic;
    port_out: out std_logic
   );
end counter1;

architecture Behavioral of counter1 is

begin
    counting_process: process(clk)
        variable aux: std_logic_vector(15 downto 0) := x"0000";
        begin
            if rising_edge(clk) then
                aux := aux + 1;
                if aux = x"FFFF" then
                    port_out <= '1';
                end if;
            end if;
        end process;

end Behavioral;
