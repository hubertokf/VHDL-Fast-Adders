LIBRARY Ieee;
USE ieee.std_logic_1164.all;

ENTITY CLGB IS
PORT (
	P0, P1, G0, G1, Cin: IN STD_LOGIC;
	Cout1, Cout2: OUT STD_LOGIC
);
END CLGB;



ARCHITECTURE strc_CLGB of CLGB is	
BEGIN 
	
	Cout1 <= G0 OR (P0 AND Cin);
	Cout2 <= G1 OR (P1 AND G0) OR (P1 AND P0 AND Cin);

END strc_CLGB;