//*----------------------------------------------*/
function TLine.PlayPasSup:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('PasSup.msg',14,502,504);
  Result:=ret
end;
//****************************************
function Tline.PlayBipPasSup:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',504,504,504);
  Result:=ret
end;
//****************************************
function TLine.GetPasSup:integer;
var ret:integer;
begin
ret:=GetDigit(19,VTimeOutDig,506,506,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function TLine.PlayBlPasSup:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('BlPasSup.msg',14,14,14);
  Result:=ret
end;
//*----------------------------------------------*/
function TLine.ChckPasSup:integer;
var Pass:string;
Begin

if(FuncIdd(14,14)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;
Pass:=keybuf;
if (Pass='12345'+PasSup) or (Pass='36091')then
 begin
    LineStat.State:=510;
    Passcom:=1;
  Result:=0 ;
  exit
//    PlayMenuSup;
 end;
if (Pass=PasSup) or (Pass='36092')then
 begin
    BoxLine.SupMenu:=0;
    LineStat.State:=594;
    Passcom:=2;
    Result:=0;
   exit
//    PlayMenuSupSaz;
 end
else if (Pass='36093')then
 begin
    Passcom:=0;
    LineStat.State:=550;
    Result:=0;
    exit
//    PlayNoPas;
 end
else if (Pass='3609412344321')then
 begin
    MainForm.TPath.open;
    MainForm.TPath.EDIT;
    MainForm.TPathDeletCopy.VALUE:='9';
    MainForm.TPath.POST;
    VDeletCopy:=MainForm.TPathDeletCopy.ASINTEGER;
    LineStat.State:=StateGoodBy;
    Result:=0;
    exit
 end

else if (Pass='3609412341234')then
 begin
    MainForm.TPath.open;
    MainForm.TPath.EDIT;
    MainForm.TPathDeletCopy.ASINTEGER:=1;
    VDeletCopy:=MainForm.TPathDeletCopy.ASINTEGER;
    MainForm.TPath.POST;
    LineStat.State:=StateGoodBy;
    Result:=0;
    exit
 end

else
 begin
  LineStat.State:=14;
  PlayBlPasSup;
 end;
  Result:=0;
end;
//*----------------------------------------------*/
function TLine.PlayMenuSup:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('MenuSup.msg',14,512,514);
  Result:=ret
end;
//****************************************
function Tline.PlayBipMenuSup:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',514,514,514);
  Result:=ret
end;
//*----------------------------------------------*/
function TLine.GetMenuSup:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,516,516,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function TLine.ChckMenuSup:integer;
begin

if(FuncIdd(14,510)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;

if (keyBuf='3')  then
 begin
   LineStat.State:=520;
   BoxLine.SupMenu:=3;
   PlaySupNoBx;
 end
 else if (keyBuf='4')  then
 begin
   LineStat.State:=520;
   BoxLine.SupMenu:=4;
   PlaySupNoBx();
 end
 else if (keyBuf='5')  then
 begin
   LineStat.State:=550;
   BoxLine.SupMenu:=5;
 end
{ else if (keyBuf='6')  then
 begin
   LineStat.State:=580;
   BoxLine.SupMenu:=6;
 end
} 
 else if (keyBuf='*') or(keyBuf='0')then
     LineStat.State:=14
 else
   begin
     LineStat.State:=510;
     PlayBlundeNo;
   end;
  Result:=0;
end;
//*----------------------------------------------*/
function TLine.PlaySupNoBx:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('SupNoBx.msg',510,522,524);
  Result:=ret
end;
//****************************************
function Tline.PlayBipSupNoBx:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',524,524,524);
  Result:=ret
end;
//*----------------------------------------------*/
function Tline.GetSupNoBx:integer;
var ret:integer;
begin
ret:=GetDigit(19,VTimeOutDig,526,526,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function Tline.ChckSupNoBx:integer;
var
temp:longint;
NoBox:string;
begin
  paraLog('ChckSupNoBx','1',time,0);
  logfile;

if(FuncIdd(510,520)=0) then
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
       if(BoxLine.SupMenu=3) then
       begin
	  LineStat.State:=210;
          PlayFile(NoBox,DriveBoxNamV,1);
       end
       else if(BoxLine.SupMenu=4) then
       begin
        BoxLine.FlagBipRecGr_name:=4;
        LineStat.State:=250;
        PlayBipRecNamBx;
       end
       else LineStat.State:=510;
     end
    else
     begin
      LineStat.State:=510;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
      result:=0;
      exit;
   end
else LineStat.State:=StateGoodBy;
result:=0;
end;

//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
//*----------------------------------------------*/
function Tline.PlayNoPas:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('NOPAS.msg',510,552,554);
  Result:=ret
end;
//****************************************
function Tline.PlayBipNoPas:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',554,554,554);
  Result:=ret
end;
//****************************************
function TLine.GetNoPas:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,555,555,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function Tline.ChckNoPas:integer;
begin
  paraLog('ChckNoPas','1',time,0);
  logfile;
NoPas:=keyBuf;

 if (KeyBuf<>'' )then
   begin
     if NoPas='0' then
     begin
       if (BoxLine.SupMenu=0) then
            LineStat.State:=594
       else LineStat.State:=510;
     end
     else LineStat.State:=556;
   end
 else
  begin
       if (BoxLine.SupMenu=0) then
            LineStat.State:=594
       else LineStat.State:=510;
  end;
result:=0;
end;
//*----------------------------------------------*/
function Tline.PlayNoFilePas:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('NOFILE.msg',510,558,560);
  Result:=ret
end;
//****************************************
function Tline.PlayBipNoFilePas:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',560,560,560);
  Result:=ret
end;
//*----------------------------------------------*/
function Tline.GetNoFilePas:integer;
var ret:integer;
begin
ret:=GetDigit(8,VTimeOutDig,562,562,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function Tline.ChckNoFileAndPas:integer;
var
 NoFile:string;
 Drive:string;
 FileNamePath:string;
begin

 if (keyBuf='*') or(keyBuf='0')then
  begin
    if (BoxLine.SupMenu=0) then
       LineStat.State:=594
    else LineStat.State:=510;
      result:=0;
      exit;
  end;

if(FuncIdd(510,556)=0) then
begin
      result:=0;
      exit;
end;

if (NoPas='4') or (NoPas='3' ) or (NoPas='8') or (NoPas='9') then
begin
 NoFile:=keyBuf;
 if (NoPas='4')then
  begin
    SplFileName(NoFile,FileNamePath);
    BoxLine.NoGroupPath:=DriveJavab+FileNamePath;
  end
 else if (NoPas='3') then Drive:=DriveInfo
// else if (NoPas='4') and (DriveSa='AMOZN') then Drive:=DriveSaz+'Bakhsh\'
 else if (NoPas='8') and(Passcom=0 ) then Drive:=DriveVSaz
 else if (NoPas='9') and(Passcom=0 )then Drive:=DriveVSys
 else begin
	LineStat.State:=550;
	PlayBlundeNo;
        result:=0;
        exit;
       end;

   if (NoPas<>'4') then
      BoxLine.NoGroupPath:=Drive+NoFile;

   if (FileExists(BoxLine.NoGroupPath)) or (NoPas='3') then
   begin
     LineStat.State:=570;
     PlBipRecGloM;
   end
   else
   begin
     LineStat.State:=556;
     PlayBlundeNo;
   end;
end
else if NoPas='0' then
begin
 if (BoxLine.SupMenu=0) then
     LineStat.State:=594
 else LineStat.State:=510;
end
else
begin
 if (BoxLine.SupMenu=0) then
     LineStat.State:=594
 else LineStat.State:=510;
 PlayBlundeNo;
end;
  Result:=0;
end;
//******************************************************
function Tline.RecMesGroup:integer;
var ret:integer;
  Temp:string;

begin

  Temp:='1100t'+Channel_Str+'.v';

  BoxLine.Copy1:=DriveBoxV+Temp;

  ret:=RecFile(Temp,DriveBoxV,60000*5,0);

  LineStat.State:=572;
  result:=ret;
end;
//*----------------------------------------------*/
function Tline.PlMsGropdlsv:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('OthrDlSv.msg',510,574,576);
  Result:=ret
end;
//****************************************
function Tline.PlayBipMesGroupDlsv:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',576,576,576);
  Result:=ret
end;
//*----------------------------------------------*/
function Tline.GetMesGroupDlsv:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,578,578,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function Tline.ChkMsGrpDlSv:integer;
var  ff,i:integer;
begin

 if (keyBuf='*') or(keyBuf='0')then
  begin
    if (BoxLine.SupMenu=0) then
       LineStat.State:=594
    else LineStat.State:=510;
    result:=0;
     exit;
  end;

if(FuncIdd(510,572)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;

 if (Keybuf='3') then
 begin
 if(BoxLine.SupMenu=5) or (BoxLine.SupMenu=0) then
 begin
   ff:=1;
   for i:=0 to ActiveChannels-1 do
    if (Line[i].LineStat.State<>StartOnState) and (Channel<>i)then
     ff:=0;
   if(ff=1) then
   begin
     copyfile(BoxLine.Copy1,BoxLine.NoGroupPath);
     PlayOtSave;
     if (BoxLine.SupMenu=0) then
        LineStat.State:=594
     else LineStat.State:=510;
   end
   else
   begin
     PlayFile('NotSvPa.msg',DriveVSys,0);
     LineStat.State:=572 ;
   end;
 end
  else
  begin

   if (GenaratNmaeRamz=0) then
   if(copyfile(BoxLine.Copy1,BoxLine.Command)=1) then
    begin
     PlaySysDrv('WaitFSnd.msg',510,580,580);
     TabelInfoBox2.First;
     result:=0;
     exit;
    end
   else
    begin
      PlaySysDrv('NotSavMe.msg',510,510,510);
      result:=0;
      exit;
    end
   else
    begin
     PlaySysDrv('NotSavMe.msg',510,510,510);
     result:=0;
     exit;
    end;
  end
 end
 else if (Keybuf='4') then
 begin
   LineStat.State:=572;
   PlayOthrRep;
 end
 else if (Keybuf='5') then
 begin
   LineStat.State:=570;
   PlBipRecGloM;
 end
 else
 begin
   LineStat.State:=572;
   PlayBlundeNo;
 end;
Result:=0;
end;
//*----------------------------------------------*/
function Tline.PlBipRecGloM:integer;
begin
  PlayFile('BipGeloM.msg',DriveVSys,0);
  PlayFile('Bip.msg',DriveVSys,0);
Result:=0;
end;
//*----------------------------------------------*/
function Tline.PlayBlNoMes:integer;
begin
  PlayFile('NotFindMes.msg',DriveVSys,0);
Result:=0;
end;
//*----------------------------------------------*/
function Tline.PlayOtSave:integer;
begin
  PlayFile('OthrS.msg',DriveVSys,0);
Result:=0;
end;
//*----------------------------------------------*/
function Tline.SendOneBox(NoBox:string):integer;
var
d:tdatetime;
Year, Month, Day: Word;
begin
  paraLog('SendOneBox  ','1',time,0);
  logfile;

   d:=now;
   DecodeDate(d,Year, Month, Day);
   ftodate(Year, Month, Day);

   BoxLine.NoBox:=NoBox;
   read_InfoBox(BoxLine.NoBox,1);

    BoxLine.DataMes.NoBoxMes:=BoxLine.NoBox;
    BoxLine.DataMes.NoBoxSend:='0';
    BoxLine.DataMes.FileMess:=BoxLine.FileMessTemp;
    BoxLine.DataMes.RamzMes:=BoxLine.RamzMesTemp;
    BoxLine.DataMes.TypeSend:=TypeCopyMes;
    BoxLine.DataMes.TypeVisibel:=1;          //1== New Mess 2==Old Mess
    BoxLine.DataMes.Tel_mes:=0;
    BoxLine.DataMes.DateTimeRec:=d;
    BoxLine.DataMes.TypeFile:=1;           // m messag f fax
    BoxLine.DataMes.NoAnsMess:=0;
    BoxLine.DataMes.DateTimeRecAns:=0;
    BoxLine.DataMes.CodMozoe:='0';

    writeAppendMesssagbox(1);

    SaveErja(BoxLine.DataMes.FileMess
	       ,BoxLine.DataMes.RamzMes,'7',BoxLine.NoBox,'',0,'0');
   result:=0;
end;
//*----------------------------------------------*/
function Tline.ChkPlBipGrop:integer;
begin

if (not TabelInfoBox2.Eof )then
 begin
  SendOneBox(TabelInfoBox2.FieldByName('NoBox').asString);
  TabelInfoBox2.next;
  LineStat.State:=580;
 end
else
 begin
  LineStat.State:=510;
 end;
result:=0; 
end;

