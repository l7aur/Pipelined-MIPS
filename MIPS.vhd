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
component register_1 is
  Port(
    clk: in std_logic;
    reset: in std_logic;
    slot_1_in: in std_logic_vector(15 downto 0);
    slot_2_in: in std_logic_vector(15 downto 0);
    slot_1_out: out std_logic_vector(15 downto 0);
    slot_2_out: out std_logic_vector(15 downto 0)
  );
end component;
component register_2 is
  Port(
    clk: in std_logic;
    reset: in std_logic;
    slot_1_in: in std_logic_vector(15 downto 0);
    slot_2_in: in std_logic_vector(3 downto 0);
    slot_3_in: in std_logic_vector(2 downto 0);
    slot_4_in: in std_logic_vector(2 downto 0);
    extension_in: in std_logic_vector(15 downto 0);
    register_file_1_in: in std_logic_vector(15 downto 0);
    register_file_2_in: in std_logic_vector(15 downto 0);
    write_back_in: in std_logic_vector(1 downto 0);
    memory_in: in std_logic_vector(1 downto 0);
    execution_in: in std_logic_vector(2 downto 0);
    
    slot_1_out: out std_logic_vector(15 downto 0);
    slot_2_out: out std_logic_vector(3 downto 0);
    slot_3_out: out std_logic_vector(2 downto 0);
    slot_4_out: out std_logic_vector(2 downto 0);
    extension_out: out std_logic_vector(15 downto 0);
    register_file_1_out: out std_logic_vector(15 downto 0);
    register_file_2_out: out std_logic_vector(15 downto 0);
    write_back_out: out std_logic_vector(1 downto 0);
    memory_out: out std_logic_vector(1 downto 0);
    execution_out: out std_logic_vector(2 downto 0)
  );
end component;
component register_3 is
  Port(
  clk: in std_logic;
  reset: in std_logic;
  write_back_in: in std_logic_vector(1 downto 0);
  memory_in: in std_logic_vector(1 downto 0);
  slot_1_in: in std_logic_vector(15 downto 0);
  slot_2_in: in std_logic_vector(15 downto 0);
  slot_3_in: in std_logic_vector(15 downto 0);
  slot_4_in: in std_logic_vector(2 downto 0);
  zero_reg3_in: in std_logic;
  
  write_back_out: out std_logic_vector(1 downto 0);
  memory_out: out std_logic_vector(1 downto 0);
  slot_1_out: out std_logic_vector(15 downto 0);
  slot_2_out: out std_logic_vector(15 downto 0);
  slot_3_out: out std_logic_vector(15 downto 0);
  slot_4_out: out std_logic_vector(2 downto 0);
  zero_reg3_out: out std_logic
  );
end component;
component register_4 is
  Port(
  clk: in std_logic;
  reset: in std_logic;
  write_back_in: in std_logic_vector(1 downto 0);
  slot_1_in: in std_logic_vector(15 downto 0);
  slot_2_in: in std_logic_vector(15 downto 0);
  slot_3_in: in std_logic_vector(2 downto 0);
  
  write_back_out: out std_logic_vector(1 downto 0);
  slot_1_out: out std_logic_vector(15 downto 0);
  slot_2_out: out std_logic_vector(15 downto 0);
  slot_3_out: out std_logic_vector(2 downto 0)
  );
end component;

--inner signals instantiation

signal aux_1: std_logic_vector(15 downto 0);
signal aux_2: std_logic_vector(15 downto 0);
signal aux_3: std_logic_vector(15 downto 0);
signal aux_3bis: std_logic_vector(15 downto 0);
signal aux_3bisbis: std_logic_vector(15 downto 0);
signal aux_4: std_logic_vector(15 downto 0);
signal aux_4bis: std_logic_vector(15 downto 0);
signal aux_4bisbis: std_logic_vector(15 downto 0);
signal aux_5: std_logic_vector(15 downto 0);
signal aux_6: std_logic_vector(15 downto 0);
signal aux_6bis: std_logic_vector(15 downto 0);
signal aux_7: std_logic;
signal aux_8: std_logic_vector(15 downto 0);
signal aux_8bis: std_logic_vector(15 downto 0);
signal aux_9: std_logic_vector(15 downto 0);
signal aux_9bis: std_logic_vector(15 downto 0);
signal aux_9bisbis: std_logic_vector(15 downto 0);
signal aux_10: std_logic_vector(15 downto 0);
signal aux_10bis: std_logic_vector(15 downto 0);
signal aux_11: std_logic_vector(15 downto 0);
signal aux_11bis: std_logic_vector(15 downto 0);
signal aux_11bisbis: std_logic_vector(15 downto 0);
signal aux_12: std_logic_vector(15 downto 0);
signal aux_12bis: std_logic_vector(15 downto 0);
signal aux_13: std_logic_vector(15 downto 0);
signal aux_14: std_logic_vector(3 downto 0);
signal aux_15: std_logic_vector(2 downto 0);
signal aux_15bis: std_logic_vector(2 downto 0);
signal aux_15bisbis: std_logic_vector(2 downto 0);
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

signal q8q9: std_logic_vector(1 downto 0);
signal q4q7: std_logic_vector(1 downto 0);
signal q1q3q6: std_logic_vector(2 downto 0);
signal zero_reg3: std_logic;

signal m_out_reg2: std_logic_vector(1 downto 0);
signal m_out_reg3: std_logic_vector(1 downto 0);
signal wb_out_reg2: std_logic_vector(1 downto 0);
signal wb_out_reg3: std_logic_vector(1 downto 0);
signal wb_out_reg4: std_logic_vector(1 downto 0);
signal ex_out_reg2: std_logic_vector(2 downto 0);

begin
    c0: instruction_memory port map(
    address => aux_2,
    data_out => aux_3
    );
    
    instr_out <= aux_3bis;
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
        register_write => wb_out_reg4(1),
        read_address_1 => aux_3bis(12 downto 10),
        read_address_2 => aux_3bis(9 downto 7),
        write_address => aux_15bisbis,
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
        field_0 => aux_3bisbis(9 downto 7),
        field_1 => aux_3bisbis(6 downto 4),
        selection_signal => ex_out_reg2(0),
        output => aux_15
        ); 
        c4: main_control port map(
        instruction => aux_3bis(15 downto 13),
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
        operand_1 => aux_8bis, 
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
        field_0 => aux_9bis,
        field_1 => aux_10bis,
        selection_signal => ex_out_reg2(1),
        output => aux_16
        );
        c8: data_memory port map(
        clk => clk,
        reset => reset,
        memory_write => m_out_reg3(1),
        write_data => aux_9bisbis,
        address => aux_11bis,
        address_to_ssd => data_address_in,
        read_data => aux_12, 
        data_to_ssd => data_out
        );
        c9: mux2_1 generic map(
        BUS_SIZE => 16
        )
                   port map(
        field_0 => aux_11bisbis,
        field_1 => aux_12bis,
        selection_signal => wb_out_reg4(0),
        output => aux_13
        );
        c10: aux_7 <= m_out_reg3(0) AND zero_reg3;
        c11: ALU_control port map(
        function_code => aux_3bisbis(3 downto 0),
        ALU_op => ex_out_reg2(2),
        shift_amount => q_10,
        control_out => aux_14
        );
        c12: adder port map(
        operator_1 => aux_4bisbis,
        operator_2 => aux_10bis,
        result =>aux_6bis
        );
        c13: mux2_1 generic map(
        BUS_SIZE => 16
        )
                   port map(
        field_0 => aux_4bis,
        field_1 => aux_6bis,
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
        data_in => aux_3bis(6 downto 0),
        data_out => aux_10
        );
        c16: aux_5 <= "000" & aux_3bis(12 downto 0);
        p1: register_1 port map(
        clk => clk,
        reset => reset,
        slot_1_in =>aux_4,
        slot_2_in =>aux_3,
        slot_1_out => aux_4bis,
        slot_2_out => aux_3bis
        );
        q8q9 <= q_8 & q_9;
        q4q7 <= q_4 & q_7;
        q1q3q6 <= q_1 & q_3 & q_6;
        p2: register_2 port map(
        clk => clk,
        reset => reset,
        slot_1_in => aux_4bis,
        slot_2_in => aux_3bis(3 downto 0),
        slot_3_in => aux_3bis(9 downto 7),
        slot_4_in => aux_3bis(6 downto 4),
        extension_in => aux_10,
        register_file_1_in => aux_8,
        register_file_2_in => aux_9,
        write_back_in => q8q9,
        memory_in => q4q7,
        execution_in => q1q3q6,
        slot_1_out => aux_4bisbis,
        slot_2_out => aux_3bisbis(3 downto 0),
        slot_3_out => aux_3bisbis(9 downto 7),
        slot_4_out => aux_3bisbis(6 downto 4),
        extension_out => aux_10bis,
        register_file_1_out => aux_8bis,
        register_file_2_out => aux_9bis,
        write_back_out => wb_out_reg2,
        memory_out => m_out_reg2,
        execution_out => ex_out_reg2
        );
        p3: register_3 port map(
        clk => clk,
        reset => reset,
        write_back_in => wb_out_reg2,
        memory_in => m_out_reg2,
        slot_1_in => aux_6,
        slot_2_in => aux_11,
        slot_3_in => aux_9bis,
        slot_4_in => aux_15,
        zero_reg3_in => q_11,
        write_back_out => wb_out_reg3,
        memory_out => m_out_reg3,
        slot_1_out => aux_6bis,
        slot_2_out => aux_11bis,
        slot_3_out => aux_9bisbis,
        slot_4_out => aux_15bis,
        zero_reg3_out => zero_reg3
        );
        p4: register_4 port map(
        clk => clk,
        reset => reset,
        write_back_in => wb_out_reg3,
        slot_1_in => aux_12,
        slot_2_in => aux_11bis,
        slot_3_in => aux_15bis,
        write_back_out => wb_out_reg4,
        slot_1_out => aux_12bis,
        slot_2_out => aux_11bisbis,
        slot_3_out => aux_15bisbis
        );
    
end Behavioral;
