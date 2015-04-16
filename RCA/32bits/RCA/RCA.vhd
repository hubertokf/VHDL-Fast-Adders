-- Somador 8_bits --
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY RCA IS
	PORT (	
		CarryIn: in std_logic;
		val1,val2: in std_logic_vector (31 downto 0);
		SomaResult: out std_logic_vector (31 downto 0);
		rst:in std_logic;
		clk:in std_logic;
		CarryOut: out std_logic
	);
END RCA ;

ARCHITECTURE strc_RCA OF RCA IS
	signal carry: std_logic_vector (31 downto 1); 
	signal CarryInTemp: std_logic;
	signal CarryOutTemp0,CarryOutTemp1: std_logic;
	signal A, B, Ssoma: std_logic_vector(31 downto 0);
	
	COMPONENT Soma1
		port (	
			CarryIn,val1,val2: in std_logic ;
			SomaResult,CarryOut: out std_logic 
		);
	END COMPONENT ;
	
	COMPONENT Reg1Bit
		port(	
			valIn:	in std_logic;
			clk:	in std_logic;
			rst:	in std_logic;
			valOut:	out std_logic
		);
	END COMPONENT ;
	
	COMPONENT Reg32Bit
		port(
			valIn:	in std_logic_vector(31 downto 0);
			clk:	in std_logic;
			rst:	in std_logic;
			valOut:	out std_logic_vector(31 downto 0)
		);
	END COMPONENT ;
	
BEGIN
	--registradores--
	Reg_CarryIn: Reg1Bit PORT MAP (
		valIn=>CarryIn,
		clk=>clk,
		rst=>rst,
		valOut=>CarryInTemp
	);
	Reg_CarryOut: Reg1Bit PORT MAP (
		valIn=>CarryOutTemp0,
		clk=>clk,
		rst=>rst,
		valOut=>CarryOut
	);
	Reg_A: Reg32Bit PORT MAP (
		valIn=>val1,
		clk=>clk,
		rst=>rst,
		valOut=>A
	);
	Reg_B: Reg32Bit PORT MAP (
		valIn=>val2,
		clk=>clk,
		rst=>rst,
		valOut=>B
	);
	Reg_Ssoma: Reg32Bit PORT MAP (
		valIn=>Ssoma,
		clk=>clk,
		rst=>rst,
		valOut=>SomaResult
	);
	
	--somador--
	Som0: Soma1 PORT MAP ( 
		CarryInTemp, 
		A(0), 
		B(0), 
		Ssoma(0), 
		carry(1)
	);	
	
	SOM: FOR i IN 1 TO 30 GENERATE
		Som1: Soma1 PORT MAP ( 
			carry(i),
			A(i),
			B(i),
			Ssoma(i),
			carry(i+1)
		);
	END GENERATE;
	
	Som7: Soma1 PORT MAP (
		carry(31),
		A(31),
		B(31),
		Ssoma(31),
		CarryOutTemp0
	);
	
END strc_RCA ;