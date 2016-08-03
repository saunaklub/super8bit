s.boot
TempoClock.tempo_(120/60);

Ndef(\play, {
    arg rate = 7, bitshiftL = 3, bitshiftR = 5,
    bitMask = 4096, cutOff = 20, rate2 = 15,
    loopStartPos = 0, resetTime = 0.012, amp = 1;

    var tempo, sig,
    t = PulseCount.ar(Impulse.ar(8192), Impulse.ar(resetTime));

    t = t + loopStartPos;

    sig = (t * rate.ceil).bitAnd(t >> [bitshiftL, bitshiftR]) * (t * rate2 & bitMask);

    HPF.ar(sig, cutOff).tanh * amp;
    }
).quant_(4).play(0,2);

Ndef(\play).set(\bitMask, 2 << 9 )
Ndef(\play).set(\bitshiftL, 7);
Ndef(\play).set(\bitshiftR, 6);
Ndef(\play).set(\rate, 8);
Ndef(\play).set(\rate2, 5pi);
Ndef(\play).set(\amp, 1)
Ndef(\play).stop
