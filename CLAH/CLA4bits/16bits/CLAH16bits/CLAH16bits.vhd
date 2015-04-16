LIBRARY Ieee;
USE ieee.std_logic_1164.all;

ENTITY CLAH16bits IS
PORT (
	val1,val2: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	CarryIn: IN STD_LOGIC;
	CarryOut: OUT STD_LOGIC;
	clk: IN STD_LOGIC;
	rst: IN STD_LOGIC;
	SomaResult:OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
END CLAH16bits;

ARCHITECTURE strc_CLAH16bits of CLAH16bits is
	SIGNAL Cin_sig, Cout_sig: STD_LOGIC;
	SIGNAL P0_sig, P1_sig, P2_sig, P3_sig: STD_LOGIC;
	SIGNAL G0_sig, G1_sig, G2_sig, G3_sig: STD_LOGIC;
	SIGNAL Cout1_temp_sig, Cout2_temp_sig, Cout3_temp_sig: STD_LOGIC;
	SIGNAL A_sig, B_sig, Out_sig: STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	SIGNAL SomaT1,SomaT2,SomaT3,SomaT4:STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	Component CLA4bits
	PORT (
		val1,val2: IN STD_LOGIC_VECTOR(3 DOWNTO 0);	
		SomaResult:OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		CarryIn: IN STD_LOGIC;
		P, G: OUT STD_LOGIC
	);
	end component;
	
	Component Reg1Bit
	PORT (
		valIn: in std_logic;
		clk: in std_logic;
		rst: in std_logic;
		valOut: out std_logic
	);
	end component;
	
	Component Reg16Bit
	PORT (
		valIn: in std_logic_vector(15 downto 0);
		clk: in std_logic;
		rst: in std_logic;
		valOut: out std_logic_vector(15 downto 0)
	);
	end component;
	
	Component CLGB
	PORT (
		P0, P1, G0, G1, Cin: IN STD_LOGIC;
		Cout1, Cout2: OUT STD_LOGIC
	);
	end component;

BEGIN 
	--registradores--
	Reg_CarryIn: Reg1Bit PORT MAP (
		valIn=>CarryIn,
		clk=>clk,
		rst=>rst,
		valOut=>Cin_sig
	);
	Reg_A: Reg16Bit PORT MAP (
		valIn=>val1,
		clk=>clk,
		rst=>rst,
		valOut=>A_sig
	);
	Reg_B: Reg16Bit PORT MAP (
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
	Reg_Ssoma: Reg16Bit PORT MAP (
		valIn=>Out_sig,
		clk=>clk,
		rst=>rst,
		valOut=>SomaResult
	);
	
	Som1: CLA4bits PORT MAP(
		val1(3 DOWNTO 0) => A_sig(3 DOWNTO 0),
		val2(3 DOWNTO 0) => B_sig(3 DOWNTO 0),
		CarryIn=>Cin_sig,
		P=>P0_sig,
		G=>G0_sig,
		SomaResult=>SomaT1 
	);
	
	CLGB1: CLGB PORT MAP(
		P0=>P0_sig,
		G0=>G0_sig,
		P1=>P1_sig,
		G1=>G1_sig,
		Cin=>Cin_sig,
		Cout1=>Cout1_temp_sig,
		Cout2=>Cout2_temp_sig
	);
	
	Som2: CLA4bits PORT MAP(
		val1(3 DOWNTO 0) => A_sig(7 DOWNTO 4),
		val2(3 DOWNTO 0) => B_sig(7 DOWNTO 4),
		CarryIn=>Cout1_temp_sig,
		P=>P1_sig,
		G=>G1_sig,
		SomaResult=>SomaT2 
	);
	
	Som3: CLA4bits PORT MAP(
		val1(3 DOWNTO 0) => A_sig(11 DOWNTO 8),
		val2(3 DOWNTO 0) => B_sig(11 DOWNTO 8),
		CarryIn=>Cout2_temp_sig,
		P=>P2_sig,
		G=>G2_sig,
		SomaResult=>SomaT3 
	);
	
	CLGB2: CLGB PORT MAP(
		P0=>P2_sig,
		G0=>G2_sig,
		P1=>P3_sig,
		G1=>G3_sig,
		Cin=>Cout2_temp_sig,
		Cout1=>Cout3_temp_sig,
		Cout2=>Cout_sig
	);
	
	Som4: CLA4bits PORT MAP(
		val1(3 DOWNTO 0) => A_sig(15 DOWNTO 12),
		val2(3 DOWNTO 0) => B_sig(15 DOWNTO 12),
		CarryIn=>Cout3_temp_sig,
		P=>P3_sig,
		G=>G3_sig,
		SomaResult=>SomaT4 
	);
	
	Out_sig <= SomaT4 & SomaT3 & SomaT2 & SomaT1;							
END strc_CLAH16bits;