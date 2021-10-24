function [] = start (version)
%2 versions
%version 1: current situation, to compare with
%version 2: Lindo result
v=version;

%HIER KOLOMMEN MET LINDO resultaten kopi�ren (via excel?):
TOTCOST	=	7.65	;
TTMIN	=	3	;
TTK11C21	=	3	;
TTK11C10	=	3	;
TTC10K20	=	20	;
TTK10E20	=	5	;
TTK10M20	=	5	;
TTE11K21	=	3	;
TTM11K21	=	7	;
TTM11K10	=	3	;
IBK1C1	=	5	;
IBK1C0	=	9	;
IBC0K0	=	4	;
IBK0E0	=	2	;
IBK0M0	=	2	;
IBE1K1	=	2	;
IBM1K1	=	7	;
IBM1K0	=	10	;
DC10HE	=	0	;
STC0AA	=	1	;
DC10AA	=	10	;
BC0AAHA	=	4	;
AC10HA	=	40	;
DC11HA	=	5	;
STC1AA	=	1	;
DC11AA	=	32	;
AC11HE	=	41	;
DE10LE	=	0	;
STE0AA	=	1	;
DE10AA	=	13	;
AE10HA	=	38	;
DE11HA	=	0	;
STE1AA	=	18	;
DE11AA	=	43	;
BE1AALE	=	2	;
AE11LE	=	57	;
DK10HA	=	0	;
STK0AL	=	1	;
DK10AL	=	7	;
STK0ST	=	1	;
DK10ST	=	16	;
STK0LA	=	1	;
DK10LA	=	26	;
BK0LALE	=	2	;
AK10LE	=	55	;
DK11LE	=	0	;
STK1LA	=	1	;
DK11LA	=	28	;
STK1ST	=	1	;
DK11ST	=	38	;
STK1AL	=	1	;
DK11AL	=	47	;
BK1ALHA	=	9	;
AK11HA	=	62	;
DM10LE	=	0	;
STM0AA	=	1	;
DM10AA	=	15	;
AM10HE	=	27	;
DM11HE	=	19	;
STM1AA	=	1	;
DM11AA	=	32	;
BM1LEAA	=	7	;
AM11LE	=	53	;
STM1LE	=	1	;
DM20LE	=	60	;
DK20HA	=	60	;
DK21LE	=	60	;
DE20LE	=	60	;
STC0HA	=	25	;
DC21HA	=	65	;
STK0LE	=	1	;
UC0K0P	=	0	;
UC0K0N	=	0	;
UE1K1P	=	0	;
UE1K1N	=	0	;
UK0E0P	=	0	;
UK0E0N	=	0	;
UK1C0P	=	0	;
UK1C0N	=	0	;
UK1C1P	=	4	;
UK1C1N	=	0	;
UK0M0P	=	0	;
UK0M0N	=	0	;
UM1K0P	=	0	;
UM1K0N	=	3	;
UM1K1P	=	0	;
UM1K1N	=	0	;
DEVIAT	=	7.65	;


%late arrival, on average, during peak hours, 1/lambda
Eav=4;
Cav=2;
Kav=3;
Mav=5;

%"necessary" transfer time is 3 minutes
TT=3; 

%VOT: value of time, weight for different types of waiting
WEA= 2;     %early arrival, normal waiting
WMT= 2.2;   %waiting due to a missed train
WLA= 2.5;   %arriving late at final destination
WST= 1.5; 	%Waiting in a stopped train due to early arrival
            
%number of arriving passengers at final destination
ARC10Ha= 3491;
ARK11Ha= 8422;
ARK10Le= 14474;
ARE11Le= 7718;
ARM11Le= 4890;

%number of through passengers per train
THC10Ha= 1745;
THC0Aa=980;
THC1Aa=980;

THE11Le= 23155;
THE0Aa=18024;
THE1Aa=18024;

THK0Al=9054;
THK0St=5109;
THK0La=5817;
THK10Le= 43423;
THK1Al=9054;
THK1St=5109;
THK1La=5817;
THK11Ha= 4227;

THM0Aa=3002;
THM11Le= 0;
THM1Aa=3002;

%transfer passengers
TK11C21=121;
TK11C10=8422;
TC10K20=119;
TK10E20=152;
TK10M20=136;
TE11K21=298;
TM11K21=245;
TM11K10=14671;
Total_number_transfer_pass= TK11C21+TK11C10+TC10K20+TK10E20+TK10M20+TE11K21+TM11K21+TM11K10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% !!!!!!!!!!!!LINDO results!!!!!!!!!!!! %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%stopping times, cost must be added
%!!!!!!!!substract one minute of the stopping times from lindo
%stopping cost in stations: SC0Aa*1.5*THC0Aa
SC0Aa=[4 (STC0AA-1)];
SC0Ha=[5 (STC0HA-1)];
SC1Aa=[4 (STC1AA-1)];

SE0Aa=[1 (STE0AA-1)];
SE1Aa=[1 (STE1AA-1)];

SK0Al=[0 (STK0AL-1)];
SK0St=[0 (STK0ST-1)];
SK0La=[1 (STK0LA-1)];
SK0Le=[1 (STK0LE-1)];
SK1Al=[0 (STK1AL-1)];
SK1St=[0 (STK1ST-1)];
SK1La=[1 (STK1LA-1)];

SM0Aa=[0 (STM0AA-1)];
SM1Aa=[0 (STM1AA-1)];
SM1Le=[0 (STM1LE-1)]; 

stopping_cost= WST*(SC0Aa(v)*THC0Aa+SC0Ha(v)*THC10Ha+SC1Aa(v)*THC1Aa+SE0Aa(v)*THE0Aa+SE1Aa(v)*THE1Aa+SK0Al(v)*THK0Al+SK0St(v)*THK0St+SK0La(v)*THK0La+SK0Le(v)*THK10Le+SK1Al(v)*THK1Al+SK1St(v)*THK1St+SK1La(v)*THK1La+SM0Aa(v)*THM0Aa+SM1Aa(v)*THM1Aa+SM1Le(v)*THM11Le);
%scheduled departure minutes
%C-train
DC10He=[0 DC10HE];  %vertrektijd eerste trein uit heist trein C0
DC20He=DC10He + [60 60]; % [dus de freq. is 1/h] voor de periodiciteit 
DC30He=DC20He + [60 60];
DC10Aa=[14 DC10AA];
DC20Aa=DC10Aa + [60 60];
DC30Aa=DC20Aa + [60 60];
AC10Ha=[40 AC10HA];
AC20Ha=AC10Ha + [60 60];
AC30Ha=AC20Ha + [60 60];
DC10Ha=[46 (AC10HA+STC0HA)]; 	%based on AC10Ha and STCOHa from lindo
DC20Ha=DC10Ha + [60 60];
DC30Ha=DC20Ha + [60 60];

AC11He=[60 AC11HE];
AC21He=AC11He + [60 60];
AC31He=AC21He + [60 60];
DC11Aa=[51 DC11AA];
DC21Aa=DC11Aa + [60 60];
DC31Aa=DC21Aa + [60 60];
DC11Ha=[20 DC11HA];
DC21Ha=DC11Ha + [60 60];
DC31Ha=DC21Ha + [60 60];

%E-train
DE10Le=[71 DE10LE];
DE20Le=DE10Le +[60 60];
DE30Le=DE20Le +[60 60];
DE10Aa=[85 DE10AA];
DE20Aa=DE10Aa +[60 60];
DE30Aa=DE20Aa +[60 60];
AE10Ha=[110 AE10HA];
AE20Ha=AE10Ha +[60 60];
AE30Ha=AE20Ha +[60 60];

AE11Le=[49 AE11LE]; 
AE21Le=AE11Le +[60 60];
AE31Le=AE21Le +[60 60];
DE11Aa=[37 DE11AA];
DE21Aa=DE11Aa +[60 60];
DE31Aa=DE21Aa +[60 60];
DE11Ha=[10 DE11HA];
DE21Ha=DE11Ha +[60 60];
DE31Ha=DE21Ha +[60 60];

%K-train
DK11Le=[35 DK11LE];
DK21Le=DK11Le + [60 60];
DK31Le=DK21Le + [60 60];
DK11La=[64 DK11LA];
DK21La=DK11La + [60 60];
DK31La=DK21La + [60 60];
DK11St=[74 DK11ST];
DK21St=DK11St + [60 60];
DK31St=DK21St + [60 60];
DK11Al=[83 DK11AL];
DK21Al=DK11Al + [60 60];
DK31Al=DK21Al + [60 60];
AK11Ha=[89 AK11HA];
AK21Ha=AK11Ha + [60 60];
AK31Ha=AK21Ha + [60 60];

AK10Le=[85 AK10LE];
AK20Le=AK10Le + [60 60];
AK30Le=AK20Le + [60 60];
DK10Le=[87 (AK10LE+STK0LE)];%based on AK10Le and STK0Le 
DK20Le=DK10Le + [60 60];
DK30Le=DK20Le + [60 60];
DK10La=[58 DK10LA];
DK20La=DK10La + [60 60];
DK30La=DK20La + [60 60];
DK10St=[47 DK10ST];
DK20St=DK10St + [60 60];
DK30St=DK20St + [60 60];
DK10Al=[38 DK10AL];
DK20Al=DK10Al + [60 60];
DK30Al=DK20Al + [60 60];
DK10Ha=[31 DK10HA];
DK20Ha=DK10Ha + [60 60];
DK30Ha=DK20Ha + [60 60];

%M-train;
DM11He=[19 DM11HE];
DM21He=DM11He + [60 60];
DM31He=DM21He + [60 60];
DM11Aa=[32 DM11AA];
DM21Aa=DM11Aa + [60 60];
DM31Aa=DM21Aa + [60 60];
AM11Le=[46 AM11LE];
AM21Le=AM11Le + [60 60];
AM31Le=AM21Le + [60 60];

AM10He=[101 AM10HE];
AM20He=AM10He + [60 60];
AM30He=AM20He + [60 60];
DM10Aa=[89 DM10AA];
DM20Aa=DM10Aa + [60 60];
DM30Aa=DM20Aa + [60 60];
DM10Le=[74 DM10LE];
DM20Le=DM10Le + [60 60];
DM30Le=DM20Le + [60 60];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% actual running time = ideal running time + some "delay"
% "delay" is calculated based on an inverse transformation of a random number
% random number, inverse transformation (Winston p.1204): -1/lambda*ln r, 
% exponential distribution for every actual running time
% only usefull to calculate for trains arriving in Hasselt or Leuven

% ideal running times first 
%C
CHeAa=9; 
CAaHa=26; 
%E
ELeAa=12;
EAaHa=25; 
%K
KHaAl=6;
KAlSt=8;
KStLa=9;
KLaLe=27; 
%M
MLeAa=14;
MAaHe=12;

%number of simulation runs
a=5000;
%passengers_arriving_late: passengers arriving late more minutes than "too_late" 
%cost_arriving_late is the cost associated with arriving late
%delay contains the minutes of delay
too_late=3;
%long_transfer_time if passengers have to wait more than "WA" minutes
WA=20;

for i=1:1:a
	%determine the real arriving times
	%these are compared later with the scheduled arrival times
   ac10ha= DC10Aa(v)+CAaHa + (round(-Cav*log(rand)));
  
   %ae10ha= DE10Aa(v)+EAaHa + (round(-Eav*log(rand)));%not required
   
	ae11le= DE11Aa(v)+ELeAa + (round(-Eav*log(rand)));

	ak11ha= DK11Al(v)+KHaAl + (round(-Kav*log(rand)));

	ak10le= DK10La(v)+KLaLe + (round(-Kav*log(rand)));

	am11le= DM11Aa(v)+MLeAa + (round(-Mav*log (rand)));

   %arriving and through passengers
%C10
   if ac10ha>AC10Ha(v);							%we have a delay
      mc10=(ac10ha-AC10Ha(v));					%minutes of delay
      pc10=mc10*ARC10Ha*WLA;					%cost of this delay
      pzc10=0;									%cost of arriving early
      if ac10ha-AC10Ha(v)>too_late;
         uc10= ARC10Ha;	%number of passengers arriving late due to this delay 
      else
         uc10=0;
      end
   else
      uc10=0;
      mc10=0;
      pc10=0;
      pzc10=(AC10Ha(v)-ac10ha)*THC10Ha*WST;     %cost of arriving early
   end

%E11
   if ae11le>AE11Le(v);								
      me11=(ae11le-AE11Le(v));					
		pe11=me11*ARE11Le*WLA;					
      pze11=0;
      if ae11le-AE11Le(v)>too_late;
         ue11= ARE11Le;	 
      else
         ue11=0;
      end
   else
      ue11=0;
      me11=0;
      pe11=0;
      pze11=(AE11Le(v)-ae11le)*THE11Le*WST;
   end   

%K10
   if ak10le>AK10Le(v);								%we have a delay
      mk10=(ak10le-AK10Le(v));					%minutes of delay
		pk10=mk10*ARK10Le*WLA;					%cost of this delay
      pzk10=0;
     if ak10le-AK10Le(v)>too_late;
         uk10= ARK10Le;	%number of passengers arriving late due to this delay 
      else
         uk10=0;
      end
   else
      uk10=0;
      mk10=0;
      pk10=0;
      pzk10=(AK10Le(v)-ak10le)*THK10Le*WST;
   end 

%K11
   if ak11ha>AK11Ha(v);								%we have a delay
      mk11=(ak11ha-AK11Ha(v));					%minutes of delay
		pk11=mk11*ARK11Ha*WLA;					%cost of this delay
       pzk11=0;
     if ak11ha-AK11Ha(v)>too_late;
         uk11= ARK11Ha;	%number of passengers arriving late due to this delay 
      else
         uk11=0;
      end
   else
      uk11=0;
      mk11=0;
      pk11=0;
      pzk11=(AK11Ha(v)-ak11ha)*THK11Ha*WST;
  end 

%M11
   if am11le>AM11Le(v);								%we have a delay
      mm11=(am11le-AM11Le(v));					%minutes of delay
		pm11=mm11*ARM11Le*WLA;					%cost of this delay
      pzm11=0;
    if am11le-AM11Le(v)>too_late;
         um11= ARM11Le;	%number of passengers arriving late due to this delay 
      else
         um11=0;
      end
   else
      um11=0;
      mm11=0;
      pm11=0;
      pzm11=(AM11Le(v)-am11le)*THM11Le*WST;
   end 

  	passengers_arriving_late(i)=uc10+ue11+uk11+uk10+um11;
   delay(i)=mc10+me11+mk11+mk10+mm11;
   cost_arriving_late(i)=pc10+pe11+pk11+pk10+pm11;
	cost_through_passengers(i)=pzc10+pze11+pzk11+pzk10+pzm11;
 
   %transfers
%K11C21
   if v==2
      if ak11ha+TT>DC21Ha(v);								%missed the transfer
         %waiting for the next train, in this case E31!!!
         cmk11c21= (DE31Ha(v)-ak11ha-TT)*TK11C21*WMT;        %cost of missed transfer
         pmk11c21=TK11C21;                                   %number_passengers_missed
         plk11c21=TK11C21;                                   %number_passengers_long
   	else	%transfer early or on schedule
         cmk11c21= (DC21Ha(v)-ak11ha-TT)*TK11C21*WEA;
         pmk11c21=0;
         if ak11ha+TT+WA<DC21Ha(v);                         %long transfer
            plk11c21=TK11C21;                               %number_passengers_long
         else
            plk11c21=0;
         end
      end
   else	%v==1
      if ak11ha+TT>DE21Ha(v);
         cmk11c21= (DE31Ha(v)-ak11ha-TT)*TK11C21*WMT;
         pmk11c21=TK11C21;
         plk11c21=TK11C21;
      else
         cmk11c21= (DE21Ha (v)-ak11ha-TT)*TK11C21*WEA;
         pmk11c21=0;
         if ak11ha+TT+WA<DE21Ha(v);
            plk11c21=TK11C21;
         else
            plk11c21=0;
         end
      end
   end
%K11C10
   if v==2
      if ak11ha+TT> DC10Ha(v)
         cmk11c10= (DC20Ha(v)-ak11ha-TT)*TK11C10*WMT;
         pmk11c10=TK11C10;
         plk11c10=TK11C10;
     	else
         cmk11c10= (DC10Ha(v)-ak11ha-TT)*TK11C10*WEA;
         pmk11c10=0;
         if ak11ha+TT+WA<DC10Ha(v)
            plk11c10=TK11C10;
         else
            plk11c10=0;
         end   
      end
   else %v=1
      if ak11ha+TT>DC20Ha(v)
         cmk11c10= (DC30Ha(v)-ak11ha-TT)*TK11C10*WMT;
         pmk11c10=TK11C10;
         plk11c10=TK11C10;
      else
         cmk11c10= (DC20Ha(v)-ak11ha-TT)*TK11C10*WEA;
         pmk11c10=0;
         if ak11ha+TT+WA<DC20Ha(v)
            plk11c10=TK11C10;
         else
            plk11c10=0;
         end   
      end
    end
%C10K20
      if ac10ha+TT> DK20Ha(v);
         cmc10k20=(DK30Ha(v)-ac10ha-TT)*TC10K20*WMT;
         pmc10k20=TC10K20;
         plc10k20=TC10K20;
     else
         cmc10k20=(DK20Ha(v)-ac10ha-TT)*TC10K20*WEA;       
         pmc10k20=0;
         if ac10ha+TT+WA<DK20Ha(v);
            plc10k20=TC10K20;
         else
            plc10k20=0;
         end
      end
%K10E20
   if ak10le+TT>DE20Le(v)
      cmk10e20= (DE30Le(v)-ak10le-TT)*TK10E20*WMT;
      pmk10e20=TK10E20;
      plk10e20=TK10E20;
   else
      cmk10e20= (DE20Le(v)-ak10le-TT)*TK10E20*WEA;
      pmk10e20=0;
      if ak10le+TT+WA<DE20Le(v)
         plk10e20=TK10E20;
      else
         plk10e20=0;
      end   
   end
%K10M20
	if ak10le+TT>DM20Le(v)
      cmk10m20= (DM30Le(v)-ak10le-TT)*TK10M20*WMT;
      pmk10m20=TK10M20; 
      plk10m20=TK10M20;
   else
      cmk10m20= (DM20Le(v)-ak10le-TT)*TK10M20*WEA;
      pmk10m20=0;
      if ak10le+TT+WA<DM20Le(v)
         plk10m20=TK10M20;
      else
         plk10m20=0;
      end   
   end
%E11K21
	if ae11le+TT>DK21Le(v)
      cme11k21=(DK31Le(v)-ae11le-TT)*TE11K21*WMT;
      pme11k21=TE11K21;
      ple11k21=TE11K21;
   else
      cme11k21=(DK21Le(v)-ae11le-TT)*TE11K21*WEA;
      pme11k21=0;
      if ae11le+TT+WA<DK21Le(v)
         ple11k21=TE11K21;
      else
         ple11k21=0;
      end   
   end

%M11K21 & M21K31
	if am11le+TT>DK21Le(v)
      cmm11k21=(DK31Le(v)-am11le-TT)*TM11K21*WMT;
      pmm11k21=TM11K21; 
      plm11k21=TM11K21;
   else
      cmm11k21=(DK21Le(v)-am11le-TT)*TM11K21*WEA;
      pmm11k21=0;
      if am11le+TT+WA<DK21Le(v)
         plm11k21=TM11K21;
      else
         plm11k21=0;
      end   
   end
%M11K10
	if am11le+TT>DK10Le(v)
      cmm11k10=(DK20Le(v)-am11le-TT)*TM11K10*WMT;
      pmm11k10=TM11K10; 
      plm11k10=TM11K10;
   else
      cmm11k10=(DK10Le(v)-am11le-TT)*TM11K10*WEA;
      pmm11k10=0;
      if am11le+TT+WA<DK10Le(v)
         plm11k10=TM11K10;
      else
         plm11k10=0;
      end   
   end

   cost_of_transfers(i)=      cmk11c21+cmc10k20+cmk10e20+cmk10m20+cme11k21+cmm11k21+cmm11k10+cmk11c10;
   missed_transfers(i)=pmk11c21+pmc10k20+pmk10e20+pmk10m20+pme11k21+pmm11k21+pmm11k10+pmk11c10;
   long_transfers(i)=  plk11c21+plc10k20+plk10e20+plk10m20+ple11k21+plm11k21+plm11k10+plk11c10;
end
missed_transfers;
long_transfers; 	%due to long OR MISSED transfer 
passengers_arriving_late;
total_passengers_arriving_late= sum(passengers_arriving_late)/a;
total_missed_transfers= sum(missed_transfers)/a;
total_long_transfers= sum(long_transfers)/a;
percentage_missed=100*total_missed_transfers/Total_number_transfer_pass
percentage_long=100*total_long_transfers/Total_number_transfer_pass
stopping_cost
total_cost_arriving_late= sum(cost_arriving_late)/a
total_delay=sum(delay)/a
total_cost_through_passengers= sum(cost_through_passengers)/a
total_cost_of_transfers= sum(cost_of_transfers)/a

totale_kost= stopping_cost + total_cost_arriving_late + total_cost_of_transfers + total_cost_through_passengers 