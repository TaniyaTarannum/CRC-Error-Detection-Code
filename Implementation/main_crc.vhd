library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main_crc is
 Port (
           data : in STD_LOGIC_VECTOR (7 downto 0);
           data_r:in STD_LOGIC_VECTOR (7 downto 0);
           crc : out STD_LOGIC_VECTOR (7 downto 0);
           valid : out STD_LOGIC);
end main_crc;

architecture Behavioral of main_crc is
signal code:STD_LOGIC_VECTOR (7 downto 0);
component crc_enc 
Port ( 
 
          data : in STD_LOGIC_VECTOR (7 downto 0);
           crc : out STD_LOGIC_VECTOR (7 downto 0));  
end component;
component crc_decr
Port ( data_r : in STD_LOGIC_VECTOR (7 downto 0);
           add:in STD_LOGIC_VECTOR (7 downto 0);
           crc_check : out STD_LOGIC);   
end component; 
begin
S1:crc_enc port map(data=>data,crc=>code);
S2:crc_decr port map(data_r=>data_r,add=>code,crc_check=>valid);
crc<=code;
end Behavioral;
