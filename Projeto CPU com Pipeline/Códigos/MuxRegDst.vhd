library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MuxRegDst is

	port(
		
		-- Registrador rt 
		regRt: in std_logic_vector(0 to 4);
		
		-- Registrador rd 
		regRd: in std_logic_vector(0 to 4);
		
		-- Sinal RegDst
		regDst: in std_logic;
		
		-- Saída do mux
		saidaMux: out std_logic_vector(0 to 4)
		);

end MuxRegDst;

architecture muxReg of MuxRegDst is
begin
	process(regDst, regRt, regRd)
		begin
			if (regDst = '0') then 
				-- Se o sinal for 0
				saidaMux <= regRt; 
			else 
				-- Se o sinal for 1
				saidaMux <= regRd;
			end if;
	end process;
end;