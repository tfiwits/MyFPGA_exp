library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity two_led is 
port(
		clk_in:in std_logic;
		rst:in std_logic;
		led_out:out std_logic_vector(15 downto 0);
		led_com:out std_logic_vector(7 downto 0)
);
end two_led;

architecture a of two_led is
 signal clk_sig,clk_s_sig:std_logic;
 signal sw_in:std_logic_vector(1 downto 0):="01";
 signal clk_st,led_st:std_logic_vector(3 downto 0);
 signal all_st:std_logic_vector(2 downto 0);
 type led_all is array(0 to 63) of std_logic_vector(7 downto 0);
 constant led_all_sig:led_all:=(X"ff",X"ff",X"ff",X"ff",X"ff",X"ff",X"ff",X"ff",
X"FB",X"FD",X"FE",X"7F",X"FE",X"FD",X"FB",X"FF",
X"FD",X"FE",X"7F",X"BF",X"7F",X"FE",X"FD",X"FF",
X"FE",X"7F",X"BF",X"DF",X"BF",X"7F",X"FE",X"FF",
X"7F",X"BF",X"DF",X"EF",X"DF",X"BF",X"7F",X"FF",
X"BF",X"DF",X"EF",X"F7",X"EF",X"DF",X"BF",X"FF",
X"DF",X"EF",X"F7",X"FB",X"F7",X"EF",X"DF",X"FF",
X"EF",X"F7",X"FB",X"FD",X"FB",X"F7",X"EF",X"11");
 constant led_all_1_sig:led_all:=(X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF");
 constant led_all_2_sig:led_all:=(X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF");
 constant led_all_3_sig:led_all:=(X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF",X"DF",X"EF",X"F7",X"FB",X"F7",X"CF",X"BF",X"FF");
 signal img : std_logic_vector(3 downto 0):="0000";
 signal led_r_out:std_logic_vector(7 downto 0);
 signal led_g_out:std_logic_vector(7 downto 0);
 signal led_sig:std_logic_vector(7 downto 0);
 signal led_com_sig:std_logic_vector(7 downto 0):="00000001"; 
	begin
		process(clk_in)
			variable scan_hz:integer range 0 to 125000 :=0;
			variable scan_s:integer range 0 to 12500000 :=0;
			begin
				if clk_in'event and clk_in='1' then 
					if scan_hz=12500 then
						clk_sig<=not clk_sig;
						scan_hz:=0;
					else
						scan_hz:=scan_hz+1;
					end if;
					if scan_s=12500000 then 
						clk_s_sig<=not clk_s_sig;
						scan_s:=0;
					else
						scan_s:=scan_s+1;
					end if;
				end if;
		end process;
		process(clk_sig)
			variable led_clk:integer range 0 to 63 :=0;
			begin
				if clk_sig'event and clk_sig='1' then 
					if clk_st="1000" then
						case all_st is
							when "000"=>
								led_clk:=0;
							when "001"=>
								led_clk:=8;
							when "010"=>
								led_clk:=16;
							when "011"=>
								led_clk:=24;
							when "100"=>
								led_clk:=32;
							when "101"=>
								led_clk:=40;
							when "110"=>
								led_clk:=48;
							when "111"=>
								led_clk:=56;
						end case;
						clk_st<="0000";
					else
						case img is 
							when "0000"=>
								led_r_out<=led_all_sig(led_clk);
								led_g_out<=led_all_sig(led_clk);
							when "0001"=>
								led_r_out<=led_all_1_sig(led_clk);
								led_g_out<=led_all_1_sig(led_clk);
							when "0010"=>
								led_r_out<=led_all_2_sig(led_clk);
								led_g_out<=led_all_2_sig(led_clk);
							when "0011"=>
								led_r_out<=led_all_3_sig(led_clk);
								led_g_out<=led_all_3_sig(led_clk);
							when others=>
							null;
						end case;
						led_com_sig<=led_com_sig(6 downto 0) & led_com_sig(7);
						led_clk:=led_clk+1; 
						clk_st<=clk_st+1;
					end if;
				end if;
		end process;
		process(clk_s_sig)
			begin
				if clk_s_sig'event and clk_s_sig='1' then 
					if all_st="111" then 
						all_st<="000";
					else
						all_st<=all_st+1;
					end if;
				end if;
		end process;
		with sw_in select
		led_sig<=led_r_out when "01",
				 led_g_out when "10",
				 "11111111" when others;
		with sw_in select
		led_out<=led_sig & "11111111" when "01",
				 "11111111" & led_sig when "10",
				 led_r_out & led_g_out when "11",
				 "1111111111111111" when others; 
		led_com<=led_com_sig;
end a;