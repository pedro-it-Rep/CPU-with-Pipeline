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
	
	type instrucoes is array (0 to 384) of std_logic_vector(0 to 7);
	signal inst: instrucoes;
	
begin
			--Instruções tipo R
			--inst(x) <= "aaaaaabb" 
			--inst(x) <= "bbbccccc"
			--inst(x) <= "dddddeee"
			--inst(x) <= "eeffffff"
			-- a: opcode
			-- b: Rs
			-- c: Rt
			-- d: Rd
			-- e: shamt
			-- f: funct
			
			--Instrucoes tipo I
			--inst(x) <= "aaaaaabb"
			--inst(x) <= "bbbccccc"
			--inst(x) <= "dddddddd"
			--inst(x) <= "dddddddd"
			-- a: opcode
			-- b: Rs
			-- c: Rt
			-- d: Imediato ou endereço
			
			-- Addi: Reg1, 0, 7 
			inst(0) <= "00001100"; 
			inst(1) <= "00000001"; 
			inst(2) <= "00000000"; 
			inst(3) <= "00000111"; 
			
			--Addi: Reg2, 0, 5
			inst(4) <= "00001100"; 
			inst(5) <= "00000010"; 
			inst(6) <= "00000000"; 
			inst(7) <= "00000101";
			
			--Addi: Reg3, 0, 3
			inst(8) <= "00001100"; 
			inst(9) <= "00000011"; 
			inst(10) <= "00000000"; 
			inst(11) <= "00000011";
			
			--nop
			inst(12) <= "00000000"; 
			inst(13) <= "00000000"; 
			inst(14) <= "00000000"; 
			inst(15) <= "00000000";
			--nop
			inst(16) <= "00000000"; 
			inst(17) <= "00000000"; 
			inst(18) <= "00000000"; 
			inst(19) <= "00000000";
			--nop
			inst(20) <= "00000000"; 
			inst(21) <= "00000000"; 
			inst(22) <= "00000000"; 
			inst(23) <= "00000000";
			
			--Add: Reg1, Reg2, Reg3
			inst(24) <= "00000100"; 
			inst(25) <= "01000011";
			inst(26) <= "00001000";
			inst(27) <= "00000000";
			
			--SUB Reg1, Reg2, Reg3; reg2-reg3
			inst(28) <= "00001000"; 
			inst(29) <= "01000011";
			inst(30) <= "00001000";
			inst(31) <= "00000000";
			
			--AND Reg1, Reg2, Reg3;
			inst(32) <= "00011100"; 
			inst(33) <= "01000011";
			inst(34) <= "00001000";
			inst(35) <= "00000000";
			
			--OR Reg1, Reg2, Reg3;
			inst(36) <= "00100100"; 
			inst(37) <= "01000011";
			inst(38) <= "00001000";
			inst(39) <= "00000000";
			
			--SUBi
			
			--ANDi
			
			--ORi
			
			
	process(endereco)
		begin
			-- Saída recebe entrada
			instrucao <= inst(to_integer(unsigned(endereco))) & 
			inst(to_integer(unsigned(endereco)) + 1) & 
			inst(to_integer(unsigned(endereco)) + 2) & 
			inst(to_integer(unsigned(endereco)) + 3); 
	end process;
end;