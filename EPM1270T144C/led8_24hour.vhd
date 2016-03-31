library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity led8_24hour is 
port(
		key_in : in std_logic:='1';
		clk_in,clk_in_hi: in std_logic;
		led_com:out std_logic_vector(3 downto 0);
		led_out: out std_logic_vector(7 downto 0)
);
end led8_24hour;

architecture a of led8_24hour is
signal led_st : std_logic_vector(3 downto 0);
signal led_sig : std_logic_vector(3 downto 0):="0001";
signal led_s,led_t : std_logic_vector (3 downto 0);
signal led_sig_s,led_sig_t,led_sig_hs,led_sig_ht : std_logic_vector(3 downto 0);
	begin
		process(clk_in_hi)
			begin
				if clk_in_hi'event and clk_in_hi='1' then 
						led_sig<=led_sig(2 downto 0) & led_sig(3);
				end if;
		end process;
		
		process(clk_in,key_in)
			begin
					if clk_in'event and clk_in='1' then 
						led_s<=led_s+1;
							if led_s="1001" then 
								led_t<=led_t+1;
								led_s<="0000";
									if led_t="0101" and led_s="1001" then 
										led_sig_s<=led_sig_s+1;
										led_t<="0000";
											if led_sig_s="1001" then 
												led_sig_t<=led_sig_t+1;
												led_sig_s<="0000";
													if led_sig_t="0101" and led_sig_s="1001" then
														led_sig_hs<=led_sig_hs+1;
														led_sig_t<="0000";
														led_sig_s<="0000";
															if led_sig_hs="1001" then 
																led_sig_ht<=led_sig_ht+1;
																	if led_sig_hs="0100" and led_sig_ht="0011" then 
																		led_sig_hs<="0000";
																		led_sig_ht<="0000";
																		led_sig_s<="0000";
																		led_sig_t<="0000";
																	end if;
															end if;
													end if;
											end if;
									end if;
							end if;
					end if;					
				if key_in='0' then 
					led_sig_hs<="0000";
					led_sig_ht<="0000";
					led_sig_s<="0000";
					led_sig_t<="0000";
				end if;
		end process;
with led_sig select
led_st<=led_sig_s when "0001",
		 led_sig_t when "0010",
		 led_sig_hs when "0100",
		 led_sig_ht when "1000",
		 "1010" when others;
with led_st select
led_out<="10000001" when "0000",
		 "11001111" when "0001",
		 "10010010" when "0010",
		 "10000110" when "0011",
		 "11001100" when "0100",
		 "10100100" when "0101",
		 "11100000" when "0110",
		 "10001111" when "0111",
		 "10000000" when "1000",
		 "10001100" when "1001",
		 "01111111" when others;
led_com<=led_sig;
end a;
