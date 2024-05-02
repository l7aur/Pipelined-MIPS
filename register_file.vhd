library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
  Port (
  clk: in std_logic;
  reset: in std_logic;
  register_write: in std_logic;
  read_address_1: in std_logic_vector(2 downto 0);
  read_address_2: in std_logic_vector(2 downto 0);
  write_address: in std_logic_vector(2 downto 0);
  write_data: in std_logic_vector(15 downto 0);
  read_data_1: out std_logic_vector(15 downto 0);
  read_data_2: out std_logic_vector(15 downto 0);
  reg_0: out std_logic_vector(15 downto 0);
  reg_1: out std_logic_vector(15 downto 0);
  reg_2: out std_logic_vector(15 downto 0);
  reg_3: out std_logic_vector(15 downto 0);
  reg_4: out std_logic_vector(15 downto 0);
  reg_5: out std_logic_vector(15 downto 0);
  reg_6: out std_logic_vector(15 downto 0);
  reg_7: out std_logic_vector(15 downto 0)
  );
end register_file;

architecture Behavioral of register_file is
type reg_array is array(0 to 7) of std_logic_vector(15 downto 0);
signal reg_data: reg_array := (
    others => x"0000"
);

begin
    writing_process: process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                reg_data(0) <= x"0000";
                reg_data(1) <= x"0000";
                reg_data(2) <= x"0000";
                reg_data(3) <= x"0000";
                reg_data(4) <= x"0000";
                reg_data(5) <= x"0000";
                reg_data(6) <= x"0000";
                reg_data(7) <= x"0000";
            else
                if register_write = '1' then
                    reg_data(TO_INTEGER(UNSIGNED(write_address))) <= write_data;
                end if;
            end if;
        end if;
    end process;
    
    read_data_1 <= reg_data(TO_INTEGER(UNSIGNED(read_address_1))); 
    read_data_2 <= reg_data(TO_INTEGER(UNSIGNED(read_address_2)));
    reg_0 <= reg_data(0);
    reg_1 <= reg_data(1);
    reg_2 <= reg_data(2);
    reg_3 <= reg_data(3);
    reg_4 <= reg_data(4);
    reg_5 <= reg_data(5);
    reg_6 <= reg_data(6);
    reg_7 <= reg_data(7);
end Behavioral;
