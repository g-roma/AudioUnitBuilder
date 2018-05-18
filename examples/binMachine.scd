(

var name, func, specs, componentSubtype, builder;

name = "binMachine";


func ={
| ptn1=8, ptn2=0, ptn3=0, ptn4=0,
  gain1=0.5, cf1=440, m1f1=440, m2f1=440, dec1=0.1,
  gain2=0.5, cf2=440, m1f2=440, m2f2=440, dec2=0.1,
  gain3=0.5, cf3=440, m1f3=440, m2f3=440, dec3=0.1,
  gain4=0.5, cf4=440, m1f4=440, m2f4=440, dec4=0.1 |

  var trig, reset,seq, ptnTable;
  var seq1, seq2, seq3, seq4;
  var d1, d2, d3, d4;
  var o1, o2, o3, o4;

  ptnTable = #[
  	[0,0,0,0],[0,0,0,1],[0,0,1,0],[0,0,1,1],
  	[0,1,0,0],[0,1,0,1],[0,1,1,0],[0,1,1,1],
  	[1,0,0,0],[1,0,0,1],[1,0,1,0],[1,0,1,1],
  	[1,1,0,0],[1,1,0,1],[1,1,1,0],[1,1,1,1]
  ];// binary numbers from 0 to 15

  trig = InTrig.kr(0);
  reset = InTrig.kr(1);

  seq1 =  Dseq(Select.kr(ptn1, ptnTable), inf);
  seq2 =  Dseq(Select.kr(ptn2, ptnTable), inf);
  seq3 =  Dseq(Select.kr(ptn3, ptnTable), inf);
  seq4 =  Dseq(Select.kr(ptn4, ptnTable), inf);

  d1 = Demand.kr(trig+reset , reset, seq1) * trig;
  d2 = Demand.kr(trig+reset, reset, seq2) * trig;
  d3 = Demand.kr(trig+reset, reset, seq3) * trig;
  d4 = Demand.kr(trig+reset, reset, seq4) * trig;

  o1 = SinOsc.ar(cf1 * SinOsc.kr(m1f1 * SinOsc.kr(m2f1) , add:1 )) * Decay.kr(d1, dec1) *gain1;
  o2 = SinOsc.ar(cf2 * SinOsc.kr(m1f2 * SinOsc.kr(m2f2) , add:1 )) * Decay.kr(d2, dec2) *gain2;
  o3 = SinOsc.ar(cf3 * SinOsc.kr(m1f3 * SinOsc.kr(m2f3) , add:1 )) * Decay.kr(d3, dec3) *gain3;
  o4 = SinOsc.ar(cf4 * SinOsc.kr(m1f4 * SinOsc.kr(m2f4) , add:1 )) * Decay.kr(d4, dec4) *gain4;

  Out.ar([0,1], Mix.new([o1,o2,o3,o4]));

};

specs =  #[
		[ 0,15, \Linear,8, \Indexed ],
		[ 0,15, \Linear,0, \Indexed ],
		[0,15, \Linear,0, \Indexed ],
		[0,15, \Linear,0, \Indexed ],

		[0, 1,\Linear, 0.5, \LinearGain ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[0.1 ,1, \Linear,0.1,\Seconds ],

		[0, 1,\Linear, 0.5, \LinearGain ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[0.1 ,1, \Linear,0.1,\Seconds ],

		[0, 1,\Linear, 0.5, \LinearGain ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[0.1 ,1, \Linear,0.1,\Seconds ],

		[0, 1,\Linear, 0.5, \LinearGain ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[20 , 2000, \Logarithmic,440,\Hertz ],
		[0.1 ,1, \Linear,0.1,\Seconds ]

];


componentSubtype = "BIM1";

builder = AudioUnitBuilder.new(name, componentSubtype,func, specs);
builder.beatDiv=8;
builder.doNoteOn=true;
builder.makeInstall;
)
