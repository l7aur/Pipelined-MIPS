library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register3 is
    Port(
    clk: in std_logic;
    reset: in std_logic;
  
    write_back_in: in std_logic_vector(1 downto 0);
    memory_in: in std_logic;
    adder_in: in std_logic_vector(15 downto 0);
    for_write_data_in: in std_logic_vector(15 downto 0);
    mux_result_in: in std_logic_vector(2 downto 0);
    branch_in: in std_logic;
    ALU_in: in std_logic_vector(15 downto 0);
  
    write_back_out: out std_logic_vector(1 downto 0);
    memory_out: out std_logic;
    adder_out: out std_logic_vector(15 downto 0);
    for_write_data_out: out std_logic_vector(15 downto 0);
    mux_result_out: out std_logic_vector(2 downto 0);
    branch_out: out std_logic;
    ALU_out: out std_logic_vector(15 downto 0)
  );
end register3;

architecture Behavioral of register3 is

begin
    process(clk)
        begin
        if rising_edge(clk) then
            if reset = '1' then
                write_back_out <= "00";
                memory_out <= '0';
                adder_out <= x"0000";
                for_write_data_out <= x"0000";
                mux_result_out <= "000";
                branch_out <= '0';
                ALU_out <= x"0000";
            else
                write_back_out <= write_back_in;
                memory_out <= memory_in;
                adder_out <= adder_in;
                for_write_data_out <= for_write_data_in;
                mux_result_out <= mux_result_in;
                branch_out <= branch_in;
                ALU_out <= ALU_in;
            end if;
        end if;
    end process;

end Behavioral;
