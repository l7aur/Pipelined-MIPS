library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register2 is
    Port(
    clk: in std_logic;
    reset: in std_logic;
  
    write_back_in: in std_logic_vector(1 downto 0);
    memory_in: in std_logic_vector(3 downto 0);
    execution_in: in std_logic_vector(2 downto 0);
    adder_in: in std_logic_vector(15 downto 0);
    register_file_data1_in: in std_logic_vector(15 downto 0);
    register_file_data2_in: in std_logic_vector(15 downto 0);
    extension_unit_in: in std_logic_vector(15 downto 0);
    for_ALU_control_in: in std_logic_vector(3 downto 0);
    for_mux1_in: in std_logic_vector(2 downto 0);
    for_mux2_in: in std_logic_vector(2 downto 0);
  
    write_back_out: out std_logic_vector(1 downto 0);
    memory_out: out std_logic_vector(3 downto 0);
    execution_out: out std_logic_vector(2 downto 0);
    adder_out: out std_logic_vector(15 downto 0);
    register_file_data1_out: out std_logic_vector(15 downto 0);
    register_file_data2_out: out std_logic_vector(15 downto 0);
    extension_unit_out: out std_logic_vector(15 downto 0);
    for_ALU_contro_out: out std_logic_vector(3 downto 0);
    for_mux1_out: out std_logic_vector(2 downto 0);
    for_mux2_out: out std_logic_vector(2 downto 0)
  );
end register2;

architecture Behavioral of register2 is

begin
    process(clk, reset)
        begin
        if rising_edge(clk) then
            if reset = '1' then
                write_back_out <= "00";
                memory_out <= x"0";
                execution_out <= "000";
                adder_out <= x"0000";
                register_file_data1_out <= x"0000";
                register_file_data2_out <= x"0000";
                extension_unit_out <= x"0000";
                for_ALU_contro_out <= x"0";
                for_mux1_out <= "000";
                for_mux2_out <= "000";
            else
                write_back_out <= write_back_in;
                memory_out <= memory_in;
                execution_out <= execution_in;
                adder_out <= adder_in;
                register_file_data1_out <= register_file_data1_in;
                register_file_data2_out <= register_file_data2_in;
                extension_unit_out <= extension_unit_in;
                for_ALU_contro_out <= for_ALU_control_in;
                for_mux1_out <= for_mux1_in;
                for_mux2_out <= for_mux2_in;
            end if;
        end if;
    end process;
    
end Behavioral;
