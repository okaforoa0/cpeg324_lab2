library ieee;
use ieee.std_logic_1164.all;

entity mux_8to1 is
    port (
        input_vector: in std_logic_vector(31 downto 0);
        sel: in std_logic_vector(2 downto 0);
        o: out std_logic_vector(3 downto 0)
    );
end mux_8to1;

architecture behave of mux_8to1 is
begin 
    o <= input_vector(3 downto 0)    when "000",  -- Select the first 4 bits (register 0)
    input_vector(7 downto 4)    when "001",  -- Select the next 4 bits (register 1)
    input_vector(11 downto 8)   when "010",  -- Select the next 4 bits (register 2)
    input_vector(15 downto 12)  when "011",  -- Select the next 4 bits (register 3)
    input_vector(19 downto 16)  when "100",  -- Select the next 4 bits (register 4)
    input_vector(23 downto 20)  when "101",  -- Select the next 4 bits (register 5)
    input_vector(27 downto 24)  when "110",  -- Select the next 4 bits (register 6)
    input_vector(31 downto 28)  when "111",  -- Select the next 4 bits (register 7)
    input_vector(3 downto 0)    when others; -- Default case, this should not occur
end architecture behave;