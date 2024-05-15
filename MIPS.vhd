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
    branch: in std_logic;
    branch_ongte: in std_logic;
    andi_signal: in std_logic;
    result: out std_logic_vector(15 downto 0);
    do_branch: out std_logic
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
    branch_ongte: out std_logic;
    andi_signal: out std_logic;
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
component register1 is
    Port(
    clk: in std_logic;
    reset: in std_logic;
    adder_in: in std_logic_vector(15 downto 0);
    instruction_in: in std_logic_vector(15 downto 0);
    adder_out: out std_logic_vector(15 downto 0);
    instruction_out: out std_logic_vector(15 downto 0)
  );
end component;
component register2 is
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
end component;
component register3 is
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
end component;
component register4 is
    Port(
    clk: in std_logic;
    reset: in std_logic;
    write_back_in: in std_logic_vector(1 downto 0);
    for_mux_1_in: in std_logic_vector(15 downto 0);
    for_mux_2_in: in std_logic_vector(15 downto 0);
    for_write_address_in: in std_logic_vector(2 downto 0);
    write_back_out: out std_logic_vector(1 downto 0);
    for_mux_1_out: out std_logic_vector(15 downto 0);
    for_mux_2_out: out std_logic_vector(15 downto 0);
    for_write_address_out: out std_logic_vector(2 downto 0)
  );
end component;
--inner signals instantiation

signal auxx_3: std_logic_vector(15 downto 0);
signal auxx_4: std_logic_vector(15 downto 0);
signal auxx_8: std_logic_vector(15 downto 0);
signal auxx_9: std_logic_vector(15 downto 0);

signal auxxx_4: std_logic_vector(15 downto 0);

signal ALU_ctrl: std_logic_vector(3 downto 0);
signal reg1: std_logic_vector(2 downto 0);
signal reg2: std_logic_vector(2 downto 0);
signal extended_result: std_logic_vector(15 downto 0);

signal wb1_in: std_logic_vector(0 to 1);
signal wb1_out: std_logic_vector(0 to 1);
signal m1_in: std_logic_vector(0 to 3);
signal m1_out: std_logic_vector(0 to 3);
signal ex1_in: std_logic_vector(0 to 2);
signal ex1_out: std_logic_vector(0 to 2);

signal wb2_out: std_logic_vector(0 to 1);
signal wb3_out: std_logic_vector(0 to 1);
signal m2_out: std_logic;
signal auxx_6: std_logic_vector(15 downto 0);
signal auxxx_9: std_logic_vector(15 downto 0);
signal auxx_15: std_logic_vector(2 downto 0);
signal auxx_12: std_logic_vector(15 downto 0);
signal auxxx_15: std_logic_vector(2 downto 0);
signal auxx_11: std_logic_vector(15 downto 0);
signal auxxx_11: std_logic_vector(15 downto 0);
signal dobranch_reg: std_logic;

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
signal aux_15: std_logic_vector(2 downto 0);
signal aux_16: std_logic_vector(15 downto 0);
signal aux_17: std_logic_vector(15 downto 0);
signal q_01: std_logic;
signal q_02: std_logic;
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
    debug_signal_1: instr_out <= aux_3;
    debug_signal_2: addr_out <= aux_11;
    debug_signal_3: ext_out <= aux_16;
    debug_signal_4: program_c <= aux_2;
    
    c0: instruction_memory port map(
    address => aux_2,
    data_out => aux_3
    );
    
    c1: program_counter port map(
        clk => clk,
        reset => reset,
        new_address => aux_1,
        out_address => aux_2
        );
    c2: register_file port map(
        clk => clk,
        reset => reset,
        register_write => wb3_out(1),
        read_address_1 => auxx_3(12 downto 10),
        read_address_2 => auxx_3(9 downto 7),
        write_address => auxxx_15,
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
        field_0 => reg1,
        field_1 => reg2,
        selection_signal => ex1_out(2),
        output => aux_15
        ); 
        c4: main_control port map(
        instruction => auxx_3(15 downto 13),
        reg_dest => q_1,
        ext_op => q_2,
        ALU_src => q_3,
        branch => q_4,
        branch_ongte => q_01,
        andi_signal => q_02,
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
        operand_1 => auxx_8, 
        operand_2 => aux_16,
        shift_amount => q_10,
        ALU_control_signal => aux_14,
        branch => m1_out(1),
        branch_ongte => m1_out(2),
        andi_signal => m1_out(3),
        result => aux_11,
        do_branch => q_11
        );
        c7: mux2_1 generic map(
        BUS_SIZE => 16
        )
                   port map(
        field_0 => auxx_9,
        field_1 => extended_result,
        selection_signal => ex1_out(1),
        output => aux_16
        );
        c8: data_memory port map(
        clk => clk,
        reset => reset,
        memory_write => m2_out,
        write_data => auxxx_9,
        address => auxx_11,
        address_to_ssd => data_address_in,
        read_data => aux_12, 
        data_to_ssd => data_out
        );
        c9: mux2_1 generic map(
        BUS_SIZE => 16
        )
                   port map(
        field_0 => auxxx_11,
        field_1 => auxx_12,
        selection_signal => wb3_out(0),
        output => aux_13
        );
        c10: aux_7 <= q_11;
        c11: ALU_control port map(
        function_code => ALU_ctrl,
        ALU_op => ex1_out(0),
        shift_amount => q_10,
        control_out => aux_14
        );
        c12: adder port map(
        operator_1 => auxxx_4,
        operator_2 => extended_result,
        result =>auxx_6
        );
        c13: mux2_1 generic map(
        BUS_SIZE => 16
        )
                   port map(
        field_0 => aux_4,
        field_1 => auxx_6,
        selection_signal => dobranch_reg,
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
        data_in => auxx_3(6 downto 0),
        data_out => aux_10
        );
        c16: aux_5 <= "000" & auxx_3(12 downto 0);
        
        ---------------------------------------------------
        pipeline1: register1 port map(
        clk => clk,
        reset => reset,
        adder_in => aux_4,
        instruction_in => aux_3,
        adder_out => auxx_4,
        instruction_out => auxx_3
        );
        
        wb1_in <= q_8 & q_9;
        m1_in <= q_7 & q_4 & q_01 & q_02;
        ex1_in <= q_6 & q_3 & q_1;
        
        pipeline2: register2 port map(
        clk => clk,
        reset => reset,
        write_back_in => wb1_in,
        memory_in => m1_in,
        execution_in => ex1_in,
        adder_in => auxx_4,
        register_file_data1_in => aux_8,
        register_file_data2_in => aux_9,
        extension_unit_in => aux_10,
        for_ALU_control_in => auxx_3(3 downto 0),
        for_mux1_in => auxx_3(9 downto 7),
        for_mux2_in => auxx_3(6 downto 4),
        write_back_out => wb1_out,
        memory_out => m1_out,
        execution_out => ex1_out,
        adder_out => auxxx_4,
        register_file_data1_out => auxx_8,
        register_file_data2_out => auxx_9,
        extension_unit_out => extended_result,
        for_ALU_contro_out => ALU_ctrl,
        for_mux1_out => reg1,
        for_mux2_out => reg2
        );
        
        pipeline3: register3 port map(
        clk => clk,
        reset => reset,
       
        write_back_in => wb1_out,
        memory_in => m1_out(0),
        adder_in => aux_6,
        for_write_data_in => auxx_9,
        mux_result_in => aux_15,
        branch_in => q_11,
        ALU_in => aux_11,
        
        write_back_out => wb2_out,
        memory_out => m2_out,
        adder_out => auxx_6,
        for_write_data_out => auxxx_9,
        mux_result_out => auxx_15,
        branch_out => dobranch_reg,
        ALU_out => auxx_11
        );
        pipeline4: register4 port map(
        clk => clk,
        reset => reset,
      
        write_back_in => wb2_out,
        for_mux_1_in => aux_12,
        for_mux_2_in => auxx_11,
        for_write_address_in => auxx_15,
      
        write_back_out => wb3_out,
        for_mux_1_out => auxx_12,
        for_mux_2_out => auxxx_11,
        for_write_address_out => auxxx_15
        );
        
end Behavioral;
