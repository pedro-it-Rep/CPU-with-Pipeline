library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity EX_MEM is

	port (
			clock: in std_logic;
			
			-- Declaração da Entrada e Saida do WB e ME
			entradaWB: in std_logic_vector(0 to 1);
			entradaMEM: in std_logic_vector(0 to 2);
			saidaWB: out std_logic_vector(0 to 1) := "00";
			saidaMEM: out std_logic_vector(0 to 2) := "000";
			
			-- Entrada e Saido do PC, responavel pela instrução/proxima instrução
			entradaPC: in std_logic_vector(0 to 31);
			saidaPC: out std_logic_vector(0 to 31) := "00000000000000000000000000000000";
			
			-- Entrada e Saido do sinal ZERO da ULA
			entradaZERO: in std_logic;
			saidaZERO: out std_logic := '0';
			
			-- Entrada e saido do resultado da operação da ALU/ULA 
			entradaResultado: in std_logic_vector(0 to 31);
			saidaResultado:	out	std_logic_vector(0 to 31) := "00000000000000000000000000000000";
			
			-- Entrada e Saida dos Dados que estão no Write Register
			entrada_DadoWriteRegister: in std_logic_vector(0 to 31);
			saida_DadoWriteRegister: out std_logic_vector(0 to 31) := "00000000000000000000000000000000";
			
			entrada_RegDST:	in std_logic_vector(0 to 4);
			saida_RegDST: out std_logic_vector(0 to 4) := "00000"
			);
			
end EX_MEM;

architecture EXMEM of EX_MEM is

begin
	process(clock)
	-- Permite que a saida recebe os dados de entrada do Registrador. Isso só ocorre na subida do clock.
	begin
		if (clock'event and clock = '1') then
			saidaWB	<= entradaWB;
			saidaMEM <= entradaMEM;
			saidaPC <= entradaPC;
			saidaZERO <= entradaZERO;
			saidaResultado 	<= entradaResultado;
			saida_DadoWriteRegister	<= entrada_DadoWriteRegister;
			saida_RegDST <= entrada_RegDST;
		end if;
	end process;
end;