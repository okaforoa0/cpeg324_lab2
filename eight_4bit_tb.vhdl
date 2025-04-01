library ieee;
use ieee.std_logic_1164.all;

entity eight_4bit_tb is 
end eight_4bit_tb; 

architecture behave of eight_4bit_tb is

    component eight_4bit
        generic (WIDTH : integer := 4);
        port (  
                clk, enable : in std_logic;
                sel : in std_logic_vector(WIDTH-1 downto 0);	
                d : in std_logic_vector (WIDTH-1 downto 0);
                q : out std_logic_vector (WIDTH-1 downto 0)
            );
    end component;


constant width : integer := 4;

--begin
--generic width : integer :=4;


-- Signals for the testbench
signal clk, enable : std_logic := '0';
signal sel : std_logic_vector(WIDTH-1 downto 0);
signal d, q : std_logic_vector(WIDTH-1 downto 0);
signal I : std_logic_vector(WIDTH-1 downto 0);
signal O : std_logic_vector(WIDTH-1 downto 0); -- Add signals for I and O

begin
-- Instantiate the eight_4bit component which uses reg internally
eight4_bit: eight_4bit
port map (
    clk    => clk,
    enable => enable,
    sel    => sel,
    d      => d,
    q      => q
);

clk <= not clk after 5 ns;

-- Stimulus process
process
    type pattern_type is record
-- The inputs of the reg.
    --clock, 
    enable: std_logic;
    I: std_logic_vector(WIDTH-1 downto 0);
    sel : std_logic_vector(WIDTH-1 downto 0);
    --d, q : std_logic_vector(3 downto 0);
    d: std_logic_vector(WIDTH-1 downto 0);
-- The expected outputs of the reg.
    o: std_logic_vector(WIDTH-1 downto 0);
end record;

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array := 
( ('1', "0000", "0000", "0001", "0000"),
        ('1', "0000", "0000", "0001", "0000"),
        ('0', "0000", "0000", "0001", "0001"),
        ('1', "0000", "0001", "0010", "0000"),
        ('0', "0001", "0001", "0010", "0010"),
        ('1', "0010", "0010", "0011", "0000"),
        ('0', "0010", "0010", "0011", "0011"),
        ('1', "0011", "0011", "0100", "0000"),
        ('0', "0011", "0011", "0100", "0100"),
        ('1', "0100", "0100", "0101", "0000"),
        ('0', "0100", "0100", "0101", "0101"),
        ('1', "0101", "0101", "0110", "0000"),
        ('0', "0101", "0101", "0110", "0110"),
        ('1', "0110", "0110", "0111", "0000"),
        ('0', "0110", "0110", "0111", "0111"),
        ('1', "0111", "0111", "1000", "0000"),
        ('0', "0111", "0111", "1000", "1000"),
        ('0', "0000", "0000", "0000", "0001"),
        ('0', "0001", "0000", "0000", "0010"),
        ('0', "0010", "0000", "0000", "0011"),
        ('0', "0011", "0000", "0000", "0100"),
        ('0', "0100", "0000", "0000", "0101"),
        ('0', "0101", "0000", "0000", "0110"),
        ('0', "0110", "0000", "0000", "0111"),
        ('0', "0111", "0000", "0000", "1000")
      );

-- Iterate through the patterns
begin
-- Check each pattern
for n in patterns'range loop
    -- Set the inputs
    I <= patterns(n).I;
    sel <= patterns(n).sel;
    enable <= patterns(n).enable;
    d <= patterns(n).d;

    -- I <= d;
    O <= q;

    -- Wait for the results
    wait for 5 ns;
    -- Check the outputs
    assert q = patterns(n).o
        report "bad q" severity error;
end loop;

-- End of test
assert false report "end of test" severity note;
-- Wait forever; this will finish the simulation
wait;
end process;

end behave;
