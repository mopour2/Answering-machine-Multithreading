//*********Khoon****************
Function Tline.PlayECodKhoon:integer;
var ret:integer;
begin
ret:=PlaysazDrv('ECodKho.msg',14,1702,1704);
Result:=ret
end;
//--------------------------------------------
Function Tline.PlayBipECodKhoon:integer;
var ret:integer;
begin
ret:=PlaySysDrv('Bip.msg',1704,1704,1704);
Result:=ret
end;
//****************************************
function TLine.GetECodKhoon:integer;
var ret:integer;
begin
ret:=GetDigit(6,VTimeOutDig+1,1706,1706,StateGoodBy);
Result:=ret;
end;
//********************************************
function TLine.ChckECodKhoon:integer;
var
goroh,Cod,Natige:string;
yearCod,Montday:string;
GorohStr:string;
begin
  paraLog('ChckPersCodHogog','1',time,0);
  logfile;

if(FuncIdd(StateMainMenu,1700)=0) then
begin
      result:=0;
      exit;
end
else if (KeyBuf<>'' )then
   begin
     Cod:=KeyBuf ;
     if length(cod)=5 then
       cod:='0'+cod;
    if FindCod(Cod,Natige,yearCod,Montday,goroh) then
      begin
          if Natige='1' then
            begin

              if (Goroh='~a+~') or (Goroh='~A+~') then
                GorohStr:='ap.msg'
              else if (Goroh='~b+~') or (Goroh='~B+~') then
                GorohStr:='bp.msg'
              else if (Goroh='~o+~') or (Goroh='~O+~') then
                GorohStr:='op.msg'
              else if (Goroh='~O-~') or (Goroh='~o-~') then
                GorohStr:='on.msg'
              else if (Goroh='~B-~') or (Goroh='~b-~') then
                GorohStr:='bn.msg'
              else if (Goroh='~a-~') or (Goroh='~A-~') then
                GorohStr:='an.msg'
              else if (Goroh='~AB+~') or (Goroh='~ab+~') then
                GorohStr:='abp.msg'
              else if (Goroh='~ab-~') or (Goroh='~AB-~') then
                GorohStr:='abn.msg';

              PlaySazDrvNot('Grk1.msg',StateGoodBy,StateGoodBy,StateGoodBy);

               PlayDateDrvNot(MontDay,106,106,106);
               PlayDateDrvNot(YearCod,106,106,106);

               PlaySazDrvNot('Grk2.msg',StateGoodBy,StateGoodBy,StateGoodBy);
               PlaySazDrvNot(gorohstr,StateGoodBy,StateGoodBy,StateGoodBy);

               PlaySazDrvNot('Bosh.msg',StateGoodBy,StateGoodBy,StateGoodBy);
               PlaySazDrvNot('Grk3.msg',StateGoodBy,StateGoodBy,StateGoodBy);

            end
          else if Natige='3' then
             begin
                           if (Goroh='~a+~') or (Goroh='~A+~') then
                GorohStr:='ap.msg'
              else if (Goroh='~b+~') or (Goroh='~B+~') then
                GorohStr:='bp.msg'
              else if (Goroh='~o+~') or (Goroh='~O+~') then
                GorohStr:='op.msg'
              else if (Goroh='~O-~') or (Goroh='~o-~') then
                GorohStr:='on.msg'
              else if (Goroh='~B-~') or (Goroh='~b-~') then
                GorohStr:='bn.msg'
              else if (Goroh='~a-~') or (Goroh='~A-~') then
                GorohStr:='an.msg'
              else if (Goroh='~AB+~') or (Goroh='~ab+~') then
                GorohStr:='abp.msg'
              else if (Goroh='~ab-~') or (Goroh='~AB-~') then
                GorohStr:='abn.msg';

               PlaySazDrvNot('MoshGor.msg',StateGoodBy,StateGoodBy,StateGoodBy);
               PlaySazDrvNot(gorohstr,StateGoodBy,StateGoodBy,StateGoodBy);
               PlaySazDrvNot('Bosh.msg',StateGoodBy,StateGoodBy,StateGoodBy);
               PlaySazDrvNot('Moshaver.msg',StateGoodBy,StateGoodBy,StateGoodBy);
             end
            else
              begin
                 PlaySazDrvNot('NotAnsKo.msg',StateGoodBy,StateGoodBy,StateGoodBy);
              end;
             result:=0;
             exit;
      end
    else
      begin
        PlaySazDrvNot('BlCodKoo.msg',14,14,14);
        result:=0;
        exit;
      end;
   end;

end;
//******************************************
function TLine.FindCod(Cod:string;var Natige:string;var year,Montday,goroh:string):boolean;
Var Flag:Boolean;
i:string;
ii:longint;
date1:string;
begin
  paraLog('search Khoon Natige  ','1',time,0);
  logfile;
  Tabekhoon.First;
//  if TabeCod10.FindKey([TelNumber])=true then
//  if TabeHogog.Locate('id', strtointdef(Percod,1010), [loPartialKey])=true then
  if TabeKhoon.Locate('CodKhoon', cod, [loCaseInsensitive])=true then
   begin
    flag:=true;
    Natige:=TabeKhoon.FieldByName('Vazeyat').asstring;
    date1:=TabeKhoon.FieldByName('Date1').asstring;
    goroh:=TabeKhoon.FieldByName('Goroh').asstring;
    ii:=length(date1);
    if (date1<>'') and (ii >= 8) then
    begin
       MontDay:=date1[4]+date1[5]+date1[1]+date1[2];
       year:='13'+date1[7]+date1[8];
    end;

   end
  else flag:=False;

  if Flag=true then
    i:='true'
  else i:='false';


  paraLog('search  Natige'+ Natige +' ' +i,'1',time,0);
  logfile;

result:=flag;
end;



