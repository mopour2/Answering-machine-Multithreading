constructor TLine.Build ( Number : integer ) ;
begin
  inherited create ( Number ) ;
//  Priority :=tpTimeCritical; { set the priority to  lower than normal }
//  Priority :=tpHighest; { set the priority to  lower than normal }
   Priority :=tpHigheR; { set the priority to  lower than normal }
//    Priority :=tpNormal; { set the priority to  lower than normal }

  machine[0]:= Startup;
  machine[1]:= FWaitForRing;
  machine[2]:= FOffHook;
  machine[3]:= FOnHook;
  machine[4]:= PlayTimeOut;
  machine[5]:= PlayGoodBy;
//*******************************
  machine[10]:= PlaySaz;
  machine[11]:= PlayUsedKey9;
  machine[12]:= PlayAyam;
  machine[14]:= PlayMainMenu;
  machine[16]:= GetMainMenu;
  machine[18]:= CheckMainMenu;
  machine[19]:= PlayMainMenuBip;
  machine[20]:= CheckMainMenuIdd;

  machine[22]:= PlayBipUsedKey9;
  machine[23]:= GetUsedKey9;
  machine[24]:= CheckUsedKey9Idd;

  machine[26]:= PlayMain2;
  machine[27]:= PlayMain2Bip;
  machine[28]:= GetMain2;
  machine[29]:= ChckMain2;

//*******************************
  machine[21]:= PlayGoran;
//*******************************
  machine[32]:= PlayTreeNod;
  machine[34]:= CheckTreeLf;
  machine[36]:= GetDigTree;
  machine[40]:= PlDosErTr;
  machine[42]:= PlayBipTree;
  machine[44]:= GetDigTree;
  machine[46]:= CheckDTree;
  machine[48]:= CheckDTreeIdd;
//*******************************
//other box
//*******************************
  machine[54]:=PlayOtherNoBox;
  machine[56]:=PlayBipOtherNoBox;
  machine[58]:=GetOtherNoBox;
  machine[60]:=ChckOthrNoBx;
  machine[62]:=PlayBxBipRec;
  machine[64]:=RecMesBx;
  machine[66]:=PlayOthrSave;
  machine[70]:=PlayChckStat;
  machine[72]:=PlayGNoMes;
  machine[74]:=PlayNoMes;
  machine[78]:=PlayGRamzMes;
  machine[80]:=PlayNoRmz;
  machine[82]:=PlayOkGRamzMes;
  machine[83]:=PlayBipOkGRamzMes;
  machine[84]:=GetOkGRamzMes;
  machine[86]:=ChckOkGRamzMes;
//*******************************
//Self box
//*******************************
  machine[100]:=GPlaySlfNoBx;
  machine[102]:=PlayBipSlfNoBx;
  machine[104]:=GetSlfNoBx;
  machine[106]:=ChckSlfNoBx;
  machine[108]:=PlaySlfRamz;
  machine[110]:=PlayBipSlfRamz;
  machine[112]:=GetSlfRamz;
  machine[114]:=ChckSlfRamz;

  machine[120]:=PlaySlfMenu0;
  machine[122]:=PlayBipSlfMenu0;
  machine[124]:=GetSlfMenu0;
  machine[126]:=ChckSlfMenu0;

  machine[130]:=PlaySetFlgNoMes;
  machine[132]:=PlayBipSetFlgNoMes;
  machine[134]:=GetSetFlgNoMes;
  machine[136]:=ChckSetFlgNoMes;

  machine[138]:=PlayNoDateTimeMes;

  machine[150]:=PlaySNoMes;
  machine[152]:=PlaySNoMes2;
  machine[154]:=ChckPlyNextMes;
  machine[156]:=PlayMesOne;
  machine[158]:=PlayToNo;

  machine[160]:=PlaySMesII;
  machine[162]:=ChckPlMenuAns;
  machine[164]:=PlayNotIfBx;
  machine[166]:=GPlayMenuAns;
  machine[168]:=PlayBipMenuAns;
  machine[170]:=GetMenuAns;
  machine[172]:=ChckMenuAns;

  machine[174]:=GPlaySDelMes;
  machine[176]:=PlayBipSDelMes;
  machine[178]:=GetSDelMes;
  machine[179]:=ChckSDelMes;

  machine[180]:=RecAnsMes;
  machine[182]:=GPlayAnsDlSv;
  machine[184]:=PlayBipAnsDlSv;
  machine[186]:=GetAnsDlSv;
  machine[188]:=ChckAnsDlSv;

  machine[190]:=GPlaySendNoBx;
  machine[192]:=PlayBipSendNoBx;
  machine[194]:=GetSendNoBx;
  machine[196]:=ChckSendNoBx;
  machine[198]:=GPlayOkSendMes;
  machine[200]:=PlayBipOkSendMes;
  machine[202]:=GetOkSendMes;
  machine[204]:=ChckOkSend;

  machine[210]:=GPlayEnterRmz;
  machine[212]:=PlayBipEnterRmz;
  machine[214]:=GetEnterRmz1;
  machine[216]:=ChckPlEnRmz2;
  machine[218]:=GPlayEnterRmz2;
  machine[220]:=PlayBipEnterRmz2;
  machine[222]:=GetEnterRmz2;
  machine[224]:=ChckEnterRmz;

  machine[230]:=PlayTypNoMes;
  machine[232]:=PlayBipTypNoMes;
  machine[234]:=GetTypNoMes;
  machine[236]:=ChckTypNoMes;
  machine[238]:=PlayTypNoRamz;
  machine[240]:=PlayBipTypNoRamz;
  machine[242]:=GetTypNoRamz;
  machine[246]:=ChckTypNoRamz;

  machine[250]:=RecNamGr;
  machine[252]:=GPlayGrDlSv;
  machine[254]:=PlayBipGrDlSv;
  machine[256]:=GetGrDlSv;
  machine[258]:=ChckGrDlSv;
//***********SUPERVISOR******************GetPAssWord
  machine[500]:=PlayPasSup;
  machine[502]:=PlayBipPasSup;
  machine[504]:=GetPasSup;
  machine[506]:=ChckPasSup;

  machine[510]:=PlayMenuSup;
  machine[512]:=PlayBipMenuSup;
  machine[514]:=GetMenuSup;
  machine[516]:=ChckMenuSup;

  machine[520]:=PlaySupNoBx;
  machine[522]:=PlayBipSupNoBx;
  machine[524]:=GetSupNoBx;
  machine[526]:=ChckSupNoBx;

  machine[550]:=PlayNoPas;
  machine[552]:=PlayBipNoPas;
  machine[554]:=GetNoPas;
  machine[555]:=ChckNoPas;
  machine[556]:=PlayNoFilePas;
  machine[558]:=PlayBipNoFilePas;
  machine[560]:=GetNoFilePas;
  machine[562]:=ChckNoFileAndPas;

  machine[570]:=RecMesGroup;
  machine[572]:=PlMsGropdlsv;
  machine[574]:=PlayBipMesGroupDlSv;
  machine[576]:=GetMesGroupDlsv;
  machine[578]:=ChkMsGrpDlSv;

  machine[580]:=ChkPlBipGrop;

  machine[594]:=PlayMenuSupSaz;
  machine[595]:=PlayBipMenuSupSaz;
  machine[596]:=GetMenuSupSaz;
  machine[597]:=ChckMenuSupSaz;
//-------------------------------------------------   Monsi 1
  machine[600]:=PlayWaitCallOp;
  machine[602]:=FlashLineOp;
  machine[604]:=CallNumberOp;
  machine[608]:=PlayWaitCall;
  machine[610]:=FlashLine;
  machine[612]:=CallNumber;
  machine[614]:=WaitForAns1;
  machine[615]:=GetKeyResponsCall;
  machine[616]:=FlashLineNotAns;
  machine[618]:=PlayCallNotAns;
  machine[620]:=FlashLineBusy;
  machine[622]:=PlayLineBuse;
  machine[623]:=ChckPlayHold30;
//--------------------------------------------------    Post
//  machine[700]:=PlayEPlakCod10_post;
//  machine[702]:=PlayBipEPlakCod10_post;
//  machine[704]:=GetEPlakCod10_post;
//  machine[706]:=ChckEPlakCod10_post;
  machine[708]:=PlayETelCod10_post;
  machine[710]:=PlayBipETelCod10_post;
  machine[712]:=GetETelCod10_post;
  machine[714]:=ChckETelCod10_post;
//-------------------------------------------------- AmozeshParvaresh
  machine[900]:=PlayBakhshMenu_amozN;
  machine[901]:=PlayBipBakhshMenu_amozN;
  machine[902]:=GetBakhshMenu_amozN;
  machine[903]:=ChckBakhshMenu_amozN;
  machine[905]:=PlayBakhshMenu2_amozN;
  machine[906]:=PlayBipBakhshMenu2_amozN;
  machine[907]:=GetBakhshMenu2_amozN;
  machine[908]:=ChckBakhshMenu2_amozN;
  machine[910]:=PlayUNoDavay_amozN;
  machine[911]:=PlayBipUNoDavay_amozN;
  machine[912]:=GetUNoDavay_amozN;
  machine[913]:=ChckUNoDavay_amozN;
//--------------------------------------------------
  machine[920]:=PlayDayNews_amozN;
//--------------------------------------------------
  machine[930]:=PlayNoDavayer_amozN;
  machine[931]:=PlayBipNoDavayer_amozN;
  machine[932]:=GetNoDavayer_amozN;
  machine[933]:=ChckNoDavayer_amozN;
  machine[934]:=PlaySGNoBakhsh_amozN;
  machine[935]:=PlayBipSGNoBakhsh_amozN;
  machine[936]:=GetSGNoBakhsh_amozN;
  machine[937]:=ChckSGNoBakhsh_amozN;
  machine[938]:=PlaySGYearBakhsh_amozN;
  machine[939]:=PlayBipSGYearBakhsh_amozN;
  machine[940]:=GetSGYearBakhsh_amozN;
  machine[941]:=ChckSGYearBakhsh_amozN;
  machine[942]:=PlaySGMontBakhsh_amozN;
  machine[943]:=PlayBipSGMontBakhsh_amozN;
  machine[944]:=GetSGMontBakhsh_amozN;
  machine[945]:=ChckSGMontBakhsh_amozN;
  machine[946]:=PlaySGDayBakhsh_amozN;
  machine[947]:=PlayBipSGDayBakhsh_amozN;
  machine[948]:=GetSGDayBakhsh_amozN;
  machine[949]:=ChckSGDayBakhsh_amozN;
  machine[951]:=RecBakhsh;
  machine[952]:=PlMsBakhshdlsv;
  machine[953]:=PlayBipBakhshDlsv;
  machine[954]:=GetBakhshDlsv;
  machine[955]:=ChkBakhshDlSv;
//*****************************
  machine[1000]:=PlayASYearBakhsh_amozN;
  machine[1001]:=PlayBipASYearBakhsh_amozN;
  machine[1002]:=GetASYearBakhsh_amozN;
  machine[1003]:=ChckASYearBakhsh_amozN;
  machine[1005]:=PlayAsMontBakhsh_amozN;
  machine[1006]:=PlayBipAsMontBakhsh_amozN;
  machine[1007]:=GetAsMontBakhsh_amozN;
  machine[1008]:=ChckAsMontBakhsh_amozN;
  machine[1010]:=PlayAsDayBakhsh_amozN ;
  machine[1011]:=PlayBipAsDayBakhsh_amozN;
  machine[1012]:=GetAsDayBakhsh_amozN;
  machine[1013]:=ChckAsDayBakhsh_amozN;
  machine[1015]:=PlayTaYearBakhsh_amozN;
  machine[1016]:=PlayBipTaYearBakhsh_amozN;
  machine[1017]:=GetTaYearBakhsh_amozN;
  machine[1018]:=ChckTaYearBakhsh_amozN;
  machine[1020]:=PlayTaMontBakhsh_amozN;
  machine[1021]:=PlayBipTaMontBakhsh_amozN;
  machine[1022]:=GetTaMontBakhsh_amozN;
  machine[1023]:=ChckTaMontBakhsh_amozN;
  machine[1025]:=PlayTaDayBakhsh_amozN;
  machine[1026]:=PlayBipTaDayBakhsh_amozN;
  machine[1027]:=GetTaDayBakhsh_amozN;
  machine[1028]:=ChckTaDayBakhsh_amozN;
  machine[1030]:=RepBackshOutTimre_amozN;

  machine[1040]:=PlyEndBakhsh_amozN;

  machine[1041]:= PlyEnd2EndBakhsh_amozN;

  machine[1042]:=PlayUNoBakhsh_amozN;
  machine[1043]:=PlayBipUNoBakhsh_amozN;
  machine[1044]:=GetUNoBakhsh_amozN;
  machine[1045]:=ChckUNoBakhsh_amozN;


//*************************           Monshi  2
  machine[1200]:=PlayMon;
  machine[1202]:=PlayBipMon;
  machine[1204]:=GetMon;
  machine[1206]:=CkeckMon;
//*************************           Dabir
  machine[1400]:=PlayDabGNo;
  machine[1401]:=PlayDabirBip;
  machine[1402]:=GetDabGNo;
  machine[1404]:=ChckDabNo;
  machine[1406]:=PlayDMErja;
  machine[1408]:=PlayYErja;
  machine[1410]:=PlayToVah;
  machine[1412]:=PlayCodErja;
  machine[1414]:=PlayErja;
  machine[1416]:=PlayVahed;
  machine[1418]:=PlayAns;
  machine[1420]:=PlayMovar;
  machine[1422]:=PlayDMSader;
  machine[1424]:=PlayYSader;
  machine[1426]:=PlayTo;
  machine[1428]:=PlayCodSader;
  machine[1430]:=PlayErsal;
  machine[1432]:=PlaySazDab;
//*******************************
  machine[1500]:=PlayEPersCodHogog;
  machine[1502]:=PlayBipEPersCodHogog;
  machine[1504]:=GetEPersCodHogog;
  machine[1506]:=ChckEPersCodHogog;
//*******************************
  machine[1700]:=PlayECodKhoon;
  machine[1702]:=PlayBipECodKhoon;
  machine[1704]:=GetECodKhoon;
  machine[1706]:=ChckECodKhoon;
//*******************************
  machine[1800]:=checkTimeDate;
  machine[1802]:=GetActivRecOfMasterFileElam;
  machine[1804]:=FOffHookElam;
//  machine[1806]:=PlayNUll;
  machine[1808]:=DialForElam;
  machine[1810]:=WaitForAnsElam;
//  machine[1812]:=PlayNUll;
//  machine[1814]:=PlayNUll;
  machine[1816]:=PlaySazEElam;
  machine[1818]:=PlayBipSazElam;
  machine[1820]:=GetSazElam;
  machine[1822]:=ChckSazElam;
//  machine[1824]:=PlayNUll;
//  machine[1826]:=PlayNUll;
  machine[1828]:=PlayELam;
//  machine[1830]:=PlayNUll;
  machine[1832]:=PlayGoodbyElam;
  machine[1834]:=OnHookElam;
//********************************************
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;
//  machine[100]:=PlayNUll;

  //*******************************
end;

