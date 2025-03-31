library ieee;
use ieee.std_logic_1164.all;

-- A testbench has no ports.
entity counter_tb is
end counter_tb;

architecture behav of counter_tb is
-- Declaration of the component that will be instantiated.
component counter
  generic (
        WIDTH : natural
  ); 
  port(
        CLOCK: in std_logic;
        RESET: in std_logic; -- rising-edge triggering
        INCDEC: in std_logic; -- 0: decrement; 1: increment
        count: out std_logic_vector(WIDTH-1 downto 0) -- output the current register content.
  );
end component;



-- Specifies which entity is bound with the component.
constant WIDTH : natural := 4;
signal clk : std_logic := '0';
-- signal enable : std_logic := '1';
signal reset : std_logic := '0';
signal incdec : std_logic := '0';

-- also showing u value
signal o : std_logic_vector(WIDTH-1 downto 0) := (others => '0');


begin
-- Component instantiation.
        counter_inst: counter
                generic map (
                        WIDTH => WIDTH
                )
                port map (
                        CLOCK => clk,
                        RESET => reset,
                        INCDEC => incdec,
                        count => o
                );

-- clock generation process
	clk_process : process
	begin
               clk <= not clk;
               wait for 10 ns;	
	end process;

-- This process does the real job.
process
type pattern_type is record
-- The inputs of the counter.
        reset : std_logic;
        incdec : std_logic;
-- The expected outputs of the counter.
        output_value : std_logic_vector (WIDTH-1 downto 0);
end record;

-- The patterns to apply.
type pattern_array is array (natural range <>) of pattern_type;

-- test the vectors
constant patterns : pattern_array := (
       
        ('1', '0', "0000"), -- Reset is on, 0000
        ('0', '1', "0001"), -- No reset, incr, expect 0000
        ('0', '1', "0010"),
        ('0', '1', "0011"),
        ('0', '0', "0010")  -- no reset, incr, expect 0000
);
-- test_process: process
begin
-- Check each pattern.
        reset <= '1'; -- Apply reset at the start
        wait for 20 ns; -- hold reset high before first clock edge
        reset <= '0';
        wait for 10 ns;

        for n in patterns'range loop
-- Set the inputs.
                RESET <= patterns(n).reset;
                INCDEC <= patterns(n).incdec;
-- Wait for the results.
                wait until rising_edge(clk);
                -- wait for 10 ns;

-- debug statements

                --report "incdec: " & std_logic'image(incdec);
                --report "Expected: ";
                --for i in o'range loop

              --report std_logic'image(patterns(n).output_value(i));
            --end loop;

            --report "Actual:   ";
            --for i in o'range loop
              --report std_logic'image(o(i));
            --end loop;
-- Check the outputs.
                -- wait for 1 ns;
                assert o = patterns(n).output_value
                report "bad output value at" & integer'image(n) severity error;

        end loop;
        assert false report "end of test" severity note;
-- Wait forever; this will finish the simulation.
 wait;
end process;
end behav;

