library ieee;
use ieee.std_logic_1164.all;

entity eight_4bit is
	port (  
		clk, enable : in std_logic;
		sel : in std_logic_vector(2 downto 0);	
		d : in std_logic_vector (3 downto 0);
		q : out std_logic_vector (3 downto 0)
	);
end entity eight_4bit;

architecture structural of eight_4bit is

-- Register Component
component reg is
    generic (
        WIDTH : natural := 4
    );
	port (  
		I : in std_logic_vector (WIDTH-1 downto 0);
		clock : in std_logic;
		enable : in std_logic;
		O : out std_logic_vector(WIDTH-1 downto 0)
	);
end component;

component demux_1to8 is
	port (
		enable: in std_logic;
		sel: in std_logic_vector(2 downto 0);
		output_enable: out std_logic_vector(7 downto 0)
	);
end component; 

component mux_8to1 is
	port (
		input_vector: in std_logic_vector(31 downto 0);
		sel: in std_logic_vector(2 downto 0);
		o: out std_logic_vector(3 downto 0)
	);
end component;

signal enable_vector : std_logic_vector(7 downto 0) := (others => '0');
signal output_vector : std_logic_vector(31 downto 0) := (others => '0');

begin
	-- Demux: Enables only the selected register
	demux : demux_1to8 port map (enable => enable, sel => sel, output_enable => enable_vector);

	-- Mux: Selects the output from one of the 8 registers
	mux : mux_8to1 port map (input_vector => output_vector, sel => sel, o => q);

	-- 8 Registers Instantiation
	reg_1: reg port map (I => d, clock => clk, enable => enable_vector(0), O => output_vector(3 downto 0));
	reg_2: reg port map (I => d, clock => clk, enable => enable_vector(1), O => output_vector(7 downto 4));
	reg_3: reg port map (I => d, clock => clk, enable => enable_vector(2), O => output_vector(11 downto 8));
	reg_4: reg port map (I => d, clock => clk, enable => enable_vector(3), O => output_vector(15 downto 12));
	reg_5: reg port map (I => d, clock => clk, enable => enable_vector(4), O => output_vector(19 downto 16));
	reg_6: reg port map (I => d, clock => clk, enable => enable_vector(5), O => output_vector(23 downto 20));
	reg_7: reg port map (I => d, clock => clk, enable => enable_vector(6), O => output_vector(27 downto 24));
	reg_8: reg port map (I => d, clock => clk, enable => enable_vector(7), O => output_vector(31 downto 28));

end architecture structural;