MIDIIn.connectAll;
~drums =  MIDIOut.newByName("Pro40", "MIDI");
~etudes = NetAddr("localhost", 6666);

Pdef(\midiClock,
    Pbind(
        \type, \midi,
        \midicmd, \midiClock,
        \dur, 1/24,
        \midiout, ~drums
    )
).quant_(4);

Pdef(\midiClock).play
TempoClock.sched(4, ~drums.start)

MIDIdef.cc(\midiCC,{
     arg val, cc, chan;
    [val,cc,chan].postln;
});


MIDIdef.cc(\nano1,{
    arg val;
    var mappedVal = val.linlin(0, 127, 2 ** 10, 2 ** 14);
    Ndef(\play).set(\bitMask, mappedVal);
    ~etudes.sendMsg("/ca/ca/bitMask", mappedVal.asInteger);
}, 0);

MIDIdef.cc(\nano2,{
    arg val;
    var mappedVal = val.linlin(0, 127, 0, 16).ceil;
    Ndef(\play).set(\rate, mappedVal);
    ~etudes.sendMsg("/ca/ca/rate", mappedVal.linexp(0, 16,16, 0.0001));
}, 1);

MIDIdef.cc(\nano3,{
    arg val;
    var mappedVal = val.linlin(0, 127, 0, 10).ceil;
    Ndef(\play).set(\bitshiftL, mappedVal);
    ~etudes.sendMsg("/ca/ca/bitshift1", (mappedVal).asInteger);
}, 2);

MIDIdef.cc(\nano4,{
    arg val;
    var mappedVal = val.linlin(0, 127, 0, 10).ceil;
    Ndef(\play).set(\bitshiftR, mappedVal);
    ~etudes.sendMsg("/ca/ca/bitshift2",(mappedVal).asInteger);
}, 3);

MIDIdef.cc(\nano5,{
    arg val;
    var mappedVal = val.linexp(0,127,16, 8192);
    Ndef(\play).set(\cutOff, mappedVal);
    ~etudes.sendMsg("/ca/ca/cutoff", mappedVal.linlin(0, 8192,0,1));
}, 4);

MIDIdef.cc(\nano5,{
    arg val;
    Ndef(\play).set(\cutOff, val.linexp(0,127,16, 8192));
}, 4);
