library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MEM_WB is
	port(
			clock: in	std_logic;
	
			-- 32 bits para o sinal de WB
			wbIn: in std_logic_vector(0 to 1);
			wbOut: out	std_logic_vector(0 to 1) := "00";
			
			-- 32 bits para o  
			rdIn: in std_logic_vector(0 to 31);
			rdOut: out	std_logic_vector(0 to 31) := "00000000000000000000000000000000";
			
			-- 32 bits para o  
			addrIn: in	std_logic_vector(0 to 31);
			addrOut: out std_logic_vector(0 to 31) := "00000000000000000000000000000000";
			
			-- 4 bits para o  
			regDstIn: in std_logic_vector(0 to 4);
			regDstOut: out	std_logic_vector(0 to 4) := "00000"
		);
			
end MEM_WB;

architecture MEMWB of MEM_WB is

begin
	process(clock)
	begin
		if (clock'event and clock = '1') then
			wbOut <= wbIn;
			rdOut <= rdIn;
			addrOut <= addrIn;
			regDstOut <= regDstIn;
		end if;
	end process;
end;