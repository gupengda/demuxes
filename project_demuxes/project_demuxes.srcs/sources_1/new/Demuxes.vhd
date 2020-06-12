----------------------------------------------------------------------------------
-- Company: 
-- Engineer: A. Salom, modified by Pengda Gu for Struck SIS8300KU with RTM
-- 
-- Create Date:    17:19:13 08/22/2014 
-- Design Name: 	
-- Module Name:    Demuxes - Behavioral 
-- Project Name: Max-IV LLRF
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee, work;
use ieee.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity Demuxes is
    Port ( VCav : in  STD_LOGIC_VECTOR (17 downto 0); --RFIN1
           FwCav : in  STD_LOGIC_VECTOR (17 downto 0); -- RFIn2
           RvCav : in  STD_LOGIC_VECTOR (17 downto 0); --RFIn3
           RFIn4 : in  STD_LOGIC_VECTOR (17 downto 0); --RFIn4;
           RFIn5 : in  STD_LOGIC_VECTOR (17 downto 0); --RFIn5
           RFIn6 : in  STD_LOGIC_VECTOR (17 downto 0); --RFIN6
           MO : in  STD_LOGIC_VECTOR ( 17 downto 0); --RFIn7
		   VMOut: in  STD_LOGIC_VECTOR (17 downto 0); --RFIn8 
       	  
       	   LookRefLatch : in  STD_LOGIC;
		   LookRefManual : in std_logic;
	       ManualOffset : in std_logic_vector (1 downto 0);
		   AnyLoopsEnable_latch : in std_logic;
           Quad : in  STD_LOGIC_VECTOR (1 downto 0);
           clk : in  STD_LOGIC;
			  
           IMuxCav : out  STD_LOGIC_VECTOR (15 downto 0);
           QMuxCav : out  STD_LOGIC_VECTOR (15 downto 0);
           IMuxFwCav : out  STD_LOGIC_VECTOR (15 downto 0);
           QMuxFwCav : out  STD_LOGIC_VECTOR (15 downto 0);
           IMuxRvCav : out  STD_LOGIC_VECTOR (15 downto 0);
           QMuxRvCav : out  STD_LOGIC_VECTOR (15 downto 0);
		   IMO : out std_logic_vector (15 downto 0);
		   QMO : out std_logic_vector (15 downto 0);			  
           IVMOut: out std_logic_vector (15 downto 0);
           QVMOut: out std_logic_vector (15 downto 0);
           IRFIn4 : out  STD_LOGIC_VECTOR (15 downto 0);
           QRFIn4 : out  STD_LOGIC_VECTOR (15 downto 0);
           IRFIn5 : out  STD_LOGIC_VECTOR (15 downto 0);
           QRFIn5 : out  STD_LOGIC_VECTOR (15 downto 0);
           IRFIn6 : out  STD_LOGIC_VECTOR (15 downto 0);
           QRFIn6 : out  STD_LOGIC_VECTOR (15 downto 0);
           ClkDemux_out : out  STD_LOGIC_VECTOR (1 downto 0);
		   WordQuad_out : out std_logic_vector (3 downto 0)
			  );
end Demuxes;

architecture Behavioral of Demuxes is

-- Signals Declaration

	signal clkdemux: std_logic_vector (1 downto 0) := (others => '0');
	signal clkcav : std_logic_vector (1 downto 0):= (others => '0');
	signal clkcav_delay : std_logic_vector (1 downto 0):= (others => '0');
	signal offset : std_logic_vector (1 downto 0):= (others => '0');
	signal LoadOffset : std_logic_vector (1 downto 0):= (others => '0');
	signal WordQuad : std_logic_vector (3 downto 0):= (others => '0');
	signal MO0, MO1, MO2, MO3 : std_logic;
   -- constant off1 : std_logic_vector (1 downto 0) := "01";


-- Components Declaration

component demux IS
	port ( SignalIn : in std_logic_vector (17 downto 0);	
			 clk : in std_logic;
			 ClkDemux : in std_logic_vector (1 downto 0);
			 IO : out std_logic_vector (15 downto 0);
			 QO : out std_logic_vector (15 downto 0));
	end component demux;



begin


process(clk)
begin
	if(clk'EVENT and clk = '1') then	
		clkdemux <= clkdemux + 1;
		WordQuad <= MO0&MO1&MO2&MO3;
		ClkCav <= ClkDemux + LoadOffset;
		--ClkCav <= ClkCav1 - off1;
		ClkDemux_out <= ClkCav;
		WordQuad_out <= WordQuad;
		
		if(AnyLoopsEnable_latch = '1') then
			LoadOffset <= LoadOffset;
		elsif(LookRefManual = '1') then
			LoadOffset <= ManualOffset;
		elsif(LookRefLatch = '1') then
			LoadOffset <= offset;
		end if;		
	
		case clkdemux is 
			when "00" => MO0 <= MO(15);
			when "01" => MO1 <= MO(15);
			when "10" => MO2 <= MO(15);
			when "11" => MO3 <= MO(15);
			when others => null;
		end case;
		

			
		case Quad is
			when "00" => if(WordQuad = "0011") then
								offset <= "01";
							 elsif(WordQuad = "0110") then
								offset <= "10";
							 elsif(WordQuad = "1100") then
								offset <= "11";
							 else offset <= "00";
							 end if;
			when "01" => if(WordQuad = "0011") then
								offset <= "00";
							 elsif(WordQuad = "0110") then
								offset <= "01";
							 elsif(WordQuad = "1100") then
								offset <= "10";
							 else offset <= "11";
							 end if;
			when "10" => if(WordQuad = "0011") then
								offset <= "11";
							 elsif(WordQuad = "0110") then
								offset <= "00";
							 elsif(WordQuad = "1100") then
								offset <= "01";
							 else offset <= "10";
							 end if;
			when "11" => if(WordQuad = "0011") then
								offset <= "10";
							 elsif(WordQuad = "0110") then
								offset <= "11";
							 elsif(WordQuad = "1100") then
								offset <= "00";
							 else offset <= "01";
							 end if;
			when others => null;
		end case;
			
	end if;
end process;


IQDemux_Cav : component Demux
	PORT MAP(
	SignalIn => VCav,
	clk => clk,
	ClkDemux => ClkCav,
	IO => IMuxCav,
	QO => QMuxCav);

		
IQDemux_FwCav : component Demux
	PORT MAP(
	SignalIn => FwCav,
	clk => clk,
	ClkDemux => ClkCav,
	IO => IMuxFwCav,
	QO => QMuxFwCav);

IQDemux_RvCav : component Demux
	PORT MAP(
	SignalIn => RvCav,
	clk => clk,
	ClkDemux => ClkCav,
	IO => IMuxRvCav,
	QO => QMuxRvCav);

IQDemux_VMOut : component Demux
	PORT MAP(
	SignalIn => VMOut,
	clk => clk,
	ClkDemux => ClkCav,
	IO => IVMOut,
	QO => QVMOut);
	
	
IQDemux_MO : component Demux
	PORT MAP(
	SignalIn => MO,
	clk => clk,
	ClkDemux => ClkCav,
	IO => IMO,
	QO => QMO);
	
IQDemux_RFIn4 : component Demux
        PORT MAP(
        SignalIn => RFIn4,
        clk => clk,
        ClkDemux => ClkCav,
        IO => IRFIn4,
        QO => QRFIn4);

IQDemux_RFIn5 : component Demux
        PORT MAP(
        SignalIn => RFIn5,
        clk => clk,
        ClkDemux => ClkCav,
        IO => IRFIn5,
        QO => QRFIn5);

IQDemux_RFIn6 : component Demux
        PORT MAP(
        SignalIn => RFIn6,
        clk => clk,
        ClkDemux => ClkCav,
        IO => IRFIn6,
        QO => QRFIn6);


end Behavioral;