s.boot
TempoClock.tempo_(120/60);

Ndef(\play, {
    arg rate = 7, bitshiftL = 3, bitshiftR = 1,
    bitMask = 1, cutOff = 20,
    loopStartPos = 0, resetTime = 0.012, amp = 1;

    var tempo, sig,
    t = PulseCount.ar(Impulse.ar(8192), Impulse.ar(resetTime));

    t = t + loopStartPos;

    sig = (t * rate.ceil).bitAnd(t >> [bitshiftL, bitshiftR]) & bitMask;

    HPF.ar(sig, cutOff) * amp;
    }
).quant_(4).play(0,2);

