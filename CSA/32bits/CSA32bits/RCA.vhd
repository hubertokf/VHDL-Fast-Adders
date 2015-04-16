-- Somador 8_bits --
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY RCA IS
	PORT (	
		CarryIn: in std_logic;
		val1,val2: in std_logic_vector (3 downto 0);
		SomaResult: out std_logic_vector (3 downto 0);
		CarryOut: out std_logic
	);
END RCA ;

ARCHITECTURE strc_RCA OF RCA IS
	signal carry: std_logic_vector (3 downto 1);
	
	COMPONENT Soma1
		port (	
			CarryIn,val1,val2: in std_logic ;
			SomaResult,CarryOut: out std_logic 
		);
	END COMPONENT ;
	
BEGIN	
	--somador--
	Som0: Soma1 PORT MAP ( 
		CarryIn, 
		val1(0), 
		val2(0), 
		SomaResult(0), 
		carry(1)
	);
	Som1: Soma1 PORT MAP ( 
		carry(1),
		val1(1),
		val2(1),
		SomaResult(1),
		carry(2)
	);
	Som2: Soma1 PORT MAP ( 
		carry(2),
		val1(2),
		val2(2),
		SomaResult(2),
		carry(3)
	);

	Som3: Soma1 PORT MAP (
		carry(3),
		val1(3),
		val2(3),
		SomaResult(3),
		CarryOut
	);
	
END strc_RCA ;