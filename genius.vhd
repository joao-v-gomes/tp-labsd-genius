library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity genius is
   
    port (
		  
		  CLK : in std_logic;
		  
		  entrada_azul : in std_logic;
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

signal jogo_ligado : std_logic := '0';

begin
--	process de teste das entradas e saídas do jogo
	process(entrada_azul,entrada_amarelo,entrada_verde, entrada_vermelho)
		
		variable var1 : unsigned(5 downto 0);
		
		
	
	
		begin
			led_azul <= '0';
			led_amarelo <= '0';
			led_verde <= '0';
			led_vermelho <= '0';
			led_ligado <= '0';
			
			var1(0) := '0';
			var1(1) := '1';
			var1(2) := '2';
			var1(3) := '3';
			var1(4) := '4';
			
			
			
			if (jogo_ligado = '1') then
			
				if (entrada_azul = '1') then
					led_azul <= '1';
				end if;
				
				if (entrada_amarelo = '1') then
					led_amarelo <= '1';
				end if;
				
				if (entrada_verde = '1') then
					led_verde <= '1';
				end if;
				
				if (entrada_vermelho = '1') then
					led_vermelho <= '1';
				end if;
				
	--			if(entrada_ligado = '1') then
	--				led_ligado <= '1';
	--			end if;
			end if;
	end process;
	
	process(entrada_ligado)
		begin
			if(jogo_ligado = '1') then
				jogo_ligado <= '0';
			else 
				jogo_ligado <= '1';
			end if;
	end process;
end arch;