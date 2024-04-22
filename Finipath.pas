procedure Tline.PathINi;
begin


 DriveSys2:=MainForm.TPathDriveInstall.asstring;
 DriveSaz:=MainForm.TPathDriveInstall.asstring ;
 DriveTr:=MainForm.TPathDriveTree.asstring;

 DriveBoxV:=MainForm.TPathDriveMess.asstring+'box\MessBox\';
 DriveJavab:=MainForm.TPathDriveAns.asstring+'box\MBoxAns\';
 DriveDb:=MainForm.TPathDriveDabir.asstring;
 DriveSa:=MainForm.TPathSazeman.asstring;

 DriveSaz:=DriveSaz+'SAZVoic\'+DriveSa+'\';
 DriveTr:=DriveTr+'SAZVoic\'+DriveSa+'\';

 DriveDb:=DriveDb+'SazDb\'+DriveSa+'\';
 DriveDbirkhane:=DriveDb+'dabir\';
 DriveDabirCV:=DriveSaz+'CodDabir\';

 DriveSYSDBBox:=DriveSys2+'SYSDB\DbBox\';
 //----------------------------------
 DriveDbInfo:=DriveTr+'DBinf\';
 DriveInfo:=DriveTr+'info\';
 //----------------------------------
 //----------------------------------
// strcpy(DriveBox,Drive);        strcat(DriveBox      ,"Bsys\\1\\");
 DriveVSaz:=DriveSaz+'msg\';

 if MainForm.TPathSondPesar.asstring='1' then
  DriveVSys:=DriveSys2+'sys\msgP\'
else  DriveVSys:=DriveSys2+'sys\msgD\';

 DriveNumber:=DriveSys2+'sys\Number\';
 DriveDateV:=DriveSys2+'sys\Date\';
 MainForm.DriveLog:=DriveSys2+'sysDB\dbLog\';
 // DriveFGroup,DriveSaz);     strcat(DriveFGroup,"Group\\FilGroup\\");
// strcpy(DriveNGroup,DriveSaz);     strcat(DriveNGroup,"Group\\NamGroup\\");
  //----------------------------------
// strcpy(DriveGoranName,DriveSys2);  strcat(DriveGoranName,"Gor\\");
  //----------------------------------
// strcpy(DriveSysName,Drive);    strcat(DriveSysName  ,"BOX\\4\\");

 DriveBoxGrV:=DriveSaz+'BOXVGr\';
 DriveBoxNamV:=DriveSaz+'BoxVNam\';

//----------------------------------
// strcpy(DriveDabir,DriveDb);      strcat(DriveDabir   ,"Dab\\DBF\\");
// strcpy(DriveDabirV,DriveDb);     strcat(DriveDabirV  ,"Dab\\Dabv\\");
// strcpy(DriveDabirCV,DriveDb);    strcat(DriveDabirCV ,"Dab\\Dabcod\\");
  //----------------------------------


// strcpy(DrivePCM,DriveSaz);      strcat(DrivePCM,"PCM\\");

 VRing:=MainForm.TPathRing.ASINTEGER;        //
 VPG:=MainForm.TPathPG.ASINTEGER;            //
 VRG:=MainForm.TPathRG.ASINTEGER;            //
 VSysIdd:=MainForm.TPathSysIdd.asinteger;    //
//VSondPesar:=MainForm.TPathSondPesar       //
 VGetDig_Pulse_Tone:=MainForm.TPathGetDig_Pulse_Tone.ASINTEGER; //
 VMainMenuRep:=MainForm.TPathMainMenuRep.ASINTEGER; //
 VTimeOutDig:=MainForm.TPathTimeOutDig.ASINTEGER;   //
 VMaxSil:=MainForm.TPathMaxSil.ASINTEGER;  //
 VDialPulseTone:=MainForm.TPathDialPulseTone.ASINTEGER;//

 VOpMod_state:=MainForm.TPathOpMod_state.ASINTEGER;    //
 VDialAfterModSt:=MainForm.TPathDialAfterModSt.ASINTEGER;    //
 VCountBus:=MainForm.TPathCountBus.ASINTEGER;    //
 VIntNotAnsOp_rec:=MainForm.TPathNotAnsOpRec.ASINTEGER;    //
 VOpOnly_serial:=MainForm.TPathOpOnly_serial.ASINTEGER;//
 VFlashMod:=MainForm.TPathFlashMod.ASINTEGER;          //
 VOpNumber:=MainForm.TPathOpNumber.asstring;           //

 VFlagDabir:=MainForm.TPathFlagDabir.ASINTEGER;          //

 Vsys_State:=MainForm.TPathVsys_State.ASINTEGER;        //
 VDeletCopy:=MainForm.TPathDeletCopy.ASINTEGER;
 VAfterFlashDelay:=MainForm.TPathAfterFlashDelay.ASINTEGER;      //
 VFlashDelay:=MainForm.TPathFlashDelay.ASINTEGER;      //
 VAnsDelay:=MainForm.TPathAnsDelay.ASINTEGER;      //
//*************************
    PasSup:=MainForm.TPathPassup.asstring;;

// strcpy(DriveDabirCV,DriveDb);    strcat(DriveDabirCV ,"Dab\\Dabcod\\");
end;
