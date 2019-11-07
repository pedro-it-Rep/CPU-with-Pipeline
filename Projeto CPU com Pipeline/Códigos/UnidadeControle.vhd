library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity UnidadeControle is

	port (
		-- Opcode
		opcode:	in  std_logic_vector(0 to 5);
		
		-- Sinal de PCSrc
		PCSrc: out std_logic := '0';
		
		-- Sinal de controle para o estáio de EX
		SignalEX:	out std_logic_vector(0 to 3) := "0000"
		
		-- Sinal de controle para o estágio de MEM
		SignalMEM: out std_logic_vector(0 to 2) := "000";
		
		-- Sinal de controle para o estágio de WB
		SignalWB:	out std_logic_vector(0 to 1) := "00";
		);
		
end UnidadeControle;

architecture control of UnidadeControle is
begin
	process(opcode)
	begin
		case opcode is
		
			-- NOP
			when "000000" => 
				PCSrc <= '0';
				SignalEX <= "XXXX";
				SignalMEM <= "0X0";
				SignalWB <= "X0";
				
				
			-- ADD	
			when "000001" => 
				PCSrc <= '0';
				SignalEX <= "0001";
				SignalMEM <= "0X0";
				SignalWB <= "01";
				
				
			-- SUB
			when "000010" =>
				PCSrc <= '0';
				SignalEX <= "0011";
				SignalMEM <= "0X0";
				SignalWB <= "01";
			
			
			-- ADDI
			when "000011" => 
				PCSrc <= '0';
				SignalEX <= "1000";			
				SignalMEM <= "0X0";
				SignalWB <= "01";
				
				
			-- SUBI	
			when "000100" => 
				PCSrc <= '0';
				SignalEX <= "1010";
				SignalMEM	<= "0X0";
				SignalWB <= "01";
			
			
			-- LW	
			when "000101" => 
				PCSrc <= '0';
				SignalEX <= "1000";				
				SignalMEM <= "010";
				SignalWB <= "11";
				
				
			-- SW
			when "000110" => 
				PCSrc <= '0';
				SignalEX <= "100X";	
				SignalMEM <= "1X0";
				SignalWB <= "00";
			
			
			-- AND	
			when "000111" => 
				PCSrc <= '0';
				SignalEX <= "0101";
				SignalMEM <= "0X0";
				SignalWB <= "01";
				
				
			-- ANDI
			when "001000" => 
				PCSrc <= '0';
				SignalEX <= "1100";
				SignalMEM <= "0X0";
				SignalWB <= "01";
				
			-- OR
			when "001001" => 
				pcsrc <= '0';
				SignalEX <= "0111";
				SignalMEM <= "0X0";
				SignalWB <= "01";
			
			
			-- ORI
			when "001010" => 
				PCSrc <= '0';
				SignalEX <= "1110";
				SignalMEM	<= "0X0";
				SignalWB <= "01";
			
			
			-- BEQ	
			when "001011" => 
				PCSrc <= '0';
				SignalEX <= "001X";
				SignalMEM	<= "0X1";
				SignalWB <= "00";
			
			
			-- OTHERS
			when others => 
				PCSrc <= '0';
				SignalEX <= "XXXX";
				SignalMEM	<= "0X0";
				SignalWB <= "00";

		end case;
	end process;
end control;