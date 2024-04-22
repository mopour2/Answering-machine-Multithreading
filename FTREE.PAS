///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
Procedure Tline.ReadCurrentNod;
var i:string;
begin
 while MainForm.FlaglinfoBox do ;
 MainForm.FlaglinfoTree:=True;
  Find_Nod_Tree:=TabelInfo.FindKey([PointCurrentNod]);
  if Find_Nod_Tree=true then
    i:='true'
  else i:='false';
  paraLog('ReadCurrentNod  '+inttostr(PointCurrentNod)+' ' +i,'1',time,0);
  logfile;
 MainForm.FlaglinfoTree:=false;
end;
//--------------------------------------------

Function Tline.PlayTreeNod:integer;
var ret:integer;
//proc:tthreadmethod;
begin

ReadCurrentNod;

//proc:=ReadCurrentNod;
// Synchronize(proc);
 if Find_Nod_Tree=true then
  begin
  if (TabelInfo.FieldByName('CountChild').asinteger=0)then
      ret:=PlayFile(TabelInfo.FieldByName('MessagFile').asstring,DriveInfo,2)
  else  ret:=PlayFile(TabelInfo.FieldByName('MessagFile').asstring,DriveInfo,1);

  if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
  else if ret=NOT_OK then
     LineStat.State:=40
  else
    begin
      if ret=PBEOF then
        LineStat.State:=34
      else if ret=Term_Digit then
        LineStat.State:=36
      else LineStat.State:=StateonHook;
    end;
    Result:=ret;
    exit;
  end
  else
   begin
     LineStat.State:=40
   end;
  result:=_Ok;;

end;

//--------------------------------------------
Function Tline.GetDigTree:integer;
var ret:integer;
begin
ret:=GetDigit(1,VTimeOutDig,48,46,StateGoodBy);
Result:=ret;
end;
//--------------------------------------------
Function Tline.PlayBipTree:integer;
var ret:integer;
begin
ret:=PlayFile('Bip.msg',DriveVSys,1);
if ret=NoChengState then
   begin
    Result:=ret;
    exit;
   end
else if ret=NOT_OK then
 LineStat.State:=44
else
 begin
   if ret=PBEOF then
    LineStat.State:=44
   else if ret=Term_Digit then
        LineStat.State:=44
   else LineStat.State:=StateonHook;
 end;
Result:=ret;
end;
//--------------------------------------------
Function Tline.CheckTreeLf:integer;
var i:integer;
begin
  paraLog('CheckTreeLf','1',time,0);
  logfile;
i:=TabelInfo.FieldByName('CountChild').asinteger;
if (i=0) then
begin
  PointCurrentNod:=TabelInfo.FieldByName('FatherSerial').asinteger;
  LineStat.State:=32;
  result:=0;
  exit;
end
else
begin
   LineStat.State:=42;
end;
result:=_Ok;
end;

//--------------------------------------------
Function Tline.CheckTreeST:integer;  //chech event star in getdigit */
begin
  paraLog('CheckTreeST','1',time,0);
  logfile;

if (PointCurrentNod<>1) then
begin
  PointCurrentNod:=TabelInfo.FieldByName('FatherSerial').asinteger;;
  LineStat.State:=32;
end
else
  begin
    PointCurrentNod:=1;
    LineStat.State:=StateMainMenu;
  end;
 result:=_Ok;
end;
//--------------------------------------------
Function Tline.CheckDTreeIdd:integer;
//var i:integer;
begin
  paraLog('CheckDTreeIdd','1',time,0);
  logfile;


if (KeyBUF='*') or (KeyBUF='0' )then
   begin
      CheckDTree;
      result:=0;
      exit;
   end;

if (KeyBuf='') and (CountMessagLinecount<2)then
begin
   LineStat.State:=32;
end
else if (KeyBuf<>'' )then
   begin
      CheckDTree;
      result:=0;
      exit;
   end
else LineStat.State:=StateGoodBy;

result:=0;
end;

//--------------------------------------------
Function Tline.CheckDTree:integer;
var i:integer;
begin
  paraLog('CheckDTree','1',time,0);
  logfile;

  if (Keybuf='*') or (Keybuf='0') then
  begin
      result:=CheckTreeST();
      exit;
  end
  else
  begin
  i:=TabelInfo.fieldByName('CountChild').asinteger;
  if (i=0)Then
    Begin
         result:=CheckTreeST;
         exit;
    end
  else
   begin
    if (length(Keybuf)>0) then
    if Keybuf[1] in [ '3','4','5','6','7','8','9','0'] then
    begin
     i:=ord(Keybuf[1])-ord('0')-3;
    if (i>=0) and (i<TabelInfo.fieldByName('CountChild').asinteger)then
    begin
      if i=0 then
       PointCurrentNod:=TabelInfo.fieldByName('Ch1').asinteger
      else if i=1 then
       PointCurrentNod:=TabelInfo.FieldByName('Ch2').asinteger
      else if i=2 then
       PointCurrentNod:=TabelInfo.FieldByName('Ch3').asinteger
      else if i=3 then
       PointCurrentNod:=TabelInfo.FieldByName('Ch4').asinteger
      else if i=4 then
       PointCurrentNod:=TabelInfo.FieldByName('Ch5').asinteger
      else if i=5 then
       PointCurrentNod:=TabelInfo.FieldByName('Ch6').asinteger
      else if i=6 then
       PointCurrentNod:=TabelInfo.FieldByName('Ch7').asinteger
      else if i=7 then
       PointCurrentNod:=TabelInfo.FieldByName('Ch8').asinteger
      else if i=8 then
       PointCurrentNod:=TabelInfo.FieldByName('Ch9').asinteger
      else  PointCurrentNod:=TabelInfo.FieldByName('Ch1').asinteger;

       LineStat.State:=32;
       result:=0;
       exit;
    end
    else  begin
	   PlayBlundeNo; //if doubl meseg state goodby*/
           LineStat.State:=32;
	   Result:=0;
           exit;
	  end;
    end
    else  begin
	   PlayBlundeNo; //if doubl meseg state goodby*/
           LineStat.State:=32;
	   Result:=0;
           exit;
	  end;

   end;
  end;
PlayBlundeNo; //if doubl meseg state goodby*/
LineStat.State:=32;
Result:=0;
exit;
end;
//--------------------------------------------
function Tline.PlDosErTr:integer;
var ret:integer;
begin
  paraLog('PlDosErTr','1',time,0);
  logfile;

 if (PointCurrentNod<>1) then
begin
  PointCurrentNod:=TabelInfo.FieldByName('FatherSerial').asinteger;
  LineStat.State:=32;
end
else
  begin
    PointCurrentNod:=1;
    LineStat.State:=14;
  end;
ret:=PlayFile('NotFInfo.msg',DriveVSYS,0);
Result:=ret;
if (ret =Not_Ok) then
   LineStat.State:=StateGoodby;
end;

///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
