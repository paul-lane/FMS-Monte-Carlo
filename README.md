# FMS-Monte-Carlo

Code to allow the probing of gas-liquid scattering measurements using Frequency Modulated Spectroscopy with a multi-pass cell.

The main code is MCScattering_FM.f90 takes in a series of input files:
-chamberDimension.inp
-directionInputs.inp
-fmInputs.inp
-herriottCellGeom.inp
-overwrite.inp
-timingInputs.inp 

All of which are contained in the 'Inputs' folder.
The 'herriottCell.inp file can be created manually or using the program 'getHerriottCell.f90 which generates this input file based on the co-ordinates of the beam spots contained in the mirrorSpots.inp file.

The code produces a series of output files:
AppProfile.txt - signal size as a function of time
Statistics.txt - counts of the trajectories probed
These are contained with in the folder 'Outputs'
A series of transverse velocity files (one for each time step in the Appearance Profile) in the subfolder 'Speed'

A number of beam profiles are produced (x-y co-ordinate 'image' of each trajectory at a particular z position in the chamber:
-IngoingCellProfile.txt* - ingoing beam 'imaged' at the centre of the Herriott Cell 
-IngoingCollimatorProfile.txt* - ingoing beam 'imaged' at the exit of the collimator
-ScatteredCellProfile.txt* - scattered beam 'imaged' at the centre of the Herriot Cell
-WheelProfile.txt* - ingoing beam at the x-y plane of the wheel position 
-MissedWheel.txt* - list of trajectory positions that miss the wheel

A number of scattered beam profiles are produced which offer a way of visualising the 2D projection of the probe volume:
-IngoingProbed.txt* - co-ordinates of all probed ingoing trajectories at the centre of the cell 
-ScatteredProbed.txt* - co-ordinates of all probed scattered trajectories at the centre of the cell

* As writing these files takes a significant amount of time they will be empty unless the appropriate input option is selected

The FM outputs are created using three other pieces of code:
-TimeSliceBinning.f90 - sums the speed data between start and end times
-StepSizeBinning.f90 - bins the speeds into step sizes equivalent to a user defined step size
-Absorption.f90 - converts the speed data into an absorption lineshape and an FM absorption lineshape.
These programs use some of the same input files used with the main MC code along with an additional file called 'binParameters.inp'

The outputs of TimeSliceBinning.f90 are written to 'Outputs/Processing1' and the outputs of StepSizeBinning are written to 'Outputs/Processing2' and are the Speed distributions for the given time window. Absorption outputs files directly to the 'Outputs' folder and these are the (integral) absorption lineshape Abs_001.txt and the FM absorption lineshape FMabs001.txt. The number 001 corresponds to the first set of specified times in the binParameters input file 002 would be the second etc. There is the option to peak normalize both the absorption lines in the input file.

All code as been written and compiled with gfortran on Linux. I would advise compiling the  using the command:
gfortran -ffree-line-length-none -o <filename>.out <filename>.f90
and run using the command
./<filename>.out
  
As the codes depend upon the previous program they need to be run in sequence:
1) MCScattering_FM.f90
2) TimeSliceBinning.f90
3) StepSizeBinning.f90
4) Absorption.f90

Step 1 is stand-alone and information can be obtained from this directly but the FM outputs require all steps 2-4 to be run, there is little benefit in running one alone, the easiest way to run these steps is with the script 'ProcessingScript.sh' on Linux or creating an equivalent batch file on windows.






