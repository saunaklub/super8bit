MIDIIn.connectAll;
~drums =  MIDIOut.newByName("Pro40", "MIDI");
~etudes = NetAddr("localhost", 6666);
~etudes = NetAddr("192.168.0.35", 6666);
~etudes = NetAddr("192.168.0.22", 6666);

~drums.noteOn(0, 34, 100)

Pdef(\midiClock,
    Pbind(
        \type, \midi,
        \midicmd, \midiClock,
        \dur, 1/24,
        \midiout, ~drums
    )
).quant_(4);

Pdef(\midiClock).play
Pdef(\midiClock).stop
TempoClock.sched(4, ~drums.start)

(
MIDIdef.cc(\midiCC,{
    arg val, cc, chan;
    [val,cc,chan].postln;
});

MIDIdef.cc(\nano1,{
    arg val;
    var mappedVal = val.linlin(0, 127, 2 ** 10, 2 ** 14);
    Ndef(\play).set(\bitMask, mappedVal);
    ~etudes.sendMsg(
        "/algosynth/algosynth/bitmask",
        mappedVal.asInteger
    );
}, 0);

MIDIdef.cc(\nano2,{
    arg val;
    var mappedVal = val.linexp(0, 127, 0.0001, 16).ceil;
    Ndef(\play).set(\rate, mappedVal);
    ~etudes.sendMsg(
        "/algosynth/algosynth/rate", 
        mappedVal.asFloat
    );
}, 1);

MIDIdef.cc(\nano3,{
    arg val;
    var mappedVal = val.linlin(0, 127, 0, 10).ceil;
    Ndef(\play).set(\bitshiftL, mappedVal);
    ~etudes.sendMsg(
        "/algosynth/algosynth/bitshift1",
        (mappedVal).asInteger
    );
}, 2);

MIDIdef.cc(\nano4,{
    arg val;
    var mappedVal = val.linlin(0, 127, 0, 10).ceil;
    Ndef(\play).set(\bitshiftR, mappedVal);
    ~etudes.sendMsg(
        "/algosynth/algosynth/bitshift2",
        (mappedVal).asInteger
    );
}, 3);

MIDIdef.cc(\nano5,{
    arg val;
    var mappedVal = val.linexp(0,127,16, 8192);
    Ndef(\play).set(\cutOff, mappedVal);
    ~etudes.sendMsg(
        "/algosynth/algosynth/cutoff", 
        mappedVal.linlin(0, 8192,1,0).asFloat
    );
}, 4);

MIDIdef.cc(\nano16,{
    arg val;
    ~etudes.sendMsg(
        "/algosynth/algosynth/program-values",
        val.asInteger
    );
}, 16);

MIDIdef.cc(\nano17,{
    arg val;
    ~etudes.sendMsg(
        "/algosynth/algosynth/program-colors",
        val.asInteger
    );
}, 17);

MIDIdef.cc(\nano18,{
    arg val;
    ~etudes.sendMsg(
        "/algosynth/algosynth/blend", 
        val.linexp(0, 127, 0.01, 1).asFloat
    );
}, 18);
)
