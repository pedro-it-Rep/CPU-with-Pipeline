library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity DataMemory is

	port(
		-- Entradas da memória
		endereco: in std_logic_vector(0 to 31);
		clock: in std_logic;
		memWrite: in std_logic;
		writeData: in std_logic_vector(0 to 31);
		memRead: in std_logic;
		
		-- Saída da memória
		readData: out std_logic_vector(0 to 31);
		
		mem1: out std_logic_vector(0 to 31);
		mem2: out std_logic_vector(0 to 31);
		mem3: out std_logic_vector(0 to 31);
		mem4: out std_logic_vector(0 to 31)
		);
		
end DataMemory;

architecture Data of DataMemory is
	type memoria is array (0 to 100) of std_logic_vector(0 to 7);
	signal memory: memoria;
begin

	mem1 <= memory(0) & memory(1) & memory(2) & memory(3);
	mem2 <= memory(4) & memory(5) & memory(6) & memory(7);
	mem3 <= memory(8) & memory(9) & memory(10) & memory(11);
	mem4 <= memory(12) & memory(13) & memory(14) & memory(15);

	process(clock)
	begin
		if (clock'event and clock = '1') then
			-- Se MemWrite estiver ativo
			if (memWrite = '1') then
				memory(to_integer(unsigned(endereco))) <= writeData(0 to 7);
				memory(to_integer(unsigned(endereco)) +1) <= writeData(8 to 15);
				memory(to_integer(unsigned(endereco)) +2) <= writeData(16 to 23);
				memory(to_integer(unsigned(endereco)) +3) <= writeData(24 to 31);
			end if;
			
			-- Se MemRead estiver ativo
			if (memRead = '1') then 
			readData <= memory(to_integer(unsigned(endereco)))&
							memory(to_integer(unsigned(endereco)) +1)&
							memory(to_integer(unsigned(endereco)) +2)&
							memory(to_integer(unsigned(endereco)) +3);
			else 
				readData <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
			end if;
		end if;
	end process;
end;
