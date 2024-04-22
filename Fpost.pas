 //*********Cod 10 ragam****************
{Function Tline.PlayEPlakCod10_post:integer;
var ret:integer;
begin
ret:=PlaySazDrv('PlkCod10.msg',14,702,704);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipEPlakCod10_post:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',704,704,704);
Result:=ret
end;
//****************************************
function TLine.GetEPlakCod10_post:integer;
var ret:integer;
begin
ret:=GetDigit(3,VTimeOutDig,706,706,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckEPlakCod10_post:integer;
//var
//    Tel,cod10:string;
begin
  paraLog('ChckETelCod10_post','1',time,0);
  logfile;

if(FuncIdd(StateMainMenu,700)=0) then
begin
      result:=0;
      exit;
end
else if (KeyBuf<>'' )then
   begin
     BoxLine.NoGroup:=KeyBuf ; //PLAK pOST yaFTE
     LineStat.State:=708;
     result:=0;
     exit;
   end
else LineStat.State:=14;
result:=0;
end;
}
//*********Cod 10 ragam****************
Function Tline.PlayETelCod10_post:integer;
var ret:integer;
begin
ret:=PlaySazDrv('telCod10.msg',14,710,712);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipETelCod10_post:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',712,712,712);
Result:=ret
end;
//****************************************
function TLine.GetETelCod10_post:integer;
var ret:integer;
begin
ret:=GetDigit(7,VTimeOutDig,714,714,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckETelCod10_post:integer;
var
    {FileDbf,}Tel,cod10,PishCodStr:string;
    PishCod,Scod,ECOd:integer;
begin
  paraLog('ChckETelCod10_post','1',time,0);
  logfile;

if(FuncIdd(StateMainMenu,708)=0) then
begin
      result:=0;
      exit;
end
else if (KeyBuf<>'' )then
   begin
     tel:=KeyBuf ;
    if FindCod10(Tel,cod10,PishCodStr,PishCod,Scod,ECOd) then
      begin
//       if FileExists(DriveDb+'cod10\'+PishCodStr+'.dbf') then
//         begin
//           FileDbf:=PishCodStr+'.dbf';
//          if FindCod10InPish(FileDbf,Tel,PishCod,Scod,ECOd)  then
//           begin
             SplitDig2(Cod10);
             PlaySazDrvNot('Cod10you.msg',StateGoodBy,StateGoodBy,StateGoodBy);
             PlayNo2;
             LineStat.State:=StateGoodBy;
             result:=0;
             exit;
//           end
//          else
//            begin
//            end;
//         end
//       else
//         begin
//         end;
      end
    else
      begin
      end;
   end;

   PlaySazDrvNot('NotFC10.msg',600,602,602);
    if (VOpMod_state=2) then
       LineStat.State:=602
     else LineStat.State:=610;
       GetActivOp;
   result:=0;
   exit;
end;
//******************************************
{function TLine.FindCod10InPish(FIleDbf,tel:string;PishCod,Scod,ECOd:integer):boolean;
Var Flag:Boolean;
Plak,i:string;
begin
  TabePishCod10.tablename:=FIleDbf;
  TabePishCod10.open;
  TabePishCod10.First;
  Plak:=BoxLine.NoGroup;
  if TabePishCod10.Locate('A10;A18;A19;A20',VarArrayOf([Plak,ECOd,Scod,PishCod]) , [loPartialKey])=true then
   begin
    flag:=true;
   end
  else flag:=False;

  if Flag=true then
    i:='true'
  else i:='false';
  paraLog('searchPish For Cod10 '+ Plak+' ' +i,'1',time,0);
  logfile;
TabePishCod10.close;  
result:=flag;
0end;
}
//******************************************
function TLine.FindCod10(tel:string;var Cod10,PishCodStr:string;var PishCod,Scod,ECOd:integer):boolean;
Var Flag:Boolean;
i:string;
TelNumber:longint;
begin
  paraLog('searchTel For Cod10 Start '+ Tel+' ' +i,'1',time,0);
  logfile;
  TelNumber:=strtointdef(tel,1010);
  TabeCod10.IndexName:='TEL';
  TabeCod10.First;
  if TabeCod10.FindKey([TelNumber])=true then
//  if TabeCod10.Locate('TEL', strtointdef(tel,1010), [loPartialKey])=true then
   begin
    flag:=true;
    PishCodStr:=TabeCod10.FieldByName('A20').asstring;
    PishCod:=TabeCod10.FieldByName('A20').asinteger;
    Scod:=TabeCod10.FieldByName('A19').asinteger;
    ECOd:=TabeCod10.FieldByName('A18').asinteger;
    cod10:=inttostr(TabeCod10.FieldByName('A20').asinteger);
    cod10:=cod10+inttostr(TabeCod10.FieldByName('A19').asinteger);
    cod10:=cod10+inttostr(TabeCod10.FieldByName('A18').asinteger);
   end
  else flag:=False;

  if Flag=true then
    i:='true'
  else i:='false';


  paraLog('searchTel For Cod10 End Search'+ Tel+' ' +i,'1',time,0);
  logfile;

result:=flag;
end;

//======================================

//********* Car  ****************



//======================================
//********* PostYfte  ****************


//======================================

//********* T&T  ****************

//======================================


