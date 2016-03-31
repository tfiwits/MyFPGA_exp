library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity t_led_rl is
 port(
		clk_in:in std_logic;
		rst:in std_logic;
		sw_in:in std_logic_vector(1 downto 0);
		clor:in std_logic;
		com:out std_logic_vector(7 downto 0);
		led_out:out std_logic_vector(15 downto 0)
);
end t_led_rl;

architecture con of t_led_rl is
signal n,s,dn,ds,ln,ls,rn,rs:integer range 0 to 7:=0;
signal clk_sig:std_logic;
signal clk_hz_sig:std_logic;
type img is array (0 to 7) of std_logic_vector(7 downto 0);
signal led_sig:std_logic_vector(7 downto 0);
signal img_r_sig:std_logic_vector(7 downto 0);
signal img_l_sig:std_logic_vector(7 downto 0);
signal led_l_sig:std_logic_vector(7 downto 0);
signal led_r_sig:std_logic_vector(7 downto 0);
signal com_u_sig:std_logic_vector(7 downto 0):="00000001";
signal com_d_sig:std_logic_vector(7 downto 0):="10000000";
signal com_r_sig:std_logic_vector(7 downto 0):="00000001";
signal com_l_sig:std_logic_vector(7 downto 0):="00000001";
signal img_sig:img:=(X"EF",X"C7",X"AB",X"6D",X"EF",X"EF",X"EF",X"EF");
	begin
			process(clk_in)
			variable clk_st:integer range 0 to 12500000:=0;
			variable clk_hz:integer range 0 to 12500:=0;
			begin
				if rising_edge(clk_in) then
					if clk_st=12500000 then
						clk_sig<=not clk_sig;
						clk_st:=0;
					else
						clk_st:=clk_st+1;
					end if;
					if clk_hz=12500 then
						clk_hz_sig<=not clk_hz_sig;
						clk_hz:=0;
					else
						clk_hz:=clk_hz+1;
					end if;
				end if;
		end process;
---------------------------------------------d
		process(clk_hz_sig)
			begin
					if clk_hz_sig'event and clk_hz_sig='1' then
						com_d_sig<=com_d_sig(0) & com_d_sig(7 downto 1);
							if com_u_sig="00000001" then
								dn<=ds;
							else
								dn<=dn-1;
							end if;
					end if;
		end process;
		process(clk_sig)
			begin
				if rising_edge(clk_sig) then
						ds<=ds-1;
				end if;
		end process;
----------------------------------------------u		
		process(clk_hz_sig)
			begin
					if clk_hz_sig'event and clk_hz_sig='1' then
						com_u_sig<=com_u_sig(6 downto 0) & com_u_sig(7);
							if com_u_sig="10000000" then
								n<=s;
							else
								n<=n+1;
							end if;
					end if;
		end process;
		process(clk_sig)
			begin
				if rising_edge(clk_sig) then
						s<=s+1;
				end if;
		end process;
------------------------------------------------l
		process(clk_hz_sig)
			begin
				if clk_hz_sig'event and clk_hz_sig='1' then
					com_l_sig<=com_l_sig(6 downto 0) & com_l_sig(7);
					ln<=ln+1;
				end if;
		end process;
		process(clk_sig)
			begin
				if rising_edge(clk_sig) then
					ls<=ls+1;
				end if;
		end process;
------------------------------------------------r
		process(clk_hz_sig)
			begin
				if clk_hz_sig'event and clk_hz_sig='1' then
					com_r_sig<=com_r_sig(6 downto 0) & com_r_sig(7);
					rn<=rn+1;
				end if;
		end process;
		process(clk_sig)
			begin
				if rising_edge(clk_sig) then
					rs<=rs+1;
				end if;
		end process;
-------------------------------------------------
		img_l_sig<=img_sig(ln);
		img_r_sig<=img_sig(rn);
		with ls select
		led_l_sig<=img_l_sig(6 downto 0) & img_l_sig(7) when 1,
					img_l_sig(5 downto 0) & img_l_sig(7 downto 6) when 2,
					img_l_sig(4 downto 0) & img_l_sig(7 downto 5) when 3,
					img_l_sig(3 downto 0) & img_l_sig(7 downto 4) when 4,
					img_l_sig(2 downto 0) & img_l_sig(7 downto 3) when 5,
					img_l_sig(1 downto 0) & img_l_sig(7 downto 2) when 6,
					img_l_sig(0) & img_l_sig(7 downto 1) when 7,
					img_l_sig(7 downto 1) & img_l_sig(0) when others;
		with rs select
		led_r_sig<=img_r_sig(0) & img_r_sig(7 downto 1) when 1,
					img_r_sig(1 downto 0) & img_r_sig(7 downto 2) when 2,
					img_r_sig(2 downto 0) & img_r_sig(7 downto 3) when 3,
					img_r_sig(3 downto 0) & img_r_sig(7 downto 4) when 4,
					img_r_sig(4 downto 0) & img_r_sig(7 downto 5) when 5,
					img_r_sig(5 downto 0) & img_r_sig(7 downto 6) when 6,
					img_r_sig(6 downto 0) & img_r_sig(7) when 7,
					img_r_sig(7 downto 1) & img_r_sig(0) when 0;
		with sw_in select
		com<=com_u_sig when "00",
			 com_d_sig when "01",
			 com_r_sig when "10",
			 com_l_sig when "11";
		with sw_in select
		led_sig<=img_sig(n) when "00",
				 img_sig(dn) when "01",
				 led_l_sig when "10",
				 led_r_sig when "11";
		led_out<=led_sig & "11111111" when clor='1' else "11111111" & led_sig; 
end con;