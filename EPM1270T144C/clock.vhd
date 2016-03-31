library ieee;
use ieee.std_logic_1164.all;

entity clock is
port(
		clk_in : in std_logic;
		clk_out: out std_logic;
		clk_out_1hz,clk_out_pwm,clk_out_t,clk_out_rxd,clk_out_txd,clk_out_key_2ms,clk_out_key_20ms: out std_logic
);
end clock;

architecture a of clock is
 signal clk_out_sig,clk_out_hi,clk_ll_pwm,clk_t,clk_rxd,clk_txd_sig,clk_key_2ms,clk_key_20ms :std_logic:='0'; 
begin
	process(clk_in)
	variable clk_sig : integer range 0 to 25000000;
	variable clk_sig_1hz : integer range 0 to 100000;
	variable clk_sig_t : integer range 0 to 600000;
	variable clk_sig_pwm : integer range 0 to 10;
	variable clk_sig_rxd : integer range 0 to 260;
	variable clk_sig_txd : integer range 0 to 2600;
	variable clk_sig_key_2ms : integer range 0 to 100000;
	variable clk_sig_key_20ms : integer range 0 to 1000000;
		begin
			if clk_in'event and clk_in='1' then
				if clk_sig=25000000 then
					clk_out_sig<=not clk_out_sig;
					clk_sig:=0;
				else
					clk_sig:=clk_sig+1;
				end if;
				if clk_sig_1hz=100000 then 
					clk_out_hi<=not clk_out_hi;
					clk_sig_1hz:=0;
				else
					clk_sig_1hz:=clk_sig_1hz+1;
				end if;
				if clk_sig_pwm=10 then 
					clk_ll_pwm<=not clk_ll_pwm;
					clk_sig_pwm:=0;
				else
					clk_sig_pwm:=clk_sig_pwm+1;
				end if;
				if clk_sig_t=600000 then 
					clk_t<=not clk_t;
					clk_sig_t:=0;
				else
					clk_sig_t:=clk_sig_t+1;
				end if;
				if clk_sig_rxd=260 then
					clk_rxd<=not clk_rxd;
					clk_sig_rxd:=0;
				else
					clk_sig_rxd:=clk_sig_rxd+1;
				end if;
				if clk_sig_txd=2700 then
					clk_txd_sig<=not clk_txd_sig;
					clk_sig_txd:=0;
				else
					clk_sig_txd:=clk_sig_txd+1;
				end if;
				if clk_sig_key_2ms=100000 then
					clk_key_2ms<=not clk_key_2ms;
					clk_sig_key_2ms:=0;
				else
					clk_sig_key_2ms:=clk_sig_key_2ms+1;
				end if;
				if clk_sig_key_20ms=1000000 then
					clk_key_20ms<=not clk_key_20ms;
					clk_sig_key_20ms:=0;
				else
					clk_sig_key_20ms:=clk_sig_key_20ms+1;
				end if;
			end if;
	end process;
clk_out_key_2ms<=clk_key_2ms;
clk_out_key_20ms<=clk_key_20ms;
clk_out_txd<=clk_txd_sig;
clk_out_rxd<=clk_rxd;
clk_out_t<=clk_t;
clk_out_pwm<=clk_ll_pwm;
clk_out_1hz<=clk_out_sig;
clk_out<=clk_out_hi;
end a; 