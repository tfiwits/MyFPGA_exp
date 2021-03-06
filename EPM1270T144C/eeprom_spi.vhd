library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity eeprom_spi is 
port(
		sw_in:in std_logic_vector(3 downto 0);
		addr:in std_logic_vector(6 downto 0);
		cs:  out std_logic;
		di: out std_logic;
		do: in std_logic;
		org: out std_logic;
		clk_in: in std_logic;
		data_out:out std_logic_vector(7 downto 0)
	);
end eeprom_spi;

architecture a of eeprom_spi is
 signal sta : std_logic_vector(3 downto 0):="1000";
 signal hh:std_logic:='0';
 signal st_a:std_logic_vector(8 downto 0):="000000000";
 signal di_tmp: std_logic_vector(21 downto 0);
 signal di_tmp_s: std_logic;
 signal data_in : std_logic_vector(15 downto 0);
 signal data_out_tmp:std_logic_vector(7 downto 0);
 signal chk:std_logic;
 --"000"READ
 --"001"ERASE
 --"010"WRITE
 --"011"EWEN
 --"100"EWDS
 --"101"ERAL
 --"110"WRAL
	begin
		process(sta,clk_in)
		variable st : integer:=21;
		variable do_st:integer:=8;
			begin
				if clk_in'event and clk_in='1' then 
					case sta is
						when "0000"=>
							cs<='1';
							di_tmp(21 downto 0)<=(di_tmp'range=>'0');
							di_tmp(21 downto 12)<="110" & addr;
							if st>11 then 
								di_tmp_s<=di_tmp(st);
								st:=st-1;
							else
								di_tmp_s<='0';
									if do_st<0 then
										data_out<=data_in(7 downto 0);
										cs<='0';
										st:=21;
										do_st:=8;
										sta<="0111";
									else
										data_in(do_st)<=do;
										do_st:=do_st-1;
									end if;
							end if;
						when "0001"=>
							cs<='1';
							di_tmp(21 downto 0)<=(di_tmp'range=>'0');
							di_tmp(21 downto 12)<="111" & addr;
							if st>11 then 
								di_tmp_s<=di_tmp(st);
								st:=st-1;
							else
								di_tmp_s<='0';
								cs<='0';
								st:=21; 
								sta<="0111";
							end if;
						when "0010"=>
							cs<='1';
							di_tmp(21 downto 0)<=(di_tmp'range=>'0');
							data_out_tmp<="10101010";
							di_tmp(21 downto 4)<="101" & addr & data_out_tmp;
							if st>3 then 
								di_tmp_s<=di_tmp(st);
								st:=st-1;
							else
								cs<='0';
								di_tmp_s<='0';
								st:=21;
								sta<="0111";
							end if;
						when "0011"=>
							cs<='1';
							di_tmp(21 downto 0)<=(di_tmp'range=>'0');
							di_tmp(21 downto 12)<="100" & "1100000";
							if st>11 then 
								di_tmp_s<=di_tmp(st);
								st:=st-1;
							else
								di_tmp_s<='0';
								cs<='0';
								st:=21;
								sta<="0111";
							end if;
						when "0100"=>
							cs<='1';
							di_tmp(21 downto 0)<=(di_tmp'range=>'0');
							di_tmp(21 downto 12)<="100" & "0000000";
							if st>11 then 
								di_tmp_s<=di_tmp(st);
								st:=st-1;
							else
								di_tmp_s<='0';	
								cs<='0';
								st:=21;
								sta<="0111";
							end if;
						when "0101"=>
							cs<='1';
							di_tmp(21 downto 0)<=(di_tmp'range=>'0');
							di_tmp(21 downto 12)<="100" & "1000000";
							if st>11 then 
								di_tmp_s<=di_tmp(st);
								st:=st-1;
							else
								di_tmp_s<='0';	
								cs<='0';
								st:=21;
								sta<="0111";
							end if;
						when "0110"=>
							cs<='1';
							di_tmp(21 downto 0)<=(di_tmp'range=>'0');
							di_tmp(21 downto 4)<="100" & "0100000" & data_out_tmp;
							if st>3 then 
								di_tmp_s<=di_tmp(st);
								st:=st-1;
							else
								di_tmp_s<='0';			
								cs<='0';			
								st:=21;
								sta<="0111";
							end if;
						when "0111"=>
							cs<='0';
							if st_a="111111111" then
								st_a<="000000000";
								sta<="1000"; 
							else
								st_a<=st_a+1;
							end if;
						when "1000"=>
							sta<=sw_in;
						when others=>
							null;
					end case;
				end if;
		end process;
di<=di_tmp_s;
org<='0';
end a;