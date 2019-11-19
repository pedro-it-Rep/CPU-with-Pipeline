-- Bibliotecas Usadas
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ShiftLeft2 is
	-- Declaração das variaveis
	port(
		entradaSHL: in  std_logic_vector(0 to 31);
		saidaSHL:	out std_logic_vector(0 to 31)
		);
end ShiftLeft2;

architecture sll2 of ShiftLeft2 is
begin
	-- Necessario colocar 2 bits para manter o formato da instrução com 32 bits
	saidaSHL <= entradaSHL(2 to 31) & "00";  -- EX: 0101010.... → 00 0101010....
end;