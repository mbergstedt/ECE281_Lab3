ECE281_Lab3
===========

####Pre-Lab
Schematic:

![alt text](https://github.com/mbergstedt/ECE281_Lab3/blob/master/Schematic.JPG?raw=true)

####Lab
Moore Nexys: First I put in the component declaration for the Moore elevator controller that was created in CE3.
After, I added a signal to hold the ouput of the floor. Next, I instantiated the Moore controller, assigning the
clock input to what was suggested in the instructions, the reset to button zero, the up/down input to switch zero,
the stop input to switch one, and the output to the signal. Then, I set nibble zero to the floor output. When I
tested the code on my device, the functionality matched what I had in my CE3 simulation.  After a certain amount
of time when up was on, the output would go up from one to four. If stop was turned on, the number would stop
going up and stay on the value it was at. When both stop and up were off, the display would work down to one. If
reset was pushed, the display would return to one. Capt Silva verified my Moore functionality.

Mealy Nexys: The Mealy nexys followed similar steps to the Moore version. I needed to add another signal to hold
the next floor output. When I instatntiated the Mealy controller, I had to comment out the Moore controller so
that I could still use the signal for the floor output. Additionally, I set nibble one to the next floor output.
Afterwards, I went back to my Mealy code and adjusted it so that when the elevator was stopped, the next floor
would output the floor it was stopped at.  The functionality matched the CE3 simulation, with the next floor
output showing either one floor higher if the elevator was moving up, one floor lower if the elevator was moving
down, or the current floor if the elevator was stopped. A difference between the actual output and the simulation
exists because I adjusted the code for the output while I was working on the lab. Capt Silva verified my Mealy
functionality.

More Floors: I adjusted the Moore controller so that it had two outputs, one for the ones digit and one for the
tens digit. Then I adjusted the next state logic to only go through the first eight prime numbers.  For the prime
numbered floors, I had the first output return the ones digit of the prime number, and I had the second output
return the tens digit of the number.  I then adjusted the top shell to account for these changes.

Change Inputs: For the change inputs functionality, I changed the input into the controller to a 3 bit vector,
with each bit representing the desired floor to move to.  For moving up and down the elevator, I checked that the
value if the value in the input was greater than or less than the value representing the current floor.  If it was
either, I set the next floor to one above or one below the current floor.  In the top shell, I assigned the values
for the input vector to the three switches on the right most side.

Moving Lights: For the moving lights I added a zero bit in front of the input vector from change input.  For the
lights, I used two signals for up and down.  The up one worked the same way as the original flashing lights, and
the down worked the reverse.  When determining which lights signal to use, I compared the input floor vector and
the output current floor vector.  When the input was higher than the current, the lights moved as originally, but
when the input was lower than the current floor, the lights moved in the opposite direction.  If the floors were
the same, then the lights would be off.  Working on using a shift register for changing the lights.

#Functionality
- basic Moore
- basic Mealy
- More Floors
- Change Inputs
- Moving Lights (3 points of 5)
