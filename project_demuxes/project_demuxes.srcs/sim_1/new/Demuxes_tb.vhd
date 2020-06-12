----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.07.2018 17:02:57
-- Design Name: 
-- Module Name: Demuxes_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_Demuxes is
--  Port ( );
end tb_Demuxes;

architecture Behavioral of tb_Demuxes is

component Demuxes is
    Port ( VCav : in  STD_LOGIC_VECTOR (15 downto 0); --RFIN1
           FwCav : in  STD_LOGIC_VECTOR (15 downto 0); -- RFIn2
  --         RvCav : in  STD_LOGIC_VECTOR (15 downto 0); --RFIn3
           MO : in  STD_LOGIC_VECTOR (15 downto 0); --RFIn4;
   --        FwIOT1 : in  STD_LOGIC_VECTOR (15 downto 0); --RFIn5
    --       RvIOT1 : in  STD_LOGIC_VECTOR (15 downto 0); --RFIN6
     --      DACsIF : in  STD_LOGIC_VECTOR (15 downto 0); --RFIn16
			  
       --    RFIn7 : in  STD_LOGIC_VECTOR (15 downto 0);
    --       RFIn8 : in  STD_LOGIC_VECTOR (15 downto 0);
     --      RFIn9 : in  STD_LOGIC_VECTOR (15 downto 0);
     --      RFIn10 : in  STD_LOGIC_VECTOR (15 downto 0);
     --      RFIn11 : in  STD_LOGIC_VECTOR (15 downto 0);
      --     RFIn12 : in  STD_LOGIC_VECTOR (15 downto 0);
     --      RFIn13 : in  STD_LOGIC_VECTOR (15 downto 0);
      --     RFIn14 : in  STD_LOGIC_VECTOR (15 downto 0);
       --    RFIn15 : in  STD_LOGIC_VECTOR (15 downto 0);
			  
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
   --        IMuxRvCav : out  STD_LOGIC_VECTOR (15 downto 0);
    --       QMuxRvCav : out  STD_LOGIC_VECTOR (15 downto 0);
			  IMO : out std_logic_vector (15 downto 0);
			  QMO : out std_logic_vector (15 downto 0);			  
    --       IMuxFwIOT1 : out  STD_LOGIC_VECTOR (15 downto 0);
     --      QMuxFwIOT1 : out  STD_LOGIC_VECTOR (15 downto 0);			  
     --      IMuxRvIOT1 : out  STD_LOGIC_VECTOR (15 downto 0);
      --     QMuxRvIOT1 : out  STD_LOGIC_VECTOR (15 downto 0);
	--		  IMuxDACsIF : out std_logic_vector (15 downto 0);
	--		  QMuxDACsIF : out std_logic_vector (15 downto 0);
			  
     --      IRFIn7 : out  STD_LOGIC_VECTOR (15 downto 0);
     --      QRFIn7 : out  STD_LOGIC_VECTOR (15 downto 0);
     --      IRFIn8 : out  STD_LOGIC_VECTOR (15 downto 0);
      --     QRFIn8 : out  STD_LOGIC_VECTOR (15 downto 0);
       --    IRFIn9 : out  STD_LOGIC_VECTOR (15 downto 0);
        --   QRFIn9 : out  STD_LOGIC_VECTOR (15 downto 0);
         --  IRFIn10 : out  STD_LOGIC_VECTOR (15 downto 0);
          -- QRFIn10 : out  STD_LOGIC_VECTOR (15 downto 0);
          -- IRFIn11 : out  STD_LOGIC_VECTOR (15 downto 0);
      --     QRFIn11 : out  STD_LOGIC_VECTOR (15 downto 0);
     --      IRFIn12 : out  STD_LOGIC_VECTOR (15 downto 0);
    --       QRFIn12 : out  STD_LOGIC_VECTOR (15 downto 0);
    --       IRFIn13 : out  STD_LOGIC_VECTOR (15 downto 0);
      --     QRFIn13 : out  STD_LOGIC_VECTOR (15 downto 0);
     --      IRFIn14 : out  STD_LOGIC_VECTOR (15 downto 0);
     --      QRFIn14 : out  STD_LOGIC_VECTOR (15 downto 0);
     --      IRFIn15 : out  STD_LOGIC_VECTOR (15 downto 0);
      --     QRFIn15 : out  STD_LOGIC_VECTOR (15 downto 0);			  
           
			  ClkDemux_out : out  STD_LOGIC_VECTOR (1 downto 0);
			  WordQuad_out : out std_logic_vector (3 downto 0)
			  );
end component;

signal d_Vcav, d_Fw, d_mo, IMuxCav1, QMuxCav1,IMuxFwCav1, QMuxFwCav1,IMO1, QMO1  : STD_LOGIC_VECTOR (15 downto 0) :=(others => '0');
signal clk1, LookRefLatch1, LookRefManual1, AnyLoopsEnable_latch1 : STD_LOGIC :='0';
signal ManualOffset1, Quad1, ClkDemux_out1: STD_LOGIC_VECTOR (1 downto 0) :=(others => '0');
signal WordQuad_out1: STD_LOGIC_VECTOR (3 downto 0) :=(others => '0');
constant TbPeriod : time := 12.5 ns; 



begin

 UUT: Demuxes 
 port map ( Vcav => d_Vcav, FwCav => d_Fw, MO => d_mo, 
 LookRefLatch=>LookRefLatch1,LookRefManual=>LookRefManual1, 
 ManualOffset=> ManualOffset1, AnyLoopsEnable_latch=>AnyLoopsEnable_latch1,  Quad=> Quad1, clk => clk1,
 IMuxCav=>IMuxCav1, QMuxCav=>QMuxCav1,IMuxFwCav=>IMuxFwCav1, QMuxFwCav=>QMuxFwCav1, 
 IMo=> IMo1, QMo=>QMO1, ClkDemux_out=>ClkDemux_out1,WordQuad_out=>WordQuad_out1);
 
 clk1 <= not clk1 after TbPeriod/2;
LookRefLatch1 <= '1';
               LookRefManual1 <= '0';
               ManualOffset1 <= "00";
               AnyLoopsEnable_latch1 <= '0';
            Quad1 <= "00";

stimuli: process
variable i: integer;
begin

i :=16;

for i in 0 to 30 loop

d_Vcav <= X"5A82";
d_Fw <= X"5A82";
d_MO <=X"5A82";
wait for 1*TbPeriod;

d_Vcav <= X"5A82";
d_Fw <= X"5A82";
d_MO <=X"5A82";
wait for 1* TbPeriod;

d_Vcav <= X"A57E";
d_Fw <= X"A57E";
d_MO <=X"A57E";
wait for 1* TbPeriod;

d_Vcav <= X"A57E";
d_Fw <= X"A57E";
d_MO <=X"A57E";
wait for 1*TbPeriod;

end loop;



wait;

end process;

end Behavioral;
