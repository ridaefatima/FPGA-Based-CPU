LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SSEG2 IS
PORT (
    bcd : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Not used in this logic
    neg : IN STD_LOGIC; -- Not used in this logic
    display_flag : IN STD_LOGIC; -- Input for 'y' or 'n' (binary representation)
    leds : OUT STD_LOGIC_VECTOR(1 TO 7) -- 7-segment output
);
END SSEG2;

ARCHITECTURE Behavior OF SSEG2 IS
BEGIN
    PROCESS (display_flag)
    BEGIN
        -- Map display_flag to 'y' or 'n' in 7-segment display
        CASE display_flag IS
            WHEN '1' =>
                -- 7-segment pattern for 'y' (0111011)
                leds <= NOT("0111011");
            WHEN '0' =>
                -- 7-segment pattern for 'n'
                leds <= NOT("0010101");
            WHEN OTHERS =>
                -- Turn off display for invalid input
                leds <= "0000000";
        END CASE;
    END PROCESS;
END Behavior;