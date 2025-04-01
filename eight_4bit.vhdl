library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eight_4bit is
	generic (WIDTH : natural := 4);
	port (  
		clk       : in  STD_LOGIC;
       -- reset     : in  STD_LOGIC;  -- Not used in this example, but you can add reset logic in your register if needed
        enable    : in  STD_LOGIC_VECTOR(7 downto 0); -- One enable per register
        address   : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit address to select which register's output is read
        data_in   : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0); -- Data input for selected register
        data_out  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)  -- Data output from selected register
	);
end entity eight_4bit;

architecture behavioral of eight_4bit is

-- Define an array type to hold the output of each register.
type reg_array is array (0 to 7) of STD_LOGIC_VECTOR(WIDTH-1 downto 0);
signal registers : reg_array := (others => (others => '0'));


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

--internal sig for mux
signal selected_data_out : std_logic_vector(3 downto 0);

begin
	selected_data_out <= registers(to_integer(unsigned(address)));
	gen_registers: for i in 0 to 7 generate
		reg_inst: reg
		generic map (
			WIDTH => WIDTH
		)
		port map (
			I => data_in,
			clock => clk,
			enable => enable(i),
			O => registers(i)
		);
	end generate gen_registers;	

-- mux : use 3 bit address to select one reg output
	data_out <= selected_data_out;	
end behavioral;