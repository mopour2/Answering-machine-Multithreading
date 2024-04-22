//*********Elam************
Function Tline.checkTimeDate:integer;
VAR
 d:tdatetime;
 Year, Month, Day: Word;
 Hour, Min, Sec, MSec:Word;
 CurentTime:longWord;
 RengTime1:longWord;
 RengTime2:longWord;
 begin

 d:=now;
 DecodeDate(d,Year, Month, Day);
 ftodate(Year, Month, Day);
 DecodeTime(d, Hour, Min, Sec, MSec);

 if (MainForm.R_Year1<=Year ) and(MainForm.R_Month1<=Month )and(MainForm.R_Day1<=Day ) and
    (MainForm.R_Year2>=Year ) and(MainForm.R_Month2>=Month )and(MainForm.R_Day2>=Day )then
   begin
     CurentTime:=Hour*60+Min;
     RengTime1:=MainForm.R_Hour1*60+MainForm.R_Min1;
     RengTime2:=MainForm.R_Hour2*60+MainForm.R_Min2;

       if (RengTime1<=CurentTime) and(RengTime2>=CurentTime) then
        begin
             LineStat.State:=1802;
             result:=0;
             exit;
        end
       else
        begin
           sleep(1000);
           LineStat.State:=1800;
           result:=0;
           exit;
        end;
   end
 else
   begin
      //
       if (MainForm.FlagShutDownElam=false )Then
      begin
         MainForm.FlagShutDownElam:=true;
         showmessage('Out date Elamie Edit File Reng Elam');
         LineStat.State:= StateonHook;
         result:=0;
         MainForm.ExitP;
      end
      else
      begin
      sleep(100);
         LineStat.State:=1800;
         result:=0;
         suspend;
         exit;
      end;
   end;

end;
//--------------------------------------------

Function Tline.GetActivRecOfMasterFileElam:integer;
var
 d:tdatetime;
 Year, Month, Day: Word;
 Hour, Min, Sec, MSec:Word;
CurentTime:longword;
Time1:longword;
begin
 d:=now;
 DecodeDate(d,Year, Month, Day);
 ftodate(Year, Month, Day);
 DecodeTime(d, Hour, Min, Sec, MSec);
           
while MainForm.FlagLockElam do sleep(10);
 MainForm.FlagLockElam:=True;

 MainForm.TabelElam.Open;
 MainForm.TabelElam.Filter:='FLock = ''0'' AND FOK= ''0'' and FErr=''0'' ' ;
 MainForm.TabelElam.Filtered:=true;

 if MainForm.TabelElam.RecordCount >0 then
 begin
   MainForm.TabelElam.First;
 // if
  if length(MainForm.TabelElam.FieldByName('TelNo').asstring)= 7 then
  begin
   BoxLine.CodElam:= MainForm.TabelElam.FieldByName('Cod').asstring;
   BoxLine.SendDig:= MainForm.TabelElam.FieldByName('TelNo').asstring;
   BoxLine.PriceElam:=MainForm.TabelElam.FieldByName('Price').asstring;

   MainForm.TabelElam.edit;
   MainForm.TabelElam.FieldByName('FLock').asstring:='1';
   MainForm.TabelElam.FieldByName('Year').asinteger:=YEAR;
   MainForm.TabelElam.FieldByName('Mont').asinteger:=Month;
   MainForm.TabelElam.FieldByName('Day').asinteger:=Day;
   MainForm.TabelElam.FieldByName('Hour').asinteger:=Hour;
   MainForm.TabelElam.FieldByName('Min').asinteger:=Min;

   MainForm.TabelElam.post;
   MainForm.TabelElam.refresh
  end
  else
    begin
               MainForm.TabelElam.edit;
               MainForm.TabelElam.FieldByName('FErr').asstring:='1';
               MainForm.TabelElam.post;
               MainForm.TabelElam.REFRESH;;
               LineStat.State:=1800;
               result:=0;
               MainForm.TabelElam.close;
               MainForm.FlagLockElam:=False;
               exit;
    end;
 end
 else
   begin
     MainForm.TabelElam.Filter:='FLock = ''1'' AND FOK= ''0'' and FErr=''0'' ' ;
     MainForm.TabelElam.Filtered:=true;
     if MainForm.TabelElam.RecordCount >0 then
       BEGIN   //check flock and stablish statuse
          while not MainForm.TabelElam.eof  do
          begin
           if (MainForm.TabelElam.FieldByName('Year').asinteger=Year)
             and (MainForm.TabelElam.FieldByName('Mont').asinteger=Month)
             and (MainForm.TabelElam.FieldByName('Day').asinteger=Day) then
               begin
                  CurentTime:=Hour*60+Min;
                  Time1:=MainForm.TabelElam.FieldByName('Hour').asinteger
                        *60+MainForm.TabelElam.FieldByName('Min').asinteger;
                  if (Time1+20<CurentTime) then
                  begin
                       MainForm.TabelElam.edit;
                       MainForm.TabelElam.FieldByName('FLock').asstring:='0';
                       MainForm.TabelElam.post;
                       MainForm.TabelElam.REFRESH;;
                  end
                  else
                   MainForm.TabelElam.NEXT;

               end
           else
            begin
               MainForm.TabelElam.edit;
               MainForm.TabelElam.FieldByName('FLock').asstring:='0';
               MainForm.TabelElam.post;
               MainForm.TabelElam.REFRESH;;
            end;
          end;//END WHILE CHEK FLOCK
               LineStat.State:=1802;
               result:=0;
               MainForm.TabelElam.close;
               MainForm.FlagLockElam:=False;
               exit;
       END
     ELSE
       BEGIN
      if (MainForm.FlagShutDownElam=false )Then
       begin
         MainForm.FlagShutDownElam:=true;
          MainForm.TabelElam.close;
         MainForm.FlagLockElam:=False;
         showmessage('Nat Actin Rec End Program');
         LineStat.State:= StateonHook;
         result:=0;
         MainForm.ExitP;
      end
      else
      begin
      sleep(100);
         LineStat.State:=1802;
         result:=0;
         MainForm.TabelElam.close;
         MainForm.FlagLockElam:=False;
         suspend;
        exit;
      end;
       END;
   end;

LineStat.State:=1804;
result:=0;
MainForm.TabelElam.close;
MainForm.FlagLockElam:=False;
end;

//============================================
function TLine.FOffHookElam: integer;
var ret:integer;
begin
  CountMessagLinecount:=1;
  PointCurrentNod:=1;
  LineStat.V_Line:=V_OffHook;
  TypeRingUsed:=3; //1=NotUse  2=Use //3=of for dial

  paraLog('OffHook  ....  '+'  line'+Channel_Str,'1',time,0);
  logfile;

ret:=OffHook;

if ret=NOT_OK then
LineStat.State:=1834
else LineStat.State:=1808;
Result:=LineStat.State;
end;

//*******************************************************************
function TLine.DialForElam:integer;
begin
 sleep(VAfterFlashDelay);
   if SendDigits<>-1 then
       LineStat.State:=1810
   else
	 LineStat.State:=1834;
Result:=0
end;
//**************************************************
function TLine.AddFlagPcmMod(ret:integer):integer;
begin

while MainForm.FlagLockElam do sleep(10);
 MainForm.FlagLockElam:=True;

 MainForm.TabelElam.Open;
 MainForm.TabelElam.Filter:='' ;
 MainForm.TabelElam.Filtered:=true;

 if MainForm.TabelElam.FindKey([BoxLine.CodElam])=true then
 begin
   MainForm.TabelElam.edit;
   if ret =3 then
   begin
     MainForm.TabelElam.FieldByName('CBusy').asinteger:=MainForm.TabelElam.FieldByName('CBusy').asinteger+1;
     if MainForm.TabelElam.FieldByName('CBusy').asinteger >5 then MainForm.TabelElam.FieldByName('FOk').asstring:='2';
   end
   else if ret =5 then
   begin
            MainForm.TabelElam.FieldByName('CNoAns').asinteger:=MainForm.TabelElam.FieldByName('CNoAns').asinteger+1;
         if MainForm.TabelElam.FieldByName('CNoAns').asinteger >5 then MainForm.TabelElam.FieldByName('FOk').asstring:='2';
   end
   else if ret =6 then
   begin
            MainForm.TabelElam.FieldByName('CAns').asinteger:=MainForm.TabelElam.FieldByName('CAns').asinteger+1;
          if MainForm.TabelElam.FieldByName('CAns').asinteger >5 then MainForm.TabelElam.FieldByName('FOk').asstring:='2';
   end
   else if ret =100  then //ANS nOT kEY
   begin
            MainForm.TabelElam.FieldByName('CAnsNotKey').asinteger:=MainForm.TabelElam.FieldByName('CAns').asinteger+1;
         if MainForm.TabelElam.FieldByName('CAnsNotKey').asinteger >5 then MainForm.TabelElam.FieldByName('FOk').asstring:='2';
   end
   else if ret =200 then  // OK ANS AND PRES KEY
            MainForm.TabelElam.FieldByName('FOk').asstring:='1'
   else if ret =300 then  // OK ANS AND PRES KEY
      MainForm.TabelElam.FieldByName('FLock').asstring:='0'

   else
   begin
     MainForm.TabelElam.FieldByName('CPCMElse').asinteger:=MainForm.TabelElam.FieldByName('CPCMElse').asinteger+1;
     if MainForm.TabelElam.FieldByName('CPCMElse').asinteger >5 then MainForm.TabelElam.FieldByName('FOk').asstring:='2';
   end;
   MainForm.TabelElam.post;
   MainForm.TabelElam.REFRESH;;
 end
 else
  begin
     paraLog('search codElam for add pcm flag error  ','1',time,0);
     logfile;
  end;

 MainForm.TabelElam.close;
 MainForm.FlagLockElam:=false;
end;

//**************************************************
function TLine.WaitForAnsElam:integer;
var ret:integer;
begin
ret:= WaitForAns;
if (ret=6) then //ans
  LineStat.State:=1816
else if (ret=3) then //busy
  LineStat.State:=1834
else if (ret=5) then //Noans
  LineStat.State:=1834
else LineStat.State:=1834;       //silens ring bak ton ...

AddFlagPcmMod(ret);

Result:=0;
end;
//******* *******************************************
Function Tline.PlaySazEElam:integer;
var ret:integer;
begin
ret:=PlaysazDrvNot('SazElam.msg',1818,1818,1820);
Result:=ret
end;

//--------------------------------------------
Function Tline.PlayBipSazElam:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1820,1820,1820);
Result:=ret
end;
//****************************************
function TLine.GetSazElam:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,1822,1822,1834);
Result:=ret;
end;
//********************************************
function TLine.ChckSazElam:integer;
begin
if (KeyBuf='') and (CountMessagLinecount<2)then
begin
   LineStat.State:=1816;
   result:=0;
   exit;

end;
if (KeyBuf='') and (CountMessagLinecount>=2)then
begin
   LineStat.State:=1828;
   //100   //ANS nOT kEY
   AddFlagPcmMod(100);
   result:=0;
   exit;
end

else //if KeyBUF<>'' then
   begin
      LineStat.State:=1828;
      TypeRingUsed:=4; //1=NotUse  2=Use //3=of for dial //4=of for dial ans and ok
//    200   // OK ANS AND PRES KEY
      AddFlagPcmMod(200);
      result:=0;
      exit;
   end;

end;
//**************************************************
Function Tline.PlayELam:integer;
var Drive,NoBox:string;
begin

if Vsys_State=10 then
begin
     NoBox:='11111.';
     Drive:=DriveSaz;
     BoxLine.NoGroupPath:=Drive+NoBox;
     if (FileExists(BoxLine.NoGroupPath)) then
      begin
        PlaysazDrvNot('endElam.msg',1832,1832,1832);
        PlayFile(NoBox,Drive,1);
      end
      else PlayFile('NotFInfo.msg',DriveVSYS,0);
     LineStat.State:=1832;
end
else
 begin
   //?
   LineStat.State:=1832;
 end;
result:=0;
end;

//********************************************
function TLine.PlayGoodbyElam:integer;
var ret:integer;
begin
ret:=PlaySazDrvNot('GoodByEl.msg',1834,1834,1834);
Result:=ret
end;
//============================================
function TLine.OnHookElam: integer;
var ret:integer;
begin
 LineStat.V_Line:=V_OnHook     ;

//  SaveRing();

  paraLog('OnHook  elam  '+'  line'+Channel_Str,'1',time,0);
  logfile;

 //    300   // unLock
 AddFlagPcmMod(300);

ret:=OnHook;

if ret=NOT_OK then
LineStat.State:=1800
else LineStat.State:=1800;
Result:=LineStat.State;
end;


