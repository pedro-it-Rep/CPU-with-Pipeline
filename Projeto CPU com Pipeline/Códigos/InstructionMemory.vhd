library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity InstructionMemory is
	
	port(
		-- Endereço que chega na memória de instrução
		endereco: in std_logic_vector(0 to 31);
		
		-- Saída da memória de instrução
		instrucao: out std_logic_vector(0 to 31) := "00000000000000000000000000000000"
		
		);
		
end InstructionMemory;


architecture Instructions of InstructionMemory is
	
	type instrucoes is array (0 to 447) of std_logic_vector(7 downto 0);
	signal inst: instrucoes;
	
begin	
	process(endereco)
		begin
			-- Saída recebe entrada
			instrucao <= inst(to_integer(unsigned(endereco)))&
						 inst(to_integer(unsigned(endereco)) +1)& 
						 inst(to_integer(unsigned(endereco)) +2)&
						 inst(to_integer(unsigned(endereco)) +3); 
	end process;
end Instructions;