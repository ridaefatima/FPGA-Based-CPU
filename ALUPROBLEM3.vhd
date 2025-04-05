LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALUPROBLEM3 IS
    PORT (
        Clock         : IN  STD_LOGIC;
        B             : IN  UNSIGNED(7 DOWNTO 0); -- Input B (8 bits)
        student_id    : IN  UNSIGNED(3 DOWNTO 0); -- Input student ID (4 bits)
        display_flag  : OUT STD_LOGIC;           -- Output to 7-segment logic ('1' for 'y', '0' for 'n')
        high_result   : OUT SIGNED(4 DOWNTO 0);  -- Output subtraction result (higher bits)
        low_result    : OUT SIGNED(4 DOWNTO 0)   -- Output subtraction result (lower bits)
    );
END ALUPROBLEM3;

ARCHITECTURE Behavior OF ALUPROBLEM3 IS
BEGIN
    PROCESS (Clock)
        VARIABLE B_high_var, B_low_var : UNSIGNED(3 DOWNTO 0); -- Split B into high and low 4 bits
    BEGIN
            -- Split B into high and low 4 bits
            B_high_var := B(7 DOWNTO 4);
            B_low_var := B(3 DOWNTO 0);

            -- Compare B's high and low digits with student_id
            -- Display 'y' if either B_high_var or B_low_var is greater than student_id
            IF (B_high_var > student_id) OR (B_low_var > student_id) THEN
                display_flag <= '1'; -- Display 'y' if either part is greater
            ELSE
                display_flag <= '0'; -- Display 'n' if neither is greater
            END IF;
    END PROCESS;
END Behavior;