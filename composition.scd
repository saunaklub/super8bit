s.boot
TempoClock.tempo_(120/60);

"~/SuperCollider/sc-tools/functions.scd".asRelativePath.load;
"~/SuperCollider/sc-tools/mapper.scd".asRelativePath.load;

~makeReceiver.value(\etudes);

SynthDef(\bitSynth, {
    arg rate = 7, bitshiftL = 3, bitshiftR = 5,
    bitMask = 4096, cutOff = 20, rate2 = 15,
    loopStartPos = 0, resetTime = 0.012, amp = 1,
    output = 0;

    var tempo, sig,
    t = PulseCount.ar(Impulse.ar(8192), Impulse.ar(resetTime));

    t = t + loopStartPos;

    sig = (t * rate.ceil).bitAnd(t >> [bitshiftL, bitshiftR]) * (t * rate2 & bitMask);

    sig = HPF.ar(sig, cutOff).tanh * amp;
    Out.ar(output, sig);
    }
).add;

~makeSynth.value(\stereoBit, \bitSynth, [], 0, 2);

~connect.value(\stereoBit,0,2);
~synth

~synth[\stereoBit].set(\bitMask, 2 << 9 )

~synth[\stereoBit].set(\bitshiftL, 7);
~synth[\stereoBit].set(\bitshiftR, 6);
~synth[\stereoBit].set(\rate, 8);
~synth[\stereoBit].set(\rate2, 5pi);
~synth[\stereoBit].set(\amp, 1)

~disconnect(\stereoBit, 0);

~durs = [
    1
];

~bitMask = [
    
];

~addBusValue.value(\etudes, "/test", \stereoBit, 1);
~removeMessage.value(\etudes, "/test", \stereoBit, 1);

~addMessage.value(\etudes, "/test", 1)
~removeMessage.value(\etudes, "/test", 1)

~sendMessages.play

~func = {
    arg a,b,c;
    [a,b,c].postln;
};

x = [1,2,3]
~func.value(x)
