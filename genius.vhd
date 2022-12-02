library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity genius is
   
    port (
		  
		  botao_pressionado : out integer  := 0;
		  valor_contador : out integer  := 0;
		  estado_fsm : out integer  := 0;
		  
		  contagem_certa : out integer := 0;
		  contagem_errada : out integer := 0;
		  
		  var_1 : out integer := 0;
		  var_2 : out integer := 0;
		  var_3 : out integer := 0;
		  var_4 : out integer := 0;
		  var_5 : out integer := 0;
		  
		  CLOCK : in std_logic;
		  
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

constant c_CLK_PERIOD : time := 10 ns;

type array_facil is array (8 downto 0) of integer range 0  to 5;
type array_dificil is array (15 downto 0) of integer range 0  to 5;

type statetype is ( INIT, PREPARA_JOGO, MOSTRA_COR, VERIFICA_MOSTRA_COR, AGUARDA_ENTRADA, VERIFICA_ENTRADA, CONTINUA_JOGO, FINALIZA_JOGO) ;
signal state, nextstate : statetype := INIT;

--signal jogo_ligado : std_logic := '0';
--signal 	var1 : array1Dc;

signal 	sequencia_facil_fpga : array_facil := (others => 0);
signal 	sequencia_dificil_fpga : array_dificil := (others => 0);

signal 	sequencia_facil_usuario : array_facil := (others => 0);
signal 	sequencia_dificil_usuario : array_dificil := (others => 0);


signal qual_botao : integer := 0;


signal var1 : array_facil := (others => 0);
signal cont : integer range 0 to 30 := 1;

signal cont_certo : integer range 0 to 30 := 0;
signal cont_errado : integer range 0 to 30 := 0;

signal cont_facil : integer range 0 to 8 := 0;
signal cont_dificil : integer range 0 to 15 := 0;

signal flag_reset : std_logic := '0';

begin


	statemachine_seq :process(CLOCK, entrada_ligado)
		begin
			if ( entrada_ligado = '1' and rising_edge(CLOCK) ) then
				state <= INIT;
			elsif (rising_edge(CLOCK)) then
				state <= nextstate;
			end if;
	end process;

	statemachine_comb: process (state)
	
		variable cont_c : integer range 0 to 8 := 0;
		variable cont_e : integer range 0 to 8 := 0;
	
		begin
			
			case state is
				when INIT =>
				
					led_ligado <= '0';
					
					cont_facil <= 1;
					cont_dificil <= 1;
					
					sequencia_facil_fpga <= (others => 0);
					sequencia_dificil_fpga <= (others => 0);
					sequencia_facil_usuario <= (others => 0);
					sequencia_dificil_usuario <= (others => 0);
					
					nextstate <= PREPARA_JOGO;
					
					estado_fsm <= 1;
					
				when PREPARA_JOGO =>
				
					led_ligado <= '1';
				
					sequencia_facil_fpga(1) <= 1;
					sequencia_facil_fpga(2) <= 2;
					sequencia_facil_fpga(3) <= 3;
					sequencia_facil_fpga(4) <= 4;
					sequencia_facil_fpga(5) <= 1;
					sequencia_facil_fpga(6) <= 2;
					sequencia_facil_fpga(7) <= 3;
					sequencia_facil_fpga(8) <= 4;
					
					estado_fsm <= 2;
					
					nextstate <= MOSTRA_COR;
					
				when MOSTRA_COR =>
				
					led_azul <= '0';
					led_amarelo <= '0';
					led_verde <= '0';
					led_vermelho <= '0';
				
					case sequencia_facil_fpga(cont) is
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
				
					var_1 <= sequencia_facil_fpga(cont);
					
					cont <= cont + 1;
					
					nextstate <= VERIFICA_MOSTRA_COR;
					
					estado_fsm <= 3;
					
				when VERIFICA_MOSTRA_COR =>
					if (cont <= 8 ) then
						nextstate <= MOSTRA_COR;
					else
						nextstate <= AGUARDA_ENTRADA;
					end if;
					
					estado_fsm <= 4;
				
				when AGUARDA_ENTRADA =>
					led_azul <= '0';
					led_amarelo <= '0';
					led_verde <= '0';
					led_vermelho <= '0';
				
					sequencia_facil_usuario(1) <= 1;
					sequencia_facil_usuario(2) <= 2;
					sequencia_facil_usuario(3) <= 3;
					sequencia_facil_usuario(4) <= 4;
					sequencia_facil_usuario(5) <= 1;
					sequencia_facil_usuario(6) <= 3;
					sequencia_facil_usuario(7) <= 3;
					sequencia_facil_usuario(8) <= 3;
					
					estado_fsm <= 5;
					
					nextstate <= VERIFICA_ENTRADA;
					
				when VERIFICA_ENTRADA =>
					
					verifica: for i in 1 to 8 loop
						if(sequencia_facil_fpga(i) = sequencia_facil_usuario(i)) then
							cont_c := cont_c + 1;
						else
							cont_e := cont_e + 1;
						end if;
						
					end loop verifica;
				
				
					cont_certo <= cont_c;
					cont_errado <= cont_e;
					
					contagem_certa <= cont_c;
					contagem_errada <= cont_e;
					
					estado_fsm <= 6;
					
					nextstate <= CONTINUA_JOGO;
					
					
				when CONTINUA_JOGO =>
				
					estado_fsm <= 7;
					
				when others =>
					nextstate <= INIT;
					
			end case;
		end process;
					
					
--	process de teste das entradas e saídas do jogo
--	process(entrada_azul,entrada_amarelo,entrada_verde, entrada_vermelho)
--		
--		begin
--			led_azul <= '0';
--			led_amarelo <= '0';
--			led_verde <= '0';
--			led_vermelho <= '0';
--			led_ligado <= '0';
----			
----			var1(0) <= 0;
----			var1(1) <= 1;
----			var1(2) <= 2;
----			var1(3) <= 3;
----			var1(4) <= 4;
--		
--			qual_botao <= 0;
--			
--				if (entrada_azul = '1') then
--					led_azul <= '1';
--					qual_botao <= 1;
--					cont <= cont + 1;
--					
--				elsif (entrada_amarelo = '1') then
--					led_amarelo <= '1';
--					qual_botao <= 2;
--					cont <= cont + 1;
--					
--				elsif (entrada_verde = '1') then
--					led_verde <= '1';
--					qual_botao <= 3;
--					cont <= cont + 1;
--
--				elsif (entrada_vermelho = '1') then
--					led_vermelho <= '1';
--					qual_botao <= 4;
--					cont <= cont + 1;
--
--				elsif (entrada_ligado = '1') then
--					led_ligado <= '1';
--					qual_botao <= 5;
--					cont <= cont + 1;
--					
--				end if;
--				
--
--	end process;
	
	process(qual_botao,cont)
		begin
			botao_pressionado <= qual_botao;
			valor_contador <= cont;
			
--			var1(cont) <= qual_botao;
			
	end process;
	
--	process(var1(1),var1(2),var1(3),var1(4),var1(5))
--		begin
--			var_1 <= var1(1);
--			var_2 <= var1(2);
--			var_3 <= var1(3);
--			var_4 <= var1(4);
--			var_5 <= var1(5);
--		end process;
		
end arch;