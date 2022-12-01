library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity genius is
   
    port (
		  
		  teste : out integer  := 0;
		  teste2 : out integer  := 0;
		  teste3 : out integer  := 0;
		  
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
		  entrada_ligado : in std_logic  := '0';
		  
		  led_azul : out std_logic  := '0';
		  led_amarelo : out std_logic  := '0';
		  led_verde : out std_logic  := '0';
		  led_vermelho : out std_logic  := '0';
		  led_ligado : out std_logic  := '0'
    );
end genius;

architecture arch of genius is

constant c_CLK_PERIOD : time := 10 ns;

type array_facil is array (8 downto 0) of integer range 0  to 5;
type array_dificil is array (15 downto 0) of integer range 0  to 5;

type statetype is ( INIT, PREPARA_JOGO, MOSTRA_COR, AGUARDA_ENTRADA, VERIFICA_ENTRADA, CONTINA_JOGO, FINALIZA_JOGO) ;
signal state, nextstate : statetype := INIT;

--signal jogo_ligado : std_logic := '0';
--signal 	var1 : array1Dc;

signal 	sequencia_facil : array_facil := (others => 0);
signal 	sequencia_dificil : array_dificil := (others => 0);


signal qual_botao : integer := 0;


signal var1 : array_facil := (others => 0);
signal cont : integer range 0 to 30 := 1;

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
		begin
			
			teste3 <= 0;
			
			case state is
				when INIT =>
--					qual_botao <= 0;
					cont_facil <= 0;
					cont_dificil <= 0;
					sequencia_facil <= (others => 0);
					sequencia_dificil <= (others => 0);
					teste3 <= 1;
					nextstate <= PREPARA_JOGO;
					
				when PREPARA_JOGO =>
					sequencia_facil(1) <= 1;
					sequencia_facil(2) <= 2;
					sequencia_facil(3) <= 3;
					sequencia_facil(4) <= 4;
					sequencia_facil(5) <= 5;
					sequencia_facil(6) <= 1;
					sequencia_facil(7) <= 2;
					sequencia_facil(8) <= 3;
					
					teste3 <= 2;
					
--					cont <= cont + 1;
					
					nextstate <= MOSTRA_COR;
					
				when MOSTRA_COR =>
					if (cont <= 8 ) then
						var_1 <= sequencia_facil(cont);
						cont <= cont + 1;
						nextstate <= MOSTRA_COR;
					else
						nextstate <= AGUARDA_ENTRADA;
					end if;
					
					teste3 <= cont;
					
				when AGUARDA_ENTRADA =>
--					wait for c_CLK_PERIOD/2;
--					nextstate <= INIT;
					sequencia_facil(1) <= 0;
					sequencia_facil(2) <= 0;
					sequencia_facil(3) <= 0;
					sequencia_facil(4) <= 0;
					sequencia_facil(5) <= 0;
					sequencia_facil(6) <= 0;
					sequencia_facil(7) <= 0;
					sequencia_facil(8) <= 0;
					
					teste3 <= 4;
					
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
			teste <= qual_botao;
			teste2 <= cont;
			
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