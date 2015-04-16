Library IEEE;
Use ieee.std_logic_1164.all;

Entity mux84 is
port (
	In0, In1: in std_logic_vector(3 downto 0);
	sel: in std_logic;
	Outs : out std_logic_vector(3 downto 0)
);
end mux84;

ARCHiTEcTURE arq_mux84 of mux84 is
begin
	with sel select
		Outs <=
			In0 when '0',
			In1 when '1'; 
		
end arq_mux84;	 