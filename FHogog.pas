//*********Hogog****************
Function Tline.PlayEPersCodHogog:integer;
var ret:integer;
begin
ret:=PlaysysDrv('PerCod.msg',14,1502,1504);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipEPersCodHogog:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1504,1504,1504);
Result:=ret
end;
//****************************************
function TLine.GetEPersCodHogog:integer;
var ret:integer;
begin
ret:=GetDigit(10,VTimeOutDig+1,1506,1506,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckEPersCodHogog:integer;
var
PerCod,Hogog,Year1,Montt1:string;
begin
  paraLog('ChckPersCodHogog','1',time,0);
  logfile;

if(FuncIdd(StateMainMenu,1500)=0) then
begin
      result:=0;
      exit;
end
else if (KeyBuf<>'' )then
   begin
     PerCod:=KeyBuf ;
    if FindPerCod(PerCod,Hogog,Year1,Montt1) then
      begin
             PlayToDate;
             PlayDateDrvNot(Montt1,StateGoodBy,StateGoodBy,StateGoodBy);
             PlayDateDrvNot(Year1,StateGoodBy,StateGoodBy,StateGoodBy);
             SplitDig3(Hogog);
             PlaySysDrvNot('HogoYou.msg',StateGoodBy,StateGoodBy,StateGoodBy);
             PlayNo;
             PlaySysDrvNot('Rial.msg',StateGoodBy,StateGoodBy,StateGoodBy);
             LineStat.State:=StateGoodBy;
             result:=0;
             exit;
      end
    else
      begin
        PlaySysDrvNot('NotPcod.msg',14,14,14);
        result:=0;
        exit;
      end;
   end;

end;
//******************************************
function TLine.FindPerCod(PerCod:string;var Hogog,Year1,Montt1:string):boolean;
Var Flag:Boolean;
i:string;
TelNumber:longint;
begin
  paraLog('searchPer cod  '+ Percod+' ' +i,'1',time,0);
  logfile;
  //TelNumber:=strtointdef(tel,1010);
//  TabeCod10.IndexName:='TEL';
  TabeHogog.First;
//  if TabeCod10.FindKey([TelNumber])=true then
//  if TabeHogog.Locate('id', strtointdef(Percod,1010), [loPartialKey])=true then
  if TabeHogog.Locate('id', Percod, [loCaseInsensitive])=true then
   begin
    flag:=true;
    Hogog:=TabeHogog.FieldByName('Amount').asstring;
    Year1:=TabeHogog.FieldByName('Year').asstring;
    Montt1:=TabeHogog.FieldByName('MontDay').asstring;
   end
  else flag:=False;

  if Flag=true then
    i:='true'
  else i:='false';


  paraLog('searchHoggo Search'+ Hogog+' ' +i,'1',time,0);
  logfile;

result:=flag;
end;



