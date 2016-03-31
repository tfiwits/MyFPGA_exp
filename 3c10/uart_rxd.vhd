library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity uart_rxd is 
port(
		clk_in:in std_logic;
		rts:out std_logic;
		cts:in std_logic;
		ok:in std_logic;
		sw_in:in std_logic_vector(1 downto 0);
		rxd_in:in std_logic;
		cts_out:out std_logic;
		rxd_out:out std_logic_vector(7 downto 0)
);
end uart_rxd;

architecture rxd of uart_rxd is
 signal bo_1200,bo_2400,bo_4800,bo_9600,bo_19200,clk_sig:std_logic;
 signal rec_sig:std_logic_vector(8 downto 0):="000000000";
signal rec_tmp:std_logic_vector(7 downto 0):="00000000";
signal ck:std_logic_vector(9 downto 0):="0000000000";
signal ck_st:std_logic_vector(3 downto 0):="0000";
signal a,g,h:std_logic_vector(3 downto 0):="0000";
signal k:std_logic_vector(1 downto 0):="01";
signal d:std_logic:='1';
signal e:std_logic:='0';
signal b,c,i,j:std_logic:='0';    
	begin
		process(clk_in)
		variable st_1200:integer range 0 to 1100:=0;
		variable st_2400:integer range 0 to 550:=0;
		variable st_4800:integer range 0 to 270:=0;
		variable st_9600:integer range 0 to 135:=0;
			begin
				if clk_in'event and clk_in='1' then
					if st_1200=1100 then 
						st_1200:=0;
						bo_1200<=not bo_1200;
					else
						st_1200:=st_1200+1;
					end if;
					if st_2400=550 then 
						st_2400:=0;
						bo_2400<=not bo_2400;
					else
						st_2400:=st_2400+1;
					end if;
					if st_4800=270 then 
						st_4800:=0;
						bo_4800<=not bo_4800;
					else
						st_4800:=st_4800+1;
					end if;
					if st_9600=135 then 
						st_9600:=0;
						bo_9600<=not bo_9600;
					else
						st_9600:=st_9600+1;
					end if;
				end if;
		end process;
		
process(clk_in,clk_sig,b,e,i,ok)
	begin
			if clk_in'event and clk_in='1' then
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
				if clk_sig'event and clk_sig='1' then
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
				if clk_sig'event and clk_sig='1' then
					g<=g+1;
					if g="1000" then 
						rec_sig<=rxd_in & rec_sig(8 downto 1);
						g<="0000";
						h<=h+1;
						if h="1001" then
							h<="0000";
								if rec_sig(8)='1' then 
									rec_tmp<=rec_sig(7 downto 0);
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
			if ok='1' then 
				rec_tmp<="00000000";
			end if;
			rxd_out<=rec_tmp;
end process;
process(cts)
begin
	if cts='1' then 
		cts_out<='1';
	end if;
end process;
rts<='0';
with sw_in select
clk_sig<=bo_1200 when "00",
		bo_2400 when "01",
		bo_4800 when "10",
		bo_9600 when "11";
end rxd;