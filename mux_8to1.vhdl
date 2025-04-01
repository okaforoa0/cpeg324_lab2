library ieee;
use ieee.std_logic_1164.all;

entity mux_8to1 is
    generic(WIDTH : natural := 4);
    port (
        input_vector: in std_logic_vector(8*WIDTH downto 0);
        sel: in std_logic_vector(2 downto 0);
        o: out std_logic_vector(WIDTH-1 downto 0)
    );
end mux_8to1;

architecture behave of mux_8to1 is
begin 
with sel select
    o <= input_vector(WIDTH-1 downto 0)      when "000",  -- Select the first `WIDTH` bits
        input_vector(2*WIDTH-1 downto WIDTH) when "001",  -- Select the next `WIDTH` bits
        input_vector(3*WIDTH-1 downto 2*WIDTH) when "010",  -- Select the next `WIDTH` bits
        input_vector(4*WIDTH-1 downto 3*WIDTH) when "011",  -- Select the next `WIDTH` bits
        input_vector(5*WIDTH-1 downto 4*WIDTH) when "100",  -- Select the next `WIDTH` bits
        input_vector(6*WIDTH-1 downto 5*WIDTH) when "101",  -- Select the next `WIDTH` bits
        input_vector(7*WIDTH-1 downto 6*WIDTH) when "110",  -- Select the next `WIDTH` bits
        input_vector(8*WIDTH-1 downto 7*WIDTH) when "111",  -- Select the next `WIDTH` bits
        input_vector(WIDTH-1 downto 0)      when others;  -- Default case, should not occur
end architecture behave;