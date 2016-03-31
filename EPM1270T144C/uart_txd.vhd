library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity uart_txd is
port(
		clk_2ms: in std_logic;
		clk_in: in std_logic;
		txd_ck: in std_logic;
		txd_out : out std_logic:='1'
);
end uart_txd;

architecture a of uart_txd is
signal txd_st : std_logic_vector(5 downto 0):="000000";
signal txd_ic,dd,hh : std_logic:='0';
signal txd_start : std_logic:='0';
signal txd_sta : std_logic:='0'; 
signal start_idle_ck : std_logic:='0';
signal txd_sig : std_logic_vector(7 downto 0):="00000000";
signal txd_out_sig : std_logic_vector(9 downto 0):="0000000000";
signal sta : std_logic;
begiN
	process(clk_in,txd_out_sig)
	variable dir:integer range 0 to 9:=9;
	variable dir_sig:integer range 0 to 12:=0;
		begin
			if txd_sta='0' then
					txd_sig<="01000010";
					txd_out_sig<='0' & txd_sig & '1';
				if txd_ck='1' then  
					if dir_sig<11 then 
						if clk_in'event and clk_in='1' then 
							txd_out<=txd_out_sig(dir);
							dir:=dir-1;
							dir_sig:=dir_sig+1;
						end if;
					else
						dir:=9;
						dir_sig:=0;
						txd_sta<='1';
					end if;
				end if;
			else
										txd_out<='1';
				if clk_2ms'event and clk_2ms='1' then
					txd_st<=txd_st+1;
						if txd_st ="111111" then 
							txd_st<="000000";
							txd_sta<='0';
						end if;
				end if;
			end if;
	end process;
end a;