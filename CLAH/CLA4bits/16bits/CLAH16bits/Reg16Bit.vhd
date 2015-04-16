library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Reg16Bit is

port(	
	valIn: in std_logic_vector(15 downto 0);
	clk: in std_logic;
	rst: in std_logic;
	valOut: out std_logic_vector(15 downto 0)
);
end Reg16Bit;

architecture strc_Reg16Bit of Reg16Bit is
    signal Temp: std_logic_vector(15 downto 0);
begin
    process(valIn, clk, rst)
	begin

		if rst = '1' then 
			Temp <= "0000000000000000";
		elsif (clk='1' and clk'event) then
			Temp <= valIn;
		end if;
		
	end process;
	valOut <= Temp;
end strc_Reg16Bit;