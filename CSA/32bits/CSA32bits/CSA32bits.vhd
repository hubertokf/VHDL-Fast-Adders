-- Somador 8_bits --
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY CSA32bits IS
	PORT (	
		CarryIn: in std_logic;
		val1,val2: in std_logic_vector (31 downto 0);
		SomaResult: out std_logic_vector (31 downto 0);
		rst:in std_logic;
		clk:in std_logic;
		CarryOut: out std_logic
	);
END CSA32bits ;

ARCHITECTURE strc_CSA32bits OF CSA32bits IS
	SIGNAL Cin_sig, Cout_sig: STD_LOGIC;
	SIGNAL Outs10, Outs11, Outs20, Outs21, Outs30, Outs31, Outs40, Outs41, Outs50, Outs51, Outs60, Outs61, Outs70, Outs71, Outs80, Outs81: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL Couts10, Couts11, Couts20, Couts21, Couts30, Couts31, Couts40, Couts41, Couts50, Couts51, Couts60, Couts61, Couts70, Couts71, Couts80, Couts81: STD_LOGIC;
	SIGNAL sel1,sel2,sel3,sel4,sel5,sel6,sel7: STD_LOGIC;
	SIGNAL A_sig, B_sig, Out_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	SIGNAL SomaT1,SomaT2,SomaT3,SomaT4,SomaT5,SomaT6,SomaT7,SomaT8:STD_LOGIC_VECTOR(3 DOWNTO 0);
		
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
	Reg_A: Reg32Bit PORT MAP (
		valIn=>val1,
		clk=>clk,
		rst=>rst,
		valOut=>A_sig
	);
	Reg_B: Reg32Bit PORT MAP (
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
	Reg_Ssoma: Reg32Bit PORT MAP (
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
	
	sel2 <= Couts20 OR (Couts21 AND sel1);
	
	--asdfasdf
	
	Som30: RCA PORT MAP (
		val1 => A_sig(11 DOWNTO 8),
		val2 => B_sig(11 DOWNTO 8),
		CarryIn=>'0',
		CarryOut=>Couts30,
		SomaResult=>Outs30 
	);
	
	Som31: RCA PORT MAP (
		val1 => A_sig(11 DOWNTO 8),
		val2 => B_sig(11 DOWNTO 8),
		CarryIn=>'1',
		CarryOut=>Couts31,
		SomaResult=>Outs31 
	);
	
	Mux3: mux84 PORT MAP (
		In1=>Outs31,
		In0=>Outs30,
		sel=>sel2,
		Outs=>SomaT3
	);
	
	sel3 <= Couts30 OR (Couts31 AND sel2);
	
	Som40: RCA PORT MAP (
		val1 => A_sig(15 DOWNTO 12),
		val2 => B_sig(15 DOWNTO 12),
		CarryIn=>'0',
		CarryOut=>Couts40,
		SomaResult=>Outs40 
	);
	
	Som41: RCA PORT MAP (
		val1 => A_sig(15 DOWNTO 12),
		val2 => B_sig(15 DOWNTO 12),
		CarryIn=>'1',
		CarryOut=>Couts41,
		SomaResult=>Outs41 
	);
	
	Mux4: mux84 PORT MAP (
		In1=>Outs41,
		In0=>Outs40,
		sel=>sel3,
		Outs=>SomaT4
	);
	
	sel4 <= Couts40 OR (Couts41 AND sel3);
	
	--aaasdfasdfasdfasdf
	
	Som50: RCA PORT MAP (
		val1 => A_sig(19 DOWNTO 16),
		val2 => B_sig(19 DOWNTO 16),
		CarryIn=>'0',
		CarryOut=>Couts50,
		SomaResult=>Outs50 
	);
	
	Som51: RCA PORT MAP (
		val1 => A_sig(19 DOWNTO 16),
		val2 => B_sig(19 DOWNTO 16),
		CarryIn=>'1',
		CarryOut=>Couts51,
		SomaResult=>Outs51 
	);
	
	Mux5: mux84 PORT MAP (
		In1=>Outs51,
		In0=>Outs50,
		sel=>sel4,
		Outs=>SomaT5
	);
	
	sel5 <= Couts50 OR (Couts51 AND sel4);
	
	Som60: RCA PORT MAP (
		val1 => A_sig(23 DOWNTO 20),
		val2 => B_sig(23 DOWNTO 20),
		CarryIn=>'0',
		CarryOut=>Couts60,
		SomaResult=>Outs60 
	);
	
	Som61: RCA PORT MAP (
		val1 => A_sig(23 DOWNTO 20),
		val2 => B_sig(23 DOWNTO 20),
		CarryIn=>'1',
		CarryOut=>Couts61,
		SomaResult=>Outs61 
	);
	
	Mux6: mux84 PORT MAP (
		In1=>Outs61,
		In0=>Outs60,
		sel=>sel5,
		Outs=>SomaT6
	);
	
	sel6 <= Couts60 OR (Couts61 AND sel5);
	
	--asdfasdf
	
	Som70: RCA PORT MAP (
		val1 => A_sig(27 DOWNTO 24),
		val2 => B_sig(27 DOWNTO 24),
		CarryIn=>'0',
		CarryOut=>Couts70,
		SomaResult=>Outs70 
	);
	
	Som71: RCA PORT MAP (
		val1 => A_sig(27 DOWNTO 24),
		val2 => B_sig(27 DOWNTO 24),
		CarryIn=>'1',
		CarryOut=>Couts71,
		SomaResult=>Outs71 
	);
	
	Mux7: mux84 PORT MAP (
		In1=>Outs71,
		In0=>Outs70,
		sel=>sel6,
		Outs=>SomaT7
	);
	
	sel7 <= Couts70 OR (Couts71 AND sel6);
	
	Som80: RCA PORT MAP (
		val1 => A_sig(31 DOWNTO 28),
		val2 => B_sig(31 DOWNTO 28),
		CarryIn=>'0',
		CarryOut=>Couts80,
		SomaResult=>Outs80 
	);
	
	Som81: RCA PORT MAP (
		val1 => A_sig(31 DOWNTO 28),
		val2 => B_sig(31 DOWNTO 28),
		CarryIn=>'1',
		CarryOut=>Couts81,
		SomaResult=>Outs81 
	);
	
	Mux8: mux84 PORT MAP (
		In1=>Outs81,
		In0=>Outs80,
		sel=>sel7,
		Outs=>SomaT8
	);
	
	Cout_sig <= Couts80 OR (Couts81 AND sel7);
	
	Out_sig <= SomaT8 & SomaT7 & SomaT6 & SomaT5 & SomaT4 & SomaT3 & SomaT2 & SomaT1;
END strc_CSA32bits ;