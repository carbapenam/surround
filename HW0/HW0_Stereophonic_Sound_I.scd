//HW0: Stereophonic Sound I
//Due: Thursday, September 13 by 3pm
//25 points

/*
Create a new folder called HW0_LastName (replace LastName with your own last name). In this folder, save this SuperCollider document and also add two subfolders called "source" and "output".
*/

/*
Problem 0. Preparation and Setup (5 points)

On the Foley CDs (or elsewhere), find a long, rich, noisy sound, at least 10 seconds in duration (e.g. air blowing, chains rattling, paper crumpling, etc). Your audio file must be in AIFF or WAV format. Use Audacity to convert from stereo to mono format, if necessary. Save this file in your "source" folder and give it a concise, descriptive name.
*/

//First, write some code to to configure and boot the SC audio server (correct number of output busses, correct number of recording channels):

(
//I was working at home. That's why this is not a 10 channel audio.
//Pls don't yell at me.

s.options.numOutputBusChannels = 2;
s.recChannels = 2;
s.boot;
)

//This is just for my convenience.
(
s.meter;
s.makeGui;
)

//Using the "thisProcess.nowExecutingPath" method, read your sound file into a Buffer, stored in a global variable:

~clapping = Buffer.read(s, PathName.new(thisProcess.nowExecutingPath).parentPath++"source/1106.wav");

/*
Problem 1. Stereo Panning I (10 points)
Write some code that plays your sound file and smoothly pans it back and forth across the stereophonic field in an oscillating manner. The oscillation of the left-right motion should start slowly, become faster during the middle of the sound file, and slow down again toward the end of the sound file. After writing your code, record your audio to the hard drive in real-time, as shown in class. Edit this file in Audacity as needed to create a stereo sound file, and save it as Problem_1.aiff (or .wav) in your "output" folder.
*/

(
~p1 = {
	var sig, panned_sig, sin, tri, period, freq;

	//speed up, reach the peak speed, slow down
	//that's just first half of a triangle waveform
	//
	//then, we'll set up the period of the wave to be the double
	//so that when we plug into the panning function, it would only
	//use upto the first half of the triangle save

	period = ~clapping.duration * 2;
	freq = 1.0 / period;
	tri = LFTri.ar(freq);
	sin = SinOsc.ar(0.5 + 2*tri);
	sig = PlayBuf.ar(1, ~clapping, doneAction:2);
	panned_sig = sig = Pan2.ar(sig, sin);
	Out.ar(0, panned_sig); //Pls don't yell at me. I was working at home. That's why I'm outputting at 0.
}.play;
)




/*
Problem 2. Stereo Panning II (10 points)
Write some code that uses multichannel expansion to create a two-channel version of your sound, in which the playback rate of both channels slowly and randomly meanders between 0.98 and 1.02. The randomness should be unique (different) for each channel. After writing your code, record your audio to the hard drive in real-time, as shown in class. Edit this file in Audacity as needed to create a stereo sound file, and save it as Problem_2.aiff (or .wav) in your "output" folder.
*/



(
~p2 = {
	var sig;
	Line.kr(0,0,~clapping.duration*1.02, doneAction:2);
	sig = PlayBuf.ar(1, ~clapping, [LFDNoise1.kr(1, 0.02, 1), LFDNoise1.kr(1, 0.02, 1)]);
	Out.ar(0,sig);
}.play;
)



//Finally, compress your HW0_LastName folder as a zip file and upload it via the assignment page on the course website.

