//HW2: Stereophonic Sound III
//Due: Thursday, September 27 by 3pm
//35 points

/*
Create a new folder called HW2_LastName. In this folder, save this SuperCollider document and also add two subfolders called "source" and "output". Immediately below this comment, write some code to to properly configure and boot the SC audio server, as you did in previous assignments.
*/





/*
Problem 0. Iterative Buffer Reading (5 points)

Copy the folder of muted piano samples from the Studio X Desktop to your "source" folder. Make sure to *copy* it, instead of moving it, leaving the original folder on the Desktop. These samples are also on the assignment page as a zip file for convenience. Write some code that reads these sound files into an array of Buffers (from your source folder) using thisProcess and collect.
*/






/*
Problem 1. Muted Piano Popcorn Texture (10 points)

First, create a simple SynthDef that reads a 1-channel sound file (the muted piano samples are already monophonic), applies an ampitude envelope, and pans the signal in stereo. Include arguments for buffer, playback rate, start position, envelope attack, envelope release, amplitude, and pan position.

Use patterns to create a sparse, infinite-length, popcorn-like texture of muted piano samples. The pattern should choose randomly from these ten samples, never choosing the same sample twice in a row. The envelopes should be very short, and the synths should be generated with an irregular rhythm. Amplitude, pan position, and playback rate should be random (exactly how much randomness is up to you). Render 5-10 seconds of this sound as an audio file and put it in your output folder.
*/







/*
Problem 2. Rhythm Exercise (10 points)

Use patterns to create a infinitely recurring rhythmic pattern of eight random piano samples. These should be 16th notes at at 120 beats per minute. In one iteration of these eight samples, the choice of samples should random, but this random order of eight samples should repeat indefinitely. Each first sample in this sequence of eight should have a relatively high amplitude, and the subsequent seven should be relatively quiet. Each sequence of eight samples should pan from left to right in alternating fashion (so that a sequence of 16 returns to where it started). Render 5-10 seconds of this sound as an audio file and put it in your output folder.
*/









/*
Problem 3. Cloud Texture (10 points)

Using patterns, create a shimmering, sustained texture, using only one of the ten piano samples. The pattern should generate Synths fast enough that consecutive amplitude envelopes overlap. The attack and release should be similar in length. The attack time should be long enough that the forceful onset of the piano sample is softened via fade-in, but not so long that it eats into the release. All parameters should be random (how much randomnes is up to you). Render 5-10 seconds of this sound as an audio file and put it in your output folder.
*/







