library ieee;
use ieee.std_logic_1164.all;

entity test is 
port(	
		clk_in:in std_logic;
		led_test:out std_logic_vector(7 downto 0);                                                                                                                                                  
		com:out std_logic_vector(7 downto 0)
);
end test;

architecture test of test is 
type img is array (0 to 7) of std_logic_vector(7 downto 0);
signal img_sig:img:=(X"EF",X"C7",X"AB",X"6D",X"EF",X"EF",X"EF",X"EF");
signal com_sig:std_logic_vector(7 downto 0):="00000001";
signal com_u_sig:std_logic_vector(7 downto 0):="00000001";
signal clk_sig:std_logic;
signal clk_hz_sig:std_logic;
signal led_l_sig:std_logic_vector(7 downto 0);
signal led_rl_sig:std_logic_vector(7 downto 0);
signal n,s:integer range 0 to 7:=0;
begin
	com<=com_u_sig;
	led_test<=img_sig(n);
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
	process(clk_in)
		variable clk_st:integer range 0 to 12500000:=0;
		variable clk_hz:integer range 0 to 10000:=0;
		begin
			if rising_edge(clk_in) then
				if clk_st=12500000 then
						clk_sig<=not clk_sig;
						clk_st:=0;
					else
						clk_st:=clk_st+1;
					end if;
					if clk_hz=10000 then
						clk_hz_sig<=not clk_hz_sig;
						clk_hz:=0;
					else
						clk_hz:=clk_hz+1;
					end if;
			end if;                                          
		end process;

end test;