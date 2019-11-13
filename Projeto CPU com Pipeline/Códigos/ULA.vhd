library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ULA is 

	port (
		-- Primeiro registrador que entra na ULA
		aluSrcA: in std_logic_vector(0 to 31);
		
		-- Segundo registrador que entra na ULA
		aluSrcB: in std_logic_vector(0 to 31);
		
		-- Operação feita pela ULA (add, sub, and e or)
		aluOp:	in std_logic_vector(0 to  1);
		
		-- Saída da ULA
		aluResult: out std_logic_vector(0 to 31);
		
		-- Sinal de controle zero
		zero: out std_logic);
		
end ULA;

architecture UnidadeLogArit of ULA is 
	 signal conta: std_logic_vector(0 to 31);
begin
	process(aluSrcA, aluSrcB, aluOp)
	begin
		case aluOp is
			
			when "00" => aluResult <= aluSrcA + aluSrcB;
			when "01" => aluResult <= aluSrcA - aluSrcB;
			when "10" => aluResult <= aluSrcA and aluSrcB;
			when "11" => aluResult <= aluSrcA or aluSrcB;
			when others => aluResult <= "00000000000000000000000000000000";
			
		end case;
		
		if(conta = "00000000000000000000000000000000") then
			zero <= '1';
		else
			zero <= '0';
		end if;
		
		 aluResult <= conta;
	end process;
end UnidadeLogArit;