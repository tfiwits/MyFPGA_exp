library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity uart_txd is
port(
		clk_2ms: in std_logic;
		clk_in: in std_logic;
		txd_ck: in std_logic;
		txd_in:in std_logic_vector(7 downto 0);
		txd_ok:out std_logic;
		txd_out : out std_logic:='1'
);
end uart_txd;

architecture a of uart_txd is
signal clk_sig,clk_sig_2ms:std_logic;
signal txd_st : std_logic_vector(5 downto 0):="000000";
signal txd_out_tmp,txd_ok_sig:std_logic;
signal txd_ic,dd,hh : std_logic:='0';
signal txd_start : std_logic:='0';
signal txd_sta : std_logic:='0'; 
signal start_idle_ck : std_logic:='0';
signal txd_sig : std_logic_vector(7 downto 0):="00000000";
signal txd_out_sig : std_logic_vector(9 downto 0):="0000000000";
signal sta : std_logic;
begin
	txd_sig<=txd_in;
	process(clk_in)
	variable st:integer range 0 to 1350:=0;
	variable st_2ms:integer range 0 to 10000000:=0;
	begin
		if clk_in'event and clk_in='1' then
			if st=1350 then 
				clk_sig<=not clk_sig;
				st:=0;
			else
				st:=st+1;
			end if;
			if st_2ms=1000000 then 
				clk_sig_2ms<=not clk_sig_2ms;
				st_2ms:=0;
			else
				st_2ms:=st_2ms+1;
			end if;
		end if;
	end process;
	process(clk_sig,txd_out_sig)
	variable dir:integer range 0 to 9:=9;
	variable dir_sig:integer range 0 to 12:=0;
		begin
			if txd_sta='0' then
					txd_ok_sig<='0';
					txd_out_sig<='0' & txd_sig & '1';
				if txd_ck='0' then  
					if dir_sig<11 then 
						if clk_sig'event and clk_sig='1' then 
							txd_out_tmp<=txd_out_sig(dir);
							dir:=dir-1;
							dir_sig:=dir_sig+1;
						end if;
					else
						dir:=9;
						dir_sig:=0;
						txd_ok_sig<='1';
						txd_sta<='1';
					end if;
				end if;
			else
				txd_out_tmp<='1';
				if clk_sig_2ms'event and clk_sig_2ms='1' then
					txd_st<=txd_st+1;
						if txd_st ="111111" then 
							txd_st<="000000";
							txd_sta<='0';
						end if;
				end if;
			end if;
	end process;
	txd_ok<=txd_ok_sig;
	txd_out<=txd_out_tmp;
end a;