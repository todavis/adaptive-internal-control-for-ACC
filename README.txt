README
======

MATLAB Instructions:

1. Modifying input file:

	1. For each test case, create a new "input_file_[].m" file in the input folder.

	2. In the input file, the following can be modified:
		a. Boolean for each disturbance model (5 flags)
		b. System matrices, initial state conditions, sample time (T), and number of states (n)
		c. The amplitude, phases, frequencies of the noise signal indexed from 1 to q (0 to q for Amplitude), where there are q frequencies
		d. The gain constants .g and .eps can be modified for each disturbance class
		e. Initial conditions on eta (size 1 + 2*q) and theta (size q) can be specified

	3. (Reference signal) If the system should track a reference signal as in Remark 1.1, the code to produce a matching disturbance is on line 73
		The temp array, Amp, phase, and freq will need to be modified to be the parameters of the matching disturbance

2. Run the input file: this will save the data into an "input.mat" file in the "input" folder

3. Run the "main.m" file that loads the "input.mat" file and runs the simulations

	1. The number of iteration can be modified for each disturbance class via the "k_max" variable

	2. Frequency estimation error and simulation result plots will be save as png in the "output" folder
		constantDist.png 		- Theorem 2.1
		multiSinDist.png		- Theorem 3.1
		multiSinEstimate.png	- Theorem 4.2
		pureSinDist.png			- Theorem 2.2
		pureSinEstimate.png		- Theorem 4.1
		unkMultiSinDist.png		- Theorem 4.2
		unkPureSinDist.png		- Theorem 4.1

	3. Copy and rename the "output" folder to prevent overwritten data and save the plots