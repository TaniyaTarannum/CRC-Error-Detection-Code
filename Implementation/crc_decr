library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity crc_decr is
    Port ( 
           data_r : in STD_LOGIC_VECTOR (7 downto 0);
           add:in STD_LOGIC_VECTOR (7 downto 0);
           crc_check : out STD_LOGIC);           
end crc_decr;

architecture Behavioral of crc_decr is
    constant poly: STD_LOGIC_VECTOR(8 downto 0) := "111010101";
    signal check: STD_LOGIC;
    signal code: STD_LOGIC_VECTOR(15 downto 0);
begin
    process(data_r,add)
        variable temp_dividend: STD_LOGIC_VECTOR(15 downto 0);
        variable val:STD_LOGIC;
    begin
        temp_dividend := data_r & add;
--use modulo 2 division for the received data
        for i in 0 to 7 loop
            if temp_dividend(15) = '1' then
                temp_dividend(15 downto 7) := temp_dividend(15 downto 7) xor poly;
            end if;
            temp_dividend(15 downto 1) := temp_dividend(14 downto 0);
            temp_dividend(0) := '0';
        end loop;   

        if temp_dividend/= "0000000000000000" then
            val := '0';
        else 
            val := '1';
        end if;
        check<=val;
    end process;

    crc_check <= check;

end Behavioral;
