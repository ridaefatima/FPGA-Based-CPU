LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY ALUPROBLEM2 IS
PORT (Clock : IN STD_LOGIC ;
A ,B : IN UNSIGNED(7 DOWNTO 0);
OP: IN UNSIGNED(15 downto 0);
Neg: OUT STD_LOGIC;
R1: OUT UNSIGNED(3 DOWNTO 0);--lower 4bits of 8bits
R2: OUT UNSIGNED(3 DOWNTO 0));--higher 4bits of 8bits 
END ALUPROBLEM2;

ARCHITECTURE Behavior OF ALUPROBLEM2 IS
SIGNAL Reg1, Reg2, Result: UNSIGNED(7 DOWNTO 0) := (OTHERS => '0');


BEGIN
Reg1 <= A;
Reg2 <= B;
PROCESS (Clock, OP,A,B)
BEGIN
IF (rising_edge(Clock)) THEN
CASE OP IS
WHEN "0000000000000001" => -- 1 - ROTATE BY 4 BITS
 Result <= Reg1(3 DOWNTO 0) & Reg1(7 DOWNTO 4);

WHEN "0000000000000010"  => -- 2 - XOR A AND B
neg <= '0';
Result <= (Reg1 XOR Reg2);
WHEN "0000000000000100" =>-- 3 - invert bits sig of B

Result <= reg2(0) & reg2(1) & reg2(2) & reg2(3) & reg2(4) & reg2(5) & reg2(6) & reg2(7);


WHEN "0000000000001000" =>-- 4 - add reg1 and 2 then decrease by 2
if ((Reg1 + Reg2) < "00000010") then
neg <= '1';
Result <= NOT((Reg1 + Reg2) + NOT("00000010") + "00000001")+"00000001";
else
neg <= '0';
Result <= ((Reg1 + Reg2) + (NOT("00000010") + "00000001"));
end if;
WHEN "0000000000010000" => -- 5 -rotate b left by 2 bits
 Result <= Reg2(5 DOWNTO 0) & Reg2(7 DOWNTO 6);
 
WHEN "0000000000100000" => -- 6 -Invert even bits of B
                    FOR i IN 0 TO 7 LOOP
                        IF i MOD 2 = 0 THEN
                            Result(i) <=  Reg2(i);
                        ELSE
                            Result(i) <= NOT(Reg2(i));
                        END IF;
                    END LOOP;

WHEN "0000000001000000" =>-- 7 - Swap lower 4 bits of B with lower 4 bits of A
Result(7 DOWNTO 4) <= Reg2(7 DOWNTO 4); -- Keep upper bits of B
Result(3 DOWNTO 0) <= Reg1(3 DOWNTO 0); -- Swap lower bits with A
WHEN "0000000010000000" =>-- 8 - Shift B right by 2 bits, input bit = 0
Result <= "00" & Reg2(7 DOWNTO 2);
WHEN OTHERS =>-- Don't care
END CASE;
END IF;
END PROCESS;
R1 <= Result(3 DOWNTO 0);
R2 <= Result(7 DOWNTO 4);

END Behavior;