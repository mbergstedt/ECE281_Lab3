ECE281_Lab3
===========

####Pre-Lab
Schematic:

![alt text](https://github.com/mbergstedt/ECE281_Lab3/blob/master/Schematic.JPG?raw=true)

####Lab
Moore Nexys: First I put in the component declaration for the Moore elevator controller that was created in CE3. After,
I added a signal to hold the ouput of the floor. Next, I instantiated the Moore controller, assigning the clock input
to what was suggested in the instructions, the reset to button zero, the up/down input to switch zero, the stop input
to switch one, and the output to the signal. Then, I set nibble zero to the floor output. When I tested the code on my
device, the functionality matched what I had in my CE3 simulation.  After a certain amount of time when up was on, the
output would go up from one to four. If stop was turned on, the number would stop going up and stay on the value it was
at. When both stop and up were off, the display would work down to one. If reset was pushed, the display would return
to one. Capt Silva verified my Moore functionality.

Mealy Nexys: The Mealy nexys followed similar steps to the Moore version. I needed to add another signal to hold the
next floor output. When I instatntiated the Mealy controller, I had to comment out the Moore controller so that I could
still use the signal for the floor output. Additionally, I set nibble one to the next floor output. Afterwards, I went
back to my Mealy code and adjusted it so that when the elevator was stopped, the next floor would output the floor it
was stopped at.  The functionality matched the CE3 simulation, with the next floor output showing either one floor
higher if the elevator was moving up, one floor lower if the elevator was moving down, or the current floor if the
elevator was stopped. A difference between the actual output and the simulation exists because I adjusted the code for
the output while I was working on the lab. Capt Silva verified my Mealy functionality.
