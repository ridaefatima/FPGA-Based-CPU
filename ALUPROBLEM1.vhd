LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY ALUPROBLEM1 IS
PORT (Clock : IN STD_LOGIC ;
A ,B : IN UNSIGNED(7 DOWNTO 0);
OP: IN UNSIGNED(15 downto 0);
Neg: OUT STD_LOGIC;
R1: OUT UNSIGNED(3 DOWNTO 0);--lower 4bits of 8bits Result
R2: OUT UNSIGNED(3 DOWNTO 0));--higher 4bits of 8bits Result
END ALUPROBLEM1;

ARCHITECTURE Behavior OF ALUPROBLEM1 IS
SIGNAL Reg1, Reg2, Result: UNSIGNED(7 DOWNTO 0) := (OTHERS => '0');


BEGIN
Reg1 <= A;
Reg2 <= B;
PROCESS (Clock, OP,A,B)
BEGIN
IF (rising_edge(Clock)) THEN
CASE OP IS
WHEN "0000000000000001" => --addition
Result <= Reg2 + Reg1;

WHEN "0000000000000010"  => -- subtraction
if (Reg1 < Reg2) then
neg <= '1';
Result <= NOT((Reg1 + NOT(Reg2) +00000001))+00000001;
else
neg <= '0';
Result <= Reg1 - Reg2;
end if;
WHEN "0000000000000100" =>-- NOT
neg <= '0';
Result <= NOT(Reg1);
WHEN "0000000000001000" =>--NAND
neg <= '0';
Result <= NOT(Reg1 AND Reg2);
WHEN "0000000000010000" =>--NOR
neg <= '0';
Result <= NOT(Reg1 OR Reg2);
WHEN "0000000000100000" => --AND
neg <= '0';
Result <= (Reg1 AND Reg2);
WHEN "0000000001000000" =>--XOR
neg <= '0';
Result <= (Reg1 XOR Reg2);
WHEN "0000000010000000" =>--OR
neg <= '0';
Result <= (Reg1 OR Reg2);
WHEN OTHERS =>-- Don't care
END CASE;
END IF;
END PROCESS;
R1 <= Result(3 DOWNTO 0);
R2 <= Result(7 DOWNTO 4);

END Behavior;