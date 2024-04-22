constructor TMyThreadNazer.Build () ;
begin
  Inherited Create(True);
  ChanelNazer:=0;
  FlagShutDown:=false;
  FlagNazer:=false;
  CountRunTreed:=0;
  Priority :=tpLowest; { set the priority to  lower than normal }
  Resume;
end;


procedure TMyThreadNazer.Execute;
var i:integer;
temp:Word;
temp2:Word;
tempTime:tdatetime;
Ev_Hour,St_Hour,Hour, Min, Sec, MSec:Word;
begin

Repeat
if(CountRunTreed >100000) then
begin
CountRunTreed:=0;
if (FlagShutDown=false) and   (FlagNazer=false ) then
begin
  FlagNazer:=true;
  tempTime:=now;
  DecodeTime(tempTime, Hour, Min, Sec, MSec);

  if ChanelNazer <  ActiveChannels-1 then
     ChanelNazer:=ChanelNazer+1
  else ChanelNazer:=0;

   i:=ChanelNazer;

   if MainForm.CheckBox2.Checked=true then
     MainForm.statusLine(i);

   Line [ i ].FStatusLine.Caption := Line [ i ].Status_String ;

    if (Line[i].LineStat.State<>StartOnState) and (Line[i].LineStat.State<>0) then
    begin
      Ev_Hour:=Line[i].LineStat.Ev_Hour;
      St_Hour:=Line[i].LineStat.Hour;
     if (Ev_Hour=0) and (Hour=0)then
        Ev_Hour:=24;
     if (St_Hour=0) and (Hour=0)then
       St_Hour:=24;
     if (Hour=0)then
       Hour:=24;

        temp :=Hour*60+Min -(Ev_Hour*60 +Line[i].LineStat.Ev_Min)  ;
        temp2:=Hour*60+Min -(St_Hour*60 +Line[i].LineStat.Min) ;

      if (temp >= MaxTimeNotEvent)  and (Line[i].LineStat.State <> StateOffHook) and (Line[i].LineStat.State <> StateonHook  ) then
      begin
             Line[i].paraLog('NotEV ERROR ERROR  state='+inttostr(Line[i].LineStat.State)+'LastState='+inttostr(Line[i].LineStat.LastState),'1',time,0);
             Line[i].logFile2;
             Line[i].LineStat.LastState:=Line[i].LineStat.State;
             Line [i].Local_Exit_Flag := not Line [ i ].Local_Exit_Flag ;
             sleep(1000);
             Line [i].Local_Exit_Flag := not Line [ i ].Local_Exit_Flag ;
             Line [ i ].Local_Exit_Flag := false ;
       	     Line[i].LineStat.State:=StateonHook;
       end
//---------------------
      else if (temp2 >=MaxTimeUsedSystem) and (Line[i].LineStat.State <> StateOutTim)and (Line[i].LineStat.State <>StateOffHook) and (Line[i].LineStat.State <>StateonHook)then
	   begin
             Line[i].paraLog('MaxTime System   state='+inttostr(Line[i].LineStat.State)+'LastState='+inttostr(Line[i].LineStat.LastState),'1',time,0);
             Line[i].logFile2;
             Line[i].LineStat.LastState:=Line[i].LineStat.State;
	     Line[i].LineStat.State:=StateOutTim;
	   end;
//---------------------
     if (temp >= MaxTimeNotEvent+4 ) and (FlagShutDown=false )Then
      begin
         FlagShutDown:=true;
         Line[i].paraLog('Denger system error   state='+inttostr(Line[i].LineStat.State)+'LastState='+inttostr(Line[i].LineStat.LastState),'1',time,0);
         Line[i].logFile2;
         MainForm.ExitP;
         ExitWindowsEx( EWX_REBOOT, 0 );
      end;
    end; //end if
   FlagNazer:=false;
end;
end
else CountRunTreed:=CountRunTreed+1;

Until Line[0].ExitFlag or Global_Exit_Flag ;
 Terminate;
end;

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
procedure Tline.paraLog(VMesLog:string;VTypeLog:string;VLogTimeSt,
                 VLogTimeEn:TDateTime);
begin
    LogType:=VTypeLog;
    LogMes:=VMesLog;
    LogDate:=date;
    LogTimeSt:=VLogTimeSt;
    LogTimeEn:=VLogTimeEn;
    LogV_Line:=LineStat.V_Line;
end;
//============================================
procedure TLine.logfile2;
begin
while MainForm.FlagLocklogfile do ;
 MainForm.FlagLocklogfile:=True;
 TabelLog.Open;
 TabelLog.insert;
 TabelLog.FieldByName('line').asstring:=Channel_Str;
 TabelLog.FieldByName('V_line').asinteger:=LogV_Line;
 TabelLog.FieldByName('TypeLog').asstring:=LogType;
 TabelLog.FieldByName('LogStr').asstring:=LogMes;
 TabelLog.FieldByName('State').asinteger:=LineStat.State;
 TabelLog.FieldByName('LastState').asinteger:=LineStat.LastState;
 TabelLog.FieldByName('Date').asstring:=datetostr(LogDate);
 TabelLog.FieldByName('Time').asstring:=timetostr(LogTimeSt);
 TabelLog.post;
 TabelLog.Refresh;
 TabelLog.Refresh;
 TabelLog.Refresh;
 TabelLog.close;
 MainForm.FlagLocklogfile:=false;
end;
//============================================
procedure TLine.logfile;
begin
if LogOnOf= 1then
begin
while MainForm.FlagLocklogfile do ;
 MainForm.FlagLocklogfile:=True;
 TabelLog.Open;
 TabelLog.insert;
 TabelLog.FieldByName('line').asstring:=Channel_Str;
 TabelLog.FieldByName('V_line').asinteger:=LogV_Line;
 TabelLog.FieldByName('TypeLog').asstring:=LogType;
 TabelLog.FieldByName('LogStr').asstring:=LogMes;
 TabelLog.FieldByName('State').asinteger:=LineStat.State;
 TabelLog.FieldByName('LastState').asinteger:=LineStat.LastState;
 TabelLog.FieldByName('Date').asstring:=datetostr(LogDate);
 TabelLog.FieldByName('Time').asstring:=timetostr(LogTimeSt);
 TabelLog.post;
 TabelLog.Refresh;
 TabelLog.Refresh;
 TabelLog.Refresh;
 TabelLog.close;
 MainForm.FlagLocklogfile:=false;
end;
end;
//============================================
destructor TLine.Free;
begin

end;
//============================================
function TLine.Startup: integer;
var proc:tthreadmethod;
begin

  LineStat.State:=StartOnState;
  LineStat.V_Line:=V_Start;
  KeyBuf:='';
  paraLog('Start UP  ....  '+'  line'+Channel_Str,'1',time,0);
  logfile2;
  proc:=logfile;
  Synchronize(Proc);

  VoicePath  := ''  ;
  Extension  := ''  ;

  Set_Ring_Param(VRing, 1);
  HookFlash_Param:=VFlashDelay;
  Max_Silence := VMaxSil;
  Tx_Gain:=VPG;
  Rx_Gain:=VRG;



LineStat.EndEventTime:= Now;
DecodeTime(LineStat.EndEventTime,LineStat.Ev_Hour,LineStat.Ev_Min,LineStat.Ev_Sec,LineStat.Ev_MSec);

OffHook_StartTime:=now;
LineStat.StartTime:=now;
DecodeTime(LineStat.StartTime,LineStat.Hour,LineStat.Min,LineStat.Sec,LineStat.MSec);

if (Vsys_State=10) or (Vsys_State=11) then
 LineStat.State:=1800
else  LineStat.State:=1;

Result:=LineStat.State;

end;
//============================================
function TLine.Tableopen: integer;
begin

TabelInfo.open;

TabelInfoBox1.open;
TabelInfoBox2.open;
TabelMessBox1.open;
TabelMessBox2.open;

TabelErja.open;

TabelRing.open;

TabelGroup.open;
TabelGroupBox.open;

TabelBakhsh.open;
Result:=0;
end;
//============================================
function TLine.tableclose: integer;
begin
if TabelInfo.active=true then
     TabelInfo.close;

if TabelInfoBox1.active=true then
     TabelInfoBox1.close;
if TabelInfoBox2.active=true then
     TabelInfoBox2.close;

if TabelMessBox1.active=true then
     TabelMessBox1.close;
if TabelMessBox2.active=true then
    TabelMessBox2.close;

if TabelErja.active=true then
    TabelErja.close;

if TabelRing.active=true then
    TabelRing.close;

if TabelGroup.active=true then
    TabelGroup.close;
if TabelGroupBox.active=true then
   TabelGroupBox.close;

if TabelBakhsh.active=true then
TabelBakhsh.close;
Result:=0;
end;
//============================================
function TLine.FWaitForRing: integer;
var ret:integer;
key:string;
begin
paraLog('WaitForRing  ....  '+'  line'+Channel_Str,'1',time,0);
 logfile;
LineStat.V_Line:=V_WaitRing     ;
LineStat.EndEventTime:= Now;
DecodeTime(LineStat.EndEventTime,LineStat.Ev_Hour,LineStat.Ev_Min,LineStat.Ev_Sec,LineStat.Ev_MSec);
OffHook_StartTime:=now;
LineStat.StartTime:=now;
DecodeTime(LineStat.StartTime,LineStat.Hour,LineStat.Min,LineStat.Sec,LineStat.MSec);

while MainForm.FlagLocklogfile do ;

Tableclose;

BoxLine.CountBus:=0;

ret:=WaitForRing;

// key:=GetToneStr([ '*','1','2','3','4','5','6','7','8','9','0','#' ] ,[ '*' ] ,20,1000);
//  ShowMessage('key===== '+key);
Tableopen;

LineStat.EndEventTime:= Now;
DecodeTime(LineStat.EndEventTime,LineStat.Ev_Hour,LineStat.Ev_Min,LineStat.Ev_Sec,LineStat.Ev_MSec);
OffHook_StartTime:=now;
LineStat.StartTime:=now;
DecodeTime(LineStat.StartTime,LineStat.Hour,LineStat.Min,LineStat.Sec,LineStat.MSec);


if ret=NOT_OK then
 LineStat.State:=1
else LineStat.State:=2;
Result:=LineStat.State;
end;
//============================================
function TLine.FOffHook: integer;
var ret:integer;
begin
  CountMessagLinecount:=1;
  PointCurrentNod:=1;
  LineStat.V_Line:=V_OffHook;
  TypeRingUsed:=1; //1=NotUse  2=Use

  paraLog('OffHook  ....  '+'  line'+Channel_Str,'1',time,0);
  logfile;

ret:=OffHook;
if ret=NOT_OK then
LineStat.State:= StateonHook
else LineStat.State:=10;
Result:=LineStat.State;
end;
//===================================================
function TLine.SaveRing:integer;
var
Temp1,Temp2,Temp3:string;
d:TdateTime;
Year, Month, Day: Word;
TimeStart:string;
timeEnd:string;
RingLine:string;
begin
//-----------------------
// TypeRing=1; //1=NotUse  2=Use
//-----------------------
d:=now;
DecodeDate(d,Year, Month, Day);
ftodate(Year, Month, Day);
  Temp2:=inttostr(year)+'/';
   temp1:=inttostr(Month);
   if (length(Temp1)<2) then
     Temp3:='0'+Temp1
   else Temp3:=Temp1;
   Temp2:=Temp2+Temp3+'/';
   temp1:=inttostr(Day);
   if (length(Temp1)<2) then
     Temp3:='0'+Temp1
   else Temp3:=Temp1;
   Temp2:=Temp2+Temp3;


//-----------------------
   RingDate:=Temp2;
   TimeStart:=timeTostr(LineStat.StartTime);
   timeEnd:=timeTostr(d);
   RingLine:=Channel_Str;
//-----------------------

while MainForm.FlagLockRing do ;
MainForm.FlagLocKRing:=true;
TabelRing.insert;
TabelRing.FieldByName('LineRing').AsVariant:=RingLine;
TabelRing.FieldByName('TypeRing').AsString :=inttostr(TypeRingUsed);
TabelRing.FieldByName('RingDate').AsString :=RingDate;
TabelRing.FieldByName('RingTime').AsString:=TimeStart;
TabelRing.FieldByName('RingTimeOut').AsString:=timeEnd;
TabelRing.post;
TabelRing.refresh;
MainForm.FlagLockRing:=false;
result:=0;
end;
//============================================
function TLine.FOnHook: integer;
var ret:integer;
begin
 LineStat.V_Line:=V_OnHook     ;

  SaveRing();

  paraLog('OnHook  ....  '+'  line'+Channel_Str,'1',time,0);
  logfile;

ret:=OnHook;
if ret=NOT_OK then
LineStat.State:=1
else LineStat.State:=1;
Result:=LineStat.State;
end;
//============================================
function TLine.PlayFileWav(filename:string;Drive:string;FlagBreak:integer):integer;
var ret:integer;
begin
    LineStat.V_Line:=V_Play;

   ClearAllInput ;

   if (filename<>'Null.msg') and  (filename<> 'Bip.msg') then
    if (CountMessagLineMsg=filename) and  (CountMessagLinecount >MaxPlayOneMess)then
     begin
        if FileExists(DriveVSYS+'outTime.msg') then
        begin
            LineStat.State:=StateOutTim;
            paraLog('Play..  '+Drive+FileName,'1',time,0);
            logfile;
            Result:=NoChengState;
            exit;
        end
     end
    else if (CountMessagLineMsg=filename)then
	 inc(CountMessagLinecount)
	 else begin
		CountMessagLineMsg:=filename;
		CountMessagLinecount:=1;
	      end;
  paraLog('Play..  '+Drive+FileName+'  line'+Channel_Str,'1',time,0);
  logfile;

   if FileExists(Drive+fileName) then
   begin
    if (FlagBreak=0) then
     ret:=PlayVoice( [ ] ,Drive+filename ,  WAV )
    else if (flagBreak=1)then
           ret:=PlayVoice( [ '1','2','3','4','5','6','7','8','9','0','#' ] ,Drive+filename , WAV )
    else   ret:=PlayVoice( [ '8','0'] ,Drive+filename ,  WAV );


  if(LineStat.State=StateOutTim) then
  begin
   Result:=NoChengState;
   exit;
  end
  else if ret =0 then
     begin
        if   Digit_Avail=true then
         Result:=Term_Digit
        ELSE if Disconnect_Flag=true then
         Result:=Disconnect
        ELSE if Fax_Rx_Flag=true then
          Result:=Fax_Rx
        else Result:=PBEOF;
     end
    else Result:=NOT_OK;  //ret<>0
   end
   else Result:=NOT_OK; //FileExists
end;
//============================================
function TLine.PlayFile(filename:string;Drive:string;FlagBreak:integer):integer;
var ret:integer;
begin
    LineStat.V_Line:=V_Play;
//    PlayStartTime:=time;


   ClearAllInput ;

   if (filename<>'Null.msg') and  (filename<> 'Bip.msg') then
    if (CountMessagLineMsg=filename) and  (CountMessagLinecount >MaxPlayOneMess)then
     begin
        if FileExists(DriveVSYS+'outTime.msg') then
        begin
            LineStat.State:=StateOutTim;
            paraLog('Play..  '+Drive+FileName,'1',time,0);
            logfile;
            Result:=NoChengState;
            exit;
        end
     end
    else if (CountMessagLineMsg=filename)then
	 inc(CountMessagLinecount)
	 else begin
		CountMessagLineMsg:=filename;
		CountMessagLinecount:=1;
	      end;
  paraLog('Play..  '+Drive+FileName+'  line'+Channel_Str,'1',time,0);
  logfile;

   if FileExists(Drive+fileName) then
   begin
    if (FlagBreak=0) then
     ret:=PlayVoice( [ ] ,Drive+filename , PCM )
    else if (flagBreak=1)then
          ret:=PlayVoice( [ '1','2','3','4','5','6','7','8','9','0'] ,Drive+filename , PCM )
    else if (flagBreak=100)then
           ret:=PlayVoice( [ '3','4','5','6','7','8','9','0','#'] ,Drive+filename , PCM )
    else   ret:=PlayVoice( [ '8','0'] ,Drive+filename , PCM );


    if(LineStat.State=StateOutTim) then
    begin
     Result:=NoChengState;
     exit;
    end
    else if ret =0 then
       begin
          if   Digit_Avail=true then
           Result:=Term_Digit
          ELSE if Disconnect_Flag=true then
           Result:=Disconnect
          ELSE if Fax_Rx_Flag=true then
            Result:=Fax_Rx
         else Result:=PBEOF;
       end
       else Result:=NOT_OK;
   end
   else Result:=NOT_OK;
end;
//============================================
function TLine.RecFile(filename:string;Drive:string;MaxTime:integer;FlagBreak:integer):integer;
var ret:integer;
begin
    LineStat.V_Line:=V_Record;
//  PlayStartTime:=time;
  paraLog('Record..  '+Drive+FileName+'  line'+Channel_Str,'1',time,0);
  logfile;


    ClearAllInput ;

    if (FlagBreak=0) then
     ret:=RecordVoice( ['*','0'] ,MaxTime,Drive+filename , PCM )
    else if (flagBreak=1)then
           ret:=RecordVoice( [ '1','2','3','4','5','6','7','8','9','0'] ,MaxTime,Drive+filename , PCM )
    else   ret:=RecordVoice( [ '0'],MaxTime ,Drive+filename , PCM );


    if ret =0 then
     begin
        if   TimeOut=true then
           Result:=MAXSECS
        else if   Digit_Avail=true then
         Result:=Term_Digit
        ELSE if Disconnect_Flag=true then
         Result:=Disconnect
        ELSE if Fax_Rx_Flag=true then
          Result:=Fax_Rx
       else Result:=_Ok;
     end
    else Result:=NOT_OK;
end;
//============================================
function Tline.GetDigits(Max_Digit:Byte;Delay_Time:DWord;FlagStar:integer):integer;
begin
  LineStat.V_Line:=V_GetDigits;
  if FlagStar=0 then
  begin
    IF VGetDig_Pulse_Tone =1 THEN
       KeyBuf:=GetToneStr([ '1','2','3','4','5','6','7','8','9','0'] ,[ ], Max_Digit,Delay_Time)
    ELSE  KeyBuf:=GetTonePulseStr([ '1','2','3','4','5','6','7','8','9','0'] ,[ ], Max_Digit,Delay_Time);
  end
  else
     begin
       IF VGetDig_Pulse_Tone =1 THEN
         KeyBuf:=GetToneStr([ '1','2','3','4','5','6','7','8','9','0','*','#'] ,['*','#' ], Max_Digit,Delay_Time)
       ELSE  KeyBuf:=GetTonePulseStr([ '1','2','3','4','5','6','7','8','9','0','*','#'] ,['*','#'], Max_Digit,Delay_Time);
     end;

  paraLog('GetDigit..  '+KeyBuf+'  line'+Channel_Str,'1',time,0);
  logfile;

  if(LineStat.State=StateOutTim) then
  begin
   Result:=NoChengState;
   exit;
  end
  ELSE if   TimeOut=true then
           Result:=IDD
      else  if   Digit_Avail=true then
           Result:=Max_Digit1
      else  if   DTMF_Exist_Flag=true then
           Result:=Max_Digit1
        ELSE if Disconnect_Flag=true then
         Result:=Disconnect
        ELSE if Fax_Rx_Flag=true then
          Result:=Fax_Rx
       else Result:=_Ok;
end;
//============================================
function TLine.SendDigits:integer;
begin

 DialStartTime:=Now;//00
 LineStat.V_Line:=V_SendDigits;
 paraLog('Send..  '+BoxLine.SendDig +'  line'+Channel_Str,'1',time,0);
 logfile;
 if BoxLine.SendDig <> '' then
 begin
   if VDialPulseTone=1 then
   Dial(BoxLine.SendDig)
 else Dial('T'+BoxLine.SendDig);
 // sleep(1000);
  result:=0;
 end
 else result:=-1;
end;
//============================================
function TLine.FlashCall:integer;
begin
 DialStartTime:=Now;//00
 LineStat.V_Line:=V_Flash;
 paraLog('Flash..  '+Channel_Str,'1',time,0);
  logfile;

 Dial('H');
 sleep(VAfterFlashDelay);
result:=0;
end;
//============================================
function TLine.WaitForAns:integer;
var StCall:LineStateType;
//s1:array [0..15] of string;
begin
 DialStartTime:=Now;//00
 LineStat.V_Line:=V_WaitAns;
// s1[0]:='Fax_Tone_2100';s1[1]:='Fax_Tone_1100';
// s1[2]:='Dial_Tone';s1[3]:='Busy_Tone';
// s1[4]:='Silence';s1[5]:='NoAnswer';
// s1[6]:='Answered';s1[7]:='Unknown';
// s1[8]:='RingBack_Tone';s1[9]:='GSM_IS_NOT_ACCESSABLE';
// s1[10]:='GSM_IS_OFF';
//  LineStateType    = ( Fax_Tone_2100,Fax_Tone_1100, Dial_Tone , Busy_Tone , Silence , NoAnswer ,
//                       Answered , Unknown ,RingBack_Tone, GSM_IS_NOT_ACCESSABLE, GSM_IS_OFF) ;  { Call Progress State }

 StCall:=WaitForAnswer(VAnsDelay);
 paraLog('Wait For Ans..  '+Channel_Str+' cp='+inttostr(ord(stcall)),'1',time,0);
  logfile;
result:=ord(stcall);
end;
//============================================
procedure TLine.Run;
var i:integer;
var lastst:integer;
begin
LineStat.LastState:=LineStat.State;
LastSt:=LineStat.State;
i:=0;

  Repeat
   LastSt:=LineStat.State;
  if Local_Exit_Flag=false then
  begin
    i:=machine[LineStat.State];
  if (i<>NOT_OK)then
    begin
     LineStat.EndEventTime:= Now;
     DecodeTime(LineStat.EndEventTime,LineStat.Ev_Hour,LineStat.Ev_Min,LineStat.Ev_Sec,LineStat.Ev_MSec);
   end;
  end;
   LineStat.LastState:=LastSt;

  Until ExitFlag or Global_Exit_Flag ;
//  Terminate;
end;
//============================================

