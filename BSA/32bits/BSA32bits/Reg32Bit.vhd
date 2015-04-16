library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Reg32Bit is

port(	
	valIn: in std_logic_vector(31 downto 0);
	clk: in std_logic;
	rst: in std_logic;
	valOut: out std_logic_vector(31 downto 0)
);
end Reg32Bit;

architecture strc_Reg32Bit of Reg32Bit is
    signal Temp: std_logic_vector(31 downto 0);
begin
    process(valIn, clk, rst)
	begin

		if rst = '1' then 
			Temp <= "00000000000000000000000000000000";
		elsif (clk='1' and clk'event) then
			Temp <= valIn;
		end if;
		
	end process;
	valOut <= Temp;
end strc_Reg32Bit;