function TLine.PlaySazDrv(FileName:string;NOT_OK_St:integer;PBEOF_St:integer;Term_St:integer):integer;
var ret:integer;
begin
ret:=PlayFile(FileName,DriveVSaz,1);
if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if ret=NOT_OK then
 LineStat.State:=NOT_OK_St
else
 begin
   if ret=PBEOF then
    LineStat.State:=PBEOF_St
   else if ret=Term_Digit then
        LineStat.State:=Term_St
   else LineStat.State:=StateonHook;
 end;
Result:=ret;
end;
//*************************
function TLine.PlaySazDrvNot(FileName:string;NOT_OK_St:integer;PBEOF_St:integer;Term_St:integer):integer;
var ret:integer;
begin
ret:=PlayFile(FileName,DriveVSaz,0);
if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if ret=NOT_OK then
 LineStat.State:=NOT_OK_St
else
 begin
   if ret=PBEOF then
    LineStat.State:=PBEOF_St
   else if ret=Term_Digit then
        LineStat.State:=Term_St
   else LineStat.State:=StateonHook;
 end;
Result:=ret;
end;

//************************************************
function TLine.PlayDateDrvNot(FileName:string;NOT_OK_St:integer;PBEOF_St:integer;Term_St:integer):integer;
var ret:integer;
begin
ret:=PlayFile(FileName,DriveDateV,0);
if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if ret=NOT_OK then
 LineStat.State:=NOT_OK_St
else
 begin
   if ret=PBEOF then
    LineStat.State:=PBEOF_St
   else if ret=Term_Digit then
        LineStat.State:=Term_St
   else LineStat.State:=StateonHook;
 end;
Result:=ret;
end;
//*******************************************
function TLine.PlaySysDrv(FileName:string;NOT_OK_St:integer;PBEOF_St:integer;Term_St:integer):integer;
var ret:integer;
begin
ret:=PlayFile(FileName,DriveVSys,1);
if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if ret=NOT_OK then
 LineStat.State:=NOT_OK_St
else
 begin
   if ret=PBEOF then
    LineStat.State:=PBEOF_St
   else if ret=Term_Digit then
        LineStat.State:=Term_St
   else LineStat.State:=StateonHook;
 end;
Result:=ret;
end;
//************************************************
function TLine.PlaySysDrvNot(FileName:string;NOT_OK_St:integer;PBEOF_St:integer;Term_St:integer):integer;
var ret:integer;
begin
ret:=PlayFile(FileName,DriveVSys,0);
if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if ret=NOT_OK then
 LineStat.State:=NOT_OK_St
else
 begin
   if ret=PBEOF then
    LineStat.State:=PBEOF_St
   else if ret=Term_Digit then
        LineStat.State:=Term_St
   else LineStat.State:=StateonHook;
 end;
Result:=ret;
end;
//********************************************
function TLine.GetDigit(dig,delay,StIdd,StMax,Stother:integer):integer;
var ret:integer;
begin
ret:= GetDigits(Dig,Delay,0);
if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if (ret=IDD) then
   LineStat.State:=StIdd
else if    (ret=Max_Digit1) then
    LineStat.State:=StMAx
else LineStat.State:=StOther;
Result:=ret;
end;
//********************************************
function TLine.GetDigitStar(dig,delay,StIdd,StMax,Stother:integer):integer;
var ret:integer;
begin
ret:= GetDigits(Dig,Delay,1);
if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if (ret=IDD) then
   LineStat.State:=StIdd
else if    (ret=Max_Digit1) then
    LineStat.State:=StMAx
else LineStat.State:=StOther;
Result:=ret;
end;
//*******************************************************************
function  Tline.copyFile(File1,File2:string):integer;
var
 f1,f2:file;
  BytesRead: Integer;
  Buf: array[1..524288] of Char;
begin
  paraLog('Copy File  '+File1+' to '+File2,'1',time,0);
  logfile;

    AssignFile(f1,File1);
    AssignFile(f2,File2);
  {$I-}
   Reset(F1, 1);	{ Record size = 1 }
  {$I+}
  if IOResult <> 0 then
  begin
   result:=0;exit;
  end;

  rewrite(f2,1);
 while not eof(f1) DO
  BEGIN
    BlockRead(F1, Buf, SizeOf(Buf), BytesRead);

    BlockWrite(F2, Buf, BytesRead );
  END;
 CLOSEfile(F1);
 CLOSEfile(F2);
result:=1;exit;
end;
//********************************************
//!@#
//--------------------------------------------
//             Other
//
//********************************************


function TLine.PlayOtherNoBox:integer;
var ret:integer;
begin
ret:=PlaySysDrv('OthrNoBx.msg',14,56,58);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipOtherNoBox:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',58,58,58);
Result:=ret
end;

//****************************************
function TLine.GetOtherNoBox:integer;
var ret:integer;
begin
ret:=GetDigit(19,VTimeOutDig,60,60,StateGoodBy);
Result:=ret;
end;
//********************************************
function Tline.searchNoBox(NoBox:string) : longint;
Var Flag:Boolean;
i:string;
begin
  TabelInfoBox1.First;
  Flag:=TabelInfoBox1.FindKey([NoBox]);
  if Flag=true then
    i:='true'
  else i:='false';
  paraLog('searchNoBox '+ NoBox+' ' +i,'1',time,0);
  logfile;
  if Flag=true then
    result:=TabelInfoBox1.RecNo
  else result:=-1;
end;
//********************************************
function TLine.FuncIdd(BackState,RepState:integer):integer;
begin
if (KeyBuf='') and (CountMessagLinecount<2)then
begin
   LineStat.State:=RepState;
   result:=0;
   exit;

end;
if (KeyBuf='') and (CountMessagLinecount>=2)then
begin
   LineStat.State:=StateGoodby;
   result:=0;
   exit;
end;

if (KeyBUF='*') or (KeyBUF='0' )then
   begin
      LineStat.State:=BackState;
      result:=0;
      exit;
   end;
 result:=1;
end;
//********************************************
function TLine.ChckOthrNoBx:integer;
var NoBox:string;
    Temp:longint;
begin
  paraLog('ChckOthrNoBx','1',time,0);
  logfile;

if(FuncIdd(StateMainMenu,54)=0) then
begin
      result:=0;
      exit;
end
else if (KeyBuf<>'' )then
   begin
    NoBox:=KeyBuf;
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=62  ;
       PlayFile(NoBox,DriveBoxGrV,1);
     end
    else
     begin
      LineStat.State:=54;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
      result:=0;
      exit;
   end
else LineStat.State:=StateGoodBy;
result:=0;
end;
//*----------------------------------------------*/
function TLine.PlayOthrRep:integer;
var
 Temp:string;
Begin
  Temp:='1100t'+Channel_Str+'.v';
  PlayFile(Temp,DriveBoxV,1);
 Result:=0;
end;
//****************************************************
function TLine.PlayBxBipRec:integer;
var ret:integer;
     namfilevoic:string;
begin
  if (BoxLine.Data.FlagRecBipMes=1) then
  begin
    PlaySysDrvNot('BxBpR.msg',64,64,64);
    PlayFile('Bip.msg',DriveVSys,0);
  end
  else begin
 	 namfilevoic:='BxBpR'+BoxLine.NoBox+'.msg';
         ret:=PlaySazDrvNot(namfilevoic,64,64,64);
         if ret<>NOT_OK then
         PlayFile('Bip.msg',DriveVSys,0)
         else  PlaySysDrvNot('BxBpR.msg',64,64,64);
       end;
Result:=0;
end;
//****************************************************
function TLine.RecMesBx:integer;
var ret:integer;
  Temp:string;
begin

  Temp:='1100t'+Channel_Str+'.v';

  BoxLine.Copy1:=DriveBoxV+Temp;

  ret:=RecFile(Temp,DriveBoxV,60000*4,0);
  LineStat.State:=66;
   result:=ret;
end;
//*----------------------------------------------*/
function Tline.ReadFC:integer;
var i:integer;
begin
  while MainForm.FlagLockCountVoice do ;
  MainForm.FlagLockCountVoice:=True;
  MainForm.TabelCountVoic.open;
  i:= MainForm.TabelCountVoic.FieldByName('CountVoice').asinteger;
  MainForm.TabelCountVoic.refresh;
  MainForm.TabelCountVoic.close;
  MainForm.FlagLockCountVoice:=false;
  result:=i;
end;
//*----------------------------------------------*/
Procedure Tline.ReadFCDate(var Year,  Month, Day:Word);
begin
   while MainForm.FlagLockCountVoice do ;
   MainForm.FlagLockCountVoice:=True;
   MainForm.TabelCountVoic.open;
   MainForm.TabelCountVoic.refresh;
   Year:=MainForm.TabelCountVoic.FieldByName('EndDateY').asinteger;
   Month:=MainForm.TabelCountVoic.FieldByName('EndDateM').asinteger;
   Day:=MainForm.TabelCountVoic.FieldByName('EndDateD').asinteger;
   MainForm.TabelCountVoic.refresh;
   MainForm.TabelCountVoic.close;
   MainForm.FlagLockCountVoice:=false;
end;
//*----------------------------------------------*/
Procedure Tline.WritFCDate(var Year, Month, Day:Word);
begin

   while MainForm.FlagLockCountVoice do ;
   MainForm.FlagLockCountVoice:=True;
   MainForm.TabelCountVoic.open;
   MainForm.TabelCountVoic.edit;
   MainForm.TabelCountVoic.FieldByName('EndDateY').asinteger:=integer(Year);
   MainForm.TabelCountVoic.FieldByName('EndDateM').asinteger:=integer(Month);
   MainForm.TabelCountVoic.FieldByName('EndDateD').asinteger:=integer(Day);
   MainForm.TabelCountVoic.post;
   MainForm.TabelCountVoic.refresh;
   MainForm.FlagLockCountVoice:=false;
   MainForm.TabelCountVoic.close;
end;

//*----------------------------------------------*/
function Tline.WritFC(LL:integer):integer;
begin
   while MainForm.FlagLockCountVoice do ;
   MainForm.FlagLockCountVoice:=True;
   MainForm.TabelCountVoic.open;
   MainForm.TabelCountVoic.edit;
   MainForm.TabelCountVoic.FieldByName('CountVoice').asinteger:=LL;
   MainForm.TabelCountVoic.post;
   MainForm.TabelCountVoic.Refresh;
   MainForm.FlagLockCountVoice:=false;
   MainForm.TabelCountVoic.close;
result:=0;
end;
//*----------------------------------------------*/
function Tline.GenertFileName( Var L:Longint;Var FileName:string;Var FileNamePath:string):integer;
var
 Montt:string;
 Temp2:string;
 Temp5:string;
 d:tdatetime;
 Year, Month, Day: Word;
 begin

  d:=date;
  DecodeDate(d,Year, Month, Day);

  temp2:=inttostr(Month);
  if (length(Temp2)<2) then
   Montt:='0'+Temp2
  else Montt:=Temp2;

  Temp5:=Montt+'\';

  FileName:=intTostr(L);
  FileName:=FileName+Montt;

  Temp2:=inttostr(L Div 1000);
  Temp5:=Temp5+Temp2+'\'+FileName;
  FileNamePath:=Temp5;
result:=0;
end;

//*----------------------------------------------*/
function TLine.CheckDateFile:integer;
var
 d:TDateTime;
 Year, Month, Day:Word;
 Year1, Month1, Day1:Word;
begin
  d:=now;
  DecodeDate(d, Year, Month, Day);


  ReadFCDate(Year1,Month1,Day1);
  if (year1=year) and (Month1=Month) then
   result:=0
  else begin
	 if ((year=year1) And (Month>=Month1)) or ((year>=year1 )and (Month<=Month1)) then
	 begin WritFCDate(Year, Month, Day); result:= 1;end
	 else result:= 0;
       end;
end;
//*----------------------------------------------*/
function TLine.GenaratNmaeRamz:integer;
var
 FileName,FileNamePath:string;
 L:longint;
 i:integer;

begin

 //--------------------
  while   MainForm.FlagLockCountVoiceRFC=True do ;
  MainForm.FlagLockCountVoiceRFC:=True;
  L:=ReadFC;
 if (CheckDateFile=1) then
   L:=0;
  if (L>99998) then
    L:=0;
  L:=L+1;
  WritFC(L);
  MainForm.FlagLockCountVoiceRFC:=False;
 //**************************************
  GenertFileName(L,FileName,FileNamePath);

   i:=random(98)+1;
   BoxLine.FileMessTemp:=strtointdef(FileName,1010);
   BoxLine.RamzMesTemp:=i;

  BoxLine.Command:=DriveBoxV+FileNamePath;
  result:= 0;
end;
//------------------------------------------------
Procedure  TLine.ReadCurentMes;
begin

   while MainForm.FlagLockMessBox do ;
   MainForm.FlagLockMessBox:=true;
   BoxLine.DataMes.FileMess:=TabelMessBox1.FieldByName('NoMess').asinteger;
   BoxLine.DataMes.RamzMes:=TabelMessBox1.FieldByName('Ramz').asinteger;
   BoxLine.DataMes.NoBoxMes:=TabelMessBox1.FieldByName('NoBox').asstring;
   BoxLine.DataMes.NoBoxSend:=TabelMessBox1.FieldByName('NoboxSend').asstring;
   BoxLine.DataMes.TypeVisibel:=TabelMessBox1.FieldByName('TypeVisibel').asinteger;
   BoxLine.DataMes.TypeFile:=TabelMessBox1.FieldByName('TypeFile').asinteger;
   BoxLine.DataMes.TypeSend:=TabelMessBox1.FieldByName('TypeSend').asinteger;
   BoxLine.DataMes.DateTimeRec:=TabelMessBox1.FieldByName('DateTimeRec').value;
   BoxLine.DataMes.NoAnsMess:=TabelMessBox1.FieldByName('NoAnsMess').asinteger;
   BoxLine.DataMes.DateTimeRecAns:=TabelMessBox1.FieldByName('DateTimeRecAns').value;
//   BoxLine.DataMes.CountRing:=TabelMessBox1.FieldByName('CountRing').value;
   BoxLine.DataMes.CodMozoe:=TabelMessBox1.FieldByName('CodMozoe').asstring;
   MainForm.FlagLockMessBox:=false;
end;
//------------------------------------------------
Procedure  TLine.writeAppendMesssagbox(BoxDAta:integer);
begin
 if BoxDAta=1 then
 begin
   while MainForm.FlagLockMessBox do ;
   MainForm.FlagLockMessBox:=true;
   TabelMessBox1.Insert;
   TabelMessBox1.FieldByName('NoMess').asinteger:=BoxLine.DataMes.FileMess;
   TabelMessBox1.FieldByName('Ramz').asinteger:=BoxLine.DataMes.RamzMes;
   TabelMessBox1.FieldByName('NoBox').asstring:=BoxLine.DataMes.NoBoxMes;
   TabelMessBox1.FieldByName('NoboxSend').asstring:=BoxLine.DataMes.NoBoxSend;
   TabelMessBox1.FieldByName('TypeVisibel').asinteger:=BoxLine.DataMes.TypeVisibel;
   TabelMessBox1.FieldByName('TypeFile').asinteger:=BoxLine.DataMes.TypeFile;
   TabelMessBox1.FieldByName('TypeSend').asinteger:=BoxLine.DataMes.TypeSend;
   TabelMessBox1.FieldByName('DateTimeRec').value:=BoxLine.DataMes.DateTimeRec;
   TabelMessBox1.FieldByName('NoAnsMess').asinteger:=BoxLine.DataMes.NoAnsMess;
   TabelMessBox1.FieldByName('DateTimeRecAns').value:=BoxLine.DataMes.DateTimeRecAns;
//   TabelMessBox1.FieldByName('CountRing').value:=BoxLine.DataMes.CountRing;
   TabelMessBox1.FieldByName('CodMozoe').asstring:=BoxLine.DataMes.CodMozoe;
   TabelMessBox1.post;
   TabelMessBox1.refresh;
   MainForm.FlagLockMessBox:=false;
end
else
 begin
   while MainForm.FlagLockMessBox do ;
   MainForm.FlagLockMessBox:=true;
   TabelMessBox2.Insert;
   TabelMessBox2.FieldByName('NoMess').asinteger:=BoxLine2.DataMes.FileMess;
   TabelMessBox2.FieldByName('Ramz').asinteger:=BoxLine2.DataMes.RamzMes;
   TabelMessBox2.FieldByName('NoBox').asstring:=BoxLine2.DataMes.NoBoxMes;
   TabelMessBox2.FieldByName('NoboxSend').asstring:=BoxLine2.DataMes.NoBoxSend;
   TabelMessBox2.FieldByName('TypeVisibel').asinteger:=BoxLine2.DataMes.TypeVisibel;
   TabelMessBox2.FieldByName('TypeFile').asinteger:=BoxLine2.DataMes.TypeFile;
   TabelMessBox2.FieldByName('TypeSend').asinteger:=BoxLine2.DataMes.TypeSend;
   TabelMessBox2.FieldByName('DateTimeRec').value:=BoxLine2.DataMes.DateTimeRec;
   TabelMessBox2.FieldByName('NoAnsMess').asinteger:=BoxLine2.DataMes.NoAnsMess;
   TabelMessBox2.FieldByName('DateTimeRecAns').value:=BoxLine2.DataMes.DateTimeRecAns;
//   TabelMessBox1.FieldByName('CountRing').value:=BoxLine2.DataMes.CountRing;
   TabelMessBox2.FieldByName('CodMozoe').asstring:=BoxLine2.DataMes.CodMozoe;
   TabelMessBox2.post;
   TabelMessBox2.refresh;
   MainForm.FlagLockMessBox:=false;
 end;
end;
//------------------------------------------------
Procedure  TLine.EditCurMesssagbox1(NoMes:longint;NoBox:string);
begin

   while MainForm.FlagLockMessBox do ;
   MainForm.FlagLockMessBox:=true;
   TabelMessBox1.Edit;
   TabelMessBox1.FieldByName('NoMess').asinteger:=BoxLine.DataMes.FileMess;
   TabelMessBox1.FieldByName('Ramz').asinteger:=BoxLine.DataMes.RamzMes;
   TabelMessBox1.FieldByName('NoBox').asstring:=BoxLine.DataMes.NoBoxMes;
   TabelMessBox1.FieldByName('NoboxSend').asstring:=BoxLine.DataMes.NoBoxSend;
   TabelMessBox1.FieldByName('TypeVisibel').asinteger:=BoxLine.DataMes.TypeVisibel;
   TabelMessBox1.FieldByName('TypeFile').asinteger:=BoxLine.DataMes.TypeFile;
   TabelMessBox1.FieldByName('TypeSend').asinteger:=BoxLine.DataMes.TypeSend;
   TabelMessBox1.FieldByName('DateTimeRec').value:=BoxLine.DataMes.DateTimeRec;
   TabelMessBox1.FieldByName('NoAnsMess').asinteger:=BoxLine.DataMes.NoAnsMess;
   TabelMessBox1.FieldByName('DateTimeRecAns').value:=BoxLine.DataMes.DateTimeRecAns;
   TabelMessBox1.FieldByName('CodMozoe').asstring:=BoxLine.DataMes.CodMozoe;
   TabelMessBox1.post;
   TabelMessBox1.refresh;
   MainForm.FlagLockMessBox:=false;
end;
//------------------------------------------------
Procedure Tline.read_InfoBox(NoBox:string;BoxData:integer);
var Flag:boolean;
    i:string;
begin

while MainForm.FlaglinfoBox do ;
MainForm.FlaglinfoBox:=true;

  if BoxData=1 then
  begin
    TabelInfoBox1.First;
    Flag:=TabelInfoBox1.FindKey([NoBox]);
    if Flag=true then
      i:='true'
    else i:='false';
    paraLog('ReadinfoBox '+ NoBox+' ' +i,'1',time,0);
    logfile;
    BoxLine.Data.NoBoxInfo:=TabelInfoBox1.FieldByName('NoBox').asString;
    BoxLine.Data.Ramz:=TabelInfoBox1.FieldByName('Ramz').asString;
    BoxLine.Data.flag_act_tel:=TabelInfoBox1.FieldByName('Flag_act_Tel').asinteger;
    BoxLine.Data.FlagRecBipMes:=TabelInfoBox1.FieldByName('FlagRecBipMes').asinteger;
    BoxLine.Data.FlagPlayNoMes:=TabelInfoBox1.FieldByName('FlagPlayNoMes').asinteger;
    BoxLine.Data.FlagRecOnly:=TabelInfoBox1.FieldByName('Flag_Rec_Only').asinteger;
  end;
  if BoxData=2 then
  begin
    TabelInfoBox2.First;
    Flag:=TabelInfoBox2.FindKey([NoBox]);
    if Flag=true then
      i:='true'
    else i:='false';
    paraLog('ReadinfoBox '+ NoBox+' ' +i,'1',time,0);
    logfile;
    BoxLine2.Data.NoBoxInfo:=TabelInfoBox2.FieldByName('NoBox').asString;
    BoxLine2.Data.Ramz:=TabelInfoBox2.FieldByName('Ramz').asstring;
    BoxLine2.Data.flag_act_tel:=TabelInfoBox2.FieldByName('Flag_act_Tel').asinteger;
    BoxLine2.Data.FlagRecBipMes:=TabelInfoBox2.FieldByName('FlagRecBipMes').asinteger;
    BoxLine2.Data.FlagPlayNoMes:=TabelInfoBox2.FieldByName('FlagPlayNoMes').asinteger;
    BoxLine2.Data.FlagRecOnly:=TabelInfoBox2.FieldByName('Flag_Rec_Only').asinteger;
  end;
MainForm.FlaglinfoBox:=false;
end;
//------------------------------------------------
Procedure Tline.Edit_InfoBox1(NoBox:string);
var Flag:boolean;
    i:string;
begin
  TabelInfoBox1.First;
  Flag:=TabelInfoBox1.FindKey([NoBox]);
  if Flag=true then
    i:='true'
  else i:='false';
  paraLog('EditinfoBox '+ NoBox+' ' +i,'1',time,0);
  logfile;
   while MainForm.FlaglinfoBox do ;
   MainForm.FlaglinfoBox:=true;
    TabelInfoBox1.edit;
    TabelInfoBox1.FieldByName('NoBox').asString:=BoxLine.NoBox;
    TabelInfoBox1.FieldByName('Ramz').asString:=BoxLine.Data.Ramz;
    TabelInfoBox1.FieldByName('Flag_act_Tel').asinteger:=BoxLine.Data.flag_act_tel;
    TabelInfoBox1.FieldByName('FlagRecBipMes').asinteger:=BoxLine.Data.FlagRecBipMes;
    TabelInfoBox1.FieldByName('FlagPlayNoMes').asinteger:=BoxLine.Data.FlagPlayNoMes;
    TabelInfoBox1.FieldByName('Flag_Rec_Only').asinteger:=BoxLine.Data.FlagRecOnly;
    TabelInfoBox1.post;
    TabelInfoBox1.refresh;
   MainForm.FlaglinfoBox:=false;
end;
//*****************************************************
function TLine.SaveErja(FileMess,RamzMes:Longint ;Type_Erja:char;SendBox,GetBox:string;SizFileMess:integer;CodMozoe:string):integer;
var
Temp1,Temp2,Temp3:string;
d:TdateTime;
TFileMess,TRamzMes:string;
Year, Month, Day: Word;
begin
d:=now;
TFileMess:=inttostr(FileMess);
TRamzMes:=inttostr(RamzMes);
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

while MainForm.FlagLockErja do ;
MainForm.FlagLockErja:=true;
TabelErja.insert;
TabelErja.FieldByName('Type_Erja').AsVariant:=Type_Erja; //1=new  2=erja   3=ans  4=delet  5=Copy  6=NotAns_New 7=SuperNew
TabelErja.FieldByName('FileMess').AsString :=TFileMess;
TabelErja.FieldByName('SizFileMess').AsString :='0';
TabelErja.FieldByName('RamzMes').AsString:=TRamzMes;
TabelErja.FieldByName('New_Send_NoBox').AsString:=SendBox;
TabelErja.FieldByName('GetNoBox').AsString:=GetBox;
TabelErja.FieldByName('DateN_S_A_d').AsString:=Temp2;
TabelErja.FieldByName('TimeN_S_A_d').AsString:=timeTostr(d);
TabelErja.post;
TabelErja.refresh;
MainForm.FlagLockErja:=false;
result:=0;
end;
//********************************************************************
function  Tline.PlayOthrSave;
var
ret:integer;
d:tdatetime;
 namfilevoic:string;
Year, Month, Day: Word;
begin
  paraLog('Play Other save ','1',time,0);
  logfile;

   d:=now;
   DecodeDate(d,Year, Month, Day);
   ftodate(Year, Month, Day);

   read_InfoBox(BoxLine.NoBox,1);

  if (GenaratNmaeRamz=0) then
  if(copyfile(BoxLine.Copy1,BoxLine.Command)=1) then
   begin
    BoxLine.DataMes.NoBoxMes:=BoxLine.NoBox;
    BoxLine.DataMes.NoBoxSend:='';
    BoxLine.DataMes.FileMess:=BoxLine.FileMessTemp;
    BoxLine.DataMes.RamzMes:=BoxLine.RamzMesTemp;
    if (BoxLine.Data.FlagRecOnly=1) then
       BoxLine.DataMes.TypeSend:=TypeMesSing //    TypeMesSing == 1  TypeMesGrop == 2 TypeCopyMes ==3
    else  BoxLine.DataMes.TypeSend:=TypeCopyMes;
    BoxLine.DataMes.TypeVisibel:=1;          //1== New Mess 2==Old Mess
    BoxLine.DataMes.Tel_mes:=0;
    BoxLine.DataMes.DateTimeRec:=d;
    BoxLine.DataMes.TypeFile:=1;           // m messag f fax
    BoxLine.DataMes.NoAnsMess:=0;
    BoxLine.DataMes.DateTimeRecAns:=0;
    BoxLine.DataMes.CodMozoe:='0';

    writeAppendMesssagbox(1);

    if (BoxLine.Data.FlagRecOnly=1) then
      SaveErja(BoxLine.DataMes.FileMess
	       ,BoxLine.DataMes.RamzMes,'1',BoxLine.NoBox,'',0,'0')
    else SaveErja(BoxLine.DataMes.FileMess
	       ,BoxLine.DataMes.RamzMes,'6',BoxLine.NoBox,'',0,'0');

   if (BoxLine.Data.FlagRecBipMes=1) then
    begin
       LineStat.State:=70;
       PlayFile('OthrS.msg',DriveVSys,1);
    end
    else begin
	   namfilevoic:='OthrS'+BoxLine.NoBox+'.msg';
           ret:=PlayFile(namfilevoic,DriveVSaz,1);
           if (ret=NOT_OK)then  PlayFile('OthrS.msg',DriveVSys,1);
	  end
  end
  else  PlayFile('NotSavMe',DriveVSys,1)
  else   PlayFile('NotSavMe',DriveVSys,1);
LineStat.State:=70;
result:=0;
end;
//*************************************************************
function TLine.PlayChckStat:integer;
begin
  if (BoxLine.Data.FlagRecOnly=1) then
     LineStat.State:=72
  else  LineStat.State:=StateGoodBy;
result:=0;
end;
//*************************************************************
function TLine.SplitDig2(str:string):integer;
var
 i,j,kk:integer;
 begin
 Buf_Dig3.countDig3:=0;
 Buf_Dig3.countDig2:=0;


 kk:=length(str)-1;

 if((kk+1)Mod 2<>0) then //
  begin
    i:=0;
    while(i<=kk) and (Buf_Dig3.countDig3< 6) do
    begin
     if(i=0) then
     begin
       j:=0;
       while (j < 3) and (i <=kk) do
        begin
         Buf_Dig3.Dig3[Buf_Dig3.countDig3][j]:=str[i+1];
         inc(i);inc(j);
        end;
       Buf_Dig3.Dig3[Buf_Dig3.countDig3][j]:=#0;
     end
     else
     begin
       j:=0;
       while (j <2) and (i <=kk) do
        begin
          Buf_Dig3.Dig3[Buf_Dig3.countDig3][j]:=str[i+1];
          Inc(i);inc(j);
        end;
       Buf_Dig3.Dig3[Buf_Dig3.countDig3][j]:=#0;
     end;
     if (i<=kk) then
      inc( Buf_Dig3.countDig3)
     else;
    end;
  end
  else
  begin
    i:=0;
    while(i<=kk) and (Buf_Dig3.countDig3< 6) do
    begin
       j:=0;
       while (j <2) and (i <=kk) do
        begin
          Buf_Dig3.Dig3[Buf_Dig3.countDig3][j]:=str[i+1];
          Inc(i);inc(j);
        end;
       Buf_Dig3.Dig3[Buf_Dig3.countDig3][j]:=#0;
     if (i<=kk) then
      inc(Buf_Dig3.countDig3)
     else;
    end
  end;
result:=0;
end;

//*----------------------------------------------*/
function Tline.PlayNo2:integer;
var  ret:integer;
begin
ret:=0;
 while( Buf_Dig3.countDig2 <=Buf_Dig3.countDig3) do
 begin
   ret:=PlayFile(string(Buf_Dig3.Dig3[Buf_Dig3.countDig2]),DriveNumber,0);
   if (ret=NOT_OK)then
    ret:=PlayFile('NotFInfo.msg',DriveVSYS,0);
   inc(Buf_Dig3.countDig2);
 end;
   result:=ret;
end;
//*----------------------------------------------*/
function Tline.PlayNoMes:integer;
begin
  paraLog('PlayNoMes ','1',time,0);
  logfile;

   PlayNo2;
   LineStat.State:=78;
   result:=0;
end;
//*----------------------------------------------*/
function Tline.PlayNoRmz:integer;
begin
  paraLog('PlayNoRmz ','1',time,0);
  logfile;

   PlayNo2;
   LineStat.State:=82;
   result:=0;
end;
//**************************************************************************
procedure Tline.trimL(var str:Digg) ;
var
 Temp:Digg;
 i,j:integer;
begin
i:=0;
while (str[i]=' ') and (str[i]<>#0) and (i < 10) do
 inc(i);
j:=0;
while  (str[i]<>#0) do
  begin
  temp[j]:=str[i];
  inc(i);inc(j);
  end;
temp[j]:=#0;
str:=temp;
end;
//*----------------------------------------------*/
function Tline.SplitDig3(str:string):integer;
var i,j:integer;
 Temp:Digg;
begin

 Buf_Dig3.countDig3:=0;

 i:=length(str);

 while(i>0) and (Buf_Dig3.countDig3< 6) do
 Begin
  j:=2;
  while (j >= 0) and ( i > 0) do
  begin
   Buf_Dig3.Dig3[Buf_Dig3.countDig3][j]:=str[i];
   dec(j);
   dec(i);
  end;
   Buf_Dig3.Dig3[Buf_Dig3.countDig3][3]:=#0;
  if (j>=0)  then
   begin
      while (j >= 0 ) do
      begin
	Buf_Dig3.Dig3[Buf_Dig3.countDig3][j]:=' ';
        dec(j);
      end;

      temp:=Buf_Dig3.Dig3[Buf_Dig3.countDig3];
      trimL(temp);
      Buf_Dig3.Dig3[Buf_Dig3.countDig3]:=temp;
   end;
    Buf_Dig3.flagDig3[Buf_Dig3.countDig3]:=0;
  if (i>0)then
     inc(Buf_Dig3.countDig3)
    else;
 end;
result:=0;
end;
//*----------------------------------------------*/
function Tline.PlayGNoMes:integer;
begin
  paraLog('GNoMes ','1',time,0);
  logfile;

  SplitDig2(inttostr(BoxLine.FileMessTemp));
  LineStat.State:=74;
  PlayFile('GNoMes.msg',DriveVSys,0);

result:=0;

end;

//*----------------------------------------------*/
function Tline.PlayNo:integer;
var temp:integer;
  pas:string;
  Stemp:string;
begin
 while( Buf_Dig3.countDig3 >=0) do
 begin
   if (Buf_Dig3.flagDig3[Buf_Dig3.countDig3]=1) then
   begin
     pas:='p'+inttostr(Buf_Dig3.countDig3);
     PlayFile(pas,DriveNumber,0);
     dec(Buf_Dig3.countDig3);
   end
   else begin
	  temp:=strtointdef(string(Buf_Dig3.Dig3[Buf_Dig3.countDig3]),1010);
	  if (temp=0) then
	  begin
           PlayFile('Null.msg',DriveVsys,0);
	   dec(Buf_Dig3.countDig3);
	  end
	  else
	  begin
	    Stemp:=inttostr(temp);
            PlayFile(Stemp,DriveNumber,0);
	    Buf_Dig3.flagDig3[Buf_Dig3.countDig3]:=1;
	  end;
	end;
  end;
result:=0;
end;
//*----------------------------------------------*/
function Tline.PlayGRamzMes:integer;
var ret:integer;
begin
  SplitDig2(inttostr(BoxLine.RamzMesTemp));
  ret:=PlaySysDrvNot('GNoRamz.msg',80,80,80);
  Result:=ret
end;
//*----------------------------------------------*/
function Tline.PlayOkGRamzMes:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('OkGRamz.msg',StateGoodBy,83,84);
  Result:=ret
end;
//*----------------------------------------------*/
function Tline.PlayBipOkGRamzMes:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',84,84,84);
  Result:=ret
end;
//*----------------------------------------------*/
function Tline.GetOkGRamzMes:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,86,86,StateGoodBy);
Result:=ret;
end;

//*----------------------------------------------*/
function Tline.ChckOkGRamzMes:integer;
begin
if(FuncIdd(StateGoodBy,82)=0)then
begin
      result:=0;
      exit;
end;
if (KeyBUF='3')then
      LineStat.State:=72
 else LineStat.State:=StateGoodBy;
 result:=0;
end;

//********************************************
//!@#
//--------------------------------------------
//
//
//********************************************
//********************************************
//!@#
//--------------------------------------------
//
//
//********************************************
//********************************************
//!@#
//--------------------------------------------
//
//
//********************************************

//********************************************
//!@#
//--------------------------------------------
//
//
//********************************************


//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/

//********************************************
//!@#
//--------------------------------------------
//              Self
//
//********************************************

function TLine.GPlaySlfNoBx:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('SlfNoBx.msg',14,102,104);
  Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipSlfNoBx:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',104,104,104);
Result:=ret
end;
//****************************************
function TLine.GetSlfNoBx:integer;
var ret:integer;
begin
ret:=GetDigit(19,VTimeOutDig,106,106,StateGoodBy);
Result:=ret;
end;
//-----------------------------------------
function TLine.ChckSlfNoBx:integer;
var
i,flag_Find:integer;
temp:longint;
NoBox:string;
begin
NoBox:=KeyBuf;

if(FuncIdd(StateMainMenu,100)=0) then
begin
      result:=0;
      exit;
end;
NoBox:=KeyBuf;
temp:=searchNoBox(NoBox);
if (temp<> -1 ) then
  begin
     flag_Find:=0;
     for i := 0 to ActiveChannels - 1 do
     begin
        if Line[i].BoxLine.NoBox=NoBox then
         if (Line[i].LineStat.State <> StartOnState)and (Line[i].LineStat.State <> 0)and
           (Line[i].LineStat.State <>StateOffHook) and (Line[i].LineStat.State <>StateonHook)then
           flag_Find:=1;
     end;

   if flag_Find=0 then
   begin
     BoxLine.NoBox:=NoBox;
     read_InfoBox(BoxLine.NoBox,1);
     LineStat.State:=108  ;
//     PlayFile(NoBox,DriveBoxGrV,1);
   end
   else
     begin
     LineStat.State:=14;
     PlayFile('NotsigCa.msg',DriveVSys,0);
     result:=0;
     exit;
   end;
  end
else
  begin
     LineStat.State:=100;
     PlayFile('BlNoBx.msg',DriveVSys,0);
   end;
result:=0;
exit;
end;
//*----------------------------------------------*/
function TLine.PlaySlfRamz:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('SlfRamz.msg',110,110,112);
  Result:=ret
end;
//*----------------------------------------------*/
function TLine.PlaySlfOkRz:integer;
begin
 result:= PlayFile('SlfOkRz.msg',DriveVSys,0);
end;
//--------------------------------------------
Function Tline.PlayBipSlfRamz:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',112,112,112);
Result:=ret
end;
//****************************************
function TLine.GetSlfRamz:integer;
var ret:integer;
begin
ret:=GetDigit(19,VTimeOutDig,114,114,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function TLine.PlayBlNoRamz:integer;
begin
 result:= PlayFile('BlNoRamz.msg',DriveVSys,0);
end;
//*----------------------------------------------*/
function TLine.ChckSlfRamz:integer;
var

 NoRamz:string;
begin
NoRamz:=KeyBuf;

if(FuncIdd(100,108)=0)then
begin
      result:=0;
      exit;
end;

if (NoRamz=BoxLine.Data.Ramz) then
begin
       LineStat.State:=120;
       PlaySlfOkRz;
end
  else
   begin
      LineStat.State:=108;
      PlayBlNoRamz;
   end;
result:=0;
end;
//********************************************
//!@#
//--------------------------------------------
//              Menu 0
//
//********************************************

//---------------------
function TLine.PlaySlfMenu0:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('SlfMenu0.msg',14,122,124);
  Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipSlfMenu0:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',124,124,124);
Result:=ret
end;
//****************************************
function TLine.GetSlfMenu0:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,126,126,StateGoodBy);
Result:=ret;
end;
//--------------------------------------------
function TLine.ChckSlfMenu0:integer;
BEGIN

if(FuncIdd(StateMainMenu,120)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;
if (KeyBuf='3') then
 begin
	LineStat.State:=150;
	PlaySlfNoMes;
 end
 //*********************
 else if (KeyBuf='4')then
 begin
      BoxLine.SupMenu:=100;
      LineStat.State:=210;
 end
//*********************
 else if (KeyBuf='5')then
 begin
      LineStat.State:=250;
      BoxLine.FlagBipRecGr_name:=3;
      PlayBipRecGrBx;
 end
//*********************
 else if (KeyBuf='6')then
 Begin
      LineStat.State:=130;
 end
//*********************
 else Begin
	LineStat.State:=120;
        PlayBlundeNo; //if doubl meseg state goodby*/
      end;
result:=0;
end;
//---------------------
function TLine.PlayBipRecGrBx:integer;
begin
  result:=PlayFile('BipRecG.msg',DriveVSys,0);
  PlayFile('Bip.msg',DriveVSys,0);
end;
//*----------------------------------------------*/
function TLine.FindCountMesInBox(NoBox:string):integer;
begin
  TabelMessBox1.First;
  TabelMessBox1.IndexName:='NoMes';
  TabelMessBox1.Filter:='NoBox='+''''+NoBox+'''' +' ' +
      'and ((TypeVisibel=''1'') or(TypeVisibel=''1'')) and typeFile= ''1'' ' ;//type 1 =new
  TabelMessBox1.Filtered:=true;
  result:=TabelMessBox1.RecordCount;
  if (result>0)then
   ReadCurentMes;
  paraLog('Count Messag in Box '+NoBox+'  '+inttostr(result),'1',time,0);
  logfile;
end;
//*----------------------------------------------*/
function TLine.PlaySlfNoMes:integer;
var ret:integer;
BEGIN
ret:=0;
  if (FindCountMesInBox(BoxLine.NoBox) < 1) then
  begin
      LineStat.State:=120;
      PlayNotMesBx;
  end
 else
 begin
  ret:=PlaySysDrvNot('SlfNoMes.msg',150,150,150);
 end;
  Result:=ret;
end;
//*----------------------------------------------*/
function TLine.PlayNotMesBx:integer;
begin
    Result:=PlayFile('NotMesBx.msg',DriveVSys,0);
END;
//*----------------------------------------------*/
function TLine.PlaySNoMes:integer;
var   Number:string;
      CountMess:integer;
Begin
    CountMess:=FindCountMesInBox(BoxLine.NoBox);
    Number:=inttostr(CountMess);
    SplitDig3(Number);
    PlayNo;
    LineStat.State:=152;
Result:=0;
end;
//*----------------------------------------------*/
function TLine.PlaySNoMes2:integer;
var ret:integer;
begin
  ret:=PlaySysDrvNot('SNoMes2.msg',156,156,156);
  Result:=ret
end;
//*----------------------------------------------*/
function TLine.PlayErrorBx:integer;
begin
    Result:=PlaySysDrvNot('Errorbx.msg',00,00,00);
end;
//*----------------------------------------------*/
function TLine.ChckPlyNextMes:integer;
 Begin
 if (not TabelMessBox1.eof)then
   Begin
      ReadCurentMes;
      if(BoxLine.Data.FlagPlayNoMes=1)then
	LineStat.State:=160
      else LineStat.State:=158;
       PlayNextMes;
   end
   else
   Begin
      LineStat.State:=120;
      PlayNotMesBx;
   end;
Result:=0;
 end;
//*----------------------------------------------*/
function TLine.PlayNextMes:integer;
begin
 Result:=PlayFile('NextMes.msg',DriveVSys,0);
end;
//*----------------------------------------------*/
function TLine.PlayMesOne:integer;
Begin
  if(BoxLine.Data.FlagPlayNoMes=1)then
     LineStat.State:=160
  else
     Begin
       LineStat.State:=158;
      end;
 PlayFile('MesOne.msg',DriveVSys,0);
 Result:=0;
end;
//*----------------------------------------------*/
function TLine.PlaySTamaMes:integer;
begin
   Result:=PlayFile('STamaMes.msg',DriveVSys,0);
end;
//*----------------------------------------------*/
function TLine.PlayToNo:integer;
begin
  SplitDig2(inttostr(BoxLine.DataMes.FileMess));
   Result:=PlaySysDrvNot('ToNo.msg',138,138,138);
end;
//*----------------------------------------------*/
function TLine.PlayNoDateTimeMes:integer;
begin
PlayNo2;
PlayToDate;
PlayDMMes;
PlayYerMes;
PlayTime;
PlayHourMes;
PlayAnd2;
PlayMinMes;
PlayMin;
LineStat.State:=160;
 Result:=0;
end;
//*----------------------------------------------*/
function TLine.PlayToDate:integer;
begin
   Result:=PlayFile('ToDate.msg',DriveVSys,0);
end;
//*----------------------------------------------*/
function TLine.PlayDMMes:integer;
VAR
 temp2,Montt:STRING;
 Year, Month, Day: Word;
Begin
 DecodeDate(BoxLine.DataMes.DateTimeRec,Year, Month, Day);
 ftodate(Year, Month, Day);
 temp2:=inttostr(Month);

   if (length(Temp2)<2) then
   Montt:='0'+Temp2
  else Montt:=Temp2;

  temp2:=inttostr(Day);

  if (length(temp2)<2) then
  Begin
   Montt:=Montt+'0'+Temp2
  end
  else Montt:=Montt+temp2;
  PlayDateDrvNot(Montt,106,106,106);
 Result:=0;
end;
//*----------------------------------------------*/
function TLine.PlayYerMes:integer;
var Year, Month, Day: Word;
 temp2:string;
Begin
 DecodeDate(BoxLine.DataMes.DateTimeRec,Year, Month, Day);
 ftodate(Year, Month, Day);
 temp2:=inttostr(Year);
 PlayDateDrvNot(temp2,106,106,106);
 Result:=0;
 end;
//*----------------------------------------------*/
function TLine.PlayTime:integer;
begin
   Result:=PlaySysDrvNot('Time.msg',106,106,106);
end;
//*----------------------------------------------*/
function TLine.PlayHourMes:integer;
var temp2:string;
 Hour, Min, Sec, MSec:Word;
Begin
 DecodeTime(BoxLine.DataMes.DateTimeRec, Hour, Min, Sec, MSec);
 temp2:=inttostr(Hour);
 PlayFile(temp2,DriveNumber,0);
 Result:=0;
end;
//*----------------------------------------------*/
function TLine.PlayAnd2:integer;
var ret:integer;
begin
  ret:=PlaySysDrvNot('And2.msg',106,106,106);
  Result:=ret
end;
//*----------------------------------------------*/
function TLine.PlayMinMes:integer;
var temp2:string;
 Hour, Min, Sec, MSec:Word;
Begin
 DecodeTime(BoxLine.DataMes.DateTimeRec, Hour, Min, Sec, MSec);
 temp2:=inttostr(Min);
 PlayFile(temp2,DriveNumber,0);
 Result:=0;
end;
//*----------------------------------------------*/
function TLine.PlayMin:integer;
var ret:integer;
begin
  ret:=PlaySysDrvNot('Min.msg',106,106,106);
  Result:=ret
end;
//*----------------------------------------------*/
function TLine.PlayRecGo:integer;
Begin
   if(BoxLine.Data.FlagPlayNoMes<>1) then
    LineStat.State:=160
  else
      LineStat.State:=158;
 PlayFile('RecGo',DriveVSys,0);      
 Result:=0;
end;

//*----------------------------------------------*/
function TLine.SplFileName(FileName:string ; var FileNamePath:string):integer;
var
 d:tdatetime;
 i:integer;
 L:integer;
 Montt,Serial,temp,Temp2,Temp5:string;
 Year, Month, Day: Word;
Begin

  temp:=FileName;
  i:=Length(temp);
  if (i>=3) then
  Begin
   Montt:=temp[i-1]+temp[i];
   setLength(temp,i-2);

   Serial:=temp;
   L:=strtointdef(Serial,1010);
  end
  else
      Begin
       d:=now;
       DecodeDate(d,Year, Month, Day);
       Temp2:=inttostr(Month);
       if (length(Temp2)<2) then
	Montt:='0'+Temp2
       else Montt:=Temp2;
       Serial:=temp;
       L:=strtointdef(Serial,1010);
      end;


  Temp5:=Montt+'\';
  Temp2:=inttostr((L div 1000));
  Temp5:=Temp5+Temp2+'\'+FileName;
  FileNamePath:=Temp5;
 Result:=0;
end;
//*----------------------------------------------*/
function TLine.PlaySMesII:integer;
var
  FileNamePath:string;
  ret:integer;
begin
  SplFileName(inttostr(BoxLine.DataMes.FileMess),FileNamePath);
  ret:=PlayFile(FileNamePath,DriveBoxV,2);
  if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if ret=NOT_OK then
 LineStat.State:=164
else
 begin
   if ret=PBEOF then
      LineStat.State:=162
   else if ret=Term_Digit then
        LineStat.State:=162
   else LineStat.State:=162;
 end;
Result:=ret;
end;
//---------------------
function TLine.ChckPlMenuAns:integer;
Begin
  if (BoxLine.DataMes.TypeSend=TypeMesSing)then
     LineStat.State:=166
  else
     LineStat.State:=174;
 Result:=0;
end;
//*----------------------------------------------*/
function TLine.DelCurentMesOfArrey(delflag:INTEGER):integer;
Begin
      if (not TabelMessBox1.eof) and (delflag=1 ) then
  	  TabelMessBox1.delete
      else if (not TabelMessBox1.eof) and (delflag=0 ) then
  	  TabelMessBox1.delete;

 Result:=0;
end;
//---------------------------
function TLine.PlayNotIfBx:integer;
Begin
   DelCurentMesOfArrey(1); //00
   PlaySysDrvNot('NotIfBx.mes',154,154,154);
   Result:=0;
end;
//********************************************
//!@#
//--------------------------------------------
//            MenuAns
//
//********************************************
//---------------------
function TLine.GPlayMenuAns:integer;
var ret:integer;
Begin
  ret:=PlaySysDrv('MenuAns.msg',168,168,170);
  Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipMenuAns:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',170,170,170);
Result:=ret
end;
//****************************************
function TLine.GetMenuAns:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,172,172,StateGoodBy);
Result:=ret;
end;

//---------------------
function TLine.ChckMenuAns:integer;
Begin
if(FuncIdd(120,166)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;
if (Keybuf='3')then
 Begin
  LineStat.State:=180;
  PlayBipRecAns;
end
//*********************
else if (Keybuf='4')then
 Begin
      LineStat.State:=160;
 end
//*********************
 else if (Keybuf='5')then
 Begin
  LineStat.State:=190;
  BoxLine.FlagBipRecGr_name:=3;
 end
//*********************
 else if (Keybuf='6')then
 Begin
      LineStat.State:=190;
      BoxLine.FlagBipRecGr_name:=4;
 end
//*********************
 else if (Keybuf='7') then
 Begin
      LineStat.State:=154;
//     saveErjaMes() //1=new  2=erja   3=ans  4=delet  5=copy 6=NewNoAns 7=SuperNew
//---------------
{ if(VFCopyDel[0]=='1' && (strcmp(BoxLine[line_number].NoBox,"2")==0 || strcmp(BoxLine[line_number].NoBox,"4")==0 || strcmp(BoxLine[line_number].NoBox,"3")==0 || strcmp(BoxLine[line_number].NoBox,"9")==0))
 Begin
      if ((temp=search("1",BoxIdx))!= -1 )
     Begin
       strcpy(BoxLine2[line_number].NoBox,"1");
	SaveErja(BoxLine[line_number].Data->ListMess[BoxLine[line_number].PointCurentMess].FileMess
	,BoxLine[line_number].Data->ListMess[BoxLine[line_number].PointCurentMess].RamzMes
	,'4',BoxLine[line_number].NoBox,"",0);
       BoxLine2[line_number].PointFile=temp;
       BoxLine2[line_number].PointCurentMess=0;
       read_data(BoxLine2[line_number].Data,sizeof(struct Data_S),BoxLine2[line_number].PointFile,BoxDat);

      if (BoxLine2[line_number].Data->CountMess< 10)
      Begin
	CopyCurentMesOfArreyto(TypeMesSing);
      end;
      else
      Begin
//	CopyCurentMesOfArreyToDelBox1(TypeMesSing);
      end;
     end;
     else ;
 end;
 else
 Begin
      if(VFCopyDel[0]=='1'&& strcmp(BoxLine[line_number].NoBox,"1")!=0 && strcmp(BoxLine[line_number].NoBox,"2")!=0 && strcmp(BoxLine[line_number].NoBox,"4")!=0 && strcmp(BoxLine[line_number].NoBox,"3")!=0 && strcmp(BoxLine[line_number].NoBox,"9")!=0)
      if ((temp=search("2",BoxIdx))!= -1 )
     Begin
       strcpy(BoxLine2[line_number].NoBox,"2");
       BoxLine2[line_number].PointFile=temp;
       BoxLine2[line_number].PointCurentMess=0;
       read_data(BoxLine2[line_number].Data,sizeof(struct Data_S),BoxLine2[line_number].PointFile,BoxDat);
      if (BoxLine2[line_number].Data->CountMess< MaxMess)
      Begin
	CopyCurentMesOfArreyto(TypeMesSing);
	SaveErja(BoxLine[line_number].Data->ListMess[BoxLine[line_number].PointCurentMess].FileMess
	 ,BoxLine[line_number].Data->ListMess[BoxLine[line_number].PointCurentMess].RamzMes
	 ,'2',BoxLine[line_number].NoBox,"2",0);
      end;
      else ;
     end;
     elseBegin
	   SaveErja(BoxLine[line_number].Data->ListMess[BoxLine[line_number].PointCurentMess].FileMess
	   ,BoxLine[line_number].Data->ListMess[BoxLine[line_number].PointCurentMess].RamzMes
	   ,'4',BoxLine[line_number].NoBox,"",0);
	 end;
 end;
 }
//---------------
      DelCurentMesOfArrey(1);
      PlayDelCuMes;
 end
//*********************
 else if (Keybuf='8')then
 Begin
      LineStat.State:=154;
      if (not TabelMessBox1.eof) then
	  TabelMessBox1.Next;
 end
//*********************
 else if (Keybuf='9') then
      LineStat.State:=158
//*********************
 else if (Keybuf='*') or (Keybuf= '0') then
   LineStat.State:=120
 else Begin
	LineStat.State:=166;
	PlayBlundeNo;
      end;
Result:=0;
end;
//*----------------------------------------------*/
function TLine.GPlaySDelMes:integer;
Begin
   Result:=PlaySysDrv('sdelmes.msg',176,176,178);
end;
//--------------------------------------------
Function Tline.PlayBipSDelMes:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',178,178,178);
Result:=ret
end;
//****************************************
function TLine.GetSDelMes:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,179,179,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function TLine.PlayDelCuMes:integer;
Begin
   Result:=PlayFile('DelCuMes.msg',DriveVSys,0);
end;
//*----------------------------------------------*/
{function TLine.ChckSDelMes:integer;
Begin
if(FuncIdd(154,174)=0)then  //backstate repstate
begin
    if (keybuf='*') or (keybuf='0') then
    if (not TabelMessBox1.eof) then
	  TabelMessBox1.Next;
      result:=0;
      exit;
end;
if (Keybuf='7') then
 Begin
   DelCurentMesOfArrey(1);
   PlayDelCuMes;
 end
 else
    Begin
      if (not TabelMessBox1.eof) then
	  TabelMessBox1.Next;
    end;
LineStat.State:=154;
Result:=0;
end;
}
function TLine.ChckSDelMes:integer;
Begin
if(FuncIdd(120,174)=0)then  //backstate repstate
begin
    if (keybuf='*') or (keybuf='0') then
    if (not TabelMessBox1.eof) then
	  TabelMessBox1.Next;
      result:=0;
      exit;
end;
if (Keybuf='7') then
 Begin
   DelCurentMesOfArrey(1);
   PlayDelCuMes;
   LineStat.State:=154;
   Result:=0;
   exit;
 end
 else if(Keybuf='8') then
    Begin
      if (not TabelMessBox1.eof) then
    	  TabelMessBox1.Next;
       LineStat.State:=154;
       Result:=0;
       exit;
    end
else if (Keybuf='0') then
 Begin
       LineStat.State:=154;
       Result:=0;
       exit;
 end
 else
    Begin
    	LineStat.State:=174;
    	PlayBlundeNo;
    end;
end;
//********************************************
//!@#
//--------------------------------------------
//            Ans Mess
//
//********************************************

//---------------------------------------
function TLine.PlayBipRecAns:integer;
begin
   Result:=PlayFile('BipRecA.msg',DriveVSys,0);
   PlayFile('Bip.msg',DriveVSys,0);
end;
//---------------------
function TLine.RecAnsMes:integer;
var
 Temp:string;
 FileNamePath:string;
Begin
 Temp:='1100tA';
 Temp:=Temp+Channel_Str+'.v';
 BoxLine.Copy1:=DriveJavab+Temp;
 SplFileName(inttostr(BoxLine.DataMes.FileMess),FileNamePath);

 BoxLine.Command:=DriveJavab+FileNamePath;

 RecFile(Temp,DriveJavab,60000*4,0);
 LineStat.State:=182;
 Result:=0;
end;
//---------------------
function TLine.GPlayAnsDlSv:integer;
begin
   Result:=PlaySysDrv('AnsDlSv.msg',184,184,186);
end;
//--------------------------------------------
Function Tline.PlayBipAnsDlSv:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',186,186,186);
Result:=ret
end;
//****************************************
function TLine.GetAnsDlSv:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,188,188,StateGoodBy);
Result:=ret;
end;
//---------------------
function TLine.ChckAnsDlSv:integer;
Begin

if (KeyBuf='') and (CountMessagLinecount<2)then
begin
   LineStat.State:=182;
   result:=0;
   exit;

end;
if (KeyBuf='') and (CountMessagLinecount>=2)then
begin
   LineStat.State:=StateGoodby;
   result:=0;
   exit;
end;

 if (Keybuf='3') then
 Begin
    PlaySaveAns;
 end
 else if (Keybuf='4')then
 Begin
   LineStat.State:=180;
   PlayBipRecAns;
 end
 else if (KeyBuf='5')then
 Begin
   LineStat.State:=182;
   PlayAnsRep;
 end
 else if (Keybuf='*') or (Keybuf= '0') then
 Begin
   LineStat.State:=154;
   TabelMessBox1.Next;
 end
 else Begin
	LineStat.State:=182;
	PlayBlundeNo;
      end;
 Result:=0;
end;
//------------------------
function TLine.AddDataToAns:integer;
var
   d:TdateTime;
   Year, Month, Day: Word;
   Hour, Min, Sec, MSec: Word;
Begin

   d:=now;
   DecodeDate(d,Year, Month, Day);
   ftodate(Year, Month, Day);
   DecodeTime(d, Hour, Min, Sec, MSec);
//     saveErjaMes() //1=new  2=erja   3=ans  4=delet  5=copy 6=NewNoAns 7=SuperNew
   SaveErja(BoxLine.DataMes.FileMess,BoxLine.DataMes.RamzMes
       ,'3',BoxLine.NoBox,'',0,BoxLine.DataMes.CodMozoe);

   BoxLine.DataMes.NoAnsMess:=BoxLine.DataMes.FileMess;;
   BoxLine.DataMes.DateTimeRecAns:=d;
//   BoxLine.DataMes.CountRing:=0;
   BoxLine.DataMes.TypeVisibel:=3;

   EditCurMesssagbox1(BoxLine.DataMes.FileMess,BoxLine.NoBox);
 Result:=0;
end;
//------------------------
function TLine.PlaySaveAns:integer;
Begin
   if(copyfile(BoxLine.Copy1,BoxLine.Command)=1) then
   if (AddDataToAns=0 )then
   Begin

      PlaySysDrvNot('SavAns.msg',14,154,154);
   end
   else PlaySysDrvNot('NotSABP.msg',14,166,166)
   else PlaySysDrvNot('NotSavAn.msg',14,166,166);
 Result:=0;
end;
//------------------------
function TLine.PlayAnsRep:integer;
var
 Temp:string;
Begin
  Temp:='1100tA'+Channel_Str+'.v';
  PlayFile(Temp,DriveJavab,0);
 Result:=0;
end;

//********************************************
//!@#
//--------------------------------------------
//            Send mes
//
//********************************************

//*----------------------------------------------*/
function TLine.GPlaySendNoBx:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('OthrNoBx.msg',166,192,194);
  Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipSendNoBx:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',194,194,194);
Result:=ret
end;
//****************************************
function TLine.GetSendNoBx:integer;
var ret:integer;
begin
ret:=GetDigit(19,VTimeOutDig,196,196,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function TLine.ChckSendNoBx:integer;
var  temp:longint;
     NoBox:string;
Begin
if(FuncIdd(166,190)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;
NoBox:=KeyBuf;
temp:=searchNoBox(NoBox);
if (temp<> -1 ) and (BoxLine.NoBox<>NoBox) then
     begin
       BoxLine2.NoBox:=NoBox;
       read_InfoBox(BoxLine2.NoBox,2);
       LineStat.State:=198 ;
       PlayFile(NoBox,DriveBoxNamV,0);
     end
    else
     Begin
      LineStat.State:=190;
      PlayBlNoBx;
     end;
 Result:=0;
end;
//---------------------
function TLine.PlayBlNoBx:integer;
begin
   Result:=PlayFile('BlNoBx.msg',DriveVSys,0);
END;
//---------------------
function TLine.GPlayOkSendMes:integer;
begin
   Result:=PlaySysDrv('OkSndMes.msg',166,200,202);
end;
//--------------------------------------------
Function Tline.PlayBipOkSendMes:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',202,202,202);
Result:=ret
end;
//****************************************
function TLine.GetOkSendMes:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,204,204,StateGoodBy);
Result:=ret;
end;
//---------------------
function TLine.ChckOkSend:integer;
Begin

if(FuncIdd(166,198)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;

if (Keybuf='3') then
 Begin
      LineStat.State:=154;
      if (BoxLine.FlagBipRecGr_name=3) then
      Begin

	if CopyCurentMesOfArreyto(TypeMesSing)=1 then
        begin
//     saveErjaMes() //1=new  2=erja   3=ans  4=delet  5=copy 6=NewNoAns 7=SuperNew
       	SaveErja(BoxLine.DataMes.FileMess,BoxLine.DataMes.RamzMes
	 ,'2',BoxLine.NoBox,BoxLine2.NoBox,0,BoxLine.DataMes.CodMozoe);
           DelCurentMesOfArrey(1);
       	   PlaySendMessOk;
   	   LineStat.State:=154;
        end
        else
        begin
              LineStat.State:=166;
              PlaySendMessNotOk;
        end
      end
      else
      Begin
//      saveErjaMes() //1=new  2=erja   3=ans  4=delet  5=copy 6=NewNoAns 7=SuperNewNoAns
	SaveErja(BoxLine.DataMes.FileMess,BoxLine.DataMes.RamzMes
	 ,'5',BoxLine.NoBox,BoxLine2.NoBox,0,BoxLine.DataMes.CodMozoe);

         if ( CopyCurentMesOfArreyto(TypeCopyMes)=1) then
          begin
            PlayCopyMesOk;
            LineStat.State:=166;
          end
         else
         begin
              LineStat.State:=166;
              PlaySendMessNotOk;
         end;
      end;
 end
//*********************
else if (Keybuf='4') then
      LineStat.State:=190
//*********************
 else if (Keybuf='*') or (Keybuf= '0') then
   LineStat.State:=166
 else Begin
	LineStat.State:=198;
	PlayBlundeNo;
      end;
 Result:=0;
end;
//------------------------------
function TLine.copyBox1ToBox2(TypeMes:integer):integer;
begin
  BoxLine2.DataMes.FileMess := BoxLine.DataMes.FileMess ;
  BoxLine2.DataMes.RamzMes  := BoxLine.DataMes.RamzMes;
  BoxLine2.DataMes.Tel_mes  := BoxLine.DataMes.Tel_mes;
  BoxLine2.DataMes.TypeSend :=TypeMes;
  BoxLine2.DataMes.NoboxMes :=BoxLine2.NoBox;
  BoxLine2.DataMes.NoboxSend :=BoxLine.DataMes.NoBoxMes;
  BoxLine2.DataMes.TypeVisibel:=BoxLine.DataMes.TypeVisibel;
  BoxLine2.DataMes.TypeFile   :=BoxLine.DataMes.TypeFile;
  BoxLine2.DataMes.DateTimeRec:=BoxLine.DataMes.DateTimeRec;
  BoxLine2.DataMes.NoAnsMess  :=BoxLine.DataMes.NoAnsMess;
  BoxLine2.DataMes.DateTimeRecAns:=BoxLine.DataMes.DateTimeRecAns;
//  BoxLine2.DataMes.CountRing  :=BoxLine.DataMes.CountRing;
  BoxLine2.DataMes.CodMozoe   :=BoxLine.DataMes.CodMozoe;
 Result:=0;
end;
//------------------------------
function TLine.findMesInBox2(NoMes:longint ;NoBox:string):Boolean;
var Flag:boolean;
    i:string;
begin
  TabelMessBox2.First;
  TabelMessBox2.IndexName:='NoMes2';
  TabelMessBox2.Filter:='';
  TabelMessBox2.Filtered:=true;
  Flag:=TabelMessBox2.FindKey([NoBox,NoMes]);
  if Flag=true then
    i:='true'
  else i:='false';
  paraLog('Read MessagBox '+ inttostr(NoMes)+' '+NoBox+'  '+i,'1',time,0);
  logfile;
  result:=Flag;
end;
//------------------------------
function TLine.CopyCurentMesOfArreyto(TypeMes:integer):integer;
Begin

  if(Not  findMesInBox2(BoxLine.DataMes.FileMess,BoxLine2.NoBox )) then
  begin
    copyBox1ToBox2(TypeMes);
    writeAppendMesssagbox(2);
    Result:=1;
    exit;
  end;
 Result:=0;
end;
//---------------------
function TLine.PlaySendMessOk:integer;
Begin
   Result:=PlayFile('Sndok.msg',DriveVSys,0);
end;
//---------------------
function TLine.PlaySendMessNotOk:integer;
Begin
   Result:=PlayFile('SndNotok.msg',DriveVSys,0);
end;
//---------------------
function TLine.PlayCopyMesOk:integer;
Begin
   Result:=PlayFile('Cpyok.msg',DriveVSys,0);
end;
//********************************************
//!@#
//--------------------------------------------
//               Cheng Ramz
//
//********************************************
function TLine.GPlayEnterRmz:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('EnterRmz.msg',120,212,214);
  Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipEnterRmz:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',214,214,214);
Result:=ret
end;
//---------------------
function TLine.GetEnterRmz1:integer;
var ret:integer;
Begin
ret:=GetDigit(19,VTimeOutDig,216,216,StateGoodBy);
Result:=ret;
end;
//***************************
function TLine.ChckPlEnRmz2:integer;
var
 NoRamz:string;
Begin
NoRamz:=KeyBuf;

if (KeyBUF='*') or (KeyBUF='0' )then
   begin
     if (BoxLine.SupMenu=100) then
	 LineStat.State:=120
      else
         LineStat.State:=510;
      result:=0;
      exit;
   end;
if (KeyBuf='') and (CountMessagLinecount<2)then
begin
   LineStat.State:=210;
   result:=0;
   exit;

end;
if (KeyBuf='') and (CountMessagLinecount>=2)then
begin
   LineStat.State:=StateGoodby;
   result:=0;
   exit;
end;

if (KeyBuf<>'') then
 begin
   LineStat.State:=218;
   BoxLine.Ramz:=NoRamz;
 end;
 Result:=0;
end;
//---------------------
function TLine.GPlayEnterRmz2:integer;
begin
   Result:=PlaySysDrv('plermz2.msg',120,220,222);
end;
//--------------------------------------------
Function Tline.PlayBipEnterRmz2:integer;
begin
 Result:=PlaySysDrv('Bip.msg',222,222,222);
end;
//---------------------
function TLine.GetEnterRmz2:integer;
var ret:integer;
Begin
ret:=GetDigit(19,VTimeOutDig,224,224,StateGoodBy);
Result:=ret;
end;
//---------------------
function TLine.ChckEnterRmz:integer;
var
NoRamz:string;
Begin
NoRamz:=KeyBuf;

if (KeyBUF='*') or (KeyBUF='0' )then
   begin
     if (BoxLine.SupMenu=100) then
	 LineStat.State:=120
      else
         LineStat.State:=510;
      result:=0;
      exit;
   end;
if (KeyBuf='') and (CountMessagLinecount<2)then
begin
   LineStat.State:=218;
   result:=0;
   exit;

end;
if (KeyBuf='') and (CountMessagLinecount>=2)then
begin
   LineStat.State:=StateGoodby;
   result:=0;
   exit;
end;
if (KeyBuf<>'') then
 begin
 if (BoxLine.Ramz=NoRamz ) then
     Begin
      if (ChengRamz=1) then
       PlayFile('chgramz.msg',DriveVSys,0)
      else  PlayFile('NotChRmz.msg',DriveVSys,0);
      if (BoxLine.SupMenu=100) then
	 LineStat.State:=120
      else
         LineStat.State:=510;
      result:=0;
      exit;
     end
     else
       Begin
          LineStat.State:=210;
          PlayFile('NotEqRz.msg',DriveVSys,0);
       end;
 end;
 Result:=0;
end;
//---------------------
function TLine.ChengRamz:integer;
Begin
   read_InfoBox(BoxLine.NoBox,1);
   BoxLine.Data.Ramz:=BoxLine.Ramz;
   edit_InfoBox1(BoxLine.NoBox);
   result:=1;
end;

//********************************************
//!@#
//--------------------------------------------
//
//
//********************************************




//********************************************
//!@#
//--------------------------------------------
//           Get ans
//
//********************************************
//*----------------------------------------------*/
function Tline.PlayTypNoMes:integer;
var ret:integer;
begin
ret:=PlaySysDrv('TypNoMes.msg',14,232,234);
Result:=ret
end;
//****************************************
function Tline.PlayBipTypNoMes:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',234,234,234);
  Result:=ret
end;
//****************************************
function TLine.GetTypNoMes:integer;
var ret:integer;
begin
ret:=GetDigit(19,VTimeOutDig,236,236,StateGoodBy);
Result:=ret;
end;
//********************************************
function Tline.ChckTypNoMes:integer;
var
temp:longint;
NoMes:string;
begin
if(FuncIdd(14,230)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;

if (KeyBUF= '*') or (KeyBUF= '0') then
   begin
   LineStat.State:=14;
   result:=0;
   exit;
   end
 else if KeyBUF<>'' then
 begin
 NoMes:=KeyBUF;
 temp:=searchAns(NoMes);
 if (temp<> -1 ) then
 begin
       LineStat.State:=238;
       ReadCurentMes;
 end
 else
   begin
      LineStat.State:=StateGoodBy;
      PlayFile('NotAns.msg',DriveVSys,0);
    end;
 end;
 Result:=0;
end;
//*----------------------------------------------*/
function Tline.PlayTypNoRamz:integer;
var ret:integer;
BEGIN
ret:=PlaySysDrv('TypNoRmz.msg',14,240,242);
Result:=ret
END;
//****************************************
function Tline.PlayBipTypNoRamz:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',242,242,242);
  Result:=ret
end;
//****************************************
function TLine.GetTypNoRamz:integer;
var ret:integer;
begin
ret:=GetDigit(19,VTimeOutDig,246,246,StateGoodBy);
Result:=ret;
end;

//*----------------------------------------------*/
function Tline.ChckTypNoRamz:integer;
var
 NoRamz:string;
 FileNamePath:string;
begin
  NoRamz:=KeyBuf;

if(FuncIdd(14,238)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;
 if (KeyBuf='*') or (KeyBuf= '0') then
 begin
   LineStat.State:=14;
   result:=0;
   exit;
 end;
 if (strtointdef(NoRamz,1010)=BoxLine.DataMes.RamzMes ) then
     begin
       SplFileName(inttostr(BoxLine.DataMes.NoAnsMess),FileNamePath);
       LineStat.State:=StateGoodBy;
       PlayFile('ggans.MSG',DriveVSys,0);
       PlayFile(FileNamePath,DriveJavab,0);
     END
  else
   BEGIN
      LineStat.State:=238;
      PlayFile('blAnsRmz.MSG',DriveVSys,0);
   END;
 Result:=0;
END;
//*********************************
function Tline.searchAns(NoMes1:string) : longint;
Var Flag:Boolean;
 NoMesInt:integer;
i:string;
begin
  TabelMessBox1.First;
  TabelMessBox1.IndexName:='NoMes';
  TabelMessBox1.Filter:='TypeVisibel =''3'''; //ans = 3
  TabelMessBox1.Filtered:=true;
  NoMesInt:=strtointdef(NoMes1,1010);
  Flag:=TabelMessBox1.FindKey([NoMesInt]);
  if Flag=true then
    i:='true'
  else i:='false';
  paraLog('searchAns  NoMes '+ NoMes1+' ' +i,'1',time,0);
  logfile;
  if Flag=true then
    result:=TabelMessBox1.RecNo
  else result:=-1;
end;

//********************************************
//!@#
//--------------------------------------------
//            Set flag Play No Mess
//
//********************************************
//*----------------------------------------------*/
function TLine.PlaySetFlgNoMes:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('SFNM.msg',120,132,134);
  Result:=ret
end;
//****************************************
function Tline.PlayBipSetFlgNoMes:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',134,134,134);
  Result:=ret
end;
//****************************************
function TLine.GetSetFlgNoMes:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,136,136,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function TLine.ChckSetFlgNoMes:integer;
Begin

if(FuncIdd(120,130)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;

if (KeyBuf='3') then
 Begin
   read_InfoBox(BoxLine.NoBox,1);
   BoxLine.Data.FlagPlayNoMes:=2;
   Edit_InfoBox1(BoxLine.NoBox);
   PlaySysDrvNot('SFNO.msg',120,120,120);
 end
 //*********************
 else if (Keybuf='4') then
 Begin
   read_InfoBox(BoxLine.NoBox,1);
   BoxLine.Data.FlagPlayNoMes:=2;
   Edit_InfoBox1(BoxLine.NoBox);
   PlaySysDrvNot('SFNf.msg',120,120,120);
 end
 else if (KeyBuf='*')or(KeyBuf= '0') then
 Begin
   LineStat.State:=120;
 end
else Begin
	LineStat.State:=130;
	PlayBlundeNo;
      end;
 Result:=0;
end;





//********************************************
//!@#
//--------------------------------------------
//            Rec Name Greting Box
//
//********************************************
//*----------------------------------------------*/
//---------------------
function TLine.RecNamGr:integer;
var
  Temp:string;
Begin
 Temp:='1100tg';
 Temp:=Temp+Channel_Str+'.v';
 RecFile(Temp,DriveBoxGrV,60000*4,0);
 LineStat.State:=252;
 Result:=0;
end;
//---------------------
function TLine.GPlayGrDlSv:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('grdlsv.msg',120,254,256);
  Result:=ret
end;
//****************************************
function Tline.PlayBipGrDlSv:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',256,256,256);
  Result:=ret
end;
//****************************************
function TLine.GetGrDlSv:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,258,258,StateGoodBy);
Result:=ret;
end;
//---------------------
function TLine.ChckGrDlSv:integer;
var
 Temp:string;
Begin

if (KeyBUF='*') or (KeyBUF='0' )then
   begin
     if (BoxLine.FlagBipRecGr_name=3) then
	 LineStat.State:=120
      else
         LineStat.State:=510;
      result:=0;
      exit;
   end;
if (KeyBuf='') and (CountMessagLinecount<2)then
begin
   LineStat.State:=252;
   result:=0;
   exit;

end;
if (KeyBuf='') and (CountMessagLinecount>=2)then
begin
   LineStat.State:=StateGoodby;
   result:=0;
   exit;
end;

if (Keybuf='5') then
 Begin
	LineStat.State:=250;
	if (BoxLine.FlagBipRecGr_name=3) then
	   PlayBipRecGrBx
	else   PlayBipRecNamBx;
 end
 //*********************
 else if (Keybuf='4') then
 Begin
      LineStat.State:=252;
      PlayRepG;
 end
//*********************
 else if (Keybuf='3') then
 Begin
      Temp:='1100tg';
      Temp:=Temp+Channel_Str+'.v';
     BoxLine.Copy1:=DriveBoxGrV+Temp;
 //--------------------
     if (BoxLine.FlagBipRecGr_name=3) then
      Begin
       BoxLine.Command:=DriveBoxGrV+BoxLine.NoBox;
      if (copyfile(BoxLine.Copy1,BoxLine.Command)=1) then
	   PlaySaveGr
	 else PlNotSave;
	 LineStat.State:=120;
      end
      else
      Begin
           LineStat.State:=510;
           BoxLine.Command:=DriveBoxNamV+BoxLine.NoBox;
	 if (copyfile(BoxLine.Copy1,BoxLine.Command)=1) then
	   PlaySaveName
	 else PlNotSave;
      end;
 end
//*********************
 else Begin
	LineStat.State:=252;
	PlayBlundeNo;
      end;
  Result:=0;
end;
//--------------------
function TLine.PlayBipRecNamBx:integer;
begin
   Result:=PlayFile('BipRecN.msg',DriveVSys,0);
   PlayFile('Bip.msg',DriveVSys,0);
end;
//*----------------------------------------------*/
function TLine.PlayRepG:integer;
var  Temp:String;
Begin

 Temp:='1100tg';
 Temp:=Temp+Channel_Str+'.v';
 PlayFile(Temp,DriveBoxGrV,1);
 Result:=0;
end;
//---------------------
function TLine.PlaySaveGr:integer;
begin
   Result:=PlayFile('SavGr.msg',DriveVSys,0);
end;
//---------------------
function TLine.PlNotSave:integer;
begin
   Result:=PlayFile('NotSavMe.msg',DriveVSys,0);
end;
//---------------------
function TLine.PlaySaveName:integer;
begin
   Result:=PlayFile('SavNam.msg',DriveVSys,0);
end;
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//---------------------
//------------------------------
function TLine.CopyCurentMesOfArreyToDelBox1(TypeMes:integer):integer;
Begin
 Result:=0;
end;

//*----------------------------------------------*/
function TLine.PlayOkBxRamz:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('OkBxRamz.msg',00,00,00);
  Result:=ret
END;
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/

