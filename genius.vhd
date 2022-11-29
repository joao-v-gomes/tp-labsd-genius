library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity genius is
   
    port (
		  
		  teste : out integer;
		  teste2 : out integer;
		  
		  var_1 : out integer;
		  var_2 : out integer;
		  var_3 : out integer;
		  var_4 : out integer;
		  var_5 : out integer;
		  
		  CLK : in std_logic;
		  
		  entrada_azul : in std_logic := '0';
		  entrada_amarelo : in std_logic;
		  entrada_verde : in std_logic;
		  entrada_vermelho : in std_logic;
		  entrada_ligado : in std_logic;
		  
		  led_azul : out std_logic;
		  led_amarelo : out std_logic;
		  led_verde : out std_logic;
		  led_vermelho : out std_logic;
		  led_ligado : out std_logic
    );
end genius;

architecture arch of genius is

type array1Dc is array (5 downto 0) of integer range 0  to 5;

signal jogo_ligado : std_logic := '0';
signal 	var1 : array1Dc := (others => 0);
--signal 	var1 : array1Dc;

signal qual_botao : integer := 0;

signal cont : integer range 0 to 8 := 0;

begin

--	process de teste das entradas e saídas do jogo
	process(entrada_azul,entrada_amarelo,entrada_verde, entrada_vermelho,entrada_ligado)
--		variable cont : integer := 0;
		
		begin
			led_azul <= '0';
			led_amarelo <= '0';
			led_verde <= '0';
			led_vermelho <= '0';
			led_ligado <= '0';
--			
--			var1(0) <= 0;
--			var1(1) <= 1;
--			var1(2) <= 2;
--			var1(3) <= 3;
--			var1(4) <= 4;
			
--			teste <= 0;
			qual_botao <= 0;
			
				if (entrada_azul = '1') then
					led_azul <= '1';
					qual_botao <= 1;
					cont <= cont + 1;
					
				elsif (entrada_amarelo = '1') then
					led_amarelo <= '1';
					qual_botao <= 2;
					cont <= cont + 1;
					
				elsif (entrada_verde = '1') then
					led_verde <= '1';
					qual_botao <= 3;
					cont <= cont + 1;

				elsif (entrada_vermelho = '1') then
					led_vermelho <= '1';
					qual_botao <= 4;
					cont <= cont + 1;

				elsif (entrada_ligado = '1') then
					led_ligado <= '1';
					qual_botao <= 5;
					cont <= cont + 1;
					
				end if;
				

	end process;
	
	process(qual_botao,cont)
		begin
			teste <= qual_botao;
			teste2 <= cont;
			
			var1(cont) <= qual_botao;

--			if (cont = 1) then
--				var1(1) <= qual_botao;
--			elsif (cont = 2) then
--				var1(2) <= qual_botao;
--			elsif (cont = 3) then
--				var1(3) <= qual_botao;
--			elsif (cont = 4) then
--				var1(4) <= qual_botao;
--			elsif (cont = 5) then
--				var1(5) <= qual_botao;
--			end if;
			
	end process;
	
	process(var1(1),var1(2),var1(3),var1(4),var1(5))
		begin
			var_1 <= var1(1);
			var_2 <= var1(2);
			var_3 <= var1(3);
			var_4 <= var1(4);
			var_5 <= var1(5);
		end process;
		
end arch;