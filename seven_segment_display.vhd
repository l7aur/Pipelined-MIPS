library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity seven_segment_display is
  Port (
  number_in: std_logic_vector(15 downto 0);
  clk: in std_logic;
  anode: out std_logic_vector(3 downto 0);
  cathode: out std_logic_vector(6 downto 0);
  dp: out std_logic
   );
end seven_segment_display;

architecture Behavioral of seven_segment_display is
component hexadecimal_to_seven_segment_converter is
  Port (
  number_in: in std_logic_vector(3 downto 0);
  number_out: out std_logic_vector(6 downto 0)
   );
end component;
signal inner_clk: std_logic_vector(1 downto 0) := "00";
signal n1_out, n2_out, n3_out, n4_out: std_logic_vector(6 downto 0) := "0110111";
begin
    component0: dp <= '1';
    component1: hexadecimal_to_seven_segment_converter port map(number_in => number_in(15 downto 12), number_out => n1_out);
    component2: hexadecimal_to_seven_segment_converter port map(number_in => number_in(11 downto 8), number_out => n2_out);
    component3: hexadecimal_to_seven_segment_converter port map(number_in => number_in(7 downto 4), number_out => n3_out);
    component4: hexadecimal_to_seven_segment_converter port map(number_in => number_in(3 downto 0), number_out => n4_out);
    frequency_divider: process(clk)
    variable aux: std_logic_vector(19 downto 0) := x"00000";
    begin
        if rising_edge(clk) then
            aux := aux + 1;
            inner_clk <= aux(19 downto 18);
        end if;
    end process;
    
    activate_corresponding_anode: process(inner_clk)
    begin
        case inner_clk is
            when "00" => anode <= x"7";
            when "01" => anode <= x"B";
            when "10" => anode <= x"D";
            when others => anode <= x"E";
        end case;
    end process;
    
    send_corresponding_number_to_cathode: process(inner_clk, n1_out, n2_out, n3_out, n4_out)
    begin
        case inner_clk is
            when "00" => cathode <= n1_out;
            when "01" => cathode <= n2_out;
            when "10" => cathode <= n3_out;
            when others => cathode <= n4_out;
        end case;
    end process; 

end Behavioral;
