library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS is
    Port (
        clk: in std_logic;
        reset: in std_logic;
        data_address_in: in std_logic_vector(15 downto 0);
        data_out: out std_logic_vector(15 downto 0);
        reg0_data_out: out std_logic_vector(15 downto 0);
        reg1_data_out: out std_logic_vector(15 downto 0);
        reg2_data_out: out std_logic_vector(15 downto 0);
        reg3_data_out: out std_logic_vector(15 downto 0);
        reg4_data_out: out std_logic_vector(15 downto 0);
        reg5_data_out: out std_logic_vector(15 downto 0);
        reg6_data_out: out std_logic_vector(15 downto 0);
        reg7_data_out: out std_logic_vector(15 downto 0);
        instr_out: out std_logic_vector(15 downto 0);
        program_c: out std_logic_vector(15 downto 0);
        addr_out: out std_logic_vector(15 downto 0);
        ext_out: out std_logic_vector(15 downto 0)
    );
end MIPS;

architecture Behavioral of MIPS is

--component instantiation
component ALU is
  Port (
    operand_1: in std_logic_vector(15 downto 0);
    operand_2: in std_logic_vector(15 downto 0);
    shift_amount: in std_logic;
    ALU_control_signal: in std_logic_vector(3 downto 0);
    result: out std_logic_vector(15 downto 0);
    zero: out std_logic
  );
end component;
component ALU_control is
  Port (
  function_code: in std_logic_vector(3 downto 0);
  ALU_op: in std_logic;
  shift_amount: out std_logic;
  control_out: out std_logic_vector(3 downto 0)
  );
end component;
component adder is
  Port (
        operator_1: in std_logic_vector(15 downto 0);
        operator_2: in std_logic_vector(15 downto 0);
        result: out std_logic_vector(15 downto 0)
  );
end component;
component data_memory is
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
end component;
component instruction_memory is
  Port ( 
  address: in std_logic_vector(15 downto 0);
  data_out: out std_logic_vector(15 downto 0)
  );
end component;
component main_control is
  Port (
    instruction: in std_logic_vector(2 downto 0);
    reg_dest: out std_logic;
    ext_op: out std_logic;
    ALU_src: out std_logic;
    branch: out std_logic;
    jump: out std_logic;
    ALU_op: out std_logic;
    mem_write: out std_logic;
    mem_to_reg: out std_logic;
    reg_write: out std_logic
  );
end component;
component mux2_1 is
  Generic(
    BUS_SIZE: POSITIVE := 16
  );
  Port(
       field_0: in std_logic_vector(BUS_SIZE - 1 downto 0);
       field_1: in std_logic_vector(BUS_SIZE - 1 downto 0);
       selection_signal: in std_logic;
       output: out std_logic_vector(BUS_SIZE -1 downto 0)
       );
end component;
component program_counter is
  Port( 
    clk: in std_logic;
    reset: in std_logic;
    new_address: in std_logic_vector(15 downto 0);
    out_address: out std_logic_vector(15 downto 0)
  );
end component;
component register_file is
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
end component;
component extension_unit is
    Port (
    ext_op: in std_logic;
    data_in: in std_logic_vector(6 downto 0);
    data_out: out std_logic_vector(15 downto 0)
    );
end component;
--inner signals instantiation

signal aux_1: std_logic_vector(15 downto 0);
signal aux_2: std_logic_vector(15 downto 0);
signal aux_3: std_logic_vector(15 downto 0);
signal aux_4: std_logic_vector(15 downto 0);
signal aux_5: std_logic_vector(15 downto 0);
signal aux_6: std_logic_vector(15 downto 0);
signal aux_7: std_logic;
signal aux_8: std_logic_vector(15 downto 0);
signal aux_9: std_logic_vector(15 downto 0);
signal aux_10: std_logic_vector(15 downto 0);
signal aux_11: std_logic_vector(15 downto 0);
signal aux_12: std_logic_vector(15 downto 0);
signal aux_13: std_logic_vector(15 downto 0);
signal aux_14: std_logic_vector(3 downto 0);
signal aux_15: std_logic_vector(15 downto 0);
signal aux_16: std_logic_vector(15 downto 0);
signal aux_17: std_logic_vector(15 downto 0);
signal q_1: std_logic;
signal q_2: std_logic;
signal q_3: std_logic;
signal q_4: std_logic;
signal q_5: std_logic;
signal q_6: std_logic;
signal q_7: std_logic;
signal q_8: std_logic;
signal q_9: std_logic;
signal q_10: std_logic;
signal q_11: std_logic;

begin
    aux_15(15 downto 8) <= x"00";

    c0: instruction_memory port map(
    address => aux_2,
    data_out => aux_3
    );
    
    instr_out <= aux_3;
    addr_out <= aux_11;
    ext_out <= aux_16;
    program_c <= aux_2;
    
    c1: program_counter port map(
        clk => clk,
        reset => reset,
        new_address => aux_1,
        out_address => aux_2
        );
    c2: register_file port map(
        clk => clk,
        reset => reset,
        register_write => q_9,
        read_address_1 => aux_3(12 downto 10),
        read_address_2 => aux_3(9 downto 7),
        write_address => aux_15(2 downto 0),
        write_data => aux_13,
        read_data_1 => aux_8,
        read_data_2 => aux_9,
        reg_0 => reg0_data_out,
        reg_1 => reg1_data_out,
        reg_2 => reg2_data_out,
        reg_3 => reg3_data_out,
        reg_4 => reg4_data_out,
        reg_5 => reg5_data_out,
        reg_6 => reg6_data_out,
        reg_7 => reg7_data_out
        );
        c3: mux2_1 generic map(
        BUS_SIZE => 3
        )
                   port map(
        field_0 => aux_3(9 downto 7),
        field_1 => aux_3(6 downto 4),
        selection_signal => q_1,
        output => aux_15(2 downto 0)
        ); 
        c4: main_control port map(
        instruction => aux_3(15 downto 13),
        reg_dest => q_1,
        ext_op => q_2,
        ALU_src => q_3,
        branch => q_4,
        jump => q_5,
        ALU_op => q_6,
        mem_write => q_7,
        mem_to_reg => q_8,
        reg_write => q_9
        );
        c5: adder port map(
        operator_1 => x"0001",
        operator_2 => aux_2,
        result => aux_4
        );
        c6: ALU port map(
        operand_1 => aux_8, 
        operand_2 => aux_16,
        shift_amount => q_10,
        ALU_control_signal => aux_14,
        result => aux_11,
        zero => q_11
        );
        c7: mux2_1 generic map(
        BUS_SIZE => 16
        )
                   port map(
        field_0 => aux_9,
        field_1 => aux_10,
        selection_signal => q_3,
        output => aux_16
        );
        c8: data_memory port map(
        clk => clk,
        reset => reset,
        memory_write => q_7,
        write_data => aux_9,
        address => aux_11,
        address_to_ssd => data_address_in,
        read_data => aux_12, 
        data_to_ssd => data_out
        );
        c9: mux2_1 generic map(
        BUS_SIZE => 16
        )
                   port map(
        field_0 => aux_11,
        field_1 => aux_12,
        selection_signal => q_8,
        output => aux_13
        );
        c10: aux_7 <= q_4 AND q_11;
        c11: ALU_control port map(
        function_code => aux_3(3 downto 0),
        ALU_op => q_6,
        shift_amount => q_10,
        control_out => aux_14
        );
        c12: adder port map(
        operator_1 => aux_4,
        operator_2 => aux_10,
        result =>aux_6
        );
        c13: mux2_1 generic map(
        BUS_SIZE => 16
        )
                   port map(
        field_0 => aux_4,
        field_1 => aux_6,
        selection_signal => aux_7,
        output => aux_17
        );
        c14: mux2_1 generic map(
        BUS_SIZE => 16
        )
                   port map(
        field_0 => aux_17,
        field_1 => aux_5,
        selection_signal => q_5,
        output => aux_1
        );
        c15: extension_unit port map(
        ext_op => q_2,
        data_in => aux_3(6 downto 0),
        data_out => aux_10
        );
        c16: aux_5 <= "000" & aux_3(12 downto 0);
end Behavioral;
