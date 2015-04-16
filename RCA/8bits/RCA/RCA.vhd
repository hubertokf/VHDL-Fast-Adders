-- Somador 8_bits --
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY RCA IS
	PORT (	
		CarryIn: in std_logic;
		val1,val2: in std_logic_vector (7 downto 0);
		SomaResult: out std_logic_vector (7 downto 0);
		rst:in std_logic;
		clk:in std_logic;
		CarryOut: out std_logic
	);
END RCA ;

ARCHITECTURE strc_RCA OF RCA IS
	signal carry: std_logic_vector (7 downto 1); 
	signal CarryInTemp: std_logic;
	signal CarryOutTemp0,CarryOutTemp1: std_logic;
	signal A, B, Ssoma: std_logic_vector(7 downto 0);
	
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
	
	COMPONENT Reg8Bit
		port(
			valIn:	in std_logic_vector(7 downto 0);
			clk:	in std_logic;
			rst:	in std_logic;
			valOut:	out std_logic_vector(7 downto 0)
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
	Reg_A: Reg8Bit PORT MAP (
		valIn=>val1,
		clk=>clk,
		rst=>rst,
		valOut=>A
	);
	Reg_B: Reg8Bit PORT MAP (
		valIn=>val2,
		clk=>clk,
		rst=>rst,
		valOut=>B
	);
	Reg_Ssoma: Reg8Bit PORT MAP (
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
	Som1: Soma1 PORT MAP ( 
		carry(1),
		A(1),
		B(1),
		Ssoma(1),
		carry(2)
	);
	Som2: Soma1 PORT MAP ( 
		carry(2),
		A(2),
		B(2),
		Ssoma(2),
		carry(3)
	);
	Som3: Soma1 PORT MAP (
		carry(3),
		A(3),
		B(3),
		Ssoma(3),
		carry(4)
	);
	Som4: Soma1 PORT MAP (
		carry(4),
		A(4),
		B(4),
		Ssoma(4),
		carry(5)
	);
	Som5: Soma1 PORT MAP (
		carry(5),
		A(5),
		B(5),
		Ssoma(5),
		carry(6)
	);
	Som6: Soma1 PORT MAP (
		carry(6),
		A(6),
		B(6),
		Ssoma(6),
		carry(7)
	);
	Som7: Soma1 PORT MAP (
		carry(7),
		A(7),
		B(7),
		Ssoma(7),
		CarryOutTemp0
	);
	
END strc_RCA ;