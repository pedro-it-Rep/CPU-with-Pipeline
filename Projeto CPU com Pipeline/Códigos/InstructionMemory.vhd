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
			-- OPCODE DAS INSTRUÇÕES
			
			-- NOP:		000000
			
			-- ADD:		000001 (OK)
			-- SUB:		000010 (OK)
			-- ADDI:	000011 (OK)
			-- SUBI:	000011 (OK)
			
			-- LW:		000101
			-- SW:		000110
			
			-- AND:		000111
			-- ANDI:	001000
			-- OR:		001001
			-- ORI:		001010
			
			-- BEQ:		001011
			
			-- J:		------
			-- JR:		------
			
			-- Addi: Reg1, 0, 7
			inst(0) <= "00001100"; 
			inst(1) <= "00000001"; 
			inst(2) <= "00000000"; 
			inst(3) <= "00000111"; 
			
			--Addi: Reg2, 0, 5
			inst(4) <= "00001100"; 
			inst(5) <= "00000010"; 
			inst(6) <= "00000000"; 
			inst(7) <= "00000011";
			
			--Addi: Reg3, 0, 3
			inst(8) <= "00001100"; 
			inst(9) <= "00000011"; 
			inst(10) <= "00000000"; 
			inst(11) <= "00000101";
			
			--Addi: Reg4, 0, 6
			inst(12) <= "00001100"; 
			inst(13) <= "00000100"; 
			inst(14) <= "00000000"; 
			inst(15) <= "00000110";
			
			-- Add: Reg1, Reg2, Reg3
			inst(16) <= "00000100"; 
			inst(17) <= "01000011";
			inst(18) <= "00001000";
			inst(19) <= "00000000";
			
			--Sub: Reg4, Reg2, Reg3
			inst(20) <= "00001000"; 
			inst(21) <= "01000011";
			inst(22) <= "00100000";
			inst(23) <= "00000000";
			
			--Subi: Reg2, 0, 1
			inst(24) <= "00010000"; 
			inst(25) <= "00000010";
			inst(26) <= "00000000";
			inst(27) <= "00000001";
			
	
	process(endereco)
		begin
			-- Saída recebe entrada
			instrucao <= inst(to_integer(unsigned(endereco)))&
						 inst(to_integer(unsigned(endereco)) +1)& 
						 inst(to_integer(unsigned(endereco)) +2)&
						 inst(to_integer(unsigned(endereco)) +3); 
	end process;
end Instructions;