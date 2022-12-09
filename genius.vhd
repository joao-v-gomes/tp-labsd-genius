library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity genius is
   
    port (
			
		  CLOCK : in std_logic;
		  
		  RESET : in std_logic;
		  
		  botao_pressionado : out integer  := 0;
		  contador_jogada : out integer  := 0;
		  estado_fsm : out integer  := 0;
		  
		  teste : out integer := 0;
		  
		  trava_leitura_botao : out integer := 0;
		  
		  contador_entrada : out integer :=0;
		  
		  rodada : out integer := 0;
		  
		  contagem_certa : out integer := 0;
		  contagem_errada : out integer := 0;
		  
		  entrada_azul : in std_logic := '0';
		  entrada_amarelo : in std_logic  := '0';
		  entrada_verde : in std_logic  := '0';
		  entrada_vermelho : in std_logic  := '0';
		  entrada_ligado : in std_logic := '0';
		  
		  modo_facil : in std_logic := '1';
		  modo_dificil : in std_logic := '0';
		
		  led_azul : out std_logic  := '0'; -- Numero da Sequencia: 1
		  led_amarelo : out std_logic  := '0'; -- Numero da Sequencia: 2
		  led_verde : out std_logic  := '0'; -- Numero da Sequencia: 3
		  led_vermelho : out std_logic  := '0'; -- Numero da Sequencia: 4
		  led_ligado : out std_logic  := '0'
		  
    );
end genius;

architecture arch of genius is

constant c_CLK_PERIOD : time := 1ns;

type array_facil is array (8 downto 0) of integer range 0  to 5;
type array_dificil is array (15 downto 0) of integer range 0  to 5;

type statetype is ( INIT, PREPARA_JOGO, AGUARDA_PREPARA_JOGO, MOSTRA_COR, VERIFICA_MOSTRA_COR, AGUARDA_ENTRADA, LE_UMA_ENTRADA, NAO_LEU_NADA, VERIFICA_ENTRADA, CONTINUA_JOGO, FINALIZA_JOGO) ;
signal state, nextstate : statetype := INIT;

--signal jogo_ligado : std_logic := '0';
--signal 	var1 : array1Dc;

signal 	sequencia_facil_fpga : array_facil := (others => 0);
signal 	sequencia_dificil_fpga : array_dificil := (others => 0);

signal 	sequencia_facil_usuario : array_facil := (others => 0);
signal 	sequencia_dificil_usuario : array_dificil := (others => 0);

signal qual_botao : integer := 0;

--signal var1 : array_facil := (others => 0);

--signal cont : integer range 0 to 16 := 1;
signal cont_entrada : integer range 0 to 16 := 1;

signal cont_certo : integer range 0 to 16 := 0;
signal cont_errado : integer range 0 to 16 := 0;

signal cont_facil : integer range 0 to 9 := 0;
signal cont_dificil : integer range 0 to 16 := 0;

--signal flag_reset : std_logic := '0';

signal cont_jogada : integer range 0 to 9 := 1;
signal cont_rodada : integer range 0 to 9 := 1;

signal trava_leitura_bot : integer range 0 to 1 := 0;

signal comeca_jogo : integer range 0 to 1 := 0;

--signal trava_comeca_jogo : integer range 0 to 1 := 0;

begin

	teste <= comeca_jogo;

	contador_entrada <= cont_entrada;
	contagem_certa <= cont_certo;
	contagem_errada <= cont_errado;
	
	botao_pressionado <= qual_botao;
	contador_jogada <= cont_jogada;
	
	trava_leitura_botao <= trava_leitura_bot;
	
	rodada <= cont_rodada;

	statemachine_seq :process(CLOCK, entrada_ligado)
		begin
			if ( entrada_ligado = '1' and rising_edge(CLOCK) ) then
			
				state <= INIT;
--				comeca_jogo <= 0;
				
--				if (trava_comeca_jogo = 0) then
					comeca_jogo <= 1;
--					trava_comeca_jogo <= 1;
--				else
--					comeca_jogo <= 0;
--					trava_comeca_jogo <= 0;
--				end if;
--				comeca_jogo <= 1;
				
			elsif (rising_edge(CLOCK)) then
			
				state <= nextstate;
				
--				comeca_jogo <= 0;
--				trava_comeca_jogo <= 0;
--				comeca_jogo <= 0;

			end if;
	end process;

	statemachine_comb: process (state)
	
		variable cont_c : integer range 0 to 9 := 0;
		variable cont_e : integer range 0 to 9 := 0;
	
		begin
			
			case state is
				when INIT =>
				
					led_ligado <= '0';
					
					led_azul <= '0';
					led_amarelo <= '0';
					led_verde <= '0';
					led_vermelho <= '0';
					
					cont_facil <= 1;
					cont_dificil <= 1;
					
					cont_certo <= 0;
					cont_errado <= 0;
					
					cont_c := 0;
					cont_e := 0;
					
--					cont <= 0;
					
					sequencia_facil_fpga <= (others => 0);
					sequencia_dificil_fpga <= (others => 0);
					sequencia_facil_usuario <= (others => 0);
					sequencia_dificil_usuario <= (others => 0);
					
					cont_entrada <= 1;
					
					cont_rodada <= 1;
					cont_jogada <= 0;
					
--					if (comeca_jogo = 1) then 
--						nextstate <= PREPARA_JOGO;
--					else
--						nextstate <= INIT;
--					end if;

					nextstate <= AGUARDA_PREPARA_JOGO;
					
					estado_fsm <= 1;
					
				when AGUARDA_PREPARA_JOGO =>
					if (comeca_jogo = 1) then 
						nextstate <= PREPARA_JOGO;
					else
						nextstate <= INIT;
					end if;
					
					estado_fsm <= 11;
					
				when PREPARA_JOGO =>
				
					led_ligado <= '1';
				
					if (modo_facil = 1) then
						sequencia_facil_fpga(1) <= 1;
						sequencia_facil_fpga(2) <= 2;
						sequencia_facil_fpga(3) <= 3;
						sequencia_facil_fpga(4) <= 4;
						sequencia_facil_fpga(5) <= 1;
						sequencia_facil_fpga(6) <= 2;
						sequencia_facil_fpga(7) <= 3;
						sequencia_facil_fpga(8) <= 4;
					elsif (modo_dificil = 1) then
						
					
--					cont_rodada <= cont_rodada + 1;
					
--					rodada <= cont_rodada;
					
					estado_fsm <= 2;
					
					nextstate <= MOSTRA_COR;
					
				when MOSTRA_COR =>
				
					led_azul <= '0';
					led_amarelo <= '0';
					led_verde <= '0';
					led_vermelho <= '0';
				
					case sequencia_facil_fpga(cont_jogada) is
						when 1 =>
							led_azul <= '1';
						when 2 =>
							led_amarelo <= '1';
						when 3 =>
							led_verde <= '1';
						when 4 =>
							led_vermelho <= '1';
						
						when others =>
							nextstate <= INIT;
					end case;
				
--					var_1 <= sequencia_facil_fpga(cont);

--					wait for 3ns;
					
					nextstate <= VERIFICA_MOSTRA_COR after (c_CLK_PERIOD*5);
					
					estado_fsm <= 3;
					
				when VERIFICA_MOSTRA_COR =>
					if (cont_jogada < cont_rodada ) then
						cont_jogada <= cont_jogada + 1;
						nextstate <= MOSTRA_COR;
					else
						
						led_azul <= '0';
						led_amarelo <= '0';
						led_verde <= '0';
						led_vermelho <= '0';
					
						nextstate <= AGUARDA_ENTRADA;
					end if;
					
					estado_fsm <= 4;
				
				when AGUARDA_ENTRADA =>
					
					case qual_botao is
						when 0 =>
--							led_azul <= '0';
--							led_amarelo <= '0';
--							led_verde <= '0';
--							led_vermelho <= '0';
							
							nextstate <= NAO_LEU_NADA;
							
							trava_leitura_bot <= 0;
							
						when 1 =>
							if(trava_leitura_bot = 0) then
								sequencia_facil_usuario(cont_entrada) <= 1;
								
								led_azul <= '1';
								led_amarelo <= '0';
								led_verde <= '0';
								led_vermelho <= '0';
								
								cont_entrada <= cont_entrada + 1;
								nextstate <= LE_UMA_ENTRADA after (c_CLK_PERIOD*5);
								
								trava_leitura_bot <= 1;
							else
								nextstate <= NAO_LEU_NADA;
							end if;
						when 2 =>
							sequencia_facil_usuario(cont_entrada) <= 2;
							
							led_amarelo <= '1';
							led_azul <= '0';
							led_verde <= '0';
							led_vermelho <= '0';
							
							cont_entrada <= cont_entrada + 1;
							nextstate <= LE_UMA_ENTRADA after (c_CLK_PERIOD*5);
						when 3 =>
							sequencia_facil_usuario(cont_entrada) <= 3;
							
							led_verde <= '1';
							led_azul <= '0';
							led_amarelo <= '0';
							led_vermelho <= '0';
							
							cont_entrada <= cont_entrada + 1;
							nextstate <= LE_UMA_ENTRADA after (c_CLK_PERIOD*5);
						when 4 =>
							sequencia_facil_usuario(cont_entrada) <= 4;
							
							led_vermelho <= '1';
							led_azul <= '0';
							led_amarelo <= '0';
							led_verde <= '0';
							
							cont_entrada <= cont_entrada + 1;
							nextstate <= LE_UMA_ENTRADA after (c_CLK_PERIOD*5);
						when others =>
							nextstate <= NAO_LEU_NADA;
--							nextstate <= NAO_LEU_NADA after (c_CLK_PERIOD*10);
					end case;

					estado_fsm <= 5;

				when NAO_LEU_NADA =>
					nextstate <= AGUARDA_ENTRADA;
					
					estado_fsm <= 61;

				when LE_UMA_ENTRADA =>
				
					led_azul <= '0';
					led_amarelo <= '0';
					led_verde <= '0';
					led_vermelho <= '0';
				
				
					if(cont_entrada <= cont_rodada) then
--						cont_entrada <= cont_entrada + 1;
--						nextstate <= AGUARDA_ENTRADA  after (c_CLK_PERIOD*5);
						nextstate <= AGUARDA_ENTRADA;
					else
--						nextstate <= VERIFICA_ENTRADA after (c_CLK_PERIOD*5);
						nextstate <= VERIFICA_ENTRADA;
						
					end if;
					
					estado_fsm <= 62;
					
				when VERIFICA_ENTRADA =>
				
					led_azul <= '0';
					led_amarelo <= '0';
					led_verde <= '0';
					led_vermelho <= '0';
					
					trava_leitura_bot <= 0;
					
					verifica: for i in 1 to 8 loop
						if (i <= cont_rodada) then
							if(sequencia_facil_fpga(i) = sequencia_facil_usuario(i)) then
								cont_c := cont_c + 1;
							else
								cont_e := cont_e + 1;
							end if;
						end if;
						
					end loop verifica;
				
				
					cont_certo <= cont_c;
					cont_errado <= cont_e;
					
					if(cont_e > 0) then
						nextstate <= FINALIZA_JOGO;
					else
						nextstate <= CONTINUA_JOGO;
					end if;
			
					estado_fsm <= 7;
					
				when CONTINUA_JOGO =>
				
					led_azul <= '0';
					led_amarelo <= '0';
					led_verde <= '0';
					led_vermelho <= '0';
					
					cont_rodada <= cont_rodada + 1;
					
--					rodada <= cont_rodada;

					cont_certo <= 0;
					cont_errado <= 0;
					
					cont_c := 0;
					cont_e := 0;
					
					cont_entrada <= 1;
					
					cont_jogada <= 0;
					
					if(cont_rodada < 8) then
						nextstate <= MOSTRA_COR;
					else 
						nextstate <= FINALIZA_JOGO;
					end if;
				
				
					estado_fsm <= 8;
					
				when FINALIZA_JOGO =>
				
--					led_azul <= '1';
--					led_amarelo <= '1';
--					led_verde <= '1';
--					led_vermelho <= '1';
					led_ligado <= '0';
					
					estado_fsm <= 9;
					
				when others =>
					nextstate <= INIT;
					
			end case;
		end process;
					
					
--	process de teste das entradas e saídas do jogo
	process(entrada_azul, entrada_amarelo, entrada_verde, entrada_vermelho)
		
		begin
			
				if (entrada_azul = '1') then
					qual_botao <= 1;
					
				elsif (entrada_amarelo = '1') then
					qual_botao <= 2;
					
				elsif (entrada_verde = '1') then
					qual_botao <= 3;

				elsif (entrada_vermelho = '1') then
					qual_botao <= 4;

--				elsif (entrada_ligado = '1') then
--					qual_botao <= 5;
--					comeca_jogo <= 1;
				else
					qual_botao <= 0;
--					comeca_jogo <= '0';
					
				end if;
				
	end process;

--	process(qual_botao,cont)
--		begin
--			botao_pressionado <= qual_botao;
--			contador_jogada <= cont_jogada;
--			
----			var1(cont) <= qual_botao;
--			
--	end process;
	
--	process(var1(1),var1(2),var1(3),var1(4),var1(5))
--		begin
--			var_1 <= var1(1);
--			var_2 <= var1(2);
--			var_3 <= var1(3);
--			var_4 <= var1(4);
--			var_5 <= var1(5);
--		end process;
		
end arch;