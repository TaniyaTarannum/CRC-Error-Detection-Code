library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity crc_enc is
    Port ( 
           data : in STD_LOGIC_VECTOR (7 downto 0);
           crc : out STD_LOGIC_VECTOR (7 downto 0));           
end crc_enc;

architecture Behavioral of crc_enc is
    constant poly: STD_LOGIC_VECTOR(8 downto 0) := "111010101";
    signal crc_sig: STD_LOGIC_VECTOR(7 downto 0) := "00000000";
begin
    process(data)
        variable temp_dividend: STD_LOGIC_VECTOR(8 downto 0);
    begin
        -- Initialize the dividend with input data and a 0 bit at the end
        temp_dividend := data & '0';

        -- Perform CRC calculation
        for i in 0 to 7 loop
            if temp_dividend(8) = '1' then
                temp_dividend := temp_dividend xor poly;
            end if;
            temp_dividend(8 downto 1) := temp_dividend(7 downto 0);
            temp_dividend(0) := '0';
        end loop;

        -- Extract the calculated CRC from the updated dividend
        crc_sig <= temp_dividend(8 downto 1);
       
    end process;

    -- Output the calculated CRC
    crc <= crc_sig;
    
end Behavioral;
