library ieee;
use ieee.std_logic_1164.all;

entity mono_pulse_generator is
    Port(
        btn: in std_logic;
        clk: in std_logic;
        enable: out std_logic
    );
end entity;

architecture arh of mono_pulse_generator is
    component counter1 is
        Port (
        clk: in std_logic;
        port_out: out std_logic
        );
    end component;    
    signal q1,q2,q3,q4: std_logic := '0';
begin
    frequency_divider: counter1 port map(clk => clk, port_out => q1);
    generated_clock: enable <= q4 and q3;
    register_1: process(clk)
        begin
            if rising_edge(clk) then
                if(q1 = '1') then
                    q2 <= btn;
                end if;
            end if;
    end process;   
    register_2: process(clk)
        begin
            if rising_edge(clk) then
                q3 <= q2;
            end if;
    end process;  
    register_3: process(clk)
        begin
            if rising_edge(clk) then
                q4 <= q3;
            end if;
    end process;  
end architecture;