//HW1: Stereophonic Sound II
//Due: Thursday, September 20 by 3pm
//30 points

/*
Create a new folder called HW1_LastName. In this folder, save this SuperCollider document and also add two subfolders called "source" and "output". Immediately below this comment, write some code to to properly configure and boot the SC audio server, as you did in the previous assignment.
*/

//For studio X setup.

/*
(
s.options.numOutputBusChannels = 10;
s.reboot;
)
*/

//Comment this out if you are in studio X.
(
s.options.numOutputBusChannels = 2;
s.recChannels = 2;
s.reboot;
)


/*
Problem 0. Bouncing Sound (10 points)
Find a very short, dry (i.e. little or no reverberation), percussive sound, such as the sound of a small object being dropped (there are ping-pong ball sounds on Foley CD #8). Copy this sound to your source folder, trimming it first in Audacity if needed, then write a line of code that reads this sound file into a Buffer using the thisProcess.nowExecutingPath method.

Then, write some code that simulates a bouncing object as it bounces from left to right across the stereophonic field. Each "bounce" should be represented by re-triggering your percussive sound. The total duration of this bouncing simulation should be five seconds. The bounces should move linearly from left to right, the amplitude of the bounces should get progressively quieter and eventually reach zero, and the time between bounces should get shorter and shorter (but not actually reach zero).
*/

(
{
var buf, path, env, trig, sig;

trig = Impulse.ar(1.99);
env = Line.ar(-1, 1, 5, doneAction: 2);

path = (PathName.new(thisProcess.nowExecutingPath)).parentPath++"source/metronome.wav";

buf = Buffer.read(s, path);

sig = PlayBuf.ar(1, buf, 1, trig);
sig = Pan2.ar(sig, env);
}.play
)



/*
Problem 1. Stereophonic Scale (10 points)
Copy the "wine_glass_strike.aiff" file from the Studio X Desktop to your "source" folder. Make sure to *copy* it, instead of moving it, leaving the original on the Desktop. This file is also uploaded to the assignment page on the course website for convenience. Write a line of code that reads this sound file (from your source folder) into a buffer.

Then, write some code that uses a triggered process to play a chromatic scale using this sample, starting at the original pitch and ending one octave higher, 13 notes altogether (on a piano keyboard, imagine starting at C, and playing all the notes in between up to and including the next-highest C). All notes should be panned hard left or hard right, in alternating fashion. The pace of the notes should get slightly slower over the course of the scale.
*/


(
{
var buf, path, env, trig, sig, freq, pan, rate;

rate = 2;
trig = Impulse.ar(rate);
pan = ToggleFF.ar(trig)*2-1; //This is so hacky, but i dig.

env = EnvGen.ar(Env.new([1, 1, 0], [13 * 1 / rate, 0]),
	  doneAction: 2); //so is this.

path = (PathName.new(thisProcess.nowExecutingPath)).parentPath++"source/wine_glass_strike.aiff";

buf = Buffer.read(s, path);

freq = Demand.ar(trig, 0, Dseq((Scale.chromatic.degrees++12).midiratio));

sig = PlayBuf.ar(1, buf, freq, trig) * env;
sig = Pan2.ar(sig, pan);
}.play
)



/*
Problem 2. Meandering Walk (10 points)
Extract five similar but unique footstep samples from Foley CD #4 (or find something similar elsewhere), trim them in Audacity if needed and put them in your source folder. Write some code that reads these five sound files into five unique buffers.

Then, write some code that simulates someone walking through the stereophonic field in a random, meandering way. Use a trigger signal to select and play a random sample for each footstep. The footsteps can be quick or slow, but should a realistic pace for footsteps. The speed of the walking movement through the stereophonic field should also be realistic (i.e. not magically "teleporting" from hard left to hard right). For additional realism, the playback rate should randomly vary above and below the original playback rate, but only slightly. The footsteps should fade in over five seconds, stay at full amplitude for ten seconds, and fade out again over five seconds, for a total duration of 20 seconds.
*/
(
{
var parent;
var buf, env;
var sig, trig, rate_offset, pan_offset, shuffler;
var freq = 2;

parent = (PathName.new(thisProcess.nowExecutingPath)).parentPath;


buf = [Buffer.read(s, parent++"source/footsteps/1.wav"),
Buffer.read(s, parent++"source/footsteps/2.wav"),
Buffer.read(s, parent++"source/footsteps/3.wav"),
Buffer.read(s, parent++"source/footsteps/4.wav"),
Buffer.read(s, parent++"source/footsteps/5.wav")
];

env = EnvGen.ar(Env.new([0.2,1, 1, 0], [5, 10, 5]),
	  doneAction: 2);

trig = Impulse.ar(freq);
pan_offset = LFDNoise0.ar(freq, 0.5, 0);
rate_offset = LFDNoise0.ar(freq, 0.1, 0);
shuffler = Drand.new(buf);

sig = PlayBuf.ar(out_chan,
	  Demand.ar(trig, 0, shuffler),
      1 + rate_offset, trig);

sig = Pan2.ar(sig, pan_offset);
}.play
)









//Using the s.makeGui method, record the sounds for all three problems, and use Audacity to convert each one to a trimmed stereo audio file (no excess silence at the beginning or end). Put these three audio files in your "output" folder. Last, compress your HW1_LastName folder as a zip file and upload it via the assignment page on the course website.