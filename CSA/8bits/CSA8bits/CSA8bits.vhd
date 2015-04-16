-- Somador 8_bits --
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY CSA8bits IS
	PORT (	
		CarryIn: in std_logic;
		val1,val2: in std_logic_vector (7 downto 0);
		SomaResult: out std_logic_vector (7 downto 0);
		rst:in std_logic;
		clk:in std_logic;
		CarryOut: out std_logic
	);
END CSA8bits ;

ARCHITECTURE strc_CSA8bits OF CSA8bits IS
	SIGNAL Cin_sig, Cout_sig: STD_LOGIC;
	SIGNAL Outs10, Outs11, Outs20, Outs21: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL Couts10, Couts11, Couts20, Couts21: STD_LOGIC;
	SIGNAL sel1: STD_LOGIC;
	SIGNAL A_sig, B_sig, Out_sig: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	SIGNAL SomaT1,SomaT2:STD_LOGIC_VECTOR(3 DOWNTO 0);
		
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
	
	COMPONENT RCA
		port (	
			CarryIn: in std_logic;
			val1,val2: in std_logic_vector (3 downto 0);
			SomaResult: out std_logic_vector (3 downto 0);
			CarryOut: out std_logic
		);
	END COMPONENT ;
	
	COMPONENT mux84
		port (
			In0, In1: in std_logic_vector(3 downto 0);
			sel: in std_logic;
			Outs : out std_logic_vector(3 downto 0)
		);
	END COMPONENT ;
	
BEGIN
	--registradores--
	Reg_CarryIn: Reg1Bit PORT MAP (
		valIn=>CarryIn,
		clk=>clk,
		rst=>rst,
		valOut=>Cin_sig
	);
	Reg_A: Reg8Bit PORT MAP (
		valIn=>val1,
		clk=>clk,
		rst=>rst,
		valOut=>A_sig
	);
	Reg_B: Reg8Bit PORT MAP (
		valIn=>val2,
		clk=>clk,
		rst=>rst,
		valOut=>B_sig
	);
	
	Reg_CarryOut: Reg1Bit PORT MAP (
		valIn=>Cout_sig,
		clk=>clk,
		rst=>rst,
		valOut=>CarryOut
	);
	Reg_Ssoma: Reg8Bit PORT MAP (
		valIn=>Out_sig,
		clk=>clk,
		rst=>rst,
		valOut=>SomaResult
	);
	
	Som10: RCA PORT MAP (
		val1 => A_sig(3 DOWNTO 0),
		val2 => B_sig(3 DOWNTO 0),
		CarryIn=>'0',
		CarryOut=>Couts10,
		SomaResult=>Outs10 
	);
	
	Som11: RCA PORT MAP (
		val1 => A_sig(3 DOWNTO 0),
		val2 => B_sig(3 DOWNTO 0),
		CarryIn=>'1',
		CarryOut=>Couts11,
		SomaResult=>Outs11 
	);
	
	Mux1: mux84 PORT MAP (
		In1=>Outs11,
		In0=>Outs10,
		sel=>Cin_sig,
		Outs=>SomaT1
	);
	
	sel1 <= Couts10 OR (Couts11 AND Cin_sig);
	
	Som20: RCA PORT MAP (
		val1 => A_sig(7 DOWNTO 4),
		val2 => B_sig(7 DOWNTO 4),
		CarryIn=>'0',
		CarryOut=>Couts20,
		SomaResult=>Outs20 
	);
	
	Som21: RCA PORT MAP (
		val1 => A_sig(7 DOWNTO 4),
		val2 => B_sig(7 DOWNTO 4),
		CarryIn=>'1',
		CarryOut=>Couts21,
		SomaResult=>Outs21 
	);
	
	Mux2: mux84 PORT MAP (
		In1=>Outs21,
		In0=>Outs20,
		sel=>sel1,
		Outs=>SomaT2
	);
	
	Cout_sig <= Couts20 OR (Couts21 AND sel1);
	
	Out_sig <= SomaT2 & SomaT1;
END strc_CSA8bits ;