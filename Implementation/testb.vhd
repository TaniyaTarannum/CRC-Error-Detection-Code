library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testb is
--  Port ( );
end testb;

architecture Behavioral of testb is
component  main_crc
Port ( 
           data : in STD_LOGIC_VECTOR (7 downto 0);
           data_r:in STD_LOGIC_VECTOR (7 downto 0);
           crc : out STD_LOGIC_VECTOR (7 downto 0);
           valid: out STD_LOGIC);
           end component;
           

signal data : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal data_r : STD_LOGIC_VECTOR(7 downto 0);
signal crc : STD_LOGIC_VECTOR(7 downto 0);
signal valid:STD_LOGIC;

begin
uut:main_crc port map(

data=>data,
data_r=>data_r,

crc=>crc,
valid=>valid
);

stim:process
begin
data<="00101011";
data_r<="00101011";
wait for 250us;
data<="10010011";
data_r<="10110011";
wait for 100us;
data<="00110101";
data_r<="00111101";
wait for 100us;
data<="10101100";
data_r<="10101100";
wait for 100us;

end process;


end Behavioral;
