library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Reg1Bit is

port(	
	valIn: in std_logic;
	clk: in std_logic;
	rst: in std_logic;
	valOut: out std_logic
);
end Reg1Bit;

architecture strc_Reg1Bit of Reg1Bit is
    signal Temp: std_logic;
begin
    process(valIn, clk, rst)
	begin

		if rst = '1' then 
			Temp <= '0';
		elsif (clk='1' and clk'event) then
			Temp <= valIn;
		end if;
		
	end process;
	valOut <= Temp;
end strc_Reg1Bit;