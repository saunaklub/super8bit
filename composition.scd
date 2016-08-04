s.boot
TempoClock.tempo_(120/60);

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

~addValue.value(\etudes, "/test", \stereoBit);
~removeValue.value(\etudes, "/test", \stereoBit);


~sendValues.play
~sendValues.stop
