function TLine.PlayTimeOut:integer;
 var ret:integer;
begin
LineStat.State:=StateonHook;
ret:=PlaySysDrv('OutTime.msg',StateonHook,StateonHook,StateonHook);
Result:=ret
end;
//********************************************
function TLine.PlayGoodby:integer;
var ret:integer;
begin
ret:=PlaySazDrvNot('GoodBy.msg',StateonHook,StateonHook,StateonHook);
Result:=ret
end;
//********************************************
function TLine.PlaySaz:integer;
var ret:integer;
NoBox:string;
temp:longint;
begin

if Vsys_State=1 then
  ret:=PlaySazDrv('Saz.msg',14,12,16)  //main menu
else if Vsys_State=2 then
  ret:=PlaySazDrv('Saz.msg',11,11,14) // key9
else if Vsys_State=3 then
  ret:=PlaySazDrv('Saz.msg',1200,1200,1204) // monshi + key9
else //if Vsys_State=4 then                   // record all line simolet Monshi Telphon
   begin
      ret:=PlaySazDrv('RecMonsh.msg',64,64,64);
      if ret <>NOT_OK then
        PlayFile('Bip.msg',DriveVSys,0)
      else PlayBxBipRec;
      NoBox:='4';
     temp:=searchNoBox(NoBox);
     if (temp<> -1 ) then
      begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
//       PlayBxBipRec;
      end;
   end;
Result:=ret
end;
//********************************************
function TLine.PlayUsedKey9:integer;
var ret:integer;
begin
ret:=PlaySazDrv('UsedK9.msg',14,22,23);
Result:=ret
end;
//********************************************
function TLine.PlayBipUsedKey9:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',23,23,23);
Result:=ret
end;
//****************************************
function TLine.GetUsedKey9:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,24,14,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.CheckUsedKey9Idd:integer;
var temp:longint;
NoBox:string;
begin
  paraLog('CheckUsedKey9','1',time,0);
  logfile;
if (KeyBUF='*') or (KeyBUF='0' )then
   begin
      LineStat.State:=StateGoodBy;
      result:=0;
      exit;
   end;

 if (KeyBuf='9')then
   begin
      LineStat.State:=14;
      result:=0;
      exit;
   end
else
 BEGIN
    if (VSysIdd=2) then
    begin
       if (VOpMod_state=2) then
	 LineStat.State:=600
     else LineStat.State:=608;
       GetActivOp;
    end
    else if (VSysIdd=3) then
     begin
     NoBox:='4';
     temp:=searchNoBox(NoBox);
     if (temp<> -1 ) then
      begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
      end
      else
      begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
     end
    else
     begin
        LineStat.State:=StateGoodBy;
     end;
 end;
result:=0;
end;
//********************************************
function TLine.PlayAyam:integer;
var ret:integer;
begin
ret:=PlaySazDrv('Ayam.msg',14,14,16);
Result:=ret
end;
//********************************************
function TLine.PlayMainMenu:integer;
var ret:integer;
begin
ret:=PlayFile('MainMenu.msg',DriveVSaz,100);
if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if ret=NOT_OK then
 LineStat.State:=StateonHook
else
 begin
   if ret=PBEOF then
    LineStat.State:=19
   else if ret=Term_Digit then
        LineStat.State:=16
   else LineStat.State:=StateonHook;
 end;
Result:=ret;
end;
//********************************************
function TLine.GetMainMenu:integer;
var ret:integer;
begin
ret:=GetDigitStar(1,VTimeOutDig,20,18,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.PlayMainMenuBip:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',16,16,16);
Result:=ret
end;
//********************************************
function TLine.CheckMainMenuIdd:integer;
var temp:longint;
NoBox:string;
begin
  paraLog('CheckMainMenuIdd','1',time,0);
  logfile;
if (KeyBUF='*') or (KeyBUF='0' )then
   begin
      CheckMainMenu;
      result:=0;
      exit;
   end;

if (KeyBuf='') and (CountMessagLinecount<VMainMenuRep)then
begin
   LineStat.State:=14;
end
else if (KeyBuf<>'' )then
   begin
      CheckMainMenu;
      result:=0;
      exit;
   end
else
 BEGIN
    if (VSysIdd=2) then
    begin
       if (VOpMod_state=2) then
	 LineStat.State:=600
     else LineStat.State:=608;
       GetActivOp;
    end
    else if (VSysIdd=3) then
     begin
     NoBox:='4';
     temp:=searchNoBox(NoBox);
     if (temp<> -1 ) then
      begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
      end
      else
      begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
     end
    else
     begin
        LineStat.State:=StateGoodBy;
     end;
 end;
result:=0;
end;
//********************************************
function TLine.PlayBlundeNo:integer;
var ret:integer;
begin
ret:=PlayFile('BlNo.msg',DriveVSys,0);
Result:=ret;
end;
//********************************************
function TLine.PlayGoran:integer;
var ret:integer;
begin

ret:=PlaySazDrv('Goran.msg',14,14,14);
Result:=ret
end;
//********************************************
//********************************************
function TLine.CheckMainMenu:integer;
begin
if DriveSa='ASTANE' then
  astane
else if DriveSa='SHAHRN' then
  SHahrN
else if DriveSa='POST' then
  pOST
else if DriveSa='AMOZN' then
  AMOZN
else if DriveSa='MO_ZIST' then
   MO_ZIST
else if DriveSa='MO_TAB' then
   MO_TAB
else if DriveSa='GANBAZ' then
  GANBAZ
else if DriveSa='TAVON' then
  TAVON
else if DriveSa='SANAT' then
  SANAT
else if DriveSa='KHOON' then
  KHOON
else SHahrN;




Result:=0;
end;
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/

//********************************************
function TLine.PlayMain2:integer;
var ret:integer;
begin
ret:=PlaySazDrv('Main2.msg',StateonHook,27,28);
Result:=ret
end;
//********************************************
function TLine.GetMain2:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,29,29,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.PlayMain2Bip:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',28,28,28);
Result:=ret
end;
//************************
function TLine.ChckMain2:integer;
var
temp:longint;
NoBox:string;
begin
NoBox:=KeyBuf;
if(FuncIdd(StateMainMenu,26)=0) then
begin
      result:=0;
      exit;
end;

if KeyBuf='3' then
  LineStat.State:=32
//*****************************
else if (KeyBuf='4')  or  (KeyBuf='5')   then
begin
    NoBox:=KeyBuf;
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
else if KeyBuf='6' then
  LineStat.State:=230     //get ans
//*****************************
else if KeyBuf='0' then
  LineStat.State:=StateGoodBy
//*****************************
else begin
       LineStat.State:=14;
       PlayBlundeNo;
     end;
result:=0;
end;
//*******************************************************
Procedure TLine.astane;
var NoBox:string;
 temp:longint;
begin
  paraLog('CheckMainMenu  ','1',time,0);
  logfile;

if KeyBuf<>'' then
 TypeRingUsed:=2;


if KeyBuf='' then
  LineStat.State:=14
//*****************************
else if KeyBuf='4' then
  LineStat.State:=26
//*****************************
else if (KeyBuf='3')  then
begin
    NoBox:='6';
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
//else if KeyBuf='7' then
//  LineStat.State:=230     //get ans
//*****************************
//else if KeyBuf='8' then
//  LineStat.State:=54      //rec no box
//*****************************
else if KeyBuf='8' then   // self box
  LineStat.State:=100
//*****************************
else if KeyBuf='5' then
  LineStat.State:=21      //goran
//*****************************
else if KeyBuf='0' then
  LineStat.State:=StateGoodBy
//*****************************
else if KeyBuf='#' then
  LineStat.State:=500      //super
//*****************************
else begin
       LineStat.State:=14;
       PlayBlundeNo;
     end;

end;
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.shahrN;
var NoBox:string;
 temp:longint;
begin
  paraLog('CheckMainMenu  ','1',time,0);
  logfile;

if KeyBuf<>'' then
 TypeRingUsed:=2;


if KeyBuf='' then
  LineStat.State:=14
//*****************************
else if KeyBuf='3' then
  LineStat.State:=32
//*****************************
else if KeyBuf='4' then
begin
    if(SelectNoBox=0) then
    begin
      NoBox:='4';
      SelectNoBox:=1;
    end
    else
    begin
      NoBox:='3';
      SelectNoBox:=0;
    end;
  //  NoBox:=KeyBuf;
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
else if KeyBuf='5' then
  LineStat.State:=230     //get ans
//*****************************
//else if KeyBuf='6' then
//  LineStat.State:=54      //rec no box
//*****************************
else if KeyBuf='6' then   // self box
  LineStat.State:=100
//*****************************
else if KeyBuf='9' then
  LineStat.State:=21      //goran
//*****************************
else if KeyBuf='0' then
  LineStat.State:=StateGoodBy
//*****************************
else if KeyBuf='#' then
  LineStat.State:=500      //super
//*****************************
else begin
       LineStat.State:=14;
       PlayBlundeNo;
     end;
end;
//********************************************
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.pOST;
var NoBox:string;
 temp:longint;
begin
  paraLog('CheckMainMenuPOST  ','1',time,0);
  logfile;

if KeyBuf<>'' then
 TypeRingUsed:=2;


if KeyBuf='' then
  LineStat.State:=14
//*****************************
else if KeyBuf='3' then
  LineStat.State:=32
//*****************************
else if KeyBuf='4' then
begin
    if(SelectNoBox=0) then
    begin
      NoBox:='4';
      SelectNoBox:=1;
    end
    else
    begin
      NoBox:='3';
      SelectNoBox:=0;
    end;
  //  NoBox:=KeyBuf;
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
else if KeyBuf='5' then
  LineStat.State:=230     //get ans
//*****************************
else if KeyBuf='6' then
  LineStat.State:=708      //pOSTyAFTE
//*****************************
else if KeyBuf='9' then   // self box
  LineStat.State:=100
//*****************************
//else if KeyBuf='9' then
//  LineStat.State:=21      //goran
//*****************************
else if KeyBuf='0' then
  LineStat.State:=StateGoodBy
//*****************************
else if KeyBuf='#' then
  LineStat.State:=500      //super
//*****************************
else begin
       LineStat.State:=14;
       PlayBlundeNo;
     end;

end;
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.AMOZN;
var NoBox:string;
 temp:longint;
begin
  paraLog('CheckMainMenuAMOZ  ','1',time,0);
  logfile;

if KeyBuf<>'' then
 TypeRingUsed:=2;


if KeyBuf='' then
  LineStat.State:=14
//*****************************
else if KeyBuf='3' then
  LineStat.State:=32
//*****************************
else if KeyBuf='5' then
begin
    if(SelectNoBox=0) then
    begin
      NoBox:='4';
      SelectNoBox:=1;
    end
    else
    begin
      NoBox:='3';
      SelectNoBox:=0;
    end;
  //  NoBox:=KeyBuf;
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
else if KeyBuf='6' then
  LineStat.State:=230     //get ans
//*****************************
else if KeyBuf='4' then
  LineStat.State:=900      //bakhsh
//*****************************
else if KeyBuf='7' then   // Day News
  LineStat.State:=920
//*****************************
else if KeyBuf='8' then   // self box
  LineStat.State:=100
//*****************************
else if KeyBuf='9' then
  LineStat.State:=21      //goran
//*****************************
else if KeyBuf='0' then
  LineStat.State:=StateGoodBy
//*****************************
else if KeyBuf='#' then
  LineStat.State:=500      //super
//*****************************
else begin
       LineStat.State:=14;
       PlayBlundeNo;
     end;

end;
//********************************************
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.MO_ZIST;
var NoBox:string;
 temp:longint;
begin
  paraLog('CheckMainMenu  ','1',time,0);
  logfile;

if KeyBuf<>'' then
 TypeRingUsed:=2;


if KeyBuf='' then
  LineStat.State:=14
//*****************************
else if KeyBuf='3' then
  LineStat.State:=32
//*****************************
else if KeyBuf='4' then
begin
    if(SelectNoBox=0) then
    begin
      NoBox:='4';
      SelectNoBox:=1;
    end
    else
    begin
      NoBox:='3';
      SelectNoBox:=0;
    end;
  //  NoBox:=KeyBuf;
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
else if KeyBuf='5' then
  LineStat.State:=230     //get ans
//*****************************
else if KeyBuf='6' then
  LineStat.State:=1400      //rec no box
//*****************************
else if KeyBuf='8' then
 begin
       if (VOpMod_state=2) then
	 LineStat.State:=600
     else LineStat.State:=608;
       GetActivOp;
 end
//*****************************
else if KeyBuf='8' then
  LineStat.State:=54      //rec no box
//*****************************
else if KeyBuf='9' then   // self box
  LineStat.State:=100
//*****************************
else if KeyBuf='9' then
  LineStat.State:=21      //goran
//*****************************
else if KeyBuf='0' then
  LineStat.State:=StateGoodBy
//*****************************
else if KeyBuf='#' then
  LineStat.State:=500      //super
//*****************************
else begin
       LineStat.State:=14;
       PlayBlundeNo;
     end;
end;
//********************************************
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.MO_Tab;
var NoBox:string;
 temp:longint;
begin
  paraLog('CheckMainMenu  ','1',time,0);
  logfile;

if KeyBuf<>'' then
 TypeRingUsed:=2;


if KeyBuf='' then
  LineStat.State:=14
//*****************************
else if (KeyBuf='3') AND (VDeletCopy<>9) then
  LineStat.State:=32
//*****************************
else if ((KeyBuf='4') or (KeyBuf='5') or (KeyBuf='6') ) AND (VDeletCopy<>9) then
begin
    NoBox:=KeyBuf;
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
else if (KeyBuf='7' ) AND (VDeletCopy<>9)then
  LineStat.State:=230     //get ans
//*****************************
else if (KeyBuf='8') AND (VDeletCopy<>9) then
  BEGIN
    PlayFile('NoAct.msg',DriveVSys,0);
    LineStat.State:=14
 END
//*****************************
else if (KeyBuf='9') AND (VDeletCopy<>9) then   // self box
  LineStat.State:=100
//*****************************
//else if KeyBuf='9' then
//  LineStat.State:=21      //goran
//*****************************
else if KeyBuf='0' then
  LineStat.State:=StateGoodBy
//*****************************
else if KeyBuf='#' then
  LineStat.State:=500      //super
//*****************************
else begin
       LineStat.State:=14;
       PlayBlundeNo;
     end;
end;
//********************************************
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.GANBAZ;
var NoBox:string;
 temp:longint;
begin
  paraLog('CheckMainMenu GANBAZ  ','1',time,0);
  logfile;

if KeyBuf<>'' then
 TypeRingUsed:=2;


if KeyBuf='' then
  LineStat.State:=14
//*****************************
else if (KeyBuf='3') AND (VDeletCopy<>9) then
  LineStat.State:=32
//*****************************
else if (KeyBuf='4') AND (VDeletCopy<>9) then
begin
    if(SelectNoBox=0) then
    begin
      NoBox:='4';
      SelectNoBox:=1;
    end
    else
    begin
      NoBox:='3';
      SelectNoBox:=0;
    end;
  //  NoBox:=KeyBuf;
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
else if (KeyBuf='5') AND (VDeletCopy<>9) then
  LineStat.State:=230     //get ans
//*****************************
else if (KeyBuf='6') AND (VDeletCopy<>9) then   // Hogog
  LineStat.State:=1500
//*****************************
else if (KeyBuf='7')AND (VDeletCopy<>9)  then   // Day News
  LineStat.State:=920
//*****************************
else if (KeyBuf='8')AND (VDeletCopy<>9)  then
  LineStat.State:=54      //rec no box
//*****************************
else if (KeyBuf='9')AND (VDeletCopy<>9)  then   // self box
  LineStat.State:=100
//*****************************
else if KeyBuf='9' then
  LineStat.State:=21      //goran
//*****************************
else if KeyBuf='0' then
  LineStat.State:=StateGoodBy
//*****************************
else if KeyBuf='#' then
  LineStat.State:=500      //super
//*****************************
else begin
       LineStat.State:=14;
       PlayBlundeNo;
     end;

end;
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.TAVON;
var NoBox:string;
 temp:longint;
begin
  paraLog('CheckMainMenu TAVON  ','1',time,0);
  logfile;

if KeyBuf<>'' then
 TypeRingUsed:=2;


if KeyBuf='' then
  LineStat.State:=14
//*****************************
else if (KeyBuf='3') AND (VDeletCopy<>9) then
  LineStat.State:=32
//*****************************
else if (KeyBuf='4') AND (VDeletCopy<>9) then
begin
    if(SelectNoBox=0) then
    begin
      NoBox:='4';
      SelectNoBox:=1;
    end
    else
    begin
      NoBox:='3';
      SelectNoBox:=0;
    end;
  //  NoBox:=KeyBuf;
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
else if (KeyBuf='5') AND (VDeletCopy<>9) then
  LineStat.State:=230     //get ans
//*****************************
else if KeyBuf='7' then
 begin
       if (VOpMod_state=2) then
	 LineStat.State:=600
     else LineStat.State:=608;
       GetActivOp;
 end
//*****************************
else if (KeyBuf='8')AND (VDeletCopy<>9)  then
  LineStat.State:=54      //rec no box
//*****************************
else if (KeyBuf='9')AND (VDeletCopy<>9)  then   // self box
  LineStat.State:=100
//*****************************
else if KeyBuf='9' then
  LineStat.State:=21      //goran
//*****************************
else if KeyBuf='0' then
  LineStat.State:=StateGoodBy
//*****************************
else if KeyBuf='#' then
  LineStat.State:=500      //super
//*****************************
else begin
       LineStat.State:=14;
       PlayBlundeNo;
     end;

end;

///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.SANAT;
var NoBox:string;
 temp:longint;
begin
  paraLog('CheckMainMenu SANAT  ','1',time,0);
  logfile;

if KeyBuf<>'' then
 TypeRingUsed:=2;


if KeyBuf='' then
  LineStat.State:=14
//*****************************
else if (KeyBuf='3') AND (VDeletCopy<>9) then
  LineStat.State:=32
//*****************************
else if (KeyBuf='4') AND (VDeletCopy<>9) then
begin
    if(SelectNoBox=0) then
    begin
      NoBox:='4';
      SelectNoBox:=1;
    end
    else
    begin
      NoBox:='3';
      SelectNoBox:=0;
    end;
  //  NoBox:=KeyBuf;
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
else if (KeyBuf='5') AND (VDeletCopy<>9) then
  LineStat.State:=230     //get ans
//*****************************
//else if KeyBuf='7' then
// begin
//       if (VOpMod_state=2) then
//	 LineStat.State:=600
//     else LineStat.State:=608;
//       GetActivOp;
// end
//*****************************
//else if (KeyBuf='8')AND (VDeletCopy<>9)  then
//  LineStat.State:=54      //rec no box
//*****************************
else if (KeyBuf='6')AND (VDeletCopy<>9)  then   // self box
  LineStat.State:=100
//*****************************
///else if KeyBuf='9' then
//  LineStat.State:=21      //goran
//*****************************
else if KeyBuf='0' then
  LineStat.State:=StateGoodBy
//*****************************
else if KeyBuf='#' then
  LineStat.State:=500      //super
//*****************************
else begin
       LineStat.State:=14;
       PlayBlundeNo;
     end;

end;
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.KHOON;
var NoBox:string;
 temp:longint;
begin
  paraLog('CheckMainMenu GANBAZ  ','1',time,0);
  logfile;

if KeyBuf<>'' then
 TypeRingUsed:=2;


if KeyBuf='' then
  LineStat.State:=14
//*****************************
else if (KeyBuf='3') AND (VDeletCopy<>9) then
  LineStat.State:=32
//*****************************
else if (KeyBuf='4') AND (VDeletCopy<>9) then
begin
    if(SelectNoBox=0) then
    begin
      NoBox:='4';
      SelectNoBox:=1;
    end
    else
    begin
      NoBox:='3';
      SelectNoBox:=0;
    end;
  //  NoBox:=KeyBuf;
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
else if (KeyBuf='5') AND (VDeletCopy<>9) then
begin
      NoBox:='5';
    temp:=searchNoBox(NoBox);
    if (temp<> -1 ) then
     begin
       BoxLine.NoBox:=NoBox;
       read_InfoBox(BoxLine.NoBox,1);
       BoxLine.PointFile:=temp;
       BoxLine.PointCurentMess:=0;
       LineStat.State:=64  ;
       PlayFile(NoBox,DriveBoxGrV,1);
       PlayBxBipRec;
     end
    else
     begin
      LineStat.State:=14;
      PlayFile('BlNoBx.msg',DriveVSys,0);
      end;
end
//*****************************
else if (KeyBuf='6') AND (VDeletCopy<>9) then
  LineStat.State:=230     //get ans
//*****************************
else if (KeyBuf='7') AND (VDeletCopy<>9) then   // Hogog
  LineStat.State:=1700
//*****************************
else if (KeyBuf='8')AND (VDeletCopy<>9)  then   // Day News
  LineStat.State:=920
//*****************************
//else if (KeyBuf='8')AND (VDeletCopy<>9)  then
//  LineStat.State:=54      //rec no box
//*****************************
else if (KeyBuf='9')AND (VDeletCopy<>9)  then   // self box
  LineStat.State:=100
//*****************************
//else if KeyBuf='9' then
//  LineStat.State:=21      //goran
//*****************************
else if KeyBuf='0' then
  LineStat.State:=StateGoodBy
//*****************************
else if KeyBuf='#' then
  LineStat.State:=500      //super
//*****************************
else begin
       LineStat.State:=14;
       PlayBlundeNo;
     end;

end;

