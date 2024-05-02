library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_control is
  Port (
  function_code: in std_logic_vector(3 downto 0);
  ALU_op: in std_logic;
  shift_amount: out std_logic;
  control_out: out std_logic_vector(3 downto 0)
  );
end ALU_control;

architecture Behavioral of ALU_control is

begin
    shift_amount <= function_code(3);
    process(ALU_op, function_code) 
    begin
        if ALU_op = '1' then
            control_out <= '1' & function_code(2 downto 0);
        else
            control_out <= "0000";
        end if; 
    end process;

end Behavioral;
