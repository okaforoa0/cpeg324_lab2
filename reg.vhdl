library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg is
    generic (
        WIDTH : natural := 4 -- default 4 bits
    );
    port(
        I: in std_logic_vector (WIDTH-1 downto 0); -- for loading
        clock: in std_logic; -- rising-edge triggering
        enable: in std_logic; -- 0: don't do anything; 1: reg is enabled
        O: out std_logic_vector(WIDTH-1 downto 0)
    );
end reg;

architecture behav of reg is

        signal reg_value : std_logic_vector(WIDTH-1 downto 0) := (others => '0'); -- internal signal to hold register value
        
begin
        --process for rising-edge triggering
        process(clock)
        begin
                if rising_edge(clock) then
                      if enable = '1' then
                                reg_value <= I; -- load input value into register when enabled
                        end if;
              end if;
        end process;

        O <= reg_value; -- output the current value stored in the register
end behav;