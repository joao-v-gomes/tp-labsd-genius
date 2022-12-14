library IEEE;
use IEEE.std_logic_1164.all;

entity tb_genius is
end tb_genius;

architecture teste of tb_genius is

component genius is
   
    port (
		  botao_pressionado : out integer  := 0;
		  contador_jogada : out integer  := 0;
		  estado_fsm : out integer  := 0;
		  
		  trava_leitura_botao : out integer := 0;
		  
		  teste : out integer := 0;
		  
		  contador_entrada : out integer := 0;
		  
		  rodada : out integer := 0;
		  
		  contagem_certa : out integer :=  0;
		  contagem_errada : out integer := 0;
		  
		  CLOCK : in std_logic := '0';
		  
		  RESET : in std_logic;
		  
--		  modo_facil : in std_logic := '0';
--		  modo_dificil : in std_logic := '0';
		  
		  entrada_azul : in std_logic := '0';
		  entrada_amarelo : in std_logic := '0';
		  entrada_verde : in std_logic := '0';
		  entrada_vermelho : in std_logic := '0';
		  entrada_ligado : in std_logic := '0';
		  
		  led_azul : out std_logic := '0';
		  led_amarelo : out std_logic := '0';
		  led_verde : out std_logic := '0';
		  led_vermelho : out std_logic := '0';
		  led_ligado : out std_logic := '0'
    );
end component;

signal clock : std_logic;

signal reset : std_logic;

signal e_azul, e_amarelo, e_verde, e_vermelho, e_ligado : std_logic;
signal l_azul, l_amarelo, l_verde, l_vermelho, l_ligado : std_logic;

signal bot_pressionado : integer;
signal cont_jogada : integer;
signal est_fsm : integer;
signal cont_rodada : integer;
signal cont_entrada : integer;

signal trava_leitura_bot : integer;

signal cont_certa : integer;
signal cont_errada : integer;

signal comeca : integer;

begin

clockprcss: process
		begin
			clock <= '0';
			wait for 500ps;
			clock <= '1';
			wait for 500ps;
		end process;


instance_genius: genius port map(
		CLOCK => clock,
		RESET => reset,
		
		teste => comeca,

		botao_pressionado => bot_pressionado,
		contador_jogada => cont_jogada,
		estado_fsm => est_fsm,
		
		trava_leitura_botao => trava_leitura_bot,
		
		contador_entrada => cont_entrada,
		
		rodada => cont_rodada,
		
		contagem_certa => cont_certa,
		contagem_errada => cont_errada,
		
		entrada_azul => e_azul,
		entrada_amarelo => e_amarelo,
		entrada_verde => e_verde,
		entrada_vermelho => e_vermelho,
		entrada_ligado => e_ligado,
		
		led_azul => l_azul,
		led_amarelo => l_amarelo,
		led_verde => l_verde,
		led_Vermelho => l_vermelho,
		led_ligado => l_ligado
);

	e_ligado <= '0', '1' after 10ns, '0' after 12ns, '1' after 42ns, '0' after 45ns;

	teste_tb: process(est_fsm)
		begin
			if (est_fsm = 5) then
				case cont_entrada is
				
					when 1 | 5 | 9 | 13=>
						e_azul <= '1','0' after 3ns;
					
					when 2 | 6 | 10 |14=>
						e_amarelo <= '1','0' after 3ns;
--						e_azul <= '1','0' after 3ns;
					
					when 3 | 7 | 11 | 15=>
						e_verde <= '1','0' after 3ns;
--						e_azul <= '1','0' after 3ns;
					
					when 4 | 8 | 12=>
						e_vermelho <= '1','0' after 3ns;
					
					when others =>
--						e_azul <= '0';
--						e_amarelo <= '0';
--						e_verde <= '0';
--						e_vermelho <= '0';
						
				end case;
				
			end if;		
		end process;
	
--e_azul <= '0', '1' after 2ns, '0' after 4ns;
--e_amarelo <= '0', '1' after 4ns, '0' after 6ns;
--e_verde <= '0', '1' after 6ns, '0' after 8ns;
--e_vermelho <= '0', '1' after 8ns, '0' after 10ns;
--e_ligado <= '0', '1' after 10ns, '0' after 12ns;



end teste;