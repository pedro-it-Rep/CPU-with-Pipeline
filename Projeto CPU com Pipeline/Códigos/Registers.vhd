library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Registers is

	port(
		-- Clock e sinal de RegWrite
		clock: in std_logic;
		regWrite: in std_logic;
		
		-- Entradas dos registradores que serão lidos
		readRegister1: in std_logic_vector(0 to 4);
		readRegister2: in std_logic_vector(0 to 4);
		
		-- Registrador que será escrito
		writeRegister: in std_logic_vector(0 to 4);
		
		-- Dado de escrita
		writeData: in std_logic_vector(0 to 31);
		
		-- Saída dos banco de registradores
		readData1: out std_logic_vector(0 to 31);
		readData2: out std_logic_vector(0 to 31)
	
		);

end Registers;

architecture registrador of Registers is

	type registrador is array (0 to 31) of std_logic_vector(0 to 31);
	signal Testereg: registrador;
	
	begin
		process(clock)
		begin
		-- Para conteúdo de writeData poder ser escrito em um registrador
		if (clock'EVENT and clock = '1' and regWrite = '1' and not (writeRegister = "00000") ) then
			Testereg(to_integer(unsigned(writeRegister))) <= writeData;
		end if;
	end process;
	
	readData1 <= Testereg(to_integer(unsigned(readRegister1)));
	readData2 <= Testereg(to_integer(unsigned(readRegister2)));
	
end registrador;