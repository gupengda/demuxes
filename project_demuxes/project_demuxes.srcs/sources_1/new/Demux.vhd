---File Demux.vhd;----
---- By Pengda Gu, I Q generation from input with offset cancellation

library ieee, work;
use ieee.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

ENTITY demux IS

	PORT ( SignalIn : in std_logic_vector (17 downto 0);	
			 clk : in std_logic;
			 ClkDemux : in std_logic_vector (1 downto 0);
			 IO : out std_logic_vector (15 downto 0);
			 QO : out std_logic_vector (15 downto 0));
END demux;

ARCHITECTURE Behavioral OF demux is


--signal IMux, IMux1, IMux2, IMux3 : std_logic_vector (15 downto 0):= (others => '0');
--signal QMux, QMux1, QMux2, QMux3 : std_logic_vector (15 downto 0):= (others => '0');  



signal di, data0, data1, data2, data3 : STD_LOGIC_VECTOR (16 downto 0);
--signal counter : STD_LOGIC_VECTOR (1 downto 0) := "10";
signal ii,qq : STD_LOGIC_VECTOR (16 downto 0);
signal dii : STD_LOGIC_VECTOR (15 downto 0);

begin



prepare_data: process (clk)
begin
    if  clk 'event and clk='1'  then
    
dii <= SignalIn(15 downto 0) + b"1000000000000000";  ---change from offset binary to 2's complement. 
di <= dii(15)& dii(15 downto 0);
data0 <= di;
data1<= data0;
data2<= data1;
data3<= data2;
    end if;
    end process;

--- For generation of IQ signals 
--Count: process (adc1_clk)
--begin
  --  if  adc1_clk 'event and adc1_clk='1'  then
    --if counter= "11" then 
   -- counter <= "00";
     --  elsif counter = "10" then
       --  counter <= "11";
       --elsif counter = "01" then
        -- counter <= "10";
       --elsif counter = "00" then
        -- counter <= "01";
        --end if;
  
--end if;
--end process;    

--supposing I Q -I -Q 

IQ: process (clk)
begin
if  clk 'event and clk='1'  then
if ClkDemux = "11" then

ii <= data3 - data1;
qq <= data2 - data0; 

IO <= ii ( 16 downto 1); --divide by 2, plus rounding
QO <= qq ( 16 downto 1);

end if;
end if;
end process; 

--- Original Angela code  
--	process (clk)
--	begin
	--if (clk'EVENT and clk = '1') then
		--case clkdemux is
			--when "00" => QMux <= SignalIn;
			--when "01" => IMux <= SignalIn;
			--when "10" => QMux <= not(SignalIn) + 1;
			--when "11" => IMux <= not(SignalIn) + 1;
			--when others =>  null;
								
		--end case;
		
		-- Removal of DC offsets of ADCS
--		QMux1 <= QMux;
--		QMux2 <= QMux1;
--		QMux3 <= QMux2;
--		
--		IMux1 <= IMux;
--		IMux2 <= IMux1;
--		IMux3 <= IMux2;
--		
--		IOut <= IMux + IMux1 + IMux2 + IMux3; 
--		QOut <= QMux + QMux1 + QMux2 + QMux3; 

	--	IOut <= IMux;
	--	QOut <= QMux;
		
--	end if;
--	end process;
	
end  Behavioral;