library ieee;
use ieee.std_logic_1164.all;

entity demux_1to8 is
    port (
        enable: in std_logic;
        sel: in std_logic_vector(2 downto 0);
        output_enable: out std_logic_vector(7 downto 0)  -- Removed default assignment
    );
end demux_1to8;

architecture behave of demux_1to8 is
begin
    process(sel, enable)
    begin
        -- Reset all outputs to '0' initially
        output_enable <= "00000000";

        -- Enable only the selected output if 'enable' is high
        if enable = '1' then
            case sel is
                when "000" => output_enable(0) <= '1';
                when "001" => output_enable(1) <= '1';
                when "010" => output_enable(2) <= '1';
                when "011" => output_enable(3) <= '1';
                when "100" => output_enable(4) <= '1';
                when "101" => output_enable(5) <= '1';
                when "110" => output_enable(6) <= '1';
                when others => output_enable(7) <= '1';  -- Default case
            end case;
        end if;
    end process;
end architecture behave;