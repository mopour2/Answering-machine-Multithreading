//********************************************
function TLine.PlayMon:integer;
var ret:integer;
begin
ret:=PlaySazDrv('GRMonshi.msg',14,1202,1204);
if ret =NOT_OK then
 ret:=PlaySysDrv('GRMonshi.msg',14,1202,1204);

Result:=ret
end;
//********************************************
function TLine.PlayBipMon:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1204,1204,1204);
Result:=ret
end;
//****************************************
function TLine.GetMon:integer;
var ret:integer;
begin
ret:=GetDigit(4,VTimeOutDig,1206,1206,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.CkeckMon:integer;
var temp:longint;
NoBox:string;
begin
  paraLog('CheckMon','1',time,0);
  logfile;
BoxLine.CountBus:=0;

  if (KeyBUF='*') or (KeyBUF='0' )then
   begin
      LineStat.State:=StateGoodBy;
      result:=0;
      exit;
   end;

 if (KeyBuf='9' )then
   begin
      LineStat.State:=14;
      result:=0;
      exit;
   end
else
 BEGIN
     if KeyBuf='' then
     begin
        if (VOpMod_state=2) then
	 LineStat.State:=600
       else LineStat.State:=608;
         GetActivOp;
     end
     else
     begin
       NoBox:=KeyBuf;
       BoxLine.SendDig:=NoBox;
       temp:=searchNoBox(NoBox);
       if (temp<> -1 ) then
        begin
          BoxLine.NoBox:=NoBox;
          BoxLine.CountBus:=0;
          read_InfoBox(BoxLine.NoBox,1);
          BoxLine.PointFile:=temp;
          BoxLine.PointCurentMess:=0;
          PlayFile(NoBox,DriveBoxGrV,1);
          LineStat.State:=608  ; //dial no
        end
        else
        begin
          if (VOpMod_state=2) then
      	    LineStat.State:=600
          else LineStat.State:=608;
          GetActivOp;
          PlayFile('Notcon.msg',DriveVSys,0);
        end;
      end;
 end;
result:=0;
end;
//***************************************************
function TLine.GetActivHoldOfDataBas:integer;
var HoldNo:integer;
begin
while MainForm.FlagLockHold do ;
 MainForm.FlagLockHold:=True;
 THold.Open;
 THold.Filter:='FalgActiv = 1 ' ;
 THold.Filtered:=true;
if THold.RecordCount >0 then
 begin
   THold.FindKey([MainForm.recnoHold]);
   HoldNo:=THold.FieldByName('NoOp').asinteger;

   if (not THold.eof)then
    THold.next
   else THold.FIRST;

   if (THold.eof)then
     THold.FIRST
   else ;
   MainForm.recnoHold:=THold.FieldByName('Id').asinteger;
end
else    HoldNo:=30;

 THold.close;

 MainForm.FlagLockHold:=false;

 result:=HoldNo;
end;
//***************************************************
function TLine.GetActivOPOfDataBas:integer;
var telNo:integer;
tempTime:tdatetime;
Hour, Min, Sec, MSec:Word;
begin
while MainForm.FlagLockOpAct do ;
 MainForm.FlagLockOpAct:=True;
 TabelTelop.Open;
  tempTime:=now;
  DecodeTime(tempTime, Hour, Min, Sec, MSec);

 if (Hour >= 7) and (hour< 14) then
   TabelTelop.Filter:='FalgActiv = 1 and Nait=''d'' ' 
 else TabelTelop.Filter:='FalgActiv = 1 and Nait=''n'' ' ;

 TabelTelop.Filtered:=true;
if TabelTelop.RecordCount >0 then
 begin
   TabelTelop.FindKey([MainForm.recno]);
   TelNo:=TabelTelop.FieldByName('NoOp').asinteger;

   if (not TabelTelop.eof)then
    TabelTelop.next
   else TabelTelop.FIRST;

   if (TabelTelop.eof)then
     TabelTelop.FIRST
   else ;
   MainForm.recno:=TabelTelop.FieldByName('Id').asinteger;
end
else    TelNo:=strtoint(VOpNumber);

 TabelTelop.close;

 MainForm.FlagLockOpAct:=false;

 result:=TelNo;
end;
//**************************************************
function TLine.GetActivOp:integer;
var NoBox:string;
temp:longint;
begin

  if (VOpOnly_serial=1) then
    NoBox:=VOpNumber
  else  if (VOpOnly_serial=2) then
   begin
      NoBox:=inttostr(strtointdef(VOpNumber,102)+Channel);
   end
  else
   begin
     NoBox:=inttostr(GetActivOPOfDataBas);
   end;

     BoxLine.SendDig:=NoBox;
     BoxLine.NoBox:='9';
     temp:=searchNoBox(VOpNumber);
     if (temp<> -1 ) then
      begin
//       BoxLine.CountBus:=0;
       BoxLine.NoBox:=VOpNumber;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
      end
      else
      begin
        PlayFile('BlNo.msg',DriveVSys,0);
      end;
Result:=0
end;
//*******************************************************************
function TLine.PlayWaitCallOp:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('WaitCall.msg',602,602,602);
  Result:=ret
end;
//*******************************************************************
function TLine.FlashLineOp:integer;
begin
if (VFlashMod=1) then
     FlashCall;
LineStat.State:=604;
Result:=0
end;
//*******************************************************************
function TLine.CallNumberOp:integer;
begin
   if SendDigits<>-1 then
   begin
   LineStat.State:=3;
   sleep(1000);
   Result:=0
   end
   else
      begin
       if (VOpMod_state=2) then
	 LineStat.State:=600
       else LineStat.State:=608;
         GetActivOp;
       PlayFile('Notcon.msg',DriveVSys,0);
      end;
Result:=0
end;
 //******************************************************************



//*******************************************************************
function TLine.PlayWaitCall:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('WaitCall.msg',14,610,610);
  Result:=ret
end;
//*******************************************************************
function TLine.FlashLine:integer;
begin
if (VFlashMod=1) then
     FlashCall;
LineStat.State:=612;
Result:=0
end;
//*******************************************************************
function TLine.CallNumber:integer;
begin
   if SendDigits<>-1 then
   begin
      if (VDialAfterModSt=2) then
     LineStat.State:=3             // dial and hang up
   else if (VDialAfterModSt=3) then   //get key check
       LineStat.State:=615
   else  LineStat.State:=614;      //wait for ans -ans busy else  check
    Result:=0
   end
   else
      begin
       if (VOpMod_state=2) then
	 LineStat.State:=600
       else LineStat.State:=608;
         GetActivOp;
       PlayFile('Notcon.msg',DriveVSys,0);
      end;
Result:=0
end;
//**************************************************
function TLine.WaitForAnsw(St_Ans:integer;St_Busy:integer;St_Else:integer):integer;
var ret:integer;
begin
ret:= WaitForAns;
if (ret=6) then //ans
  LineStat.State:=St_Ans
else if (ret=3) then //busy
  LineStat.State:=St_Busy
else LineStat.State:=St_else;
Result:=0;
end;
//*******************************************************************
function TLine.WaitForAns1:integer;
begin
WaitForAnsw(3,620,616);
Result:=0
end;

//******************************************************************
//                   No Ans
//
//*******************************************************************
function TLine.FlashLineNotAns:integer;
begin
 FlashCall;
LineStat.State:=618;
Result:=0
end;
//*******************************************************************
function TLine.PlayCallNotAns:integer;
var ret:integer;
begin

   if (VIntNotAnsOp_rec=1) then
    begin
      if (BoxLine.NoBox<>VOpNumber) and (findindb<>1) then
      begin
        ret:=PlaySysDrvNot('CallNotA.msg',600,600,600);
         Result:=ret;
         if (VOpMod_state=2) then
           LineStat.State:=600
         else LineStat.State:=608;
         GetActivOp
       end
      else
       begin
        ret:=PlaySysDrvNot('notsigca.msg',StateGoodBy,StateGoodBy,StateGoodBy);
        Result:=ret;
        LineStat.State:=StateGoodBy;
       end;
    end
   else
     begin
      ret:=PlaySysDrvNot('cnar.msg',600,600,600);
      PlayFile('Bip.msg',DriveVSys,0);
      Result:=ret;
      GetLocalNoBoxOp;
      LineStat.State:=64;
     end;

end;
//*******************************************************************
//
//
//            busy
 //
//*******************************************************************
function TLine.FlashLineBusy:integer;
begin
FlashCall;
LineStat.State:=622;
Result:=0
end;
//*******************************************************************
function TLine.PlayLineBuse:integer;
var ret:integer;
begin
  ret:=PlaySysDrvNot('LineBsy.msg',623,623,StateGoodBy);
  Result:=ret
end;
//*******************************************************************
function TLine.findindb:integer;
var nobb:integer;
flagfind:integer;
begin
Nobb:=strtoint(BoxLine.NoBox);
while MainForm.FlagLockOpAct do ;
 MainForm.FlagLockOpAct:=True;
 TabelTelop.Open;
 TabelTelop.Filter:='' ;
 TabelTelop.Filtered:=true;
if TabelTelop.RecordCount >0 then
 begin
    flagfind:=0;
   while (not TabelTelop.eof) do
   begin
     if (TabelTelop.FieldByName('NoOp').asinteger=Nobb) then
       flagfind:=1;
     TabelTelop.next
   end;
   result:=flagfind;
end
else  result:=0;
 TabelTelop.close;
 MainForm.FlagLockOpAct:=false;
end;
//*******************************************************************
function TLine.GetLocalNoBoxOp:integer;
var NoBox:string;
temp:longint;
begin
  if (BoxLine.NoBox=VOpNumber) or (findindb=1) then
  begin
     NoBox:='4';
     temp:=searchNoBox(NoBox);
     if (temp<> -1 ) then
      begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
      end
      else
        PlayFile('BlNoBx.msg',DriveVSys,0);
   end;
Result:=0   
end;
//*******************************************************************
function TLine.ChckPlayHold30:integer;
var ret:integer;
NoBox:string;

begin
if  BoxLine.CountBus < VCountBus then
 begin
   if (BoxLine.NoBox=VOpNumber) or (findindb=1) then
        GetActivOp;

    BoxLine.CountBus:=BoxLine.CountBus+1;
    NoBox:=inttostr(GetActivHoldOfDataBas);
    ret:=PlaySysDrv('hold'+NoBox+'.msg',608,608,608);
    if ret =NOT_OK then
      ret:=PlaySysDrv('Hold30.msg',608,608,608)
    else ;
    LineStat.State:=608;
    Result:=ret
 end
 else
 begin
   if (VIntNotAnsOp_rec=1) then
    begin
      if (BoxLine.NoBox<>VOpNumber) and (findindb<>1) then
      begin
         Result:=0;
         if (VOpMod_state=2) then
           LineStat.State:=600
         else LineStat.State:=608;
         GetActivOp
       end
      else
       begin
        ret:=PlaySysDrvNot('notsigca.msg',StateGoodBy,StateGoodBy,StateGoodBy);
        Result:=ret;
        LineStat.State:=StateGoodBy;
       end;
    end
   else
     begin
      ret:=PlaySysDrvNot('vbcaor.msg',64,64,64);
      PlayFile('Bip.msg',DriveVSys,0);
      Result:=ret;
      GetLocalNoBoxOp;
      LineStat.State:=64;
     end;
 end;
end;
//****************************************************************
//
//
//
//
//****************************************************************
function TLine.GetKeyResponsCall:integer;
var ret:integer;
begin
ret:=GetDigit(1,VAnsDelay,620,3,620);
Result:=ret;
end;
//***********************************************
