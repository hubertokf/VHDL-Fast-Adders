LIBRARY Ieee;
USE ieee.std_logic_1164.all;

ENTITY CLA2bits IS
PORT (
	val1,val2: IN STD_LOGIC_VECTOR(1 DOWNTO 0);	
	SomaResult:OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	CarryIn: IN STD_LOGIC;
	CarryOut: OUT STD_LOGIC;
	P, G: OUT STD_LOGIC
);
END CLA2bits;



ARCHITECTURE strc_cla2bits of CLA2bits is
	
	SIGNAL Sum,Gen,Prop,Carry:STD_LOGIC_VECTOR(1 DOWNTO 0);
	
BEGIN 
	-- soma dos valores e propagação do carry --
	Sum<=val1 xor val2;	
	Prop<=val1 or val2;	
	Gen<=val1 and val2;
	
	PROCESS (Gen,Prop,Carry)
    BEGIN
		Carry(1) <= Gen(0) OR (Prop(0) AND CarryIn);
    END PROCESS;
		
    SomaResult(0) <= Sum(0) XOR CarryIn;
    SomaResult(1) <= Sum(1) XOR Carry(1);
    
    P <= Prop(1) AND Prop(0);
    G <= Gen(1) OR (Prop(1) AND Gen(0));
	
END strc_cla2bits;