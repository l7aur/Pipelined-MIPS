library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
    Port(
        clk: in std_logic;
        switch: in std_logic_vector(15 downto 0);
        button: in std_logic;
        clock_led: out std_logic;              
        anode: out std_logic_vector(3 downto 0);
        cathode: out std_logic_vector(6 downto 0)  --seven segment out code 
    );
end top_module;

architecture Behavioral of top_module is

--component instantiation
component seven_segment_display is
    Port(
        number_in: std_logic_vector(15 downto 0);
        clk: in std_logic;
        anode: out std_logic_vector(3 downto 0);
        cathode: out std_logic_vector(6 downto 0);
        dp: out std_logic
        );
end component;
component mono_pulse_generator is
    Port(
        btn: in std_logic;
        clk: in std_logic;
        enable: out std_logic
        );
end component;
component MIPS is
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
end component;

--auxiliary signals instantiation
signal debouncer_clock: std_logic;
signal aux1: std_logic_vector(15 downto 0);
signal aux2: std_logic_vector(15 downto 0);

--debugging signals
signal aux_reg0: std_logic_vector(15 downto 0);
signal aux_reg1: std_logic_vector(15 downto 0);
signal aux_reg2: std_logic_vector(15 downto 0);
signal aux_reg3: std_logic_vector(15 downto 0);
signal aux_reg4: std_logic_vector(15 downto 0);
signal aux_reg5: std_logic_vector(15 downto 0);
signal aux_reg6: std_logic_vector(15 downto 0);
signal aux_reg7: std_logic_vector(15 downto 0);
signal to_be_displayed: std_logic_vector(15 downto 0);
signal instruction_to_be_executed: std_logic_vector(15 downto 0);
signal program_counter_state: std_logic_vector(15 downto 0);
signal address_to_data_memory: std_logic_vector(15 downto 0);
signal second_operand_to_ALU: std_logic_vector(15 downto 0);

begin
    manual_clock_generator: mono_pulse_generator port map(
    btn => button,
    clk => clk,
    enable => debouncer_clock
    );
    processor: MIPS port map(
    clk => debouncer_clock,
    reset => switch(9),
    data_address_in => switch,
    data_out => aux1,
    reg0_data_out => aux_reg0,
    reg1_data_out => aux_reg1,
    reg2_data_out => aux_reg2,
    reg3_data_out => aux_reg3,
    reg4_data_out => aux_reg4,
    reg5_data_out => aux_reg5,
    reg6_data_out => aux_reg6,
    reg7_data_out => aux_reg7,
    instr_out => instruction_to_be_executed,
    program_c => program_counter_state,
    addr_out => address_to_data_memory,
    ext_out => second_operand_to_ALU
    );
    display: seven_segment_display port map(
    number_in => to_be_displayed,
    clk => clk,
    anode => anode,
    cathode => cathode
    );
    check_manual_clock: clock_led <= debouncer_clock;
    
    --select the content of which register should to be displayed on the seven segment display with a MUX
    register_data_out: with switch(12 downto 10) select aux2 <= 
        aux_reg0 when "000",
        aux_reg1 when "001",
        aux_reg2 when "010",
        aux_reg3 when "011",
        aux_reg4 when "100",
        aux_reg5 when "101",
        aux_reg6 when "110",
        aux_reg7 when others;
        
    --select what is displayed on the seven segment
    select_display_data: with switch(15 downto 13) select to_be_displayed <=
        aux1 when "000", 
        aux2 when "001", --registers
        instruction_to_be_executed when "010",
        program_counter_state when "011",
        address_to_data_memory when "100",
        second_operand_to_ALU when others; 
end Behavioral;
