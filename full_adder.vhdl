library ieee;
use ieee.std_logic_1164.all;

-- declare entity for full adder
entity full_adder is
	
	port(	a: in std_logic;
		b: in std_logic;
		cin: in std_logic;
		sum: out std_logic;
		cout: out std_logic
	);

end entity full_adder;

-- behavioral arch of full adder
architecture behav of full_adder is

	-- internal signals to store the intermediate results
	signal t0, t1, t2: std_logic;

begin
	-- represents the XOR of a and b, intermediate sum before considering carry-in
	t0 <= a xor b;
	--the carry generated by the sum of a,b and carry in
	t1 <= t0 and cin;
	--the carry generated by the inputs a and b
	t2 <= a and b;
	--sum output is the XOR of t0 and carry in
	sum <= t0 xor cin;
	--carry out is the logical OR of t1 and t2
	cout <= t1 or t2;

end behav;