library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Declaração das variaveis
entity Adder is
	port	(entrada1:	in  std_logic_vector(0 to 31);
			entrada2:	in  std_logic_vector(0 to 31);
			saidaAdder:	out std_logic_vector(0 to 31));
end Adder;

-- Faz a soma dos valores que estão nas entradas, e fazem com que a saida receba esse valor
architecture add of Adder is
begin
	saidaAdder <= entrada1 + entrada2;
end;