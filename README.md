# VHDL-Occupancy-Tracking-System

You have been assigned the exciting task of designing a sophisticated digital system capable of accurately  tracking  and  monitoring  the  occupancy  of  a  room.  Within  this  system,  the  primary entrance  door  is  equipped  with  a  highly  responsive  photocell,  which,  upon  the  obstruction  of light, induces a change in a binary signal denoted as  X. Similarly, individuals exiting the room pass through a second door featuring a photocell, triggering a binary signal Y when the light is interrupted. 

The system has a predefined maximum occupancy threshold, adjustable through an input signal known as max_occupancy, allowing for values up to a maximum limit of 63. This value should be stored in  a  register.  When  the  room's  occupancy  reaches this  defined maximum, the system must promptly respond by illuminating a conspicuous red indicator light, signifying that the room has reached its capacity. This state change is reflected through a binary signal Z. Furthermore, the system is equipped with a reset mechanism, invoked through a reset signal. This reset  functionality  enables  the  system  to  return  to  an  initial  state,  allowing  for  the  accurate tracking of occupancy to commence anew.  

- 1. Provide a conceptual diagram for the digital system. Clearly identify the different blocks such as multiplexers, flip-flops, incrementor, etc. and their interconnect.
- 2. Model your circuit using VHDL.
- 3. Provide a relevant testbench. Make sure to cover enough scenarios to verify your design.
- 4. Provide simulation and synthesis results for a Xilinx Nexys A7 FPGA development board (note:  no  actual  FPGA  implementation  is  required).  Include  the  Vivado  log  file  in  the report.
- 5. Based on the results, comment on the quality of the design in term of speed and FPGA resource utilization.


# Room.vhd
Reset function:
- When reset = '1', the occupancy counter (count) is set to 0.
- This clears the room count regardless of how many people were inside.
- Used to start fresh or in emergency situations.

Entry function (X signal)
- When a rising edge of X is detected (someone enters):
- If the current count is less than max_occupancy, increment by +1.
- If already at max_occupancy, no change (prevents overflow).

Exit function (Y signal)
- When a rising edge of Y is detected (someone leaves):
- If the current count is greater than 0, decrement by -1.
- If already 0, no change (prevents negative values).

Max occupancy indicator (Z output)
- Continuously checks count against max_occupancy:
- If count >= max_occupancy → set Z = '1' (room full).
- If count < max_occupancy → set Z = '0' (space available).

# Room_Testbench.vhd
Signals:
- X = entry, Y = exit, reset_tb = reset, Z = full indicator.
max_cap_tb = 3 (room holds 3 people).

- UUT: connects the testbench signals to your Room design.
- Reset process: applies reset at start and again later to clear the counter.
- Enter process: simulates 3 people entering (X pulses). After the 3rd, Z should go high (room full).
- Exit process: simulates 2 people leaving (Y pulses). Counter decreases and Z should go low again.
