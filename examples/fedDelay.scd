
(
var name, func, specs, componentType, componentSubtype, builder;

name = "fedDelay";
func =  {
 	| tap1Time=0.1,  tap1Feedback=0.1,
 	  tap2Time=0.1,  tap2Feedback=0.1,
 	  tap3Time=0.1,  tap3Feedback=0.1,
 	  tap4Time=0.1,  tap4Feedback=0.1|

 	var tap1, tap2, tap3, tap4;
	var local, in, amp, feedBackMix, tapArray;
	var maxDelay = 3;

	in = Mix.new(AudioIn.ar([1,2]));

	local = LocalIn.ar(4);
   	feedBackMix = Mix.new(local);

   	tap1 = AllpassN.ar((feedBackMix * tap1Feedback) +in*(1-tap1Feedback), maxDelay, tap1Time,  0.2);
   	tap2 = AllpassN.ar((feedBackMix * tap2Feedback) +in*(1-tap2Feedback), maxDelay, tap2Time, 0.2);
   	tap3 = AllpassN.ar((feedBackMix * tap3Feedback) +in*(1-tap3Feedback), maxDelay, tap3Time, 0.2);
   	tap4 = AllpassN.ar((feedBackMix * tap4Feedback) +in*(1-tap4Feedback), maxDelay, tap4Time,  0.2);

   	tapArray = [ tap1, tap2, tap3, tap4 ];

   	 LocalOut.ar(tapArray);

	Out.ar(0, Pan2.ar(Mix.new(tapArray)));
};

specs =  #[
	[0, 2 , \Linear, 0.1,\Seconds ] ,
	[0, 0.5 , \Linear, 0.1,\LinearGain ] ,
	[0, 2 , \Linear, 0.1,\Seconds ] ,
	[0, 0.5 , \Linear, 0.1,\LinearGain ] ,
	[0, 2 , \Linear, 0.1,\Seconds ] ,
	[0, 0.5 , \Linear, 0.1,\LinearGain ] ,
	[0, 2 , \Linear, 0.1,\Seconds ] ,
	[0, 0.5 , \Linear, 0.1,\LinearGain ]
];


componentType = \aufx;

componentSubtype = "FEDL";

builder = AudioUnitBuilder.new(name, componentSubtype,func, specs, componentType);

builder.makeInstall;
)
