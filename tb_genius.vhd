library IEEE;
use IEEE.std_logic_1164.all;

entity tb_genius is
end tb_genius;

architecture teste of tb_genius is

component genius is
   
    port (
		  
		  teste : out integer;
		  teste2 : out integer;
		  teste3 : out integer;
		  
		  CLOCK : in std_logic;
		  
		  var_1 : out integer;
		  var_2 : out integer;
		  var_3 : out integer;
		  var_4 : out integer;
		  var_5 : out integer;
		  
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
end component;

signal clock : std_logic;

signal e_azul, e_amarelo, e_verde, e_vermelho, e_ligado : std_logic;
signal l_azul, l_amarelo, l_verde, l_vermelho, l_ligado : std_logic;

signal teste : integer;
signal teste2 : integer;
signal teste3 : integer;

signal var1 : integer;
signal var2 : integer;
signal var3 : integer;
signal var4 : integer;
signal var5 : integer;

begin

clockprcss: process
		begin
			clock <= '0';
			wait for 1ns;
			clock <= '1';
			wait for 1ns;
		end process;


instance_genius: genius port map(
		CLOCK => clock,

		teste => teste,
		teste2 => teste2,
		teste3 => teste3,
		
		var_1 => var1,
		var_2 => var2,
		var_3 => var3,
		var_4 => var4,
		var_5 => var5,
		
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

e_ligado <= '0';

--e_azul <= '0', '1' after 2ns, '0' after 4ns;
--e_amarelo <= '0', '1' after 4ns, '0' after 6ns;
--e_verde <= '0', '1' after 6ns, '0' after 8ns;
--e_vermelho <= '0', '1' after 8ns, '0' after 10ns;
--e_ligado <= '0', '1' after 10ns, '0' after 12ns;



end teste;