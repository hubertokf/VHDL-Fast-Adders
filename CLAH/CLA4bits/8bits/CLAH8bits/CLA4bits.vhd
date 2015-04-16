LIBRARY Ieee;
USE ieee.std_logic_1164.all;

ENTITY CLA4bits IS
PORT (
	val1,val2: IN STD_LOGIC_VECTOR(3 DOWNTO 0);	
	SomaResult:OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	CarryIn: IN STD_LOGIC;
	P, G: OUT STD_LOGIC
);
END CLA4bits;



ARCHITECTURE strc_cla4bits of CLA4bits is
	
	SIGNAL Sum,Gen,Prop,Carry:STD_LOGIC_VECTOR(3 DOWNTO 0);
	
BEGIN 
	-- soma dos valores e propagação do carry --
	Sum<=val1 xor val2;	
	Prop<=val1 or val2;	
	Gen<=val1 and val2;
	
	PROCESS (Gen,Prop,Carry)
    BEGIN
		Carry(1) <= Gen(0) OR (Prop(0) AND CarryIn);
			inst: FOR i IN 1 TO 2 LOOP
				  Carry(i+1) <= Gen(i) OR (Prop(i) AND Carry(i));
				  END LOOP;
    END PROCESS;
		
    SomaResult(0) <= Sum(0) XOR CarryIn;
    SomaResult(3 DOWNTO 1) <= Sum(3 DOWNTO 1) XOR Carry(3 DOWNTO 1);
    
    P <= Prop(3) AND Prop(2) AND Prop(1) AND Prop(0);
    G <= Gen(3) OR (Prop(3) AND Gen(2)) OR (Prop(3) AND Prop(2) AND Gen(1)) OR (Prop(3) AND Prop(2) AND Prop(1) AND Gen(0));
	
END strc_cla4bits;