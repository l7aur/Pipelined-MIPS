library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_memory is
  Port (  
  clk: in std_logic;
  reset: in std_logic;
  memory_write: in std_logic;
  write_data: in std_logic_vector(15 downto 0);
  address: in std_logic_vector(15 downto 0);
  address_to_ssd: in std_logic_vector(15 downto 0);
  read_data: out std_logic_vector(15 downto 0);
  data_to_ssd: out std_logic_vector(15 downto 0)
  );
end data_memory;

architecture Behavioral of data_memory is

type random_access_memory is array(0 to 255) of std_logic_vector(15 downto 0);
signal RAM: random_access_memory := (
0 => x"0001",
1 => x"0001",
2 => x"0001",
others => x"FFFF"
);

begin
    comp1: process(clk)
        begin
            if rising_edge(clk) then
                if reset = '1' then
                    RAM(0) <= x"0001";
                    RAM(1) <= x"0001";
                    RAM(2) <= x"0001";
                else
                    if memory_write = '1' then
                        RAM(TO_INTEGER(UNSIGNED(address(7 downto 0)))) <= write_data;
                    end if;
                end if;
            end if;
        end process;  
    reset_process: process(reset)
        begin
            
        end process; 
    read_data <= RAM(TO_INTEGER(UNSIGNED(address(7 downto 0))));   
    data_to_ssd <= RAM(TO_INTEGER(UNSIGNED(address_to_ssd(7 downto 0))));
    
end Behavioral;
