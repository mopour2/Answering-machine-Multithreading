Function Tline.PlayNoDavayer_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('NoDavaye.msg',594,931,932);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipNoDavayer_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',932,932,932);
Result:=ret
end;
//****************************************
function TLine.GetNoDavayer_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(5,VTimeOutDig,933,933,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckNoDavayer_amozN:integer;
begin

  paraLog('ChckNoDavayer','1',time,0);
  logfile;

if(FuncIdd(594,930)=0) then
begin
      result:=0;
      exit;
end;

Bakhshname.CodDavayer:=KeyBuf;

 if (strtoint(Bakhshname.CodDavayer)>1)then
       LineStat.State:=934
   else
    begin
      LineStat.State:=930;
      PlayBlundeNo;
    end;
result:=0;
end;
//--------------------------------------------
Function Tline.PlaySGNoBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('NoBakhsh.msg',594,935,936);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipSGNoBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',936,936,936);
Result:=ret
end;
//****************************************
function TLine.GetSGNoBakhsh_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(10,VTimeOutDig,937,937,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckSGNoBakhsh_amozN:integer;
begin

  paraLog('ChckSGNoBakhsh','1',time,0);
  logfile;

if(FuncIdd(594,934)=0) then
begin
      result:=0;
      exit;
end;

Bakhshname.NoBakhsh:=KeyBuf;

 if (strtoint(Bakhshname.NoBakhsh)>1)then
       LineStat.State:=938
   else
    begin
      LineStat.State:=934;
      PlayBlundeNo;
    end;
result:=0;
end;
//--------------------------------------------
Function Tline.PlaySGYearBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('YearBakh.msg',594,939,940);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipSGYearBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',940,940,940);
Result:=ret
end;
//****************************************
function TLine.GetSGYearBakhsh_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(2,VTimeOutDig,941,941,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckSGYearBakhsh_amozN:integer;
begin

  paraLog('ChckYearBakhsh','1',time,0);
  logfile;

if(FuncIdd(594,938)=0) then
begin
      result:=0;
      exit;
end;

Bakhshname.year:=KeyBuf;

 if (strtoint(Bakhshname.year)<81) or (strtoint(Bakhshname.year)>91)then
   begin
     LineStat.State:=938;
     PlayBlundeNo;
     Result:=0;
     exit;
   end;

LineStat.State:=942;
result:=0;
end;
//--------------------------------------------
Function Tline.PlaySGMontBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('MontBakh.msg',594,943,944);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipSGMontBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',944,944,944);
Result:=ret
end;
//****************************************
function TLine.GetSGMontBakhsh_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(2,VTimeOutDig,945,945,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckSGMontBakhsh_amozN:integer;
begin

  paraLog('ChckMontBakhsh','1',time,0);
  logfile;

if(FuncIdd(594,942)=0) then
begin
      result:=0;
      exit;
end;
Bakhshname.Mont:=KeyBuf;

 if (strtoint(Bakhshname.Mont)<1) or (strtoint(Bakhshname.Mont)> 12)then
   begin
     LineStat.State:=942;
     PlayBlundeNo;
     Result:=0;
     exit;
   end;

LineStat.State:=946;
result:=0;
end;
//--------------------------------------------
Function Tline.PlaySGDayBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('DayBakh.msg',594,947,948);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipSGDayBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',948,948,948);
Result:=ret
end;
//****************************************
function TLine.GetSGDayBakhsh_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(2,VTimeOutDig,949,949,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckSGDayBakhsh_amozN:integer;
begin

  paraLog('ChckDayBakhsh','1',time,0);
  logfile;

if(FuncIdd(594,946)=0) then
begin
      result:=0;
      exit;
end;
Bakhshname.day:=KeyBuf;

 if (strtoint(Bakhshname.Day)<1) or (strtoint(Bakhshname.Day)>31)then
   begin
     LineStat.State:=946;
     PlayBlundeNo;
     Result:=0;
     exit;
   end;
LineStat.State:=951;
PlBipRecGloM;
result:=0;
end;
//******************************************************
function Tline.RecBakhsh:integer;
var ret:integer;
  Temp:string;
begin

  Temp:='1100t'+Channel_Str+'.v';

  BoxLine.Copy1:=DriveBoxV+Temp;

  ret:=RecFile(Temp,DriveBoxV,60000*9,0);
  LineStat.State:=952;
  result:=ret;
end;
//*----------------------------------------------*/
function Tline.PlMsBakhshdlsv:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('OthrDlSv.msg',594,953,954);
  Result:=ret
end;
//****************************************
function Tline.PlayBipBakhshDlsv:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',954,954,954);
  Result:=ret
end;
//*----------------------------------------------*/
function Tline.GetBakhshDlsv:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,955,955,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function Tline.ChkBakhshDlSv:integer;
var  ff,i:integer;
begin

if(FuncIdd(594,952)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;

 if (Keybuf='3') then
 begin
   ff:=1;
   for i:=0 to ActiveChannels-1 do
    if (Line[i].LineStat.State<>StartOnState) and (Channel<>i)then
     ff:=0;
   if(ff=1) then
    begin

      if SaveRecTable_amozN=1 then
        PlayOtSave
      else PlaySysDrv('NotSavMe.msg',594,594,594);
       LineStat.State:=594;
       result:=0;
       exit;
    end
   else
    begin
      PlayFile('NotSvPa.msg',DriveVSys,0);
      LineStat.State:=952 ;
      result:=0;
      exit;
    end;
 end
 else if (Keybuf='4') then
 begin
   LineStat.State:=952;
   PlayOthrRep;
 end
 else if (Keybuf='5') then
 begin
   LineStat.State:=951;
   PlBipRecGloM;
 end
 else
 begin
   LineStat.State:=952;
   PlayBlundeNo;
 end;
Result:=0;
end;
//*----------------------------------------------*/
Function Tline.SaveRecTable_amozN:integer;
var 
Flag:Boolean;
i:string;
FileNamePath:string;
begin

  if (length(Bakhshname.Mont)<2) then
   Bakhshname.Mont:='0'+Bakhshname.Mont
  else ;

  if (length(Bakhshname.Day)<2) then
   Bakhshname.Day:='0'+Bakhshname.day
  else ;

  TabelBakhsh.First;

  if TabelBakhsh.Locate('CodDavayer;NoBakhsh;Year;Mont;Day',VarArrayOf([Bakhshname.CodDavayer,Bakhshname.NoBaKhsh,Bakhshname.Year,Bakhshname.Mont,Bakhshname.Day]) , [loPartialKey])=true then
   begin
    flag:=true;
   end
  else flag:=False;

  if Flag=true then
    i:='true'
  else i:='false';
  paraLog('search  Bakhsh '+ 'Bakhshname.NoBachsh ' +i,'1',time,0);
  logfile;

 if Flag=True then
    begin

     BoxLine.NoGroupPath:=DriveSaz+'Bakhsh\'+TabelBakhsh.FieldByName('NoFile').asString;
     copyfile(BoxLine.Copy1,BoxLine.NoGroupPath);

     SplFileName(TabelBakhsh.FieldByName('NoFile').asString,FileNamePath);
     BoxLine.Command:=DriveBoxV+FileNamePath;
     if copyfile(BoxLine.Copy1,BoxLine.Command)=1 then
     begin
           result:=1; exit;
     end
     else  begin  result:=0; exit;  end
    end
 else
  begin
   if (GenaratNmaeRamz=0) then
   if(copyfile(BoxLine.Copy1,BoxLine.Command)=1) then
    begin
       BoxLine.NoGroupPath:=DriveSaz+'Bakhsh\'+inttostr(BoxLine.FileMessTemp);
       copyfile(BoxLine.Copy1,BoxLine.NoGroupPath);
     writeAppendBakhsh;
     result:=1;
     exit;
    end
     else
   begin
     result:=0;
     exit;
    end
    else
   begin
     result:=0;
     exit;
    end;
  end;
end;
//------------------------------------------------
Procedure  TLine.writeAppendBakhsh;
begin

   while MainForm.FlagLockTabeBakhsh do ;
   MainForm.FlagLockTabeBakhsh:=true;
  paraLog('writeAppendBakhsh; ','1',time,0);
  logfile;

   TabelBakhsh.Insert;
   TabelBakhsh.FieldByName('CodDavayer').asstring:=Bakhshname.CodDavayer;
   TabelBakhsh.FieldByName('NoFile').asinteger:=BoxLine.FileMessTemp;
   TabelBakhsh.FieldByName('NoBakhsh').asstring:=Bakhshname.NoBakhsh;
   TabelBakhsh.FieldByName('Year').asstring:=Bakhshname.year;
   TabelBakhsh.FieldByName('Mont').asstring:=Bakhshname.Mont;
   TabelBakhsh.FieldByName('Day').value:=Bakhshname.day;
   TabelBakhsh.FieldByName('Date').value:=Bakhshname.year+'/'+Bakhshname.Mont+'/'+Bakhshname.day;
   TabelBakhsh.post;
   TabelBakhsh.refresh;
   MainForm.FlagLockTabeBakhsh:=false;
end;

//*************************************************************
//*************************************************************
//*************************************************************
//*************************************************************
//*************************************************************
//*************************************************************
//*************************************************************
//*************************************************************
//***********************************************
Function Tline.PlayDayNews_amozN:integer;
var Drive,NoBox:string;
begin
     NoBox:='11111.';
     Drive:=DriveSaz;
     BoxLine.NoGroupPath:=Drive+NoBox;
     if (FileExists(BoxLine.NoGroupPath)) then
      begin
        PlayFile(NoBox,Drive,1);
      end
      else PlayFile('NotFInfo.msg',DriveVSYS,0);
     LineStat.State:=14;
result:=0;
end;
//***********************************************
//***********************************************
//***********************************************
//***********************************************
//***********************************************
//***********************************************
//***********************************************

Function Tline.PlayBakhshMenu_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('BakhMain.msg',14,901,902);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipBakhshMenu_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',902,902,902);
Result:=ret
end;
//****************************************
function TLine.GetBakhshMenu_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,903,903,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckBakhshMenu_amozN:integer;
begin

  paraLog('ChckBakhshMenu','1',time,0);
  logfile;

if(FuncIdd(StateMainMenu,900)=0) then
begin
      result:=0;
      exit;
end;

 if (Keybuf='6') then
 Begin
   BoxLine.SupMenu:=103;
   LineStat.State:=1042;
 end
 else if (Keybuf='5')then
 Begin
   BoxLine.SupMenu:=104;
   LineStat.State:=905;
 end
 else if (KeyBuf='3')then
 Begin
   BoxLine.SupMenu:=105;
   LineStat.State:=905;
 end
 else if (KeyBuf='4')then
 Begin
   BoxLine.SupMenu:=106;
   LineStat.State:=905;
 end
 else if (Keybuf='*') or (Keybuf= '0') then
 Begin
   LineStat.State:=14;
 end
 else Begin
	LineStat.State:=900;
	PlayBlundeNo;
      end;
 Result:=0;
end;
//***********************************************
Function Tline.PlayBakhshMenu2_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('BakhMai2.msg',14,906,907);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipBakhshMenu2_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',907,907,907);
Result:=ret
end;
//****************************************
function TLine.GetBakhshMenu2_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,908,908,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckBakhshMenu2_amozN:integer;
begin

  paraLog('ChckBakhshMenu','1',time,0);
  logfile;

if(FuncIdd(StateMainMenu,905)=0) then
begin
      result:=0;
      exit;
end
else if (KeyBuf<>'' )then
   begin
     NoPas:=keyBuf;
     LineStat.State:=910;
   end;
NoPas:=keyBuf;
LineStat.State:=910;
result:=0;
end;

//--------------------------------------------
Function Tline.PlayUNoDavay_amozN:integer;
begin
     if NoPas='3' then
        PlaySazDrv('f1.msg',14,911,912)
     else if NoPas='4' then
        PlaySazDrv('f2.msg',14,911,912)
     else if NoPas='5' then
        PlaySazDrv('f3.msg',14,911,912)
     else if NoPas='6' then
         PlaySazDrv('f4.msg',14,911,912)
     else if NoPas='7' then
         PlaySazDrv('f5.msg',14,911,912)
     else if NoPas='8' then
         PlaySazDrv('f6.msg',14,911,912)
     else if NoPas='9' then
         PlaySazDrv('f7.msg',14,911,912)
     else PlaySazDrv('f1.msg',14,911,912);
result:=0;
end;
//--------------------------------------------
Function Tline.PlayBipUNoDavay_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',912,912,912);
Result:=ret
end;
//****************************************
function TLine.GetUNoDavay_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(7,VTimeOutDig,913,913,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckUNoDavay_amozN:integer;
begin

  paraLog('ChckNoBakhsh','1',time,0);
  logfile;

if(FuncIdd(StateMainMenu,905)=0) then
begin
      result:=0;
      exit;
end
else if (KeyBuf<>'' )then
   begin
     Bakhshname.CodDavayer:=KeyBuf;
     if BoxLine.SupMenu=104 then
       LineStat.State:=1000
     else if BoxLine.SupMenu=105 then
       LineStat.State:=1040
     else if BoxLine.SupMenu=106 then
       LineStat.State:=1041
     else LineStat.State:=1000;
   end;
result:=0;
end;
//*******************************************************
Function Tline.PlayASYearBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('asyearb.msg',14,1001,1002);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipASYearBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1002,1002,1002);
Result:=ret
end;
//****************************************
function TLine.GetASYearBakhsh_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(2,VTimeOutDig,1003,1003,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckASYearBakhsh_amozN:integer;
begin

  paraLog('ChckNoDavayer','1',time,0);
  logfile;

if(FuncIdd(900,1000)=0) then
begin
      result:=0;
      exit;
end;
Bakhshname.year:=KeyBuf;

 if (strtoint(Bakhshname.year)<80) or (strtoint(Bakhshname.year)>99)then
   begin
     LineStat.State:=1000;
     PlayBlundeNo;
     Result:=0;
     exit;
   end;

LineStat.State:=1005;
result:=0;

end;
//--------------------------------------------
Function Tline.PlayAsMontBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('asMontb.msg',14,1006,1007);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipAsMontBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1007,1007,1007);
Result:=ret
end;
//****************************************
function TLine.GetAsMontBakhsh_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(2,VTimeOutDig,1008,1008,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckAsMontBakhsh_amozN:integer;
begin

  paraLog('ChckMontBakhsh','1',time,0);
  logfile;

if(FuncIdd(900,1005)=0) then
begin
      result:=0;
      exit;
end;
Bakhshname.Mont:=KeyBuf;

 if (strtoint(Bakhshname.Mont)<1) or (strtoint(Bakhshname.Mont)> 12)then
   begin
     LineStat.State:=1005;
     PlayBlundeNo;
     Result:=0;
     exit;
   end;
LineStat.State:=1010;
result:=0;
end;
//--------------------------------------------
Function Tline.PlayAsDayBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('asDayb.msg',14,1011,1012);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipAsDayBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1012,1012,1012);
Result:=ret
end;
//****************************************
function TLine.GetAsDayBakhsh_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(2,VTimeOutDig,1013,1013,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckAsDayBakhsh_amozN:integer;
begin

  paraLog('ChckDayBakhsh','1',time,0);
  logfile;

if(FuncIdd(900,1010)=0) then
begin
      result:=0;
      exit;
end;
Bakhshname.day:=KeyBuf;

 if (strtoint(Bakhshname.Day)<1) or (strtoint(Bakhshname.Day)>31)then
   begin
     LineStat.State:=1010;
     PlayBlundeNo;
     Result:=0;
     exit;
   end;
LineStat.State:=1015;
result:=0;
end;


//*******************************************************
Function Tline.PlayTaYearBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('Toyearb.msg',14,1016,1017);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipTaYearBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1017,1017,1017);
Result:=ret
end;
//****************************************
function TLine.GetTaYearBakhsh_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(2,VTimeOutDig,1018,1018,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckTaYearBakhsh_amozN:integer;
begin

  paraLog('ChckTaYear','1',time,0);
  logfile;

if(FuncIdd(900,1015)=0) then
begin
      result:=0;
      exit;
end;
Bakhshname.year2:=KeyBuf;

 if (strtoint(Bakhshname.year2)<80) or (strtoint(Bakhshname.year2)>99)then
   begin
     LineStat.State:=1015;
     PlayBlundeNo;
     Result:=0;
     exit;
   end;

LineStat.State:=1020;
result:=0;

end;
//--------------------------------------------
Function Tline.PlayTaMontBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('ToMontb.msg',14,1021,1022);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipTaMontBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1022,1022,1022);
Result:=ret
end;
//****************************************
function TLine.GetTaMontBakhsh_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(2,VTimeOutDig,1023,1023,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckTaMontBakhsh_amozN:integer;
begin

  paraLog('ChckMontBakhsh','1',time,0);
  logfile;

if(FuncIdd(900,1020)=0) then
begin
      result:=0;
      exit;
end;
Bakhshname.Mont2:=KeyBuf;

 if (strtoint(Bakhshname.Mont2)<1) or (strtoint(Bakhshname.Mont2)> 12)then
   begin
     LineStat.State:=1020;
     PlayBlundeNo;
     Result:=0;
     exit;
   end;

LineStat.State:=1025;
result:=0;
end;
//--------------------------------------------
Function Tline.PlayTaDayBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('ToDayb.msg',14,1026,1027);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipTaDayBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1027,1027,1027);
Result:=ret
end;
//****************************************
function TLine.GetTaDayBakhsh_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(2,VTimeOutDig,1028,1028,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckTaDayBakhsh_amozN:integer;
Var Flag:boolean;
i:string;
Date1,Date2:string;
begin

  paraLog('ChckDayBakhsh','1',time,0);
  logfile;

if(FuncIdd(900,1025)=0) then
begin
      result:=0;
      exit;
end;
Bakhshname.day2:=KeyBuf;

 if (strtoint(Bakhshname.Day2)<1) or (strtoint(Bakhshname.Day2)>31)then
   begin
     LineStat.State:=1025;
     PlayBlundeNo;
     Result:=0;
     exit;
   end;


  if (length(Bakhshname.Mont)<2) then
   Bakhshname.Mont:='0'+Bakhshname.Mont
  else ;

  if (length(Bakhshname.Day)<2) then
   Bakhshname.Day:='0'+Bakhshname.day
  else ;

  if (length(Bakhshname.Mont2)<2) then
   Bakhshname.Mont2:='0'+Bakhshname.Mont2
  else ;

  if (length(Bakhshname.Day2)<2) then
   Bakhshname.Day2:='0'+Bakhshname.day2
  else ;

  TabelBakhsh.First;
{  TabelBakhsh.filter:='CodDavayer = '''+Bakhshname.CodDavayer+''''
                         +' and  year >= '''+bakhshname.year+''''
                         +' and  mont >= '''+bakhshname.mont+''''
                         +' and  day  >= '''+bakhshname.day+''''
                         +' and  year <= '''+bakhshname.year2+''''
                         +' and  mont <= '''+bakhshname.mont2+''''
                         +' and  day  <= '''+bakhshname.day2+'''';
}
  Date1:=Bakhshname.year+'/'+Bakhshname.Mont+'/'+Bakhshname.day;
  Date2:=Bakhshname.year2+'/'+Bakhshname.Mont2+'/'+Bakhshname.day2;

  TabelBakhsh.filter:='CodDavayer = '''+Bakhshname.CodDavayer+''''
                         +' and  Date >= '''+Date1+''''
                         +' and  Date <= '''+Date2+'''';


  TabelBakhsh.filtered:=true;
  bakhshname.Count:=TabelBakhsh.RecordCount;
  if bakhshname.Count > 0 then
   begin
    flag:=true;
   end
  else flag:=False;

  if Flag=true then
    i:='true'
  else i:='false';

  paraLog('search  Bakhsh Count '+inttostr(Bakhshname.count) +i,'1',time,0);
  logfile;

 if Flag=True then
   begin
    PlaySazDrv('OnePlBak.msg',1030,1030,1030);
    LineStat.State:=1030;
   end
 else
   begin
     PlaySazDrv('NotFB2.msg',900,900,900);
     LineStat.State:=900;
   end;

result:=0;
end;

//*********************************************************
function TLine.RepBackshOutTimre_amozN:integer;
var FileNamePath:string;
begin

 if (not TabelBakhsh.eof)then
  begin
    SplFileName(inttostr(TabelBakhsh.FieldByName('NoFile').asinteger),FileNamePath);
    PlayFile(FileNamePath,DriveBoxV,2);
    TabelBakhsh.next;
     if (not TabelBakhsh.eof)then
      PlaySazDrv('NextBakh.msg',1030,1030,1030);
    LineStat.State:=1030;
  end
 else
  begin
    LineStat.State:=900;
  end;
result:=0;
end;

//-------------------------------------------------------
function TLine.PlyEndBakhsh_amozN:integer;
var FileNamePath:string;
flag:boolean;
i:string;
begin


  TabelBakhsh.First;
  TabelBakhsh.filter:='CodDavayer = '''+Bakhshname.CodDavayer+'''';
  TabelBakhsh.filtered:=true;
  bakhshname.Count:=TabelBakhsh.RecordCount;
  if bakhshname.Count > 0 then
   begin
    flag:=true;
   end
  else flag:=False;

  if Flag=true then
    i:='true'
  else i:='false';

  paraLog('search  Bakhsh End '+ inttostr(Bakhshname.count)+i,'1',time,0);
  logfile;

 if Flag=True then
   begin
    PlaySazDrv('endbakh.msg',900,900,900);
    TabelBakhsh.Last;
    SplFileName(inttostr(TabelBakhsh.FieldByName('NoFile').asinteger),FileNamePath);
    PlayFile(FileNamePath,DriveBoxV,2);
    LineStat.State:=900;
   end
 else
   begin
     PlaySazDrv('EmpBak.msg',900,900,900);
     LineStat.State:=900;
   end;
result:=0;
end;

//--------------------------------------------
Function Tline.PlayUNoBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySazDrv('NoBakhsh.msg',14,1043,1044);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipUNoBakhsh_amozN:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1044,1044,1044);
Result:=ret
end;
//****************************************
function TLine.GetUNoBakhsh_amozN:integer;
var ret:integer;
begin
ret:=GetDigit(10,VTimeOutDig,1045,1045,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckUNoBakhsh_amozN:integer;
var flag:boolean;
FileNamePath:string;
i:string;
begin

  paraLog('ChckUNoBakhsh','1',time,0);
  logfile;

if(FuncIdd(900,1042)=0) then
begin
      result:=0;
      exit;
end;

Bakhshname.NoBakhsh:=KeyBuf;

 if (Bakhshname.NoBakhsh <> '') then
   begin
    TabelBakhsh.First;
    TabelBakhsh.filter:='NoBakhsh= '''+Bakhshname.NoBakhsh+'''';
    TabelBakhsh.filtered:=true;
    bakhshname.Count:=TabelBakhsh.RecordCount;
    if bakhshname.Count > 0 then
   begin
    flag:=true;
   end
  else flag:=False;

  if Flag=true then
    i:='true'
  else i:='false';

  paraLog('search  No Bakhsh  '+ inttostr(Bakhshname.count) +i,'1',time,0);
  logfile;

 if Flag=True then
   begin
    PlaySazDrv('UPNoBakh.msg',900,900,900);
    TabelBakhsh.Last;
    SplFileName(inttostr(TabelBakhsh.FieldByName('NoFile').asinteger),FileNamePath);
    PlayFile(FileNamePath,DriveBoxV,2);
    LineStat.State:=900;
   end
 else
     BEGIN
       PlaySazDrv('NotFBakh.msg',900,900,900);
       LineStat.State:=900;
     end
 end
 else
    BEGIN
       PlaySazDrv('NotFBak.msg',900,900,900);
       LineStat.State:=900;
     end;
result:=0;
end;
//-------------------------------------------------------
function TLine.PlyEnd2EndBakhsh_amozN:integer;
var
flag:boolean;
i:string;
begin


  TabelBakhsh.First;
  TabelBakhsh.filter:='CodDavayer = '''+Bakhshname.CodDavayer+'''';
  TabelBakhsh.filtered:=true;
  TabelBakhsh.First;
  bakhshname.Count:=TabelBakhsh.RecordCount;
  if bakhshname.Count > 0 then
   begin
    flag:=true;
   end
  else flag:=False;

  if Flag=true then
    i:='true'
  else i:='false';

  paraLog('search  Bakhsh end 2 End '+inttostr( Bakhshname.count)  + i,'1',time,0);
  logfile;

 if Flag=True then
   begin
    if bakhshname.Count >= 2 then
    begin
      TabelBakhsh.Last;
       paraLog('Prior  Bakhsh end 2 End ','1',time,0);
       logfile;
      TabelBakhsh.prior;
      LineStat.State:=1030;
    end
    else begin
            TabelBakhsh.Last;
            LineStat.State:=1040;
         end;
   end
 else
   begin
     PlaySazDrv('EmpBak.msg',900,900,900);
     LineStat.State:=900;
   end;
result:=0;
end;

{
     Drive:=DriveSaz+'Bakhsh\';
     BoxLine.NoGroupPath:=Drive+NoBox;
     if (FileExists(BoxLine.NoGroupPath)) then
      begin
        PlayFile(NoBox,Drive,1);
      end
//     else PlaySazDrv('BLNoBakhsh.msg',14,907,907);
      else PlayFile('NotFInfo.msg',DriveVSYS,0);
     LineStat.State:=14;
 }
