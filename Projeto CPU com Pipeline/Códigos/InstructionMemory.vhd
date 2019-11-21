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
			
			-- nop
			inst(12) <= "00000000"; 
			inst(13) <= "00000000"; 
			inst(14) <= "00000000"; 
			inst(15) <= "00000000";
			
			-- nop
			inst(16) <= "00000000"; 
			inst(17) <= "00000000"; 
			inst(18) <= "00000000"; 
			inst(19) <= "00000000";
			
			-- nop
			inst(20) <= "00000000"; 
			inst(21) <= "00000000"; 
			inst(22) <= "00000000"; 
			inst(23) <= "00000000";
			
			-- Add: Reg1, Reg2, Reg3
			inst(24) <= "00000100"; 
			inst(25) <= "01000011";
			inst(26) <= "00001000";
			inst(27) <= "00000000";
			
			-- SUB Reg1, Reg2, Reg3; reg2-reg3
			inst(28) <= "00001000"; 
			inst(29) <= "01000011";
			inst(30) <= "00001000";
			inst(31) <= "00000000";
			
			-- AND Reg1, Reg2, Reg3;
			inst(32) <= "00011100"; 
			inst(33) <= "01000011";
			inst(34) <= "00001000";
			inst(35) <= "00000000";
			
			-- OR Reg1, Reg2, Reg3;
			inst(36) <= "00100100"; 
			inst(37) <= "01000011";
			inst(38) <= "00001000";
			inst(39) <= "00000000";
			
			-- SUBi Reg1, Reg2, 3
			inst(40) <= "00010000"; 
			inst(41) <= "01000001";
			inst(42) <= "00000000";
			inst(43) <= "00000011";
			
			-- ANDi Reg1, Reg2, 7
			inst(44) <= "00100000"; 
			inst(45) <= "01000001";
			inst(46) <= "00000000";
			inst(47) <= "00000111";
			
			-- ORi Reg1, Reg2, 7
			inst(48) <= "00101000"; 
			inst(49) <= "01000001";
			inst(50) <= "00000000";
			inst(51) <= "00000111";
			
			--Sw Reg2, 0(Reg7)
			inst(52) <= "00011000"; 
			inst(53) <= "11100010";
			inst(54) <= "00000000";
			inst(55) <= "00000000";
			
			-- nop
			inst(56) <= "00000000"; 
			inst(57) <= "00000000"; 
			inst(58) <= "00000000"; 
			inst(59) <= "00000000";
			
			-- nop
			inst(60) <= "00000000"; 
			inst(61) <= "00000000"; 
			inst(62) <= "00000000"; 
			inst(63) <= "00000000";
			
			-- nop
			inst(64) <= "00000000"; 
			inst(65) <= "00000000"; 
			inst(66) <= "00000000"; 
			inst(67) <= "00000000";
			
			--LW Reg5, 0(Reg7)
			inst(68) <= "00010100"; 
			inst(69) <= "11100101";
			inst(70) <= "00000000";
			inst(71) <= "00000000";
			
			--ADDi REG1,0,0
			inst(72) <= "00001100"; 
			inst(73) <= "00000001"; 
			inst(74) <= "00000000"; 
			inst(75) <= "00000000";
			
			-- nop
			inst(76) <= "00000000"; 
			inst(77) <= "00000000"; 
			inst(78) <= "00000000"; 
			inst(79) <= "00000000";
			
			-- nop
			inst(80) <= "00000000"; 
			inst(81) <= "00000000"; 
			inst(82) <= "00000000"; 
			inst(83) <= "00000000";	
			
			-- BEQ REG1, Reg0, 27 
			inst(84) <= "00101100"; 
			inst(85) <= "00100000";
			inst(86) <= "00000000";
			inst(87) <= "00011011";
			
			-- NOP
			inst(88) <= "00000000"; 
			inst(89) <= "00000000";
			inst(90) <= "00000000";
			inst(91) <= "00000000";
			
			-- NOP
			inst(92) <= "00000000"; 
			inst(93) <= "00000000";
			inst(94) <= "00000000";
			inst(95) <= "00000000";
			
			-- NOP
			inst(96) <= "00000000"; 
			inst(97) <= "00000000";
			inst(98) <= "00000000";
			inst(99) <= "00000000";
			
			-- NOP
			inst(100) <= "00000000"; 
			inst(101) <= "00000000";
			inst(102) <= "00000000";
			inst(103) <= "00000000";
			
			-- Add Reg1, Reg2, Reg3 
			inst(104) <= "00000100"; 
			inst(105) <= "01000011";
			inst(106) <= "00001000";
			inst(107) <= "00000000";
			
			
	process(endereco)
		begin
			-- Saída recebe entrada
			instrucao <= inst(to_integer(unsigned(endereco))) & 
			inst(to_integer(unsigned(endereco)) + 1) & 
			inst(to_integer(unsigned(endereco)) + 2) & 
			inst(to_integer(unsigned(endereco)) + 3); 
	end process;
end;