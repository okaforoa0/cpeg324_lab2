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
signal next_val : std_logic_vector(WIDTH-1 downto 0) := (others => '0'); 
signal add_B : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
signal Cin : std_logic := '0';

-- implement an adder

begin 

	--instantiate 4-bit register
	register_inst : reg
	generic map (WIDTH => WIDTH)
	   port map(
		I => next_val,	-- data to load into the register
		clock => CLOCK, -- clock input
		enable => '1', -- enable reg for now
		O => reg_out -- 4-bit counter output
	);

	-- Define adder inputs 

	 add_B <= (others => '0') when INCDEC = '1' else (others => '1');
	 Cin <= INCDEC;
	
	-- instantiate adder
	 adder_inst : counter_adder
	 generic map (WIDTH => WIDTH)
	 port map(
		A => reg_out,
		B => add_B,
		Cin => Cin,
		SUM => next_val,
		Cout => open
 );
	next_val <= reg_out;
	
process (CLOCK, RESET)
    begin
        if rising_edge(CLOCK) then
            if RESET = '1' then
                reg_out <= (others => '0'); -- Reset counter to 0000
            else
		reg_out <= next_val;
	    end if;
	end if;
    end process;
    count <= reg_out;

end structural;





