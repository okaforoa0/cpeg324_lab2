library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
	generic(
		WIDTH: natural := 4
	);
	port(
		CLOCK: in std_logic; 
		RESET: in std_logic;
		INCDEC: in std_logic;
		count : out std_logic_vector(WIDTH-1 downto 0)
	);
end counter;

architecture structural of counter is


	component reg is
		generic (
			WIDTH : natural := 4
        );
        port(
                I: in std_logic_vector (WIDTH-1 downto 0); -- for loading
                clock: in std_logic; -- rising-edge triggering
                enable: in std_logic; -- 0: don't do anything; 1: reg is enabled            
		        O: out std_logic_vector(WIDTH-1 downto 0)
);
end component;

	component counter_adder is
		generic (WIDTH : natural);
		port(
		 
			A:  in std_logic_vector (WIDTH-1 downto 0);
			B:  in std_logic_vector (WIDTH-1 downto 0);
			Cin: in std_logic;
			SUM: out std_logic_vector(WIDTH-1 downto 0);
			Cout: out std_logic
		);
 end component;


-- signal to hold internal counter value

signal reg_out : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
signal next_val : std_logic_vector(WIDTH-1 downto 0); 
signal add_B : std_logic_vector(WIDTH-1 downto 0) := (others => '1'); 
signal Cin : std_logic := '0';
signal carry_out : std_logic := '0';
signal mux_val : std_logic_vector(WIDTH-1 downto 0);



-- implement an adder

begin 

-- Define adder inputs 

	add_B <= (others => '0') when INCDEC = '1' else (others => '1');
	Cin <= INCDEC;

	--instantiate 4-bit register
	register_inst : reg
	generic map (WIDTH => WIDTH)
	   port map(
		I => mux_val,	-- data to load into the register
		clock => CLOCK, -- clock input
		enable => '1', -- enable reg for now
		O => reg_out -- 4-bit counter output
	);

	mux_val <= (others => '0') when RESET = '1' else next_val;
	
	-- instantiate adder
	 adder_inst : counter_adder
	 generic map (WIDTH => WIDTH)
	 port map(
		--showing u
		A => reg_out,
		--showing u
		B => add_B,
		-- showing 
		Cin => Cin,
		--showing u
		SUM => next_val,
		--showing u
		Cout => carry_out
 );
	
	count <= reg_out;

end structural;
