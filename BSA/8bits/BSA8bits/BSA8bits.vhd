library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;
 
ENTITY BSA8bits IS
PORT (
	val1,val2: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
	SomaResult:OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	clk: IN STD_LOGIC;
	rst: IN STD_LOGIC;
	CarryOut: OUT STD_LOGIC
);
END BSA8bits;
 
architecture strc_BSA8bits of BSA8bits is
	SIGNAL Cin_temp, Cout_temp, Cout_sig, done: STD_LOGIC;
	SIGNAL A_sig, B_sig, Out_sig: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
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
begin

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
		valIn=>Cin_temp,
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

	process(clk,rst,done)
		variable counter: integer range 0 to 8 := 0;
	begin
		if rst = '1' then 
			Cin_temp <= '0';
		elsif (clk='1' and clk'event) then
			Out_sig(counter) <= (A_sig(counter) XOR B_sig(counter)) XOR Cin_temp;
			Cin_temp <= (A_sig(counter) AND B_sig(counter)) OR (Cin_temp AND A_sig(counter)) OR (Cin_temp AND B_sig(counter));		
			
			counter := counter + 1;
		end if;		
	end process;

end strc_BSA8bits;