LIBRARY Ieee;
USE ieee.std_logic_1164.all;

ENTITY CLAH32bits IS
PORT (
	val1,val2: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	CarryIn: IN STD_LOGIC;
	CarryOut: OUT STD_LOGIC;
	clk: IN STD_LOGIC;
	rst: IN STD_LOGIC;
	SomaResult:OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END CLAH32bits;

ARCHITECTURE strc_CLAH32bits of CLAH32bits is
	SIGNAL Cin_sig, Cout_sig: STD_LOGIC;
	SIGNAL P0_sig, P1_sig, P2_sig, P3_sig, P4_sig, P5_sig, P6_sig, P7_sig, P8_sig, P9_sig, P10_sig, P11_sig, P12_sig, P13_sig, P14_sig, P15_sig: STD_LOGIC;
	SIGNAL G0_sig, G1_sig, G2_sig, G3_sig, G4_sig, G5_sig, G6_sig, G7_sig, G8_sig, G9_sig, G10_sig, G11_sig, G12_sig, G13_sig, G14_sig, G15_sig: STD_LOGIC;
	SIGNAL Cout1_temp_sig, Cout2_temp_sig, Cout3_temp_sig, Cout4_temp_sig, Cout5_temp_sig, Cout6_temp_sig, Cout7_temp_sig: STD_LOGIC;
	SIGNAL Cout8_temp_sig, Cout9_temp_sig, Cout10_temp_sig, Cout11_temp_sig, Cout12_temp_sig, Cout13_temp_sig, Cout14_temp_sig, Cout15_temp_sig: STD_LOGIC;
	SIGNAL A_sig, B_sig, Out_sig: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	SIGNAL SomaT1,SomaT2,SomaT3,SomaT4,SomaT5,SomaT6,SomaT7,SomaT8,SomaT9,SomaT10,SomaT11,SomaT12,SomaT13,SomaT14,SomaT15,SomaT16:STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	Component CLA2bits
	PORT (
		val1,val2: IN STD_LOGIC_VECTOR(1 DOWNTO 0);	
		SomaResult:OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
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
	
	Component Reg32Bit
	PORT (
		valIn: in std_logic_vector(31 downto 0);
		clk: in std_logic;
		rst: in std_logic;
		valOut: out std_logic_vector(31 downto 0)
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
	
	Som1: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(1 DOWNTO 0),
		val2(1 DOWNTO 0) => B_sig(1 DOWNTO 0),
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
	
	Som2: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(3 DOWNTO 2),
		val2(1 DOWNTO 0) => B_sig(3 DOWNTO 2),
		CarryIn=>Cout1_temp_sig,
		P=>P1_sig,
		G=>G1_sig,
		SomaResult=>SomaT2 
	);
	
	Som3: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(5 DOWNTO 4),
		val2(1 DOWNTO 0) => B_sig(5 DOWNTO 4),
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
		Cout2=>Cout4_temp_sig
	);
	
	Som4: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(7 DOWNTO 6),
		val2(1 DOWNTO 0) => B_sig(7 DOWNTO 6),
		CarryIn=>Cout3_temp_sig,
		P=>P3_sig,
		G=>G3_sig,
		SomaResult=>SomaT4 
	);
	
	--novoooooooo--
	
	Som5: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(9 DOWNTO 8),
		val2(1 DOWNTO 0) => B_sig(9 DOWNTO 8),
		CarryIn=>Cout4_temp_sig,
		P=>P4_sig,
		G=>G4_sig,
		SomaResult=>SomaT5 
	);
	
	CLGB3: CLGB PORT MAP(
		P0=>P4_sig,
		G0=>G4_sig,
		P1=>P5_sig,
		G1=>G5_sig,
		Cin=>Cout4_temp_sig,
		Cout1=>Cout5_temp_sig,
		Cout2=>Cout6_temp_sig
	);
	
	Som6: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(11 DOWNTO 10),
		val2(1 DOWNTO 0) => B_sig(11 DOWNTO 10),
		CarryIn=>Cout5_temp_sig,
		P=>P5_sig,
		G=>G5_sig,
		SomaResult=>SomaT6 
	);
	
	Som7: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(13 DOWNTO 12),
		val2(1 DOWNTO 0) => B_sig(13 DOWNTO 12),
		CarryIn=>Cout6_temp_sig,
		P=>P6_sig,
		G=>G6_sig,
		SomaResult=>SomaT7 
	);
	
	CLGB4: CLGB PORT MAP(
		P0=>P6_sig,
		G0=>G6_sig,
		P1=>P7_sig,
		G1=>G7_sig,
		Cin=>Cout6_temp_sig,
		Cout1=>Cout7_temp_sig,
		Cout2=>Cout8_temp_sig
	);
	
	Som8: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(15 DOWNTO 14),
		val2(1 DOWNTO 0) => B_sig(15 DOWNTO 14),
		CarryIn=>Cout7_temp_sig,
		P=>P7_sig,
		G=>G7_sig,
		SomaResult=>SomaT8 
	);
	
	--novoooooooo--
	
	Som9: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(17 DOWNTO 16),
		val2(1 DOWNTO 0) => B_sig(17 DOWNTO 16),
		CarryIn=>Cout8_temp_sig,
		P=>P8_sig,
		G=>G8_sig,
		SomaResult=>SomaT9 
	);
	
	CLGB5: CLGB PORT MAP(
		P0=>P8_sig,
		G0=>G8_sig,
		P1=>P9_sig,
		G1=>G9_sig,
		Cin=>Cout8_temp_sig,
		Cout1=>Cout9_temp_sig,
		Cout2=>Cout10_temp_sig
	);
	
	Som10: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(19 DOWNTO 18),
		val2(1 DOWNTO 0) => B_sig(19 DOWNTO 18),
		CarryIn=>Cout9_temp_sig,
		P=>P9_sig,
		G=>G9_sig,
		SomaResult=>SomaT10
	);
	
	Som11: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(21 DOWNTO 20),
		val2(1 DOWNTO 0) => B_sig(21 DOWNTO 20),
		CarryIn=>Cout10_temp_sig,
		P=>P10_sig,
		G=>G10_sig,
		SomaResult=>SomaT11 
	);
	
	CLGB6: CLGB PORT MAP(
		P0=>P10_sig,
		G0=>G10_sig,
		P1=>P11_sig,
		G1=>G11_sig,
		Cin=>Cout10_temp_sig,
		Cout1=>Cout11_temp_sig,
		Cout2=>Cout12_temp_sig
	);
	
	Som12: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(23 DOWNTO 22),
		val2(1 DOWNTO 0) => B_sig(23 DOWNTO 22),
		CarryIn=>Cout11_temp_sig,
		P=>P11_sig,
		G=>G11_sig,
		SomaResult=>SomaT12 
	);
	
	--novoooooooo--
	
	Som13: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(25 DOWNTO 24),
		val2(1 DOWNTO 0) => B_sig(25 DOWNTO 24),
		CarryIn=>Cout12_temp_sig,
		P=>P12_sig,
		G=>G12_sig,
		SomaResult=>SomaT13 
	);
	
	CLGB7: CLGB PORT MAP(
		P0=>P12_sig,
		G0=>G12_sig,
		P1=>P13_sig,
		G1=>G13_sig,
		Cin=>Cout12_temp_sig,
		Cout1=>Cout13_temp_sig,
		Cout2=>Cout14_temp_sig
	);
	
	Som14: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(27 DOWNTO 26),
		val2(1 DOWNTO 0) => B_sig(27 DOWNTO 26),
		CarryIn=>Cout13_temp_sig,
		P=>P13_sig,
		G=>G13_sig,
		SomaResult=>SomaT14 
	);
	
	Som15: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(29 DOWNTO 28),
		val2(1 DOWNTO 0) => B_sig(29 DOWNTO 28),
		CarryIn=>Cout14_temp_sig,
		P=>P14_sig,
		G=>G14_sig,
		SomaResult=>SomaT15 
	);
	
	CLGB8: CLGB PORT MAP(
		P0=>P14_sig,
		G0=>G14_sig,
		P1=>P15_sig,
		G1=>G15_sig,
		Cin=>Cout14_temp_sig,
		Cout1=>Cout15_temp_sig,
		Cout2=>Cout_sig
	);
	
	Som16: CLA2bits PORT MAP(
		val1(1 DOWNTO 0) => A_sig(31 DOWNTO 30),
		val2(1 DOWNTO 0) => B_sig(31 DOWNTO 30),
		CarryIn=>Cout15_temp_sig,
		P=>P15_sig,
		G=>G15_sig,
		SomaResult=>SomaT16 
	);
	
	Out_sig <= SomaT16 & SomaT15 & SomaT14 & SomaT13 & SomaT12 & SomaT11 & SomaT10 & SomaT9 & SomaT8 & SomaT7 & SomaT6 & SomaT5 & SomaT4 & SomaT3 & SomaT2 & SomaT1;							
END strc_CLAH32bits;