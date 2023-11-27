///////
//Mirror
//By: Millenwise (beno_83au)
///////
//Use and abuse as required. Please just give credit.
///////

MIL_Mirror allows a mission maker to add a mirror-type effect to any object capable of using setObjectTexture.

To use:	

	- Copy the folder MIL_Mirror into your mission directory.
	- Place your intended mirror object (e.g. a whiteboard - "Land_MapBoard_01_Wall_F" - they work best) and name it.
	
	- Add this line to your mission's init.sqf file:
		- nul = [_mirrors] execVM "MIL_Mirror\initialise.sqf";
			- _mirrors - array
				   - names of all the mirrors
		
		- Example:
			- nul = [mirror_1,mirror_2] execVM "MIL_Mirror\initialise.sqf";
			
Know issues:

	- The reflection doesn't behave quite like a mirrored reflection because it's a camera, but it's the best I could achieve.
	- Resolution isn't outstanding, but it's ok.
	- Torch beams (and probably most other light sources) aren't reflected.

Changes:

	- Changed the way the function is implemented. Objects no longer need to have setObjectTexture run on them from the editor!!!
		- Instructions have changed due to this, but are now MUCH simpler.
	- Added glass breaking.
		- 1-3 shots at random.
		- Breaks from explosions.
		- Glass shatter effect.
		- Glass breaking noise.
	- Added 50m distance check to mirrors being "active".