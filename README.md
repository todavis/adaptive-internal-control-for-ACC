# Adaptive Internal Control for General Reference Velocities in Adaptive Cruise Control

*Implementation and simulation code for Engineering Science thesis supervised by Dr. Mireille Broucke at the University of Toronto*
*Implementation of "Multi-sinusoidal disturbance rejection for discrete-time uncertain stable systems" (Tomei 2017)

## Overview
Adaptive internal models can be used for disturbance rejection and output regulation problems. These approaches seek stable controller designs for an unknown plant and unknown disturbance. The models are applicable to the adaptive cruise control (ACC) problem of following a vehicle with a changing velocity. The project set out to implement an adaptive internal model to reject general disturbances for an unknown plant. The controller was examined for stability and performance in the ACC problem for a single follower and a second follower to simulate a platoon. First, control literature on adaptive internal models was reviewed to select a model. A literature review of control methods applied to the adaptive cruise control problem was conducted to examine current approaches. 

The selected model was implemented in MATLAB and simulations of the selected worked examples were performed to replicate results of the selected work. The stability and performance of the implementation was verified for several models and disturbances. Better performance was achieved for pure sinusoid models when the disturbance allows for this model. Simulations of the ACC situations were performed. The single vehicle model achieved stability for multi-sinusoid reference velocities with large settling times. A second follower achieved stability but experienced tracking delays and instability for constant controller parameters indicating string instability.


## MATLAB Instructions:

1. Modifying input file:

	1. For each test case, create a new "input_file_[name].m" file in the input folder.

	2. In the input file, the following can be modified:
		1. Boolean for each disturbance model (5 flags)
		2. System matrices, initial state conditions, sample time (T), and number of states (n)
		3. The amplitude, phases, frequencies of the noise signal indexed from 1 to q (0 to q for Amplitude), where there are q frequencies
		4. The gain constants .g and .eps can be modified for each disturbance class
		5. Initial conditions on eta (size 1 + 2*q) and theta (size q) can be specified

	3. (Reference signal) If the system should track a reference signal as in Remark 1.1, the code to produce a matching disturbance is on line 73
		The temp array, Amp, phase, and freq will need to be modified to be the parameters of the matching disturbance

2. Run the input file: this will save the data into an "input.mat" file in the "input" folder

3. Run the "main.m" file that loads the "input.mat" file and runs the simulations

	1. The number of iteration can be modified for each disturbance class via the "k_max" variable

	2. Frequency estimation error and simulation result plots will be save as png in the "output" folder
		* constantDist.png 		- Theorem 2.1
		* multiSinDist.png		- Theorem 3.1
		* multiSinEstimate.png		- Theorem 4.2
		* pureSinDist.png		- Theorem 2.2
		* pureSinEstimate.png		- Theorem 4.1
		* unkMultiSinDist.png		- Theorem 4.2
		* unkPureSinDist.png		- Theorem 4.1

	3. Copy and rename the "output" folder to prevent overwritten data and save the plots
