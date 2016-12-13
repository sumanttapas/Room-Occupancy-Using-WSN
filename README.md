# Room-Occupancy-Using-WSN
This repository contains the source code for the Room occupancy application using WSN.

Each Mica 2 mote is attached to a MTS 300 sensor board. The on board photo sensor is used as a trigger device in the application.

Whenever the mote with mote id = 1 senses a fall in its photo sensor value, it broadcasts a message indicating the change in sensor value.
Mote with mote id =2, upon receiving the packet from mote 1, sets a local variable, flag, to 1. If mote 2 also senses a change in its sesnor value within 3 seconds, the counter value is increamented.
