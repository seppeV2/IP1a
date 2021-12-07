function [] = basis
%2 versions
%version 1: current situation, to compare with
%version 2: Lindo result
v=2;
plot=1;

lindoRes = transformLindoData('lindoResults.txt');
%HIER KOLOMMEN MET LINDO resultaten kopiëren (via excel?):
STK1AL	=	lindoRes.STK1AL	;
STE1AA	=	lindoRes.STE1AA	;
STM1AA	=	lindoRes.STM1AA	;
DC10HE	=	lindoRes.DC10HE	;
DK10AL	=	lindoRes.DK10AL;
AK11HA	=	lindoRes.AK11HA	;
TOTCOST	=	lindoRes.TOTCOST;
TTMIN	=	lindoRes.TTMIN	;
TTK11C21	=	lindoRes.TTK11C21	;
TTK11C10	=	lindoRes.TTK11C10	;
TTC10K20	=	lindoRes.TTC10K20	;
TTK10E20	=	lindoRes.TTK10E20	;
TTK10M20	=	lindoRes.TTK10M20	;
TTE11K21	=	lindoRes.TTE11K21	;
TTM11K21	=	lindoRes.TTM11K21	;
TTM11K10	=	lindoRes.TTM11K10	;
IBK1C1	=	lindoRes.IBK1C1	;
IBK1C0	=	lindoRes.IBK1C0	;
IBC0K0	=	lindoRes.IBC0K0	;
IBK0E0	=	lindoRes.IBK0E0	;
IBK0M0	=	lindoRes.IBK0M0	;
IBE1K1	=	lindoRes.IBE1K1	;
IBM1K1	=	lindoRes.IBM1K1	;
IBM1K0	=	lindoRes.IBM1K0	;
STC0AA	=	lindoRes.STC0AA	;
DC10AA	=	lindoRes.DC10AA	;
BC0AAHA	=	lindoRes.BC0AAHA;
AC10HA	=	lindoRes.AC10HA	;
DC11HA	=	lindoRes.DC11HA	;
STC1AA	=	lindoRes.STC1AA	;
DC11AA	=	lindoRes.DC11AA	;
AC11HE	=	lindoRes.AC11HE	;
DE10LE	=	lindoRes.DE10LE	;
STE0AA	=	lindoRes.STE0AA	;
DE10AA	=	lindoRes.DE10AA	;
AE10HA	=	lindoRes.AE10HA	;
DE11HA	=	lindoRes.DE11HA	;
DE11AA	=	lindoRes.DE11AA	;
BE1AALE	=	lindoRes.BE1AALE;
AE11LE	=	lindoRes.AE11LE	;
DK10HA	=	lindoRes.DK10HA	;
STK0AL	=	lindoRes.STK0AL	;
STK0ST	=	lindoRes.STK0ST	;
DK10ST	=	lindoRes.DK10ST	;
STK0LA	=	lindoRes.STK0LA	;
DK10LA	=	lindoRes.DK10LA	;
BK0LALE	=	lindoRes.BK0LALE	;
AK10LE	=	lindoRes.AK10LE	;
DK11LE	=	lindoRes.DK11LE	;
STK1LA	=	lindoRes.STK1LA	;
DK11LA	=	lindoRes.DK11LA	;
STK1ST	=	lindoRes.STK1ST	;
DK11ST	=	lindoRes.DK11ST	;
DK11AL	=	lindoRes.DK11AL	;
BK1ALHA	=	lindoRes.BK1ALHA	;
DM10LE	=	lindoRes.DM10LE	;
STM0AA	=	lindoRes.STM0AA	;
DM10AA	=	lindoRes.DM10AA	;
AM10HE	=	lindoRes.AM10HE	;
DM11HE	=	lindoRes.DM11HE	;
DM11AA	=	lindoRes.DM11AA	;
BM1LEAA	=	lindoRes.BM1LEAA	;
AM11LE	=	lindoRes.AM11LE	;
STM1LE	=	lindoRes.STM1LE	;
DM20LE	=	lindoRes.DM20LE	;
DK20HA	=	lindoRes.DK20HA	;
DK21LE	=	lindoRes.DK21LE	;
DE20LE	=	lindoRes.DE20LE	;
STC0HA	=	lindoRes.STC0HA	;
DC21HA	=	lindoRes.DC21HA	;
STK0LE	=	lindoRes.STK0LE	;
UC0K0P	=	lindoRes.UC0K0P	;
UC0K0N	=	lindoRes.UC0K0N	;
UE1K1P	=	lindoRes.UE1K1P	;
UE1K1N	=	lindoRes.UE1K1N	;
UK0E0P	=	lindoRes.UK0E0P	;
UK0E0N	=	lindoRes.UK0E0N	;
UK1C0P	=	lindoRes.UK1C0P	;
UK1C0N	=	lindoRes.UK1C0N	;
UK1C1P	=	lindoRes.UK1C1P	;
UK1C1N	=	lindoRes.UK1C1N	;
UK0M0P	=	lindoRes.UK0M0P	;
UK0M0N	=	lindoRes.UK0M0N	;
UM1K0P	=	lindoRes.UM1K0P	;
UM1K0N	=	lindoRes.UM1K0N	;
UM1K1P	=	lindoRes.UM1K1P	;
UM1K1N	=	lindoRes.UM1K1N	;
DK20AL	=	lindoRes.DK20AL	;
DK20ST	=	lindoRes.DK20ST	;
TTCOST	=	lindoRes.TTCOST	;
STCOST	=	lindoRes.STCOST	;
DEVIAT	=	lindoRes.DEVIAT	;



TT=3; %"necessary" transfer time is 3 minutes

%VOT: value of time, weight for different types of waiting
WEA= 2;     %early arrival, normal waiting
WMT= 2.2;   %waiting due to a missed train
WLA= 2.5;   %arriving late at final destination
WST= 1.5; 	%Waiting in a stopped train due to early arrival

%WEA= 1;	%what if no weights are used
%WMT= 1;
%WLA= 1;
%WST= 1;

%number of arriving passengers at final destination
ARC10Ha= 3491;
ARK11Ha= 8422;
ARK10Le= 14474;
ARE11Le= 7718;
ARM11Le= 4890;

%number of through passengers per train
THC10Ha= 1745;
THK11Ha= 4227;
THK10Le= 43423;
THE11Le= 23155;
THM11Le= 0;

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

%through passengers in other stations
THC1Aa=980;
THC0Aa=980;
THE0Aa=18024;
THE1Aa=18024;
THK0Al=9054;
THK0St=5109;
THK0La=5817;
THK1Al=9054;
THK1St=5109;
THK1La=5817;
THM0Aa=3002;
THM1Aa=3002;

%stopping times, cost must be added
%!!!!!!!!substract one minute of the stopping times from lindo
%stopping cost in stations: SC0Aa*1.5*THC0Aa
% [stopping cost (per trein nummer lijn) trein 0 in aarschot, maal het gewicht maal doorgaande passagiers]

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

% actual running time = ideal running time + some "delay"
% "delay" is calculated based on an inverse transformation of a random number
% random number, inverse transformation (Winston p.1204): -1/lambda*ln r,
% exponential distribution for every actual running time
% only useful to calculate for trains arriving in Hasselt or Leuven

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

%late arrival, on average, during peak hours, 1/lambda
Eav=4;
Cav=2;
Kav=3;
Mav=5;

%number of simulation runs
a=500000;
%passengers_arriving_late: passengers arriving late more minutes than "too_late"
%cost_arriving_late is the cost associated with arriving late
%delay contains the minutes of delay
too_late=3;
%long_transfer_time if passengers have to wait more than "WA" minutes
WA=20;

%variables added to make plots at the end of this file
%amount of missed transfers
missedC10K20 = 0;
missedK11C21 = 0;
missedK11C10 = 0;
missedK10E20 = 0;
missedK10M20 = 0;
missedE11K21 = 0;
missedM11K21 = 0;
missedM11K10 = 0;

%amount of trains with delay
delayC10 = 0;
delayE11 = 0;
delayK10 = 0;
delayK11 = 0;
delayM11 = 0;

%aray with the amount of minutes per delay
delayArrayK10 = zeros(0,0);
delayArrayE11 = zeros(0,0);
delayArrayC10 = zeros(0,0);
delayArrayK11 = zeros(0,0);
delayArrayM11 = zeros(0,0);

%array with amount of cost early arrival 
costTHC10 = zeros(0,0);
costTHE11 = zeros(0,0);
costTHK11 = zeros(0,0);
costTHK10 = zeros(0,0);
costTHM11 = zeros(0,0);

for i=1:1:a
    %determine the real arriving times
    %these are compared later with the scheduled arrival times
    ac10ha= DC10Aa(v)+CAaHa + (round(-Cav*log(rand)));
    
    %ae10ha= DE10Aa(v)+EAaHa + (round(-Eav*log(rand))); %not required
    
    ae11le= DE11Aa(v)+ELeAa + (round(-Eav*log(rand)));
    
    ak11ha= DK11Al(v)+KHaAl + (round(-Kav*log(rand)));
    
    ak10le= DK10La(v)+KLaLe + (round(-Kav*log(rand)));
    
    am11le= DM11Aa(v)+MLeAa + (round(-Mav*log (rand)));
    
    %arriving and through passengers
    %C10
    if ac10ha>AC10Ha(v)							%we have a delay
        delayC10 = delayC10 + 1;
        mc10=(ac10ha-AC10Ha(v));					%minutes of delay
        delayArrayC10 = [delayArrayC10 mc10];
        pc10=mc10*ARC10Ha*WLA;					%cost of this delay
        pzc10=0;									%cost of arriving early
        if ac10ha-AC10Ha(v)>too_late
            uc10= ARC10Ha;	%number of passengers arriving late due to this delay
        else
            uc10=0;
        end
    else
        uc10=0;
        mc10=0;
        pc10=0;
        pzc10=(AC10Ha(v)-ac10ha)*THC10Ha*WST;     %cost of arriving early
        costTHC10 = [costTHC10 pzc10];
    end
    
    %E11
    if ae11le>AE11Le(v)
        delayE11 = delayE11 + 1;
        me11=(ae11le-AE11Le(v));
        delayArrayE11 = [delayArrayE11 me11];
        pe11=me11*ARE11Le*WLA;
        pze11=0;
        if ae11le-AE11Le(v)>too_late
            ue11= ARE11Le;
        else
            ue11=0;
        end
    else
        ue11=0;
        me11=0;
        pe11=0;
        pze11=(AE11Le(v)-ae11le)*THE11Le*WST;
        costTHE11 = [costTHE11 pze11];
    end
    
    %K10
    if ak10le>AK10Le(v)								%we have a delay
        delayK10 = delayK10 + 1;
        mk10=(ak10le-AK10Le(v));					%minutes of delay
        delayArrayK10 = [delayArrayK10 mk10];
        pk10=mk10*ARK10Le*WLA;					%cost of this delay
        pzk10=0;
        if ak10le-AK10Le(v)>too_late
            uk10= ARK10Le;	%number of passengers arriving late due to this delay
        else
            uk10=0;
        end
    else
        uk10=0;
        mk10=0;
        pk10=0;
        pzk10=(AK10Le(v)-ak10le)*THK10Le*WST;
        costTHK10 = [costTHK10 pzk10];
    end
    
    %K11
    if ak11ha>AK11Ha(v)								%we have a delay
        delayK11 = delayK11 + 1;
        mk11=(ak11ha-AK11Ha(v));					%minutes of delay
        delayArrayK11 = [delayArrayK11 mk11];
        pk11=mk11*ARK11Ha*WLA;					%cost of this delay
        pzk11=0;
        if ak11ha-AK11Ha(v)>too_late
            uk11= ARK11Ha;	%number of passengers arriving late due to this delay
        else
            uk11=0;
        end
    else
        uk11=0;
        mk11=0;
        pk11=0;
        pzk11=(AK11Ha(v)-ak11ha)*THK11Ha*WST;
        costTHK11 = [costTHK11 pzk11];
    end
    
    %M11
    if am11le>AM11Le(v);								%we have a delay
        delayM11 = delayM11 + 1;
        mm11=(am11le-AM11Le(v));					%minutes of delay
        delayArrayM11 = [delayArrayM11 mm11];
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
        costTHM11 = [costTHM11 pzm11];
    end
    
    passengers_arriving_late(i)=uc10+ue11+uk11+uk10+um11;
    delay(i)=mc10+me11+mk11+mk10+mm11;
    cost_arriving_late(i)=pc10+pe11+pk11+pk10+pm11;
    cost_through_passengers(i)=pzc10+pze11+pzk11+pzk10+pzm11;
    
   
    
    
    
    
    %transfers
    
    %K11C21
    if v==2
        
        if ak11ha+TT>DC21Ha(v);
            missedK11C21 = missedK11C21 +1;                       %missed the transfer
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
            missedK11C10 = missedK11C10 +1;
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
        
        missedC10K20 = missedC10K20 +1;
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
        missedK10E20 = missedK10E20 +1;
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
        missedK10M20 = missedK10M20 +1;
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
        missedE11K21 = missedE11K21 +1;
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
        missedM11K21 = missedM11K21 +1;
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
        missedM11K10 = missedM11K10 +1;
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

%% Plotting all the information about delays and missed transfers
if plot
    close all
    %Missed transfers
    
    figure
    subplot(3,1,1);
    barplot = [missedC10K20/(a/100)
        missedK11C21/(a/100)
        missedK11C10/(a/100)
        missedK10E20/(a/100)
        missedK10M20/(a/100)
        missedE11K21/(a/100)
        missedM11K21/(a/100)
        missedM11K10/(a/100)];
    
    names =  {'C10K20'
        'K11C21'
        'K11C10'
        'K10E20'
        'K10M20'
        'E11K21'
        'M11K21'
        'M11K10'};
    
    bar(barplot);
    set(gca,'xticklabel',names);
    title('Percentage missed transfers');
    
    %people missed transfer compare
    subplot(3,1,2);
    barplot = [missedC10K20/a*TC10K20 (1-missedC10K20/a)*TC10K20;
        missedK11C21/a*TK11C21 (1-missedK11C21/a)*TK11C21;
        missedK11C10/a*TK11C10 (1-missedK11C10/a)*TK11C10;
        missedK10E20/a*TK10E20 (1-missedK10E20/a)*TK10E20;
        missedK10M20/a*TK10M20 (1-missedK10M20/a)*TK10M20;
        missedE11K21/a*TE11K21 (1-missedE11K21/a)*TE11K21;
        missedM11K21/a*TM11K21 (1-missedM11K21/a)*TM11K21;
        missedM11K10/a*TM11K10 (1-missedM11K10/a)*TM11K10];
    
    
    bar(barplot);
    set(gca,'xticklabel',names);
    title('Comparison of types of passengers considering missed transfers');
    legend('Passengers who missed transfer', 'Passengers who didn''t miss transfer');
    %people missed transfer compare
    subplot(3,1,3);
    barplot = [missedC10K20/a*TC10K20
        missedK11C21/a*TK11C21
        missedK11C10/a*TK11C10
        missedK10E20/a*TK10E20
        missedK10M20/a*TK10M20
        missedE11K21/a*TE11K21
        missedM11K21/a*TM11K21
        missedM11K10/a*TM11K10];
    
    
    bar(barplot);
    set(gca,'xticklabel',names);
    title('Number of passengers who missed their transfer');

    
    %Delay on trains
    figure
    subplot(3,1,1);
    barplot2 = [delayC10/(a/100)
        delayE11/(a/100)
        delayK10/(a/100)
        delayK11/(a/100)
        delayM11/(a/100)];
    names2 = {'delayC10'
        'delayE11'
        'delayK10'
        'delayK11'
        'delayM11'};
    bar(barplot2);
    set(gca,'xticklabel', names2);
    title('Percentage of trains with delay');
    
    %people delay on trains
    subplot(3,1,2);
    barplot2 = [delayC10/a*((ARC10Ha)) (1-delayC10/a)*((ARC10Ha)) THC10Ha;
        delayE11/a*(ARE11Le) (1-delayE11/a)*(ARE11Le) THE11Le;
        delayK10/a*(ARK10Le) (1-delayK10/a)*(ARK10Le) THK10Le;
        delayK11/a*(ARK11Ha) (1-delayK11/a)*(ARK11Ha) THK11Ha;
        delayM11/a*(ARM11Le) (1-delayM11/a)*(ARM11Le) THM11Le];
    names4 = {'passengersC10'
        'passengersE11'
        'passengersK10'
        'passengersK11'
        'passengersM11'};
    bar(barplot2);
    set(gca,'xticklabel', names4);
    title('Comparison of types of passengers considering the delay');
    legend('Passengers with delay', 'Passengers without delay', 'through passengers');
    
    % %mean of min delays
    subplot(3,1,3);
    barplot3 = [mean(delayArrayK10)
        mean(delayArrayE11)
        mean(delayArrayC10)
        mean(delayArrayK11)
        mean(delayArrayM11) ];
    
    names5 = {'minDelayC10'
        'minDelayE11'
        'minDelayK10'
        'minDelayK11'
        'minDelayM11'};
    bar(barplot3);
    set(gca, 'xticklabel', names5);
    title('Mean of minutes delay for each train');
    
    figure
    subplot(2,1,1);
    barplot7 = [length(costTHC10)
        length(costTHE11)
        length(costTHK10)
        length(costTHK11)
        length(costTHM11)
        ];
    
    names3 = {'costEarlyC10'
        'costEarlyE11'
        'costEarlyK10'
        'costEarlyK11'
        'costEarlyM11'};
    
    names6 = {'EarlyC10'
        'EarlyE11'
        'EarlyK10'
        'EarlyK11'
        'EarlyM11'};
    bar(barplot7);
    set(gca, 'xticklabel', names6);
    title('Trains with cost from early arrival (through train costs)');
    
    subplot(2,1,2);
    barplot8 = [mean(costTHC10)
        mean(costTHE11)
        mean(costTHK10)
        mean(costTHK11)
        mean(costTHM11)
        ];
    
    bar(barplot8);
    set(gca, 'xticklabel', names3);
    title('Mean of early arrival cost');
    
    figure
    barplot9= [ARC10Ha THC10Ha (TC10K20);
        ARK11Ha THK11Ha (TK11C21 + TK11C10);
        ARK10Le THK10Le (TK10E20 + TK10M20);
        ARE11Le THE11Le (TE11K21);
        ARM11Le THM11Le (TM11K21 + TM11K10);
        ];
    
    names7 = {'C10'
        'K11'
        'K10'
        'E11'
        'M11'
        };
    bar(barplot9);
    legend('Arriving Passengers','Through Passengers','Transfering Passengers');
    set(gca, 'xticklabel',names7);
    title('Types of passenger on the train at the transfer point');
end
%%


