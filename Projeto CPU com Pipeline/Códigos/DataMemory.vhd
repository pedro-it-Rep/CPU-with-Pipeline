library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity DataMemory is

	port(
		-- Entradas da memória
		endereco: in std_logic_vector(0 to 31);
		writeData: in std_logic_vector(0 to 31);
		
		-- Saída da memória
		readData: out std_logic_vector(0 to 31);
		
		-- Sinais de controle
		clock: in std_logic;
		memWrite: in std_logic;
		memRead: in std_logic);
		
end DataMemory;

architecture Data of DataMemory is
	type memoria is array (0 to 63) of std_logic_vector(0 to 7);
	signal memory: memoria;
begin
	
	process(clock)
	begin
		if (clock'EVENT and clock = '1') then
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
end Data;
