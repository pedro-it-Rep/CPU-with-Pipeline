library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Declaração das variaveis no CPU
entity CPU is
	port(clock:in std_logic; -- Controle das instruções
			pcAtual:	out std_logic_vector(0 to 31); -- Responasel por mostrar o PC Atual
			instrucAtual: out std_logic_vector(0 to 31); -- Contem a instrução que será executada
			Testereg:		out std_logic_vector(0 to 31));
			
end CPU;

	-- Declaração dos componentes utilizados durante a execução do pipeline
architecture components of cpu is

	--OBS: Explicação aprofundada de cada componente se encontra no proprio arquivo do componente

	-- Declaração da Memoria de Instruções, responsavel por obter as instruções do programa
	component InstructionMemory
	
		port (endereco: in std_logic_vector(0 to 31);
				instrucao: out std_logic_vector(0 to 31));
				
	end component;
	
	-- Declaração dos registradores usados pelo programa
	component Registers
	
		port	(regWrite: in std_logic;
				clock: in std_logic;
				readRegister1:	in  std_logic_vector(0 to 4);
				readRegister2:	in  std_logic_vector(0 to 4);
				writeRegister:	in  std_logic_vector(0 to 4);
				writeData:			in  std_logic_vector(0 to 31);
				readData1: 		out std_logic_vector(0 to 31);
				readData2: 		out std_logic_vector(0 to 31));
				--registrador:		out std_logic_vector(0 to 31));

	end component;
	
	-- Declaração da memoria de Dados
	component DataMemory
		
		port	(endereco:	in  std_logic_vector(0 to 31);
				writeData:	in  std_logic_vector(0 to 31);
				readData:	out std_logic_vector(0 to 31);
				clock: 		in std_logic;
				memWrite: 	in std_logic;
				memRead: 	in 	std_logic);

	end component;
	
	-- Declaração do somador responsavel por calcular o Branch se necessario
	component AdderBranch
		
		port	(entrada1:	in  std_logic_vector(0 to 31);
				entrada2:		in  std_logic_vector(0 to 31);
				saidaAdder:		out std_logic_vector(0 to 31));
				
	end component;
	
	-- Declaração do multiplexador de 32 bits de forma generica, para multiplos usos ao longo do programa
	component Muxs_32bits is
		
		port	(sinalControle:	in  std_logic;
				entrada1:	in  std_logic_vector(0 to 31);
				entrada2:		in  std_logic_vector(0 to 31);
				saidaMux32:		out std_logic_vector(0 to 31));
				
	end component;
	
	-- Declaração do multiplexador usado para o controle do RegDst
	component MuxRegDst is
		
		port	(regDst: in std_logic;
				regRt: in std_logic_vector(0 to 4);
				regRd: in std_logic_vector(0 to 4);
				saidaMux:		out std_logic_vector(0 to 4));
				
	end component;
	
	-- Declaração do PC, utilizado ao longo do programa
	component PC is
		
		port	(clock:	in  std_logic;
				pc4:	in  std_logic_vector(0 to 31);
				pc:		out std_logic_vector(0 to 31));
				
	end component;
	
	-- Declaração do sinal extendido, necessario para o bom funcionamento do pipeline
	component SignExtend is
		
		port	(entradaSE:	in  std_logic_vector(0 to 15);
				 saidaSE:	out std_logic_vector(0 to 31));
				 
	end component;
	
	-- Declaração do shitf left 2, para o programa apenas é necessario mover 2 bits
	component ShiftLeft2 is
		
		port	(entradaSHL: 	in  std_logic_vector(0 to 31);
				 saidaSHL:	out std_logic_vector(0 to 31));
				 
	end component;
	
	-- Declaração da unidade Logica e Aritmetica, responsavel pelas operações necessarias durante o programa
	component ULA is
		
		port (aluSrcA: 	in  std_logic_vector(0 to 31);
				aluSrcB: 	in  std_logic_vector(0 to 31);
				aluOp:		in  std_logic_vector(0 to  1);
				aluResult: out std_logic_vector(0 to 31);
				zero: 	out std_logic);
				
	end component;
	
	
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Declaração dos registradores de pipeline, fundametais para a implementação do pipeline
	-- Registradores de Pipeline
	
	-- Registrador IF/ID
		component IF_ID is
		
		port (clock:	in		std_logic;
	
			pcIn:		in		std_logic_vector(0 to 31);
			pcOut:		out	std_logic_vector(0 to 31);
			
			InstructionIn:	in		std_logic_vector(0 to 31);
			InstructionOut:	out	std_logic_vector(0 to 31));
			
	end component;
	
	-- Registrador ID/EX
		component ID_EX is
		
		port (clock:	in		std_logic;
			entradaWB:		in		std_logic_vector(0 to 1);
			entradaMEM:		in		std_logic_vector(0 to 2);
			entradaEX:		in		std_logic_vector(0 to 3);
			saidaWB:		out	std_logic_vector(0 to 1);
			saidaMEM:		out	std_logic_vector(0 to 2);
			saidaEX:		out	std_logic_vector(0 to 3);
			
			entradaPC:		in		std_logic_vector(0 to 31);
			saidaPC:		out	std_logic_vector(0 to 31);
			
			entrada_ReadData1:	in		std_logic_vector(0 to 31);
			saida_ReadData1:	out	std_logic_vector(0 to 31);
			
			entrada_ReadData2:	in		std_logic_vector(0 to 31);
			saida_ReadData2:	out	std_logic_vector(0 to 31);
			
			entrada_imed:		in		std_logic_vector(0 to 31);
			saida_imed:	out	std_logic_vector(0 to 31);
			
			entradaRT:		in		std_logic_vector(0 to 4);
			saidaRT:		out	std_logic_vector(0 to 4);
			entradaRD:		in		std_logic_vector(0 to 4);
			saidaRD:		out	std_logic_vector(0 to 4));
			
	end component;
	
	-- Registrador EX/MEM
		component EX_MEM is
		
		port (clock:	in		std_logic;
			entradaWB:		in		std_logic_vector(0 to 1);
			entradaMEM:		in		std_logic_vector(0 to 2);
			saidaWB:		out	std_logic_vector(0 to 1);
			saidaMEM:		out	std_logic_vector(0 to 2);
			
			entradaPC:		in		std_logic_vector(0 to 31);
			saidaPC:		out	std_logic_vector(0 to 31);
			
			entradaZERO:		in		std_logic;
			saidaZERO:	out	std_logic;
			
			entradaResultado:	in		std_logic_vector(0 to 31);
			saidaResultado:	out	std_logic_vector(0 to 31);
			
			entrada_DadoWriteRegister:	in		std_logic_vector(0 to 31);
			saida_DadoWriteRegister:	out	std_logic_vector(0 to 31);
			
			entrada_RegDST:	in		std_logic_vector(0 to 4);
			saida_RegDST:	out	std_logic_vector(0 to 4));
			
	end component;
	
	-- Registrador MEM/WB
		component MEM_WB is
		
		port (clock:	in		std_logic;
			wbIn:		in		std_logic_vector(0 to 1);
			wbOut:		out	std_logic_vector(0 to 1);
			
			rdIn:	in		std_logic_vector(0 to 31);
			rdOut:	out	std_logic_vector(0 to 31);
			
			addrIn:		in		std_logic_vector(0 to 31);
			addrOut:	out	std_logic_vector(0 to 31);
			
			redDstIn:	in		std_logic_vector(0 to 4);
			redDstOut:	out	std_logic_vector(0 to 4));
			
	end component;
	
	-- Declaração da Unidade de Controle, responsavel pelas "escolha" das operações.
		component UnidadeControle is
		
		port (opcode:	in  std_logic_vector(0 to 5);
			PCSrc:		out std_logic;
			SignalEX:			out std_logic_vector(0 to 3);
			SignalMEM:			out std_logic_vector(0 to 2);
			SignalWB:			out std_logic_vector(0 to 1));
			
	end component;
	
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Fetch da Instrução
	--Sinais responsaveis por fazer o fetch da instrução
	
	signal instrucaoPC:			std_logic_vector(0 to 31); -- Instrução vai ser feita o fetch
	signal instrucao_IF_ID:		std_logic_vector(0 to 31); -- Instrução pós fetch || Saida da memoria de instrução e entrada no registrador IF/ID

	signal PCSrc:	std_logic; -- PC Source responsavel pelo controle do que vai passar para o PC
	signal PCSrc_0:		std_logic_vector(0 to 31); -- Entrada do 0 no Mux do PCSrc - PC + 4 - Proxima instrução
	signal PCSrc_1:		std_logic_vector(0 to 31); -- Entrada do 1 no Mux do PCSrc - Pos Branch
	
	signal atualizaPC:				std_logic_vector(0 to 31); -- Responsavel por atualizar o PC baseado na saida do multiplexador do PCSrc
	
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Decodificação da Instrução - Recebe a instrução e decodificação para a continuação do programa
	-- Sinais responsaveis pela decodificação da instrução
	
	signal PC_plus4:	std_logic_vector(0 to 31); -- Sinal responsavel por receber o PC + 4
	
	signal RegWrite:	std_logic; -- Sinal do RegWrite - Responsavel pelo controle de escrita ou não do registrador.
	signal instrucao:	std_logic_vector(0 to 31); -- Responsavel por receber a instrução que será decoficada
	signal OPCode:		std_logic_vector(0 to 5); -- Recebe o OPCode
	signal Read_Register_1:		std_logic_vector(0 to 4); -- Responsavel por receber os bits correspondentes ao RS
	signal Read_Register_2:		std_logic_vector(0 to 4); -- Responsavel por receber os bits correspondentes ao RT
	signal Write_Register:		std_logic_vector(0 to 4); -- Responsavel por receber os bits correspondentes ao RD
	signal Write_Data:			std_logic_vector(0 to 31); -- Responsavel por receber os bits correspondentes a escrita, se necessario, após toda a operação
	signal Read_Data_1:			std_logic_vector(0 to 31); -- Saida dos dados do Registrador 1, correspondete ao RS
	signal Read_Data_2:			std_logic_vector(0 to 31); -- Saida dos dados do Registrador 2, correspondete ao RT
	
	signal imed:				std_logic_vector(0 to 15); -- Sinal Imediato para as operações
	signal imed_extended_ID:	std_logic_vector(0 to 31); -- Imediato extendido para operação
	
	signal Jump_imed_x_quatro:	std_logic_vector(0 to 31); -- ?
	signal JumpType:			std_logic; -- ?
	
	signal Rt_ID:				std_logic_vector(0 to 4); -- Entrada do RT no registrador ID
	signal Rd_ID:				std_logic_vector(0 to 4); -- Entrada do RD no registrador ID
	
	signal verificaPC_0:		std_logic_vector(0 to 31); -- ?
	signal verificaPC_1:		std_logic_vector(0 to 31); -- ?
	signal SinalBranch:			std_logic; -- Responsavel por indicar se a operação é um branch ou não
	
	signal controle_WB_ID:		std_logic_vector(0 to 1); -- Controle do WB para o Registrador de pipeline ID/EX
	signal controle_ME_ID:		std_logic_vector(0 to 2); -- Controle do MEM para o Registrador de pipeline ID/EX
	signal controle_EX_ID:		std_logic_vector(0 to 3); -- Controle do EX para o Registrador de pipeline ID/EX
	
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Execução da Instrução
	-- Sinais responsaveis pela execução da operação
	
	signal imediate_extended_EX: std_logic_vector(0 to 31); -- Imediato extendido na etapa de execução
	signal PC_plus4_EX:			 std_logic_vector(0 to 31); -- Pc mais 4 na etapa de execução
	signal imed_ext_x_quatro:	 std_logic_vector(0 to 31); -- ?
	signal Branch_addr:			 std_logic_vector(0 to 31); -- Calculo do Branch com a ajuda do somador responsavel
	
	signal ULA_Src_A:		std_logic_vector(0 to 31); -- Entrada A na ULA - Vem do Read_Data_1
	signal ULA_Src_B:		std_logic_vector(0 to 31); -- Entrada B da ULA - Depende do resultado do ALUSrc
	signal ULA_Resultado:	std_logic_vector(0 to 31); -- Resultado da ULA
	signal ULA_Zero:		std_logic; -- Saida zero da ULA
	
	signal ALUSrc:				std_logic; -- Controle da entrada B na ULA - Controle do Multiplexador
	signal ALUScr_0:			std_logic_vector(0 to 31); -- Entrada 0 do multiplexador controlado pelo ALUSrc
	signal ALUScr_1:			std_logic_vector(0 to 31); -- Entrada 0 do multiplexador controlado pelo ALUSrc
	signal ULA_Operation:		std_logic_vector(0 to 1); -- Responsavel pelo controle de qual operação vai ser feita na ULA
	
	signal RegDst:				std_logic; -- Sinal de controle representando o RegDst
	signal regDst_0:			std_logic_vector(0 to 4); -- Entrada 0 do multiplexador controlado pelo RegDst
	signal regDst_1:			std_logic_vector(0 to 4); -- Entrada 1 do multiplexador controlado pelo RegDst
	signal regDst_Saida:		std_logic_vector(0 to 4); -- Saida do multiplexador controlado pelo RegDst
	
	signal controle_WB_EX:			std_logic_vector(0 to 1);  -- Sinal de controle do WB na etapa do registrador EX/MEM
	signal controle_ME_EX:			std_logic_vector(0 to 2); -- Sinal de controle do MEM na etapa do registrador EX/MEM
	signal controle_EX_EX:			std_logic_vector(0 to 3); -- Sinal de controle do EX na etapa do registrador EX/MEM
	
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Sinais da Memoria
	-- Declaração dos sinais responsaveis por salvar a operação feita pelo sistema (ULA) na memoria de dados
	
	signal endereco_MEM:			std_logic_vector(0 to 31); -- Endereço de memoria onde o dado vai ser salvo
	signal memWrite:				std_logic; -- Sinal de controle representando o memWrite
	signal writeData_MEM:		std_logic_vector(0 to 31); -- Entrada da memoria de dados, vem da saida do Read_Data_2, após passar por dois registradores(ID/EX e EX/MEM)
	signal memRead:				std_logic;  -- Sinal de controle representando o memRead
	signal readData_MEM:			std_logic_vector(0 to 31); -- Saida da memoria de dados || Entrada do registrador MEM/WB
	
	signal andBranch_0:			std_logic; -- Entrada 0 do AND responsavel por calcular se é um Branch ou não
	signal andBranch_1:			std_logic; -- Entrada 1 do AND responsavel por calcular se é um Branch ou não || Saida Zero da ULA
	
	signal regDst_MEM:			std_logic_vector(0 to 4); -- Controle do multiplexador responsavel pela entrada de dados no registrador EX/MEM
	
	signal controle_WB_ME:			std_logic_vector(0 to 1); -- Sinal de controle do WB na etapa do registrador MEM/WB 
	signal controle_ME_ME:			std_logic_vector(0 to 2); -- Sinal de controle do ME na etapa do registrador MEM/WB 
	
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Sinais Writeback
	
	signal memtoReg_mux0:		std_logic_vector(0 to 31); -- Entrada 0 do multiplexador responsavel pelo controle de Escrita no Registrador
	signal memtoReg_mux1:		std_logic_vector(0 to 31); -- Entrada 1 do multiplexador responsavel pelo controle de Escrita no Registrador
	signal memToReg:			std_logic;  -- Sinal de controle representando o memToReg
	
	signal controle_WB_WB:			std_logic_vector(0 to 1); -- Sinal de controle do WB na etapa de saida do registrador MEM/WB
	
begin 

	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Sinais para WaveForm
	
	pcAtual <= instrucaoPC;
	instrucAtual <= instrucao_IF_ID;
	
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Componentes Fetch Da Instrução
	Instruction_Memory:	InstructionMemory port map (instrucaoPC, instrucao_IF_ID); -- OK
	PC4:	AdderBranch	port map (instrucaoPC, "00000000000000000000000000000100", PCSrc_0); -- OK
	MuxBranch: Muxs_32bits port map (SinalBranch, PCSrc_0, PCSrc_1, verificaPC_0); -- OK
	ProgramCounter:	PC	port map (clock, atualizaPC, instrucaoPC); -- OK
	
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Registrador IF/ID
	
		Reg_IF_ID:	IF_ID	port map (clock, PCSrc_0, PC_plus4, instrucao_IF_ID, instrucao); -- OK
		
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Declaração das intruções de Decodificação
	OPCode				<= instrucao( 0 to  5);
	Read_Register_1	<= instrucao( 6 to 10);
	Read_Register_2	<= instrucao(11 to 15);
	imed				<= instrucao(16 to 31);
	Rt_ID					<= instrucao(11 to 15);
	Rd_ID					<= instrucao(16 to 20);
	
	Registradores:	Registers	port map (RegWrite, clock, Read_Register_1, Read_Register_2, Write_Register, Write_Data, Read_Data_1, Read_Data_2); -- OK
	Sing_Extend:	SignExtend		port map (imed, imed_extended_ID); -- OK
	MuxPCSrc:	Muxs_32bits	 port map (PCSrc, verificaPC_0, verificaPC_1, atualizaPC); -- OK
	shift_jump:	ShiftLeft2 port map (instrucao, Jump_imed_x_quatro); -- OK
	
	ControlUnity: UnidadeControle port map (OPCode, PCSrc, controle_EX_ID, controle_ME_ID, controle_WB_ID); -- OK
	
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Registrador ID/EX
	
	Reg_ID_EX:	ID_EX	port map (clock, controle_WB_ID, controle_ME_ID, controle_EX_ID,
								controle_WB_EX, controle_ME_EX, controle_EX_EX, 
								PC_plus4, PC_plus4_EX, Read_Data_1, ULA_Src_A,
								Read_Data_2, ALUScr_0, imed_extended_ID, imediate_extended_EX,
								Rt_ID, regDst_0, Rd_ID, regDst_1); -- OK
 
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Componentes necessarios para a execução do programa
	
	CalculoBranch:	AdderBranch	port map (PC_plus4_EX, imed_ext_x_quatro, Branch_addr); -- OK
	ALU: ULA	port map (ULA_Src_A, ULA_Src_B, ULA_Operation, ULA_Resultado, ULA_Zero); -- OK
	MuxALUSrc:	Muxs_32bits	port map (ALUSrc, ALUScr_0, ALUScr_1, ULA_Src_B); -- OK
	Mux_RegDst:	MuxRegDst	port map (RegDst, regDst_0, regDst_1, regDst_Saida); -- OK
	ShiftEX: ShiftLeft2	port map (imediate_extended_EX, imed_ext_x_quatro); -- OK
	
	ALUScr_1 <= imediate_extended_EX;
	
	process(controle_EX_EX)
	begin
		ALUSrc <= controle_EX_EX(0);
		ULA_Operation <= controle_EX_EX(1 to 2);
		RegDst <= controle_EX_EX(3);
	end process;

	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Registrador EX/MEM

	Reg_EX_MEM:	EX_MEM	port map (clock, controle_WB_EX, controle_ME_EX,
								controle_WB_ME, controle_ME_ME,
								Branch_addr, PCSrc_1, ULA_Zero, andBranch_1,
								ULA_Resultado, endereco_MEM, ALUScr_0, writeData_MEM,
								regDst_Saida, regDst_MEM); -- OK
												
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Declaração dos componentes da Memoria de Dados
	
	Data_Memory: DataMemory port map (endereco_MEM, writeData_MEM, readData_MEM, clock, memWrite, memRead); -- OK
	
	memWrite <= controle_ME_ME(0);
	memRead <= controle_ME_ME(1);
	andBranch_0 <= controle_ME_ME(2);
	SinalBranch <= andBranch_0 and andBranch_1;
	
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Registrador MEM/WB
	Reg_MEM_WB:	MEM_WB	port map (clock, controle_WB_ME, controle_WB_WB,
								readData_MEM, memtoReg_mux1,
								endereco_MEM, memtoReg_mux0, regDst_MEM, Write_Register); -- OK
	
	--------------------------------------------------------------------------------------------------
	
	--------------------------------------------------------------------------------------------------
	-- Declaração do funcionamento do WriteBack
	
	MuxMEMtoReg:	MUXs_32bits	port map	(MemToReg, memtoReg_mux0, memtoReg_mux1, Write_Data); -- OK
	
	MemToReg <= controle_WB_WB(0);
	RegWrite <= controle_WB_WB(1);
end;