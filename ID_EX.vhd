library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Declaração de Variaveis
entity ID_EX is
	port (
			clock: in std_logic;
			
			-- Declaração das entradas e saidas do registrador de Pipeline
			entradaWB: in std_logic_vector(0 to 1);
			entradaMEM: in std_logic_vector(0 to 2);
			entradaEX: in std_logic_vector(0 to 3);
			saidaWB: out std_logic_vector(0 to 1) := "00";
			saidaMEM: out std_logic_vector(0 to 2) := "000";
			saidaEX: out std_logic_vector(0 to 3) := "0000";
			
			-- Entrada e saida do valor do PC, responsavel pela instrução
			entradaPC: in std_logic_vector(0 to 31);
			saidaPC: out std_logic_vector(0 to 31) := "00000000000000000000000000000000";
			
			-- Declaração da Entrada e Saida do dado 1
			entrada_ReadData1: in std_logic_vector(0 to 31);
			saida_ReadData1: out std_logic_vector(0 to 31) := "00000000000000000000000000000000";
			
			-- Declaração da Entrada e Saida do dado 2
			entrada_ReadData2: in std_logic_vector(0 to 31);
			saida_ReadData2: out std_logic_vector(0 to 31) := "00000000000000000000000000000000";
			
			-- Entrada e Saida do imediato
			entrada_imed: in std_logic_vector(0 to 31);
			saida_imed:	out	std_logic_vector(0 to 31) := "00000000000000000000000000000000";
			
			-- Entrada e Saida dos Registradores RT e RD, cada um com 5 bits
			entradaRT: in std_logic_vector(0 to 4);
			saidaRT: out std_logic_vector(0 to 4) := "00000";
			entradaRD: in std_logic_vector(0 to 4);
			saidaRD: out std_logic_vector(0 to 4) := "00000");
end ID_EX;

architecture IDEX of ID_EX is

begin
	process(clock)
	begin
		-- Define que a saida recebe a entrada na subida do clock
		if (clock'event and clock = '1') then
			saidaWB <= entradaWB;
			saidaMEM <= entradaMEM;
			saidaEX <= entradaEX;
			saidaPC <= entradaPC;
			saida_ReadData1	<= entrada_ReadData1;
			saida_ReadData2	<= entrada_ReadData2;
			saida_imed <= entrada_imed;
			saidaRT <= entradaRT;
			saidaRD <= entradaRD;
		end if;
	end process;
end; 