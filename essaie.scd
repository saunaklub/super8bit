s.boot
sig = (t * rate) & (t >> [bitshiftL, bitshiftR]) & bitMask;

Ndef(\play, {
    var t = PulseCount.ar(Impulse.ar(8e3));
    HPF.ar(
        (
            ((t * 14) & (t >> 6)) |
            ((t * 5)  & (t >> [3, 7])) |
            ((t * 2)  & (t >> 2)) |
            ((t * 1)  & (t >> 8))
            - 1 & (2 ** 16 - 1)
        ) / 127-1 * 3
        , 20
    ).tanh
}).play;

Ndef(\play, {
    arg x = 7, module = 1023, loopStartPos = 0, resetTime = 0.0001;
    var t = PulseCount.ar(Impulse.ar(8e3), Impulse.ar(resetTime));
    t = t + loopStartPos;
    HPF.ar(
        (
             ( t * 9 & (t >> [3, 5]) | ((t * 5) & (t >> x)) | ((t * 3) & (t >> 10)) ) & module
    )

        , 20).tanh
}).play(0,2);

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

Ndef(\play).set(\rate, 10)
Ndef(\play).set(\bitMask, 2 ** 15 -1)
Ndef(\play).set(\bitshift, 10);
Ndef(\play).get(\module, {arg val; val.postln;})
Ndef(\play).get(\bitMask, {arg val; val.postln;})

TempoClock.tempo_(120/60);
