library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity uart is
port(
		clk_in:in std_logic;
		rTS:in std_logic;
		clk_in_325:in std_logic;
		rxd_in: in std_logic;
		rxd_out:out std_logic_vector(7 downto 0)		
);
end uart;

architecture a of uart is
signal rec_sig:std_logic_vector(8 downto 0):="000000000";
signal ck:std_logic_vector(9 downto 0):="0000000000";
signal ck_st:std_logic_vector(3 downto 0):="0000";
signal a,g,h:std_logic_vector(3 downto 0):="0000";
signal k:std_logic_vector(1 downto 0):="01";
signal d:std_logic:='1';
signal e:std_logic:='0';
signal b,c,i,j:std_logic:='0';   
begin
process(clk_in,clk_in_325,b,e,i)
	begin
			if clk_in_325'event and clk_in_325='1' then
				case j is
					when '0'=>
						if rxd_in='0' then
							j<='1';
						end if;
					when '1'=>
						if k="01" then 
							b<='1';
						end if;
						k<="10";
				end case;
				if c='1' then
					b<='0';
					e<='1';
				end if;
			end if;
			if b='1' then 
				if clk_in'event and clk_in='1' then
					a<=a+1;
					if a="0100" then 
						d<=rxd_in;
						a<="0000"; 
						if d='0' then
							d<='1';
							c<='1';
						end if;
					end if;
				end if;
			end if;
			if e='1' then
				c<='0';
				if clk_in'event and clk_in='1' then
					g<=g+1;
					if g="1000" then 
						rec_sig<=rxd_in & rec_sig(8 downto 1);
						g<="0000";
						h<=h+1;
						if h="1001" then
							h<="0000";
								if rec_sig(8)='1' then 
									rxd_out<=rec_sig(7 downto 0);
								end if;
								i<='1';
						end if;
					end if;
				end if;
			end if;
			if i='1' then 
				e<='0';
				k<="01";
				j<='0';
				i<='0';	
			end if;
end process;
end a;