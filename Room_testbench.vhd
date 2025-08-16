library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Room_tb is
end entity;

architecture Behavior_tb of Room_tb is
-- Testbench signals
signal X, Y, reset_tb: std_logic := '0';
signal Z: std_logic;
signal max_cap_tb: unsigned(5 downto 0) := "000011"; -- Set maximum capacity to 3

begin
-- Instantiate the Unit Under Test (UUT)
uut: entity work.Room(Behavior)
    port map(
        X => X,
        Y => Y,
        Z => Z,
        reset => reset_tb,
        max_occupancy => max_cap_tb
    );

-- Process to control the reset signal
reset_process: process
begin
    reset_tb <= '1';     -- Apply reset
    wait for 5 ns;
    reset_tb <= '0';     -- Release reset
    wait for 100 ns;
    reset_tb <= '1';     -- Apply reset again
    wait for 5 ns;
    reset_tb <= '0';     -- Release reset
    wait;
end process reset_process;

-- Process to simulate people entering the room (signal X)
enter_process: process
begin
    wait for 15 ns;
    X <= '1';         -- Person enters
    wait for 10 ns;
    X <= '0';
    wait for 20 ns;
    X <= '1';         -- Another person enters
    wait for 10 ns;
    X <= '0';
    wait for 20 ns;
    X <= '1';         -- Third person enters (Max occupancy reached)
    wait for 10 ns;
    X <= '0';
    wait for 50 ns;     -- Wait to see if Z goes to 1
end process enter_process;

-- Process to simulate people exiting the room (signal Y)
exit_process: process
begin
    wait for 40 ns;
    Y <= '1';         -- Person exits
    wait for 10 ns;
    Y <= '0';
    wait for 30 ns;
    Y <= '1';         -- Another person exits
    wait for 10 ns;
    Y <= '0';
    wait for 100 ns;     -- Wait to observe behavior after exits
end process exit_process;

end architecture Behavior_tb;
