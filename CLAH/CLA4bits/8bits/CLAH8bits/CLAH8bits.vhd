LIBRARY Ieee;
USE ieee.std_logic_1164.all;

ENTITY CLAH8bits IS
PORT (
	val1,val2: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	CarryIn: IN STD_LOGIC;
	CarryOut: OUT STD_LOGIC;
	clk: IN STD_LOGIC;
	rst: IN STD_LOGIC;
	SomaResult:OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END CLAH8bits;

ARCHITECTURE strc_CLAH8bits of CLAH8bits is
	SIGNAL Cin_sig, Cout_sig, P0_sig, P1_sig, G0_sig, G1_sig: STD_LOGIC;
	SIGNAL Cout_temp_sig: STD_LOGIC;
	SIGNAL A_sig, B_sig, Out_sig: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	SIGNAL SomaT1,SomaT2:STD_LOGIC_VECTOR(3 DOWNTO 0);
	
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
	
	Component Reg8Bit
	PORT (
		valIn: in std_logic_vector(7 downto 0);
		clk: in std_logic;
		rst: in std_logic;
		valOut: out std_logic_vector(7 downto 0)
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
		Cout1=>Cout_temp_sig,
		Cout2=>Cout_sig
	);
	
	Som2: CLA4bits PORT MAP(
		val1(3 DOWNTO 0) => A_sig(7 DOWNTO 4),
		val2(3 DOWNTO 0) => B_sig(7 DOWNTO 4),
		CarryIn=>Cout_temp_sig,
		P=>P1_sig,
		G=>G1_sig,
		SomaResult=>SomaT2 
	);
	
	Out_sig <= SomaT2 & SomaT1;							
END strc_CLAH8bits;