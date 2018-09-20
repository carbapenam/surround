//HW1: Stereophonic Sound II
//Due: Thursday, September 20 by 3pm
//30 points

/*
Create a new folder called HW1_LastName. In this folder, save this SuperCollider document and also add two subfolders called "source" and "output". Immediately below this comment, write some code to to properly configure and boot the SC audio server, as you did in the previous assignment.
*/

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

trig = Impulse.ar(1.9);
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
//Come back to this
{
var buf, path, env, trig, sig, freq, pan;

trig = Impulse.ar(2);
env = Line.kr(2, 1, 5, doneAction: 2);

path = (PathName.new(thisProcess.nowExecutingPath)).parentPath++"source/wine_glass_strike.aiff";

buf = Buffer.read(s, path);

freq = Demand.ar(trig, 0, Dseq((Scale.major.degrees++12).midiratio));

sig = PlayBuf.ar(1, buf, freq, trig);
sig = Pan2.ar(sig, env);
}.play
)



/*
Problem 2. Meandering Walk (10 points)
Extract five similar but unique footstep samples from Foley CD #4 (or find something similar elsewhere), trim them in Audacity if needed and put them in your source folder. Write some code that reads these five sound files into five unique buffers.

Then, write some code that simulates someone walking through the stereophonic field in a random, meandering way. Use a trigger signal to select and play a random sample for each footstep. The footsteps can be quick or slow, but should a realistic pace for footsteps. The speed of the walking movement through the stereophonic field should also be realistic (i.e. not magically "teleporting" from hard left to hard right). For additional realism, the playback rate should randomly vary above and below the original playback rate, but only slightly. The footsteps should fade in over five seconds, stay at full amplitude for ten seconds, and fade out again over five seconds, for a total duration of 20 seconds.
*/










//Using the s.makeGui method, record the sounds for all three problems, and use Audacity to convert each one to a trimmed stereo audio file (no excess silence at the beginning or end). Put these three audio files in your "output" folder. Last, compress your HW1_LastName folder as a zip file and upload it via the assignment page on the course website.