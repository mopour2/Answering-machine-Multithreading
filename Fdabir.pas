//---------------------------------------------------------------------
Function Tline.playDabirDrv(FileName:string):integer;
begin
   PlayFile(FileName,DriveVsys,1);
   Result:=0;
end;
//*----------------------------------------------*/
Function Tline.playDabirDrvNot(FileName:string):integer;
begin
   PlayFile(FileName,DriveVsys,0);
   Result:=0
end;
//*----------------------------------------------*/
Function Tline.PlayDabGNo:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('dadgno.msg',1401,1401,1402);
  result:=ret;
end;
//********************************************
function TLine.PlayDabirBip:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1402,1402,1402);
Result:=ret
end;
//****************************************
function TLine.GetDabGNo:integer;
var ret:integer;
begin
ret:=GetDigit(9,VTimeOutDig,1404,1404,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
Function Tline.searchDabir(No:string):integer;
var flag:boolean;
i:string;
begin
while MainForm.FlagLockTabeDabir do ;
 MainForm.FlagLockTabeDabir:=True;
 TabelDabir.Open;
 Flag:=TabelDabir.FindKey([No]);
  if Flag=true then
    i:='true'
  else i:='false';
  paraLog('searchNoDabir '+i,'1',time,0);
  logfile;

  if Flag=true then
  begin
    DataDabir.no_vared:=TabelDabir.FieldByName('no_vared').asstring;
    DataDabir.cod_erja:=TabelDabir.FieldByName('cod_erja').asstring;
    DataDabir.y_erja:=TabelDabir.FieldByName('y_erja').asstring;
    DataDabir.d_erja:=TabelDabir.FieldByName('d_erja').asstring;
    DataDabir.m_erja:=TabelDabir.FieldByName('m_erja').asstring;
    DataDabir.no_sader:=TabelDabir.FieldByName('no_sader').asstring;
    DataDabir.y_sader:=TabelDabir.FieldByName('y_sader').asstring;
    DataDabir.m_sader:=TabelDabir.FieldByName('m_sader').asstring;
    DataDabir.d_sader:=TabelDabir.FieldByName('d_sader').asstring;
    DataDabir.cod_sader:=TabelDabir.FieldByName('cod_sader').asstring;
    result:=TabelInfoBox1.RecNo
  end
  else result:=-1;
TabelDabir.Close;
MainForm.FlagLockTabeDabir:=false;
end;
//*----------------------------------------------*/
Function Tline.ChckDabNo:integer;
var  i:integer;
 temp:longint ;
 No:string;
begin

No:=KeyBuf;

  paraLog('ChckDabir','1',time,0);
  logfile;

if(FuncIdd(StateMainMenu,1400)=0) then
begin
      result:=0;
      exit;
end
else if (KeyBuf<>'' )then
   begin
    temp:=searchDabir(No);
    if (temp<> -1 ) then
     begin
       if (DataDabir.no_sader='0') or (DataDabir.no_sader=NULL) then
	begin
	  PlayEndErja;
      	  LineStat.State:=1406;
	end
       else
       begin
	   SplitDig3(DataDabir.no_sader);
           LineStat.State:=1418;
       end
     end
   else
     begin
       PlayBlNoName;
       LineStat.State:=14;
     end;
      result:=0;
      exit;
   end
else LineStat.State:=StateGoodBy;
result:=0;
end;
//*----------------------------------------------*/
Function Tline.PlayEndErja:integer;
begin
  result:=playDabirDrvNot('enderja.msg');
  LineStat.State:=1406;
end;
//*----------------------------------------------*/
Function Tline.PlayBlNoName:integer;
begin
  result:=playDabirDrvNot('blnoname.msg');
  LineStat.State:=14;
end;
//*----------------------------------------------*/
Function Tline.PlayDMErja:integer;
var  temp2,Montt:string;
begin

  temp2:=DataDabir.m_erja;
  if (length(Temp2)<2) then
   Montt:='0'+Temp2
  else Montt:=Temp2;

  temp2:= DataDabir.d_erja;

  if (length(temp2)<2) then
  Begin
   Montt:=Montt+'0'+Temp2
  end
  else Montt:=Montt+temp2;
  PlayDateDrvNot(Montt,1408,1408,1408);
 Result:=0;
end;
//*----------------------------------------------*/
Function Tline.PlayYErja:integer;
var  temp:string;
begin
  temp:=DataDabir.y_erja;
  PlayDateDrvNot(temp,1410,1410,1410);
  Result:=0;
end;
//*----------------------------------------------*/
Function Tline.PlayToVah:integer;
begin
  playDabirDrvNot('toVah.msg');
  LineStat.State:=1412;
  Result:=0;
end;
//*----------------------------------------------*/
Function Tline.PlayCodErja:integer;
var   temp:string;
ret:integer;
begin

  temp:=DataDabir.cod_erja+'.msg';
   ret:=PlayFile(temp,DriveDabirCV+'coderja\',0);
   if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if ret=NOT_OK then
 LineStat.State:=1416
else
 begin
   if ret=PBEOF then
    LineStat.State:=1414
   else if ret=Term_Digit then
        LineStat.State:=1414
   else LineStat.State:=StateonHook;
 end;
Result:=ret;
end;
//*----------------------------------------------*/
Function Tline.PlayErja:integer;
begin
  result:=playDabirDrvNot('Erja.msg');
  LineStat.State:=14;
end;
//*----------------------------------------------*/
Function Tline.PlayVahed:integer;
begin
  playDabirDrvNot('Vahed.msg');
  LineStat.State:=1414;
   Result:=0;
end;
//*----------------------------------------------*/
//*----------------------------------------------*/
Function Tline.PlayAns:integer;
begin
  playDabirDrvNot('ans.msg');
  PlayNo;
  LineStat.State:=1420;
  Result:=0;
end;
//********************************************
Function Tline.PlayMovar:integer;
begin
  playDabirDrvNot('Movar.msg');
  LineStat.State:=1422;
   Result:=0;
end;
//*----------------------------------------------*/
Function Tline.PlayDMSader:integer;
var temp2,Montt:string;
begin
  temp2:=DataDabir.m_sader;
  if (length(Temp2)<2) then
   Montt:='0'+Temp2
  else Montt:=Temp2;

  temp2:= DataDabir.d_sader;

  if (length(temp2)<2) then
  Begin
   Montt:=Montt+'0'+Temp2
  end
  else Montt:=Montt+temp2;
  PlayDateDrvNot(Montt,1424,1424,1424);
 Result:=0;
end;
//*----------------------------------------------*/
Function Tline.PlayYSader:integer;
var  temp:string;
begin
  temp:=DataDabir.y_sader;
  PlayDateDrvNot(temp,1426,1426,1426);
  Result:=0;
end;
//*----------------------------------------------*/
Function Tline.PlayTo:integer;
begin
   playDabirDrvNot('to.msg');
   LineStat.State:=1428;
   Result:=0;
end;
//*----------------------------------------------*/
Function Tline.PlayCodSader:integer;
var  temp:string;
ret :integer;
begin
  temp:=DataDabir.cod_sader+'.msg';
   ret:=PlayFile(temp, DriveDabirCV+'codsader\',0);
      if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if ret=NOT_OK then
 LineStat.State:=1432
else
 begin
   if ret=PBEOF then
    LineStat.State:=1430
   else if ret=Term_Digit then
        LineStat.State:=1430
   else LineStat.State:=StateonHook;
 end;
Result:=ret;
end;
//*----------------------------------------------*/
Function Tline.PlayErsal:integer;
begin
  playDabirDrvNot('Ersal.msg');
  LineStat.State:=14;
  Result:=0;
end;
//*----------------------------------------------*/
Function Tline.PlaySazDab:integer;
begin
  playDabirDrvNot('saz.msg');
  LineStat.State:=1430;
  Result:=0;
end;
///*----------------------------------------------*/
