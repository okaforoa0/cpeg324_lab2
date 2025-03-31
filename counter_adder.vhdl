library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;


entity counter_adder is 
	generic(WIDTH: natural := 4);
	port(
		A: in std_logic_vector(WIDTH-1 downto 0);
		B: in std_logic_vector(WIDTH-1 downto 0);
		Cin: in std_logic;
		SUM: out std_logic_vector(WIDTH-1 downto 0);
		Cout: out std_logic
	);
end counter_adder;

architecture structural of counter_adder is
	signal carry : std_logic_vector(WIDTH downto 0);
begin 
	carry(0) <= Cin;

	gen_adder: for i in 0 to WIDTH-1 generate
		SUM(i) <= A(i) xor B(i) xor carry(i);
		carry(i+1) <= (A(i) and B(i)) or (B(i) and carry(i)) or (A(i) and carry(i));
	end generate;

	Cout <= carry(WIDTH);
end structural; 
