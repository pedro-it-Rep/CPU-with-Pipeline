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
		readData2: out std_logic_vector(0 to 31);
	
		register1: out std_logic_vector(0 to 31);
		register2: out std_logic_vector(0 to 31);
		register3: out std_logic_vector(0 to 31);
		register4: out std_logic_vector(0 to 31);
		register5: out std_logic_vector(0 to 31);
		register6: out std_logic_vector(0 to 31);
		register7: out std_logic_vector(0 to 31);
		register8: out std_logic_vector(0 to 31)
		
		);

end Registers;

architecture registrador of Registers is

	-- 10 registradores de 32 bits
	type registrador is array (0 to 9) of std_logic_vector(0 to 31);
	signal Testereg: registrador;
	
	begin
	
		register1 <= Testereg(0);
		register2 <= Testereg(1);
		register3 <= Testereg(2);
		register4 <= Testereg(3);
		register5 <= Testereg(4);
		register6 <= Testereg(5);
		register7 <= Testereg(6);
		register8 <= Testereg(7);
		
		process(clock)
		begin
		-- Para conteúdo de writeData poder ser escrito em um registrador
		if (clock'EVENT and clock = '1' and regWrite = '1' and not (writeRegister = "00000") ) then
			Testereg(to_integer(unsigned(writeRegister))) <= writeData;
		end if;
	end process;
	
	readData1 <= Testereg(to_integer(unsigned(readRegister1)));
	readData2 <= Testereg(to_integer(unsigned(readRegister2)));
	
end;