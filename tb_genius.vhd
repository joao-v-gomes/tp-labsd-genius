library IEEE;
use IEEE.std_logic_1164.all;

entity tb_genius is
end tb_genius;

architecture teste of tb_genius is

component genius is
   
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
end component;

signal e_azul, e_amarelo, e_verde, e_vermelho, e_ligado : std_logic;
signal l_azul, l_amarelo, l_verde, l_vermelho, l_ligado : std_logic;
signal clk : std_logic;

begin

instance_genius: genius port map(
		CLK => clk,

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

e_ligado <= '0', '1' after 5ns,'0' after 8ns, '1' after 10ns;

e_azul <= '0', '1' after 2ns, '0' after 4ns, '1' after 11ns;
e_amarelo <= '0', '1' after 4ns, '0' after 6ns, '1' after 13ns;
e_verde <= '0', '1' after 6ns, '0' after 8ns, '1' after 15ns;
e_vermelho <= '0', '1' after 8ns, '0' after 10ns, '1' after 17ns;




end teste;