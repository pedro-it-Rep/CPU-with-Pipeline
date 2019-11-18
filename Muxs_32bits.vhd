library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Muxs_32bits is

	port(
		-- Sinal de cotrole do mux 
		sinalControle: in  std_logic;
		
		-- 1º entrada do mux
		entrada1: in  std_logic_vector(0 to 31);
		
		-- 2º entrada do registrador
		entrada2: in  std_logic_vector(0 to 31);
		
		-- Saída do mux
		saidaMux32: out std_logic_vector(0 to 31)
		);
		
end Muxs_32bits;

architecture mux32 of Muxs_32bits is
begin
	process(sinalControle, entrada1, entrada2)
	begin
		if (sinalControle = '0') then 
			-- Se o sinal for 0
			saidaMux32 <= entrada1;
		else 
			-- Se o sinal for 1
			saidaMux32 <= entrada2;
		end if;
	end process;
end;