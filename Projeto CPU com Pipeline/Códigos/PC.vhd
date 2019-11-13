library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity PC is
	port(clock:	in  std_logic;
	
		-- Declaração de pc e pc+4
		pc4:in std_logic_vector(0 to 31);
		pc:	out std_logic_vector(0 to 31) := "00000000000000000000000000000000");
		
end PC;

architecture PC4 of PC is
begin 
	process (clock, pc4)
		begin
			if (clock'event and clock = '1') then
				-- Realiza PC+4
				pc <= pc4;
			end if;
	end process;
end PC4;