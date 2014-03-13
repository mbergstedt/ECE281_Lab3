----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Silva
-- 
-- Create Date:    10:33:47 07/07/2012 
-- Design Name: 
-- Module Name:    MooreElevatorController_Silva - Behavioral 
-- Project Name: 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MealyElevatorController_Shell is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           floor : out  STD_LOGIC_VECTOR (3 downto 0);
			  nextfloor : out std_logic_vector (3 downto 0));
end MealyElevatorController_Shell;

architecture Behavioral of MealyElevatorController_Shell is

type floor_state_type is (floor1, floor2, floor3, floor4);

signal floor_state,next_state : floor_state_type;

begin

---------------------------------------------------------
--Code your Mealy machine next-state process below
--Question: Will it be different from your Moore Machine?
---------------------------------------------------------
--floor_state_machine: process(clk)
--begin
----Insert your state machine below:
--	if rising_edge(clk) then
--		--reset is active high and will return the elevator to floor1
--		--Question: is reset synchronous or asynchronous?
--		if reset='1' then  -- synchronous because it checks the clock first
--			floor_state <= floor1;
--		--now we will code our next-state logic
--		else
--			case floor_state is
--				--when our current state is floor1
--				when floor1 =>
--					--if up_down is set to "go up" and stop is set to 
--					--"don't stop" which floor do we want to go to?
--					if (up_down='1' and stop='0') then 
--						--floor2 right?? This makes sense!
--						floor_state <= floor2;
--					--otherwise we're going to stay at floor1
--					else
--						floor_state <= floor1;
--					end if;
--				--when our current state is floor2
--				when floor2 => 
--					--if up_down is set to "go up" and stop is set to 
--					--"don't stop" which floor do we want to go to?
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor3; 			
--					--if up_down is set to "go down" and stop is set to 
--					--"don't stop" which floor do we want to go to?
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor1;
--					--otherwise we're going to stay at floor2
--					else
--						floor_state <= floor2;
--					end if;
--				
----COMPLETE THE NEXT STATE LOGIC ASSIGNMENTS FOR FLOORS 3 AND 4
--				when floor3 =>
--					--going up and not stopping, go up one floor
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor4;
--					--not going up and not stopping, go down one floor
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor2;
--					--stopping, so stay on floor
--					else
--						floor_state <= floor3;
--					end if;
--				when floor4 =>
--					--not going up and not stopping, go down one floor
--					if (up_down='0' and stop='0') then 
--						floor_state <= floor3;
--					--at top or stopping so can't go any higher
--					else 
--						floor_state <= floor4;
--					end if;
--				
--				--This line accounts for phantom states
--				when others =>
--					floor_state <= floor1;
--			end case;
--		end if;
--	end if;
--end process;

--------------------------
--   Next State Logic   --
--------------------------
process(up_down,stop,clk) -- include clk to update on the way down if up_down and stop do not change
begin
	case floor_state is
		--when our current state is floor1
		when floor1 =>
			--if up_down is set to "go up" and stop is set to 
			--"don't stop" which floor do we want to go to?
			if (up_down='1' and stop='0') then 
				--floor2 right?? This makes sense!
				next_state <= floor2;
			--otherwise we're going to stay at floor1
			else
				next_state <= floor1;
			end if;
		--when our current state is floor2
		when floor2 => 
			--if up_down is set to "go up" and stop is set to 
			--"don't stop" which floor do we want to go to?
			if (up_down='1' and stop='0') then 
				next_state <= floor3; 			
			--if up_down is set to "go down" and stop is set to 
			--"don't stop" which floor do we want to go to?
			elsif (up_down='0' and stop='0') then 
				next_state <= floor1;
			--otherwise we're going to stay at floor2
			else
				next_state <= floor2;
			end if;
		
--COMPLETE THE NEXT STATE LOGIC ASSIGNMENTS FOR FLOORS 3 AND 4
		when floor3 =>
			--going up and not stopping, go up one floor
			if (up_down='1' and stop='0') then 
				next_state <= floor4;
			--not going up and not stopping, go down one floor
			elsif (up_down='0' and stop='0') then 
				next_state <= floor2;
			--stopping, so stay on floor
			else
				next_state <= floor3;
			end if;
		when floor4 =>
			--not going up and not stopping, go down one floor
			if (up_down='0' and stop='0') then 
				next_state <= floor3;
			--at top or stopping so can't go any higher
			else 
				next_state <= floor4;
			end if;
		
		--This line accounts for phantom states
		when others =>
			next_state <= floor1;
	end case;
end process;

--------------------------
--     State Memory     --
--------------------------
process(reset,clk)
begin
	if rising_edge(clk) then
		if reset = '1' then
			floor_state <= floor1;
		else
			floor_state <= next_state;
		end if;
	end if;
end process;

-----------------------------------------------------------
--Code your Ouput Logic for your Mealy machine below
--Remember, now you have 2 outputs (floor and nextfloor)
-----------------------------------------------------------
-- floor is same
floor <= "0001" when (floor_state = floor1) else
			"0010" when (floor_state = floor2) else
			"0011" when (floor_state = floor3) else
			"0100" when (floor_state = floor4) else
			"0001";
-- dependent on up_down and floor
nextfloor <= "0001" when ((floor_state = floor2) and (up_down = '0')) else -- floor 2 going down
				 "0010" when (((floor_state = floor1) and (up_down = '1')) -- floor 1 going up
									or ((floor_state = floor3) and (up_down = '0'))) else -- floor 3 going down
				 "0011" when (((floor_state = floor2) and (up_down = '1')) -- floor 2 going up
									or ((floor_state = floor4) and (up_down = '0'))) else -- floor 4 going down
				 "0100" when (((floor_state = floor3) or (floor_state = floor4))
									and (up_down = '1')) else -- floor 3 going up or top floor still reading up
				 "0001";

end Behavioral;

