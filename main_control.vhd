library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_control is
  Port (
    instruction: in std_logic_vector(2 downto 0);
    reg_dest: out std_logic;
    ext_op: out std_logic;
    ALU_src: out std_logic;
    branch: out std_logic;
    branch_ongte: out std_logic;
    andi_signal: out std_logic;
    jump: out std_logic;
    ALU_op: out std_logic;
    mem_write: out std_logic;
    mem_to_reg: out std_logic;
    reg_write: out std_logic
  );
end main_control;

architecture Behavioral of main_control is

begin
    process(instruction)
    begin
        case instruction is
            when "000" => -- arithmetic instructions
                reg_dest <= '1'; 
                ext_op <= '0';
                ALU_src <= '0';
                branch <= '0';
                branch_ongte <= '0';
                andi_signal <= '0';
                jump <= '0';
                ALU_op <= '1';
                mem_write <= '0';
                mem_to_reg <= '0';
                reg_write <= '1';
            when "001" => -- add immediate
                reg_dest <= '0'; 
                ext_op <= '0';
                ALU_src <= '1';
                branch <= '0'; 
                branch_ongte <= '0';
                andi_signal <= '0';
                jump <= '0';
                ALU_op <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                reg_write <= '1';
            when "010" => -- load word
                reg_dest <= '0'; 
                ext_op <= '0';
                ALU_src <= '1';
                branch <= '0';
                branch_ongte <= '0';
                andi_signal <= '0';
                jump <= '0';
                ALU_op <= '0';
                mem_write <= '0';
                mem_to_reg <= '1';
                reg_write <= '1';
            when "011" => --store word
                reg_dest <= '0'; 
                ext_op <= '0';
                ALU_src <= '1';
                branch <= '0';
                branch_ongte <= '0';
                andi_signal <= '0';
                jump <= '0';
                ALU_op <= '0';
                mem_write <= '1';
                mem_to_reg <= '0';
                reg_write <= '1';
            when "100" => --branch on equal
                reg_dest <= '0'; 
                ext_op <= '0';
                ALU_src <= '0';
                branch <= '1';
                branch_ongte <= '0';
                andi_signal <= '0';
                jump <= '0';
                ALU_op <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                reg_write <= '0';
            when "101" => --AND immediate
                reg_dest <= '0'; 
                ext_op <= '0';
                ALU_src <= '1';
                branch <= '0';
                branch_ongte <= '0';
                andi_signal <= '1';
                jump <= '0';
                ALU_op <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                reg_write <= '1';
            when "110" => --branch on greater than 0
                reg_dest <= '0'; 
                ext_op <= '0';
                ALU_src <= '0';
                branch <= '0';
                branch_ongte <= '1';
                andi_signal <= '0';
                jump <= '0';
                ALU_op <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                reg_write <= '0';
            when others => --jump
                reg_dest <= '0'; 
                ext_op <= '0';
                ALU_src <= '0';
                branch <= '0';
                branch_ongte <= '0';
                andi_signal <= '0';
                jump <= '1';
                ALU_op <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                reg_write <= '0';
        end case;
    end process;

end Behavioral;
