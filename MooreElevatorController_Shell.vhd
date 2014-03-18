----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Silva
-- 
-- Create Date:    	10:33:47 07/07/2012 
-- Design Name:		CE3
-- Module Name:    	MooreElevatorController_Shell - Behavioral 
-- Description: 		Shell for completing CE3
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MooreElevatorController_Shell is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           floor : out  STD_LOGIC_VECTOR (3 downto 0); -- use for ones digit with more floors functionality
			  floor_ten : out STD_LOGIC_VECTOR (3 downto 0)); -- use for tens digit
end MooreElevatorController_Shell;

architecture Behavioral of MooreElevatorController_Shell is

--Below you create a new variable type! You also define what values that 
--variable type can take on. Now you can assign a signal as 
--"floor_state_type" the same way you'd assign a signal as std_logic 
type floor_state_type is (floor2, floor3, floor5, floor7,
									floor11, floor13, floor17, floor19); -- change to first 8 prime numbers

--Here you create a variable "floor_state" that can take on the values
--defined above. Neat-o!
signal floor_state, next_state : floor_state_type;

begin
---------------------------------------------
--Below you will code your next-state process
---------------------------------------------

----This line will set up a process that is sensitive to the clock
--floor_state_machine: process(clk)
--begin
--	--clk'event and clk='1' is VHDL-speak for a rising edge
--	if clk'event and clk='1' then   --use rising_edge(clk) instead--
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
--end process;  --all together, separate into three boxes

--------------------------
--   Next State Logic   --
--------------------------
process(up_down,stop,clk) -- include clk to update on the way down if up_down and stop do not change
begin -- adjust for prime numbers
	case floor_state is
		--when our current state is floor1
		when floor2 =>
			--if up_down is set to "go up" and stop is set to 
			--"don't stop" which floor do we want to go to?
			if (up_down='1' and stop='0') then 
				--floor2 right?? This makes sense!
				next_state <= floor3;
			--otherwise we're going to stay at floor1
			else
				next_state <= floor2;
			end if;
		--when our current state is floor2
		when floor3 => 
			--if up_down is set to "go up" and stop is set to 
			--"don't stop" which floor do we want to go to?
			if (up_down='1' and stop='0') then 
				next_state <= floor5; 			
			--if up_down is set to "go down" and stop is set to 
			--"don't stop" which floor do we want to go to?
			elsif (up_down='0' and stop='0') then 
				next_state <= floor2;
			--otherwise we're going to stay at floor2
			else
				next_state <= floor3;
			end if;
		
--COMPLETE THE NEXT STATE LOGIC ASSIGNMENTS FOR FLOORS 3 AND 4
		when floor5 =>
			--going up and not stopping, go up one floor
			if (up_down='1' and stop='0') then 
				next_state <= floor7;
			--not going up and not stopping, go down one floor
			elsif (up_down='0' and stop='0') then 
				next_state <= floor3;
			--stopping, so stay on floor
			else
				next_state <= floor5;
			end if;
		when floor7 =>
			--going up and not stopping, go up one floor
			if (up_down='1' and stop='0') then 
				next_state <= floor11;
			--not going up and not stopping, go down one floor
			elsif (up_down='0' and stop='0') then 
				next_state <= floor5;
			else 
				next_state <= floor7;
			end if;
		-- floor 11
		when floor11 =>
			--going up and not stopping, go up one floor
			if (up_down='1' and stop='0') then 
				next_state <= floor13;
			--not going up and not stopping, go down one floor
			elsif (up_down='0' and stop='0') then 
				next_state <= floor7;
			else 
				next_state <= floor11;
			end if;
		-- floor 13
		when floor13 =>
			--going up and not stopping, go up one floor
			if (up_down='1' and stop='0') then 
				next_state <= floor17;
			--not going up and not stopping, go down one floor
			elsif (up_down='0' and stop='0') then 
				next_state <= floor11;
			else 
				next_state <= floor13;
			end if;
		-- floor 17
		when floor17 =>
			--going up and not stopping, go up one floor
			if (up_down='1' and stop='0') then 
				next_state <= floor19;
			--not going up and not stopping, go down one floor
			elsif (up_down='0' and stop='0') then 
				next_state <= floor13;
			else 
				next_state <= floor17;
			end if;
		-- floor 19
		when floor19 =>
			--not going up and not stopping, go down one floor
			if (up_down='0' and stop='0') then 
				next_state <= floor17;
			else -- at topp
				next_state <= floor19;
			end if;
		
		--This line accounts for phantom states
		when others =>
			next_state <= floor2;
	end case;
end process;

--------------------------
--     State Memory     --
--------------------------
process(reset,clk)
begin
	if rising_edge(clk) then
		if reset = '1' then
			floor_state <= floor2;
		else
			floor_state <= next_state;
		end if;
	end if;
end process;

-- Here you define your output logic. Finish the statements below
floor <= "0010" when (floor_state = floor2) else
			"0011" when (floor_state = floor3) else
			"0101" when (floor_state = floor5) else
			"0111" when (floor_state = floor7) else
			"0001" when (floor_state = floor11) else
			"0011" when (floor_state = floor13) else
			"0111" when (floor_state = floor17) else
			"1001" when (floor_state = floor19) else
			"0010"; -- default to floor 2
floor_ten <= "0001" when (floor_state = floor11 or floor_state = floor13
							or floor_state = floor17 or floor_state = floor19) else
				 "0000";

end Behavioral;

