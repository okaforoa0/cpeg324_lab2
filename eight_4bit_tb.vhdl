library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eight_4bit_tb is 
end eight_4bit_tb; 

architecture test of eight_4bit_tb is

    component eight_4bit
        generic (WIDTH : natural := 4);
        port (  
            clk       : in STD_LOGIC;
            -- reset     : in STD_LOGIC;
            enable    : in STD_LOGIC_VECTOR(7 downto 0);  -- Enable for each register
            address   : in STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit address for selecting register
            data_in   : in STD_LOGIC_VECTOR(WIDTH-1 downto 0);  -- Data input for selected register
            data_out  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)  -- Data output from selected register
        );
    end component;

--signals 
    constant WIDTH : natural := 4;

    signal clk       : STD_LOGIC := '0';
    -- signal reset     : STD_LOGIC := '0';
    signal enable    : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal address   : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal data_in   : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');  -- Adjust this for WIDTH
    signal data_out  : STD_LOGIC_VECTOR(3 downto 0);  -- Adjust this for WIDTH

begin
        uut: eight_4bit generic map (
            WIDTH => WIDTH
        )
        port map (
            clk => clk,
           -- reset => reset,
            enable => enable,
            address => address,
            data_in => data_in,
            data_out => data_out
        );

    -- Clock process definitions
    clk_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;


    stim_proc: process
    begin
        -- Reset the register file
        --reset <= '1';
        wait for 40 ns;
        --reset <= '0';
        --wait for 40 ns;

        -- Test writing and reading from each register
        for i in 0 to 7 loop
            -- Set address and enable line for current register
            address <= std_logic_vector(to_unsigned(i, address'length));
            enable <= (others => '0');
            enable(i) <= '1';  -- Enable only the current register
            
            -- Test data pattern for current register
            data_in <= std_logic_vector(to_unsigned(i, data_in'length));
            
            -- Wait two clock cycles between operations
            wait for 40 ns;

            -- Check that the correct register has been written to
            assert data_out = std_logic_vector(to_unsigned(i, data_out'length))
            report "Register write test failed for register at address " & integer'image(i) severity error;

            -- Disable writing for the next test
            enable <= (others => '0');
            
            -- Wait two clock cycles before the next test
            wait for 40 ns;
        end loop;

        -- Test is complete
        report "End of Register File testbench simulation" severity note;
        wait;  -- Terminate the simulation
    end process;
end test;

