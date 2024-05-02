library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hexadecimal_to_seven_segment_converter is
  Port (
  number_in: in std_logic_vector(3 downto 0);
  number_out: out std_logic_vector(6 downto 0)
   );
end hexadecimal_to_seven_segment_converter;

architecture Behavioral of hexadecimal_to_seven_segment_converter is

begin
    with number_in select 
        number_out <= "0000001" when x"0",
                      "1001111" when x"1",
                      "0010010" when x"2",
                      "0000110" when x"3",
                      "1001100" when x"4",
                      "0100100" when x"5",
                      "0100000" when x"6",
                      "0001111" when x"7",
                      "0000000" when x"8",
                      "0000100" when x"9",
                      "0001000" when x"A",
                      "1100000" when x"B",
                      "0110001" when x"C",
                      "1000010" when x"D",
                      "0110000" when x"E",
                      "0111000" when x"F",
                      "0110000" when others;
end Behavioral;
