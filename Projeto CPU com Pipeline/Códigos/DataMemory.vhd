library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity DataMemory is

	port(
		-- Entradas da memória
		endereco: in  std_logic_vector(0 to 31);
		writeData: in  std_logic_vector(0 to 31);
		
		-- Saída da memória
		readData: out std_logic_vector(0 to 31);
		
		-- Para armazenar o conteúdo na memória
		memoria: std_logic_vector(0 to 32);
		
		-- Sinais de controle
		clock: in std_logic;
		memWrite: in std_logic;
		memRead: in 	std_logic;

		);
		
end DataMemory;

architecture Data of DataMemory is
begin
	process(clock)
	begin
		if (clock'EVENT and clock = '1') then
			-- Se MemWrite estiver ativo
			if (memWrite = '1') then
				memoria <= writeData;
			end if;
			
			-- Se MemRead estiver ativo
			if (memRead = '1') then 
				readData <= memoria;
			else 
				read_data <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
			end if;
		end if;
	end process;
end Data;