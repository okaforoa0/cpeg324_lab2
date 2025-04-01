library ieee;
use ieee.std_logic_1164.all;

entity counter_adder_tb is 
end counter_adder_tb;

architecture behav of counter_adder_tb is 

    -- Declare component
    component counter_adder
        generic (
            WIDTH : natural
        );
        port (
            A: in std_logic_vector(WIDTH-1 downto 0);
            B: in std_logic_vector(WIDTH-1 downto 0);
            Cin: in std_logic;
            SUM: out std_logic_vector(WIDTH-1 downto 0);
            Cout: out std_logic
        );
    end component;

    constant WIDTH : natural := 4;
    signal A, B, SUM : std_logic_vector(WIDTH-1 downto 0);
    signal Cin, Cout : std_logic;

begin

    -- Instantiate the counter_adder
    adder_inst: counter_adder
        generic map (
            WIDTH => WIDTH
        )
        port map (
            A => A,
            B => B,
            Cin => Cin,
            SUM => SUM,
            Cout => Cout
        );

process
    type pattern_type is record
        A: std_logic_vector(WIDTH-1 downto 0);
        B: std_logic_vector(WIDTH-1 downto 0);
        Cin: std_logic;
        expected_SUM: std_logic_vector(WIDTH-1 downto 0);
    end record;
        
    type pattern_array is array (natural range <>) of pattern_type;
        
    constant patterns : pattern_array := (
        ("0000", "0000", '0', "0000"),
        ("0001", "0001", '0', "0010"),
        ("1111", "0001", '0', "0000"),
        ("1111", "1111", '1', "1111")
    );
begin
    for n in patterns'range loop
        A   <= patterns(n).A;
        B   <= patterns(n).B;
        Cin <= patterns(n).Cin;
        wait for 10 ns;
        assert SUM = patterns(n).expected_SUM
            report "Mismatch at pattern " & integer'image(n) severity error;
        end loop;
        assert false report "End of counter_adder test" severity note;
        wait;
    end process;

end behav;