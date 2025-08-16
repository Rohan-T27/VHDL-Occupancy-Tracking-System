library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Room is
port(
    X, Y, reset: in std_logic;       -- Signals for entering (X) and exiting (Y)
    max_occupancy: in unsigned(5 downto 0); -- Maximum occupancy, up to 63 (6-bit unsigned)
    Z: out std_logic := '0'         -- Indicator light for max occupancy
);
end entity;

architecture Behavior of Room is
signal count: unsigned(5 downto 0) := (others => '0'); -- Occupancy counter
begin
process(X, Y, reset)
    variable counter: unsigned(5 downto 0) := (others => '0');
begin
    counter := count;
 
    if reset = '1' then
        counter := (others => '0'); -- Reset counter to zero
    else
        if rising_edge(X) and counter /= max_occupancy then
            counter := counter + 1; -- Increment counter on X rising edge (entry)
        end if;

        if rising_edge(Y) and counter /= 0 then
            counter := counter - 1; -- Decrement counter on Y rising edge (exit)
        end if;
    end if;
 
    count <= counter;
end process;

process(count, max_occupancy)
begin
    if (count >= max_occupancy) then
        Z <= '1';                   -- Set Z to '1' when occupancy reaches max
    else
        Z <= '0';                   -- Set Z to '0' otherwise
    end if;
end process;

end architecture;
