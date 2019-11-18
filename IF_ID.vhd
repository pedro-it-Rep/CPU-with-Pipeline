library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity IF_ID is
	port(
		clock: in	std_logic;
		
		-- 32 bits para o PC
		pcIn: in std_logic_vector(0 to 31);
		pcOut: out std_logic_vector(0 to 31) := "00000000000000000000000000000000";
			
		-- 32 bits para a instrução
		InstructionIn:	in std_logic_vector(0 to 31);
		InstructionOut:	out std_logic_vector(0 to 31) := "00000000000000000000000000000000"
		);
		
end IF_ID;

architecture IFID of IF_ID is
begin
	process(clock)
		begin
			if (clock'event and clock = '1') then
				InstructionOut <= InstructionIn;
				pcOut <= pcIn;
			end if;
	end process;
end;