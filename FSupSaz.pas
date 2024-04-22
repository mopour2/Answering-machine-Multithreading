//*----------------------------------------------*/
function TLine.PlayMenuSupSaz:integer;
var ret:integer;
begin
  ret:=PlaySazDrv('MenSupS2.msg',14,595,596);
  if ret=NOT_OK then
    ret:=PlaySysDrv('MenSupS2.msg',14,595,596);
  Result:=ret
end;
//****************************************
function Tline.PlayBipMenuSupSaz:integer;
var ret:integer;
begin
  ret:=PlaySysDrv('Bip.msg',596,596,596);
  Result:=ret
end;
//*----------------------------------------------*/
function TLine.GetMenuSupSaz:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,597,597,StateGoodBy);
Result:=ret;
end;
//*----------------------------------------------*/
function TLine.ChckMenuSupSaz:integer;
begin

if(FuncIdd(14,594)=0)then  //backstate repstate
begin
      result:=0;
      exit;
end;

BoxLine.SupMenu:=0;
Passcom:=1;

if DriveSa='ASTANE' then
 MenSupS2Chek
else if DriveSa='SHAHRN' then
 MenSupS2Chek
else if DriveSa='POST' then
 MenSupS2Chek
else if DriveSa='AMOZN' then
  SupAMOZN
else if DriveSa='GANBAZ' then
 MenuSupSaz3
else   MenSupS2Chek;
  Result:=0;
end;
//*----------------------------------------------*/
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.SupAMOZN;
begin
  paraLog('Check  SupAMOZN  ','1',time,0);
  logfile;

 if KeyBuf='3' then
  LineStat.State:=550
//*****************************
else if KeyBuf='4' then
  LineStat.State:=930
//*****************************
  else if KeyBuf='5' then
  BEGIN
  BoxLine.NoGroupPath:=DriveSaz+'11111.';
  PlBipRecGloM;
  LineStat.State:=570
  END
//*****************************
else if KeyBuf='0' then
  LineStat.State:=14
else begin
       LineStat.State:=594;
       PlayBlundeNo;
     end;
end;
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.MenSupS2Chek;
begin
  paraLog('Check  MenSupS2  ','1',time,0);
  logfile;

 if KeyBuf='3' then
  LineStat.State:=550
//*****************************
else if KeyBuf='0' then
  LineStat.State:=14
else begin
       LineStat.State:=594;
       PlayBlundeNo;
     end;
end;
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure TLine.MenuSupSaz3;
begin
  paraLog('Check  SupAMOZN  ','1',time,0);
  logfile;

 if KeyBuf='3' then
  LineStat.State:=550
//*****************************
  else if KeyBuf='4' then
  BEGIN
  BoxLine.NoGroupPath:=DriveSaz+'11111.';
  PlBipRecGloM;
  LineStat.State:=570
  END
//*****************************
else if KeyBuf='0' then
  LineStat.State:=14
else begin
       LineStat.State:=594;
       PlayBlundeNo;
     end;
end;

