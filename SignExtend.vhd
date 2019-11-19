library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity SignExtend is
	-- Declaração de Variaveis
	port(
		entradaSE:	in  std_logic_vector(0 to 15);
		saidaSE:	out std_logic_vector(0 to 31)
		);
end SignExtend;

architecture SignExt of SignExtend is 
begin
	process(entradaSE)
	begin
		if (entradaSE(0) = '0') then -- Se o bit inicial for 0, preenche os outros 16 bits com 0
			saidaSE <= "0000000000000000" & entradaSE;
		else -- Caso contrario o bit será 1, e os 16 bits extras serão 1
			saidaSE <= "1111111111111111" & entradaSE;
		end if;
	end process;
end;