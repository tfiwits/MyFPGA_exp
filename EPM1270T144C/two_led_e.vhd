library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity two_led_e is
port(
		clk_in : in std_logic;
		key:in std_logic;
		sw_in: in std_logic_vector(1 downto 0);
		com: out std_logic_vector(7 downto 0);
		scan: out std_logic_vector(7 downto 0)
);
end two_led_e;

architecture a of two_led_e is
 signal st,st_t : std_logic_vector(3 downto 0):="0000"; 
 signal chk : std_logic;
 signal led_r,led_r_tmp,led_g,led_g_tmp,led_o: std_logic_vector(7 downto 0);
 signal led_o_tmp : std_logic_vector(7 downto 0):="11111100";
 signal com_tmp: std_logic_vector(7 downto 0);
	begin
		process(clk_in)
			  begin
				if clk_in'event and clk_in='1' then 
					if sw_in="01" and chk='1' then
						if st="1000" then 
							st<="0000";
							if st_t/="1000" then 
								st_t<=st_t+1;
							else
								st_t<="0000";
							end if;
						else
							com_tmp<=com_tmp(6 downto 0) & com_tmp(7);
							st<=st+1;
						end if;
					end if;
					if sw_in="10" and chk='1' then 
						if st="1000" then 
							st<="0000";
							if st_t/="1000" then 
								st_t<=st_t+1;
							else
								st_t<="0000";
							end if;
						else
							com_tmp<=com_tmp(0) & com_tmp(7 downto 1);
							st<=st+1;
						end if;
					end if;
					if sw_in="11" and chk='1' then
						led_o<=led_o_tmp;
						if st="1000" then 
							com_tmp<=com_tmp(6 downto 0) & com_tmp(7);
						else
							led_o_tmp<=led_o_tmp(5 downto 0) & led_o_tmp(7 downto 6);
							st<=st+1;
						end if;
					end if;
				end if;
		end process;
		process(sw_in)
			begin
				case sw_in is 
					when "00"=>
							
					when "01"=>
						chk<='0';
						if key='1' then
							chk<='1';
						end if;
					when "10"=>
						chk<='0';
						if key='1' then
							chk<='1';
						end if;
					when "11"=>
						chk<='0';
						if key='1' then
							chk<='1';
						end if;	
				end case;
		end process;
		with sw_in select 
		scan<="ZZZZZZZZ" when "00",
			  led_r when "01",
			  led_g when "10",
			  led_o when "11";
		with st_t select 
		led_r<=led_r_tmp when "0000",
			led_r_tmp(6 downto 0) & led_r_tmp(7)	  when "0001",
			led_r_tmp(5 downto 0) & led_r_tmp(7 downto 6)    when "0010",
			led_r_tmp(4 downto 0) & led_r_tmp(7 downto 5)	 when "0011",
			led_r_tmp(3 downto 0) & led_r_tmp(7 downto 4)    when "0100",
			led_r_tmp(2 downto 0) & led_r_tmp(7 downto 3)	 when "0101",
			led_r_tmp(1 downto 0) & led_r_tmp(7 downto 2)    when "0110",
			led_r_tmp(0) & led_r_tmp(7 downto 1)    when "0111",
			"11111111" when others;
		with st select 
		led_r_tmp<="11110111" when "0000",
				   "11101111" when "0001",
				   "11001111" when "0010",
				   "11000000" when "0011",
				   "11000000" when "0100",
				   "11001111" when "0101",
				   "11101111" when "0110",
				   "11110011" when "0111",
				   "11111111" when others;
		with st_t select 
		led_g<=led_g_tmp when "0000",
			led_g_tmp(6 downto 0) & led_g_tmp(7) when "0001",
			led_g_tmp(5 downto 0) & led_g_tmp(7 downto 6) when "0010",
			led_g_tmp(4 downto 0) & led_g_tmp(7 downto 5)  when "0011",
			led_g_tmp(3 downto 0) & led_g_tmp(7 downto 4)    when "0100",
			led_g_tmp(2 downto 0) & led_g_tmp(7 downto 3)	  when "0101",
			led_g_tmp(1 downto 0) & led_g_tmp(7 downto 2)    when "0110",
			led_g_tmp(0) & led_g_tmp(7 downto 1)    when "0111",
			"11111111" when others;
		with st select 
		led_g_tmp<="11011111" when "0000",
				   "11101111" when "0001",
					"11110111" when "0010",
				   "00000111" when "0011",
				   "00000111" when "0100",
				   "11110111" when "0101",
				   "11101111" when "0110",
				   "11011111" when "0111",
				   "11111111" when others;
		com<=com_tmp;
end a;