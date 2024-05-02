library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
  Port (
    operand_1: in std_logic_vector(15 downto 0);
    operand_2: in std_logic_vector(15 downto 0);
    shift_amount: in std_logic;
    ALU_control_signal: in std_logic_vector(3 downto 0);
    result: out std_logic_vector(15 downto 0);
    zero: out std_logic
  );
end ALU;

architecture Behavioral of ALU is

signal intermediary_result: std_logic_vector(15 downto 0);

begin
    result <= intermediary_result;
    process(intermediary_result)
    begin
        if intermediary_result = x"0000" then
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;
    
    process(ALU_control_signal, operand_1, operand_2, shift_amount)
    begin
        if ALU_control_signal(3) = '1' then
            case ALU_control_signal(2 downto 0) is
                when "000" => intermediary_result <= operand_1 + operand_2;
                when "001" => intermediary_result <= operand_1 - operand_2;
                when "010" => 
                    if shift_amount = '1' then
                        intermediary_result <= operand_1(14 downto 0) & '0';
                    else
                        intermediary_result <= operand_1;
                    end if;
                when "011" => 
                    if shift_amount = '1' then
                        intermediary_result <= '0' & operand_1(15 downto 1);
                    else
                        intermediary_result <= operand_1;
                    end if;
                when "100" => intermediary_result <= operand_1 and operand_2;
                when "101" => intermediary_result <= operand_1 or operand_2;
                when "110" =>
                    if shift_amount = '1' then
                        intermediary_result <= '1' & operand_1(15 downto 1);
                    else
                        intermediary_result <= operand_1;
                    end if;
                when others => intermediary_result <= operand_1 xor operand_2;
            end case;
        else
            intermediary_result <= operand_1 + operand_2;
        end if;
    end process;
end Behavioral;
