unit UMain;

interface

uses
   SysUtils,_V4VXDI, Windows, _DTMF, _WType, _Date, _WV4Obj, _WFile, _Wave,
   _WV4Const, Classes, IniFiles, Forms, FileCtrl, _TVType, Dialogs,
   Graphics, ExtCtrls, Db, dbTables, Controls, Buttons, StdCtrls,
  Grids, DBGrids,datetof, Menus, Mask;


const
//*****************************Max

 MaxPlayOneMess=2;

 MaxTimeNotEvent=19;
 MaxTimeUsedSystem=17;
 TypeMesSing = 1;
 TypeMesGrop =2;
 TypeCopyMes =3;
//*****************************State
 StartOnState=1;
 StateOffHook=2;
 StateonHook=3;
 StateOutTim=4;
 StateGoodby=5;
 StateMainMenu=14;
//*****************************Event
 Disconnect=-200;
 Term_Digit=-201;
 PBEOF     =-202;
 Fax_Rx    =-203;
 MAXSECS   =-204;                 // timeout: max seconds
 IDD       =-205;
 Max_Digit1 =-206;
 NoChengState  =-300;
//*****************************V_State

 V_Start     = 1;
 V_OffHook   = 2;
 V_OnHook    = 3;
 V_Play      = 4;
 V_Record    = 5;
 V_GetDigits = 6;
 V_SendDigits= 7;
 V_DosError  = 8;
 V_Flash     = 9;
 V_SetPara   = 10;
 V_WaitAns   = 11;
 V_WaitRing  = 12;


 StatusStrFarsi:array[1..12] of string  = ('Start System'
        ,'            '
 	,'           '
        ,'                '
	,'                '
	,'                 '
	,'          '
        ,'   '
	,'Flashing'
	,'     '
        ,'               '
        ,'        ');
 StatusStrFarsiColor:array[1..12] of integer  = (claqua
        ,clDkGray,clfuchsia,clBlue,clGreen,clRed,clGray
	,clYellow,clLime,clNavy,clMaroon,clRed);
  StatusStr:array[1..12] of string  = ('Start System'
       ,'Wait  For connect'
       ,'Wait  For Diconnect'
       ,'Playing'
       ,'Recording'
       ,'Enter Digit'
       ,'Dialing','Flashing','Conterol Parametr'
       ,'Error'
       ,'Wait  For Answer','Wait  For Ring');
//*****************************Type
type
 Bakhsh=record
     CodDavayer:string;
     NoBakhsh:string;
     Year:string;
     Mont:string;
     Day:string;
     Year2:string;
     Mont2:string;
     Day2:string;
     Count:integer;
end;
//*************************************
TDataDabir =record
    no_vared:string;
    cod_erja:string;
    y_erja:string;
    d_erja:string;
    m_erja:string;
    no_sader:string;
    y_sader:string;
    m_sader:string;
    d_sader:string;
    cod_sader:string;
end;
//*************************************

 PositionLine=record
     State:integer;
     LastState:integer;
     StartTime:TDatetime;
     Hour, Min, Sec, MSec:Word;
     EndEventTime:TDatetime;
     Ev_Hour, Ev_Min, Ev_Sec, Ev_MSec:Word;
     V_Line:integer;
     pfhandle:integer;
end;
//*************************************
Digg= array [0..9] of char;

StDig3=record
  Dig3:array [0..7] of Digg;
  countDig3:integer;
  countDig2:integer;
  flagDig3:array [0..7] of integer;
end;
//*************************************
Data_S=record
  NoBoxInfo:string;
  Ramz:string;
  Tel_Box:Longint;
  flag_act_tel:integer;      // 0 or 1 =act
  FlagRecOnly:integer;       //1=rec and ans or 2=rec only
  FlagRecBipMes:integer;     //Start 1=Play BxBipRec or 2=Play BxBipRec+NoBox
			  //Go    1=Play OthrSave or 2=Play OthrSave+NoBox
  FlagPlayNoMes:integer;     //1=Play Date TimeRec Off or 2=Play Date TimeRec ON
  FlagMenu:string;
  NoBoxJanesh1:string;
end;
//*************************************
Data_M=record
  NoBoxMes:string;
  NoboxSend:string;
  FileMess:Longint;
  RamzMes:Longint;
  TypeSend:Integer;          //    TypeMesSing == 1  TypeMesGrop == 2 TypeCopyMes ==3
  TypeVisibel:Integer;        //1== New Mess 2==Old Mess
  Tel_mes:Integer;
  TypeFile:integer;
  DateTimeRec:double;
  NoAnsMess:Longint;
  DateTimeRecAns:double;
  CodMozoe:string;
  EndNoParaf:Integer;
end;
//*************************************
 BoxL=record
   NoBox:string;
   SendDig:string;
   CodElam:string;
   PriceElam:string;
   PointFile:Longint;
   PointCurentMess:Longint;
   FileMessTemp:Longint;
   RamzMesTemp:Longint;
   Ramz:string;
   Tel_mesTemp:Longint;
   PointTel:integer;
   Command:string;
   Copy1:string;
   FlagBipRecGr_name:integer;
   Data:Data_S;
   DataMes:daTa_M;
   CountBus:integer;
   NoGroup:string;
   NoGroupPath:string;
   SupMenu:integer;
   PointRecCount:longint;
   PointRecMax:longint;
   GoStateGet:integer;
   GoStateRep:integer;
   FlagRecordAll0:integer;
end;
//*************************************
type
  TMainForm = class(TForm)
    TPath: TTable;
    DataSource2: TDataSource;
    Panel2: TPanel;
    Image1: TImage;
    Image4: TImage;
    Label1: TLabel;
    Image3: TImage;
    Image2: TImage;
    Label2: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    StaticText1: TStaticText;
    BitBtn2: TBitBtn;
    StaticText2: TStaticText;
    BitBtn3: TBitBtn;
    StaticText3: TStaticText;
    BitBtn4: TBitBtn;
    StaticText4: TStaticText;
    BitBtn5: TBitBtn;
    StaticText5: TStaticText;
    BitBtn6: TBitBtn;
    StaticText6: TStaticText;
    BitBtn7: TBitBtn;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    StaticText9: TStaticText;
    StaticText10: TStaticText;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    StaticText11: TStaticText;
    BitBtn12: TBitBtn;
    StaticText12: TStaticText;
    BitBtn13: TBitBtn;
    StaticText13: TStaticText;
    BitBtn14: TBitBtn;
    StaticText14: TStaticText;
    BitBtn15: TBitBtn;
    StaticText15: TStaticText;
    BitBtn16: TBitBtn;
    StaticText16: TStaticText;
    CheckBox1: TCheckBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    TabletELOP: TTable;
    DStELoP: TDataSource;
    TPathRing: TIntegerField;
    TPathPG: TIntegerField;
    TPathRG: TIntegerField;
    TPathDriveInstall: TStringField;
    TPathDriveTree: TStringField;
    TPathDriveMess: TStringField;
    TPathDriveAns: TStringField;
    TPathDriveDabir: TStringField;
    TPathSazeman: TStringField;
    TPathVsys_State: TStringField;
    TPathSysIdd: TStringField;
    TPathSondPesar: TStringField;
    TPathGetDig_Pulse_Tone: TStringField;
    TPathMainMenuRep: TStringField;
    TPathTimeOutDig: TIntegerField;
    TPathMaxSil: TIntegerField;
    TPathDeletCopy: TStringField;
    TPathDialPulseTone: TStringField;
    TPathOpMod_state: TStringField;
    TPathDialAfterModSt: TStringField;
    TPathCountBus: TIntegerField;
    TPathNotAnsOpRec: TIntegerField;
    TPathOpOnly_serial: TStringField;
    TPathFlashMod: TStringField;
    TPathAnsDelay: TIntegerField;
    TPathAfterFlashDelay: TIntegerField;
    TPathFlashDelay: TIntegerField;
    TPathOpNumber: TStringField;
    TPathPAsSup: TStringField;
    TPathFlagDabir: TStringField;
    THOLD: TTable;
    DSHold: TDataSource;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    MaskEdit1: TMaskEdit;
    N6: TMenuItem;
    Panel4: TPanel;
    DBGrid2: TDBGrid;
    BitBtn20: TBitBtn;
    Panel5: TPanel;
    DBGrid1: TDBGrid;
    BitBtn21: TBitBtn;
    THOLDId: TAutoIncField;
    THOLDNoOp: TIntegerField;
    THOLDFalgActiv: TIntegerField;
    N7: TMenuItem;
    CheckBox2: TCheckBox;
    N8: TMenuItem;
    TabletELOPId: TAutoIncField;
    TabletELOPNoOp: TIntegerField;
    TabletELOPFalgActiv: TIntegerField;
    TabletELOPNait: TStringField;
    Label16: TLabel;
    TabelRengDate: TTable;
    TabelRengDateYear1: TIntegerField;
    TabelRengDateMont1: TIntegerField;
    TabelRengDateDay1: TIntegerField;
    TabelRengDateYear2: TIntegerField;
    TabelRengDateMont2: TIntegerField;
    TabelRengDateDay2: TIntegerField;
    TabelRengDateHour1: TIntegerField;
    TabelRengDateMin1: TIntegerField;
    TabelRengDateHour2: TIntegerField;
    TabelRengDateMin2: TIntegerField;
    TabelElam: TTable;


    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure TabletELOPAfterInsert(DataSet: TDataSet);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure THOLDAfterInsert(DataSet: TDataSet);
    procedure BitBtn21Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
      FlagShutDownElam:boolean;
      DriveLog:string;
      FlaglinfoTree:boolean;
      FlaglinfoBox:boolean;
      FlagLockMessBox:boolean;
      FlagLockRing:boolean;
      FlagLockErja:boolean;
      FlagStartSystem:boolean;
      FlagLocklogfile:boolean;
      FlagLockOpAct:boolean;
      FlagLockHold:boolean;
      FlagLockCountVoice:boolean;
      FlagLockCountVoiceRFC:boolean;
      TabelCountVoic:TTable;
      //*********~!*************
      FlagLockTabeHogog:boolean;
      //*********~!*************
      FlagLockTabeKhoon:boolean;
      //*********~!*************
      FlagLockTabeCod10:boolean;
      FlagLockTabePishCod10:boolean;
      //*********~!*************
      FlagLockTabeBakhsh:boolean;
      flaglockchek:integer;

      FlagLockTabeDabir:boolean;

      DSTabelRengDate: TDataSource;
      DSTabelElam: TDataSource;

      FlagLockElam:boolean;
       R_Year1, R_Month1, R_Day1: Word;
       R_Year2, R_Month2, R_Day2: Word;
       R_Hour1, R_Min1:Word;
       R_Hour2, R_Min2:Word;

      recNo:integer;
      recNoHold:integer;
      procedure statusLine(Count:integer);
      procedure ExitP;

//      procedure MyErrorHandler(ErrorCode: Integer; ErrorAddr: Pointer);
      //***********************
    { Public declarations }
  end;

type

//****************************************************
//
//               Thread Nazer
//
//
//****************************************************

  TMyThreadNazer = class(TThread)

  private
    { Private declarations }
  protected
    constructor Build () ;
    procedure Execute; override;
  public
    ChanelNazer:integer;
    FlagShutDown:boolean;
    FlagNazer:boolean;
    CountRunTreed:longint;
    constructor Create(Autorun:boolean);
  end;

//****************************************************
  Func = function : integer of object;
//****************************************************
//
//
//               Thread Line
//
//
//****************************************************
  TLine = class ( V4_Object )
    FStatusLine : TStaticText ;
    FStatusLineFarsi : TLabel ;
    ExitFlag:boolean;
  public
//**********************************************

   LineStat:PositionLine;
    KeyBuf:string;
    BoxLine,BoxLine2:BoxL;
    Buf_Dig3:StDig3;
    SelectNoBox:integer;
    Bakhshname:Bakhsh;
    DataDabir:TDataDabir;
//**********************************************
    DriveSYSDBBox:string;
    DriveSYS:string;
    DriveSys2:string;
    DriveSaz:string;
    DriveVSaz:string;
    DriveVSys:string;
    DriveTr:string;
    DriveDb:string;
    DriveDbirkhane:string;
    VflagDabir:integer;
    DriveFGroup:string;
    DriveNGroup:string;
    DriveSa:string;
    DriveDbinfo:string;
    DriveInfo:string;
    DriveDBox:string;
    DriveBoxV:string;
    DriveBoxGrV:string;
    DriveBoxNamV:string;
    DriveJavab:string;

    DriveDabir:string;
    DriveDabirCV:string;
    DriveNumber:string;
    DriveDateV:string;

    VRing: Integer;
    VPG: Integer;
    VRG:integer;
    Vsys_State:integer;
    VSysIdd: integer;
    VGetDig_Pulse_Tone: integer;
    VMainMenuRep: integer;
    VTimeOutDig:integer;
    VMaxSil: integer;
    VDeletCopy: integer;
    VDialPulseTone: integer;
    VOpMod_state: integer;
    VDialAfterModSt: integer;
    VCountBus: integer;
    VIntNotAnsOp_rec:integer;
    VOpOnly_serial: integer;
    VFlashMod: integer;
    VFlashDelay: integer;
    VAfterFlashDelay:integer;
    VAnsDelay:integer;
    VOpNumber: String;
//*****************
//*****************
    PasSup:string;
    Passcom:integer;
    NoPas:string;
//--------------------------
    TabelinfoBox1:TTable;
    TabelinfoBox2:TTable;
//--------------------------
    TabelMessBox1:TTable;
    TabelMessBox2:TTable;
//--------------------------
    TabelRing:TTable;
//--------------------------
    TabelErja:TTable;
//--------------------------
    TabelGroup:TTable;
//--------------------------
    TabelGroupBox:TTable;
//--------------------------
    TabelInfo:TTable;
//--------------------------
    TabelLog:TTable;
    TabelTelop:TTable;
    THold:TTable;
//*******~!*****************
    TabeCod10:TTable;
    TabePishCod10:TTable;
//*******~!*****************
    TabeHogog:TTable;
//*******~!*****************
    TabeKhoon:TTable;
//*******~!*******************
    TabelBakhsh:TTable;
//*******~!*******************
    TabelDabir:TTable;
//*******~!*******************
//**************************
    LogType:string[3];
    LogMes:string;
    LogDate:TDateTime;
    LogTimeSt,LogTimeEn:TDateTime;
    LogV_Line:integer;
//**********************************************
    DialStartTime:Tdatetime;
    OnHook_StartTime:Tdatetime;
    OffHook_StartTime:Tdatetime;
    TypeRingUsed:integer;
    RingDate:string;
//**********************************************
    CountMessagLineMsg:string;
    CountMessagLinecount:integer;
//**********************************************
   PointCurrentNod:integer;
   Find_Nod_Tree:boolean;
//**********************************************
    machine : array[0..4000] of Func;
//**********************************************
   function Startup: integer;
   function FlashCall:integer;
   function SendDigits:integer;
   function GetDigits(Max_Digit:Byte;Delay_Time:DWord;FlagStar:integer):integer;
   function Tableopen: integer;
   function tableclose: integer;
   function FWaitForRing: integer;
   function FOffHook: integer;
   function FOnHook: integer;
   function PlayFile(filename:string;Drive:string;FlagBreak:integer):integer;
   function PlayFileWav(filename:string;Drive:string;FlagBreak:integer):integer;
   function RecFile(filename:string;Drive:string;MaxTime:integer;FlagBreak:integer):integer;
   procedure paraLog(VMesLog:string;VTypeLog:string;VLogTimeSt:TDateTime;VLogTimeEn:TDateTime);
   procedure logfile2;
   procedure logfile;
   function WaitForAns:integer;
   function PlayGoodBy:integer;
   function PlayTimeOut:integer;
   function PlayGoran:integer;
   function PlayBlundeNo:integer;

   function PlaySaz:integer;
   function PlayUsedKey9:integer;
   function PlayBipUsedKey9:integer;
   function GetUsedKey9:integer;
   function CheckUsedKey9Idd:integer;
   function PlayAyam:integer;
   function PlayMainMenu:integer;
   function GetMainMenu:integer;
   function PlayMainMenuBip:integer;
   function CheckMainMenu:integer;
   function CheckMainMenuIdd:integer;

   function PlayMain2:integer;
   function PlayMain2Bip:integer;
   function GetMain2:integer;
   function ChckMain2:integer;



   Procedure ReadCurrentNod;
   Function PlayTreeNod:integer;
   Function GetDigTree:integer;
   Function PlayBipTree:integer;
   Function CheckTreeLf:integer;
   Function CheckTreeST:integer;  //chech event star in getdigit */
   Function CheckDTreeIdd:integer;
   Function CheckDTree:integer;
   function PlDosErTr:integer;
//**********************************************
   procedure PathINi;
   function PlaySazDrv(FileName:string;NOT_OK_St:integer;PBEOF_St:integer;Term_St:integer):integer;
   function PlaySazDrvNot(FileName:string;NOT_OK_St:integer;PBEOF_St:integer;Term_St:integer):integer;
   function PlaySysDrv(FileName:string;NOT_OK_St:integer;PBEOF_St:integer;Term_St:integer):integer;
   function PlayDateDrvNot(FileName:string;NOT_OK_St:integer;PBEOF_St:integer;Term_St:integer):integer;   
   function PlaySysDrvNot(FileName:string;NOT_OK_St:integer;PBEOF_St:integer;Term_St:integer):integer;
   function PlayOtherNoBox:integer;
   Function PlayBipOtherNoBox:integer;
   function GetDigit(dig,delay,StIdd,StMax,Stother:integer):integer;
   function GetDigitStar(dig,delay,StIdd,StMax,Stother:integer):integer;
   function GetOtherNoBox:integer;
   function ChckOthrNoBx:integer;
   function PlayOthrRep:integer;
   function searchNoBox(NoBox:string):longint;
   function PlayBxBipRec:integer;
   function RecMesBx:integer;
   function PlayOthrSave:integer;
   function ReadFC:integer;
   Procedure ReadFCDate(var Year, Month, Day:Word);
   Procedure WritFCDate(var Year, Month, Day:Word);
   function  WritFC(LL:integer):integer;
   function GenertFileName(var L:Longint;var FileName:string;var FileNamePath:string):integer;
   function CheckDateFile:integer;
   function GenaratNmaeRamz:integer;
   function copyFile(File1,File2:string):integer;
   Procedure read_InfoBox(NoBox:string;BoxData:integer);
   Procedure Edit_InfoBox1(NoBox:string);
   Procedure writeAppendMesssagbox(BoxDAta:integer);
   Procedure EditCurMesssagbox1(NoMes:longint;NoBox:string);
   function  SaveErja(FileMess,RamzMes:Longint ;Type_Erja:char;SendBox,GetBox:string;SizFileMess:integer;CodMozoe:string):integer;
   function  SaveRing:integer;
   function PlayChckStat:integer;
   function SplitDig2(str:string):integer;
   function PlayNo2:integer;
   procedure trimL(var str:Digg) ;
   function SplitDig3(str:string):integer;
   function PlayGNoMes:integer;
   function PlayNo:integer;
   function PlayNoMes:integer;
   function PlayNoRmz:integer;
   function PlayGRamzMes:integer;
   function PlayOkGRamzMes:integer;
   function PlayBipOkGRamzMes:integer;   
   function GetOkGRamzMes:integer;
   function ChckOkGRamzMes:integer;

   function searchAns(NoMes1:string) : longint;
   function FuncIdd(BackState,RepState:integer):integer;
   function SplFileName(FileName:string ; var FileNamePath:string):integer;
   function ChckTypNoMes:integer;
   function PlayTypNoMes:integer;
   function PlayBipTypNoMes:integer;
   function GetTypNoMes:integer;
   function ChckTypNoRamz:integer;
   function PlayTypNoRamz:integer;
   function PlayBipTypNoRamz:integer;
   function GetTypNoRamz:integer;
   function PlayOkBxRamz:integer;
   function PlayBlNoBx:integer;
   function PlayNotMesBx:integer;
   function FindCountMesInBox(NoBox:string):integer;
   Procedure ReadCurentMes;   
   function PlaySlfNoMes:integer;
   function ChckSlfNoBx:integer;
   function GPlaySlfNoBx:integer;
   Function PlayBipSlfNoBx:integer;
   function GetSlfNoBx:integer;
   function PlaySlfOkRz:integer;
   function PlayBlNoRamz:integer;
   function ChckSlfRamz:integer;
   function PlaySlfRamz:integer;
   function PlayBipRecGrBx:integer;
   Function PlayBipSlfRamz:integer;
   function GetSlfRamz:integer;
   function PlayBipRecNamBx:integer;
   function ChckSlfMenu0:integer;
   function PlaySlfMenu0:integer;
   Function PlayBipSlfMenu0:integer;
   function GetSlfMenu0:integer;
   function PlaySetFlgNoMes:integer;
   function PlayBipSetFlgNoMes:integer;
   function GetSetFlgNoMes:integer;
   function ChckSetFlgNoMes:integer;
   function PlaySNoMes:integer;
   function PlaySNoMes2:integer;
   function PlayErrorBx:integer;
   function PlayNextMes:integer;
   function ChckPlyNextMes:integer;
   function PlaySTamaMes:integer;
   function PlayMesOne:integer;
   function PlayToNo:integer;
   function PlayNoDateTimeMes:integer;
   function PlayToDate:integer;
   function PlayTime:integer;
   function PlayAnd2:integer;
   function PlayMin:integer;
   function PlayYerMes:integer;
   function PlayDMMes:integer;
   function PlayHourMes:integer;
   function PlayMinMes:integer;
   function PlayRecGo:integer;
   function PlaySMesII:integer;
   function ChckPlMenuAns:integer;
   function PlayNotIfBx:integer;
   function DelCurentMesOfArrey(delflag:INTEGER):integer;
   function PlayBipRecAns:integer;
   function CopyCurentMesOfArreyToDelBox1(TypeMes:integer):integer;
   function ChckMenuAns:integer;
   function PlayDelCuMes:integer;
   function GPlayMenuAns:integer;
   Function PlayBipMenuAns:integer;
   function GetMenuAns:integer;
   function ChckSDelMes:integer;
   function GPlaySDelMes:integer;
   Function PlayBipSDelMes:integer;
   function GetSDelMes:integer;
   function RecAnsMes:integer;
   function AddDataToAns:integer;
   function PlaySaveAns:integer;
   function PlayAnsRep:integer;
   function ChckAnsDlSv:integer;
   function GPlayAnsDlSv:integer;
   Function PlayBipAnsDlSv:integer;
   function GetAnsDlSv:integer;      
   function ChckSendNoBx:integer;
   function GPlaySendNoBx:integer;
   Function PlayBipSendNoBx:integer;
   function GetSendNoBx:integer;
   function copyBox1ToBox2(TypeMes:integer):integer;
   function findMesInBox2(NoMes:longint ;NoBox:string):Boolean;
   function CopyCurentMesOfArreyto(TypeMes:integer):integer;
   function PlaySendMessOk:integer;
   function PlaySendMessNotOk:integer;
   function PlayCopyMesOk:integer;
   function ChckOkSend:integer;
   function GPlayOkSendMes:integer;
   Function PlayBipOkSendMes:integer;
   function GetOkSendMes:integer;
   function ChckPlEnRmz2:integer;
   function GPlayEnterRmz:integer;
   Function PlayBipEnterRmz:integer;
   function GetEnterRmz1:integer;
   function ChengRamz:integer;
   function ChckEnterRmz:integer;
   function GPlayEnterRmz2:integer;
   Function PlayBipEnterRmz2:integer;
   function GetEnterRmz2:integer;
   function RecNamGr:integer;
   function PlayRepG:integer;
   function PlaySaveName:integer;
   function PlaySaveGr:integer;
   function PlNotSave:integer;
   function ChckGrDlSv:integer;
   function GPlayGrDlSv:integer;
   function PlayBipGrDlSv:integer;
   function GetGrDlSv:integer;   

//***************sup*********
  function PlayPasSup:integer;
  function PlayBipPasSup:integer;
  function GetPasSup:integer;
  function PlayBlPasSup:integer;
  function ChckPasSup:integer;
  function PlayMenuSup:integer;
  function PlayBipMenuSup:integer;
  function GetMenuSup:integer;
  function ChckMenuSup:integer;
  function PlaySupNoBx:integer;
  function PlayBipSupNoBx:integer;
  function GetSupNoBx:integer;
  function ChckSupNoBx:integer;
  function PlayNoPas:integer;
  function PlayBipNoPas:integer;
  function GetNoPas:integer;
  function ChckNoPas:integer;  
  function PlayNoFilePas:integer;
  function PlayBipNoFilePas:integer;
  function GetNoFilePas:integer;
  function ChckNoFileAndPas:integer;
  function RecMesGroup:integer;
  function PlMsGropdlsv:integer;
  function PlayBipMesGroupDlsv:integer;
  function GetMesGroupDlsv:integer;
  function ChkMsGrpDlSv:integer;
  function PlBipRecGloM:integer;
  function PlayBlNoMes:integer;                   
  function PlayOtSave:integer;
  function SendOneBox(NoBox:string):integer;

  function ChkPlBipGrop:integer;

  function PlayMenuSupSaz:integer;
  function PlayBipMenuSupSaz:integer;
  function GetMenuSupSaz:integer;
  function ChckMenuSupSaz:integer;
  Procedure SupAMOZN;
  Procedure MenSupS2Chek;
  Procedure MenuSupSaz3;
//******************************************Monshi****
function PlayMon:integer;
function PlayBipMon:integer;
function GetMon:integer;
function CkeckMon:integer;

function findindb:integer;
function GetLocalNoBoxOp:integer;
function GetActivHoldOfDataBas:integer;
function GetActivOPOfDataBas:integer;
function WaitForAnsw(St_Ans:integer;St_Busy:integer;St_Else:integer):integer;
function GetActivOp:integer;
function FlashLineOp:integer;
function PlayWaitCallOp:integer;
function CallNumberOp:integer;
function PlayWaitCall:integer;
function FlashLine:integer;
function CallNumber:integer;
function WaitForAns1:integer;
function FlashLineNotAns:integer;
function PlayCallNotAns:integer;
function FlashLineBusy:integer;
function PlayLineBuse:integer;
function ChckPlayHold30:integer;
function GetKeyResponsCall:integer;
//*****************************************Dabir******
Function playDabirDrv(FileName:string):integer;
Function playDabirDrvNot(FileName:string):integer;
Function PlayDabGNo:integer;
function PlayDabirBip:integer;
function GetDabGNo:integer;
Function searchDabir(No:string):integer;
Function ChckDabNo:integer;
Function PlayEndErja:integer;
Function PlayBlNoName:integer;
Function PlayDMErja:integer;
Function PlayYErja:integer;
Function PlayToVah:integer;
Function PlayCodErja:integer;
Function PlayErja:integer;
Function PlayVahed:integer;
Function PlayAns:integer;
Function PlayMovar:integer;
Function PlayDMSader:integer;
Function PlayYSader:integer;
Function PlayTo:integer;
Function PlayCodSader:integer;
Function PlayErsal:integer;
Function PlaySazDab:integer;
//*****************************************Post******
{Function PlayEPlakCod10_post:integer;
Function PlayBipEPlakCod10_post:integer;
function GetEPlakCod10_post:integer;
function ChckEPlakCod10_post:integer;
}
Function PlayETelCod10_post:integer;
Function PlayBipETelCod10_post:integer;
function GetETelCod10_post:integer;
function ChckETelCod10_post:integer;
function FindCod10(tel:string;var Cod10,PishCodStr:string;var PishCod,Scod,ECOd:integer):boolean;
//function FindCod10InPish(FIleDbf,tel:string;PishCod,Scod,ECOd:integer):boolean;
//**********************************************AMOZESH*
Function PlayNoDavayer_amozN:integer;
Function PlayBipNoDavayer_amozN:integer;
function GetNoDavayer_amozN:integer;
function ChckNoDavayer_amozN:integer;
Function PlaySGNoBakhsh_amozN:integer;
Function PlayBipSGNoBakhsh_amozN:integer;
function GetSGNoBakhsh_amozN:integer;
function ChckSGNoBakhsh_amozN:integer;
Function PlaySGYearBakhsh_amozN:integer;
Function PlayBipSGYearBakhsh_amozN:integer;
function GetSGYearBakhsh_amozN:integer;
function ChckSGYearBakhsh_amozN:integer;
Function PlaySGMontBakhsh_amozN:integer;
Function PlayBipSGMontBakhsh_amozN:integer;
function GetSGMontBakhsh_amozN:integer;
function ChckSGMontBakhsh_amozN:integer;
Function PlaySGDayBakhsh_amozN:integer;
Function PlayBipSGDayBakhsh_amozN:integer;
function GetSGDayBakhsh_amozN:integer;
function ChckSGDayBakhsh_amozN:integer;
function RecBakhsh:integer;
function PlMsBakhshdlsv:integer;
function PlayBipBakhshDlsv:integer;
function GetBakhshDlsv:integer;
function ChkBakhshDlSv:integer;
Function SaveRecTable_amozN:integer;
Procedure writeAppendBakhsh;
//******
Function PlayBakhshMenu_amozN:integer;
Function PlayBipBakhshMenu_amozN:integer;
function GetBakhshMenu_amozN:integer;
function ChckBakhshMenu_amozN:integer;
Function PlayBakhshMenu2_amozN:integer;
Function PlayBipBakhshMenu2_amozN:integer;
function GetBakhshMenu2_amozN:integer;
function ChckBakhshMenu2_amozN:integer;
Function PlayUNoDavay_amozN:integer;
Function PlayBipUNoDavay_amozN:integer;
function GetUNoDavay_amozN:integer;
function ChckUNoDavay_amozN:integer;

Function PlayDayNews_amozN:integer;

Function PlayASYearBakhsh_amozN:integer;
Function PlayBipASYearBakhsh_amozN:integer;
function GetASYearBakhsh_amozN:integer;
function ChckASYearBakhsh_amozN:integer;
Function PlayAsMontBakhsh_amozN:integer;
Function PlayBipAsMontBakhsh_amozN:integer;
function GetAsMontBakhsh_amozN:integer;
function ChckAsMontBakhsh_amozN:integer;
Function PlayAsDayBakhsh_amozN:integer;
Function PlayBipAsDayBakhsh_amozN:integer;
function GetAsDayBakhsh_amozN:integer;
function ChckAsDayBakhsh_amozN:integer;
Function PlayTaYearBakhsh_amozN:integer;
Function PlayBipTaYearBakhsh_amozN:integer;
function GetTaYearBakhsh_amozN:integer;
function ChckTaYearBakhsh_amozN:integer;
Function PlayTaMontBakhsh_amozN:integer;
Function PlayBipTaMontBakhsh_amozN:integer;
function GetTaMontBakhsh_amozN:integer;
function ChckTaMontBakhsh_amozN:integer;
Function PlayTaDayBakhsh_amozN:integer;
function RepBackshOutTimre_amozN:integer;
Function PlayBipTaDayBakhsh_amozN:integer;
function GetTaDayBakhsh_amozN:integer;
function ChckTaDayBakhsh_amozN:integer;
function PlyEndBakhsh_amozN:integer;
function PlyEnd2EndBakhsh_amozN:integer;
Function PlayUNoBakhsh_amozN:integer;
Function PlayBipUNoBakhsh_amozN:integer;
function GetUNoBakhsh_amozN:integer;
function ChckUNoBakhsh_amozN:integer;
//***************************************Elam And Price********
Function checkTimeDate:integer;
Function GetActivRecOfMasterFileElam:integer;
function FOffHookElam: integer;
function DialForElam:integer;
function AddFlagPcmMod(ret:integer):integer;
function WaitForAnsElam:integer;
Function PlaySazEElam:integer;
Function PlayBipSazElam:integer;
function GetSazElam:integer;
function ChckSazElam:integer;
Function PlayELam:integer;
function PlayGoodbyElam:integer;
function OnHookElam: integer;

//***************************************HoGoG********
Function PlayEPersCodHogog:integer;
Function PlayBipEPersCodHogog:integer;
function GetEPersCodHogog:integer;
function ChckEPersCodHogog:integer;
function FindPerCod(PerCod:string;var Hogog,Year1,Montt1:string):boolean;
//***********************************************
Function PlayECodKhoon:integer;
Function PlayBipECodKhoon:integer;
function GetECodKhoon:integer;
function ChckECodKhoon:integer;
function FindCod(Cod:string;var Natige:string;var year,Montday,goroh:string):boolean;
//***********************************************
//***********************************************
  Procedure astane;
  Procedure shahrN;
  Procedure pOST;
  Procedure AMOZN;
  Procedure MO_ZIST;
  Procedure MO_Tab;
  Procedure GANBAZ;
  Procedure TAVON;
  Procedure SANAT;
  Procedure KHOON;
//**********************************************
   constructor Build ( Number : integer ) ;
   Destructor Free ;
   procedure Run ; override ;
//**********************************************
end ;
//**************************************************************************
//**************************************************************************
//**************************************************************************
//**************************************************************************
//**************************************************************************
//**************************************************************************
//**************************************************************************
//**************************************************************************
//**************************************************************************
//**************************************************************************
//**************************************************************************
var
  MainForm: TMainForm;
  Line : array [ 0 .. 16 ] of TLine ;
  ActiveChannels : integer ;
  LogOnOf:integer;
  MyThreadNazer:TMyThreadNazer;
implementation

uses TutilFom;
{$R *.DFM}
constructor TMyThreadNazer.Create(Autorun:boolean);
begin
  inherited Create(Autorun);
end;

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//*----------------------------------------------*/
{$INCLUDE Fmasin99.pas}
//*----------------------------------------------*/

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*----------------------------------------------*/
{$INCLUDE Fmashin.pas}
//*----------------------------------------------*/

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*----------------------------------------------*/
{$INCLUDE Fdabir.pas}
//*----------------------------------------------*/
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*----------------------------------------------*/
{$INCLUDE FHogog.pas}
//*----------------------------------------------*/
//*----------------------------------------------*/
{$INCLUDE FElam}
//*----------------------------------------------*/

//*----------------------------------------------*/
{$INCLUDE FKhoon.pas}
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*----------------------------------------------*/
//*----------------------------------------------*/

{$INCLUDE FGreet.pas}
//*----------------------------------------------*/

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
//********************************************
//*----------------------------------------------*/
{$INCLUDE FTree.pas}
//*----------------------------------------------*/

///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
///*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
//********************************************
//*----------------------------------------------*/
{$INCLUDE FAns.pas}
//*----------------------------------------------*/
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


//********************************************
//*----------------------------------------------*/
{$INCLUDE FSup.pas}
//*----------------------------------------------*/
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//********************************************
//********************************************
//*----------------------------------------------*/
{$INCLUDE FSupSaz.pas}
//*----------------------------------------------*/
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//********************************************

//*----------------------------------------------*/
{$INCLUDE FMonsh.pas}
//*----------------------------------------------*/
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//*----------------------------------------------*/
{$INCLUDE FPost.pas}
//*----------------------------------------------*/
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
{$INCLUDE Famozn.pas}
//*----------------------------------------------*/
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
{procedure  TMainForm.MyErrorHandler(ErrorCode: Integer; ErrorAddr: Pointer);
begin
   Line[0].paraLog('error RUN TIME error ErrorCode='+inttostr(ErrorCode),'1',time,0);
   Line[0].logFile2;
end;
}

procedure TMainForm.statusLine(Count:integer);
var  i:integer;
     ss:string;
     color2:TColor;
begin
  i:=Line [ count ].LineStat.V_Line;
 if (i>=1) and (i<=12) then
   color2:=StatusStrFarsiColor[i]
 else    color2:=clRed ;
  Line [ Count ].FStatusLineFarsi.Font.color:=color2;
  Line [ Count ].FStatusLine.Font.color:=color2;
  if (i>=1) and (i<=12) then
   Line [ Count ].FStatusLineFarsi.Caption :=  StatusStrFarsi[i]
  //  Line [ Count ].FStatusLineFarsi.Caption :=  StatusStr[i]
  else Line [ Count ].FStatusLineFarsi.Caption :=  '            ';
  Line [ Count ].FStatusLine.Caption := Line [ Count ].Status_String ;
END;

//++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++

//++++++++++++++++++++++++++++++++++++++++++++
procedure TMainForm.ExitP;
var
  Count : integer ;
begin
  Line [ 0 ].ExitFlag:=true ;
  for Count := 0 to ActiveChannels - 1 do
    begin
        Line [ Count ].ExitFlag:=true ;
        Line [ Count ].Terminate ;
        Line [ Count ].TabelInfo.close;
        Line [ Count ].TabelInfoBox1.close;
        Line [ Count ].TabelMessBox1.close;
        Line [ Count ].TabelInfoBox2.close;
        Line [ Count ].TabelMessBox2.close;
        Line [ Count ].TabelRing.close;
        Line [ Count ].TabelErja.close;
        Line [ Count ].TabelGroup.close;
        Line [ Count ].TabelGroupBox.close;
        //*******~!******************
      if Line [ Count ].DriveSa='POST' then
         Line [  Count  ].TabeCod10.Close;
        //*******~!******************
      if Line [ Count ].DriveSa='GANBAZ' then
         Line [  Count  ].TabeHOGOG.Close;
        //*******~!******************
      if Line [ Count ].DriveSa='AMOZN' then
         Line [  Count  ].TabelBakhsh.Close;
      //***************************
      if Line [ Count ].DriveSa='KHOON' then
         Line [  Count  ].TabeKhoon.Close;

       Line [ Count ].suspend;
      end;
    TabelCountVoic.close;
//    table1.close;
    Terminate_All_Channels;
end;
//*************************************************
//++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++
procedure TMainForm.SpeedButton1Click(Sender: TObject);
var
 LineNumber : integer ;
begin
  if MaskEdit1.Text='09' then
  begin
  if ( Sender as TBitBtn ).Tag <= ActiveChannels - 1 then
  begin
    LineNumber := ( Sender as TBitBtn ).Tag ;
    Line [ LineNumber  ].Local_Exit_Flag := not Line [ LineNumber ].Local_Exit_Flag ;
  end;
  end;
end;
//++++++++++++++++++++++++++++++++++++++++++++
procedure TMainForm.CheckBox1Click(Sender: TObject);
begin

 if CheckBox1.Checked=true then
 begin
//  DBGrid1.DataSource:=DataSource1;
  LogOnOf:=1;
//  DBGrid1.Visible:=true
 end
else
  begin
//    DBGrid1.Visible:=false;
    LogOnOf:=0;
//    DBGrid1.DataSource:=NIL;
  end;
end;
//++++++++++++++++++++++++++++++++++++++++++++
//*----------------------------------------------*/
{$INCLUDE Finipath.pas}
//*----------------------------------------------*/

procedure TMainForm.FormCreate(Sender: TObject);
var
  I         : integer  ;
begin
//  ErrorProc :=@MyErrorHandler;
flaglockchek:=0;

TabletELOP.open;
TabletELOP.FIRST;
MainForm.recno:=TabletELOP.FieldByName('Id').asinteger;
TabletELOP.close;

THold.open;
THold.FIRST;
MainForm.recnoHold:=THold.FieldByName('Id').asinteger;
THold.close;

//if flaglockchek=1 then
// if SysHardLock1.CheckLock = false then
//  exit
//else ;


  ActiveChannels := 0 ;
  for i := 0 to 10{MAX_CHANNEL - 1} do
     if Channel_Ready ( i ) then
       inc ( ActiveChannels ) ;

TPath.open;
LogOnOf:=0;
FlagShutDownElam:=false;
FlagLockCountVoice:=true;
FlagLockMessBox:=true;
FlagLockErja:=true;
FlagLockRing:=true;
FlaglinfoBox:=true;
FlaglinfoTree:=true;
FlagLocklogfile:=true;
FlagLockOpAct:=true;
FlagLockElam:=true;
FlagLockHold:=true;
FlagStartSystem:=true;//Lock start system
FlagLockCountVoiceRFC:=true;
//**********~!**************
FlagLockTabeCod10:=true;
FlagLockTabeHogog:=true;
FlagLockTabeKhoon:=true;
FlagLockTabeDabir:=true;
FlagLockTabePishCod10:=true;
//**********~!**************
FlagLockTabeBakhsh:=true;
//************************
TabelCountVoic:=TTable.Create(MainForm);
TabelCountVoic.Databasename:=TPathDriveInstall.asstring+'SYSDB\DbBox\';
TabelCountVoic.tablename:='ContVoic.db';
//****************************
TabelRengDate.Databasename:=TPathDriveInstall.asstring+'SYSDB\DbBox\';
TabelRengDate.open;
       R_Year1:=TabelRengDateYear1.AsInteger;
       R_Month1:=TabelRengDateMont1.asinteger;
       R_Day1:=TabelRengDateDay1.asinteger;
       R_Year2:=TabelRengDateYear2.asinteger;
       R_Month2:=TabelRengDateMont2.asinteger;
       R_Day2:=TabelRengDateDay2.asinteger;
       R_Hour1:=TabelRengDateHour1.asinteger;
       R_Min1:=TabelRengDateMin1.asinteger;
       R_Hour2:=TabelRengDateHour2.asinteger;
       R_Min2:=TabelRengDateMin2.asinteger;
TabelRengDate.close;

//****************************
TabelElam.Databasename:=TPathDriveInstall.asstring+'SYSDB\DbBox\';
//TabelElam.open;
//FlagLockElam:=true;



  for i := 0 to ActiveChannels - 1 do
     begin

     Line [ i ] := TLine.Build ( I ) ;
     Line [ i ].PathINi;

     Line [ i ].SelectNoBox:=1;
     Line [ i ].TabelLog:=TTable.Create(MainForm);
//     Line [ i ].TabelLog.Databasename:=DriveLog;
     Line [ i ].TabelLog.Databasename:=Line [ i ].DriveSYSDBBox;
     Line [ i ].TabelLog.tablename:='logfile.db';
//------------------------------------
     Line [ i ].TabelTelop:=TTable.Create(MainForm);
//     Line [ i ].TabelTelop.Databasename:=Line [ i ].DriveSYSDBBox;
     Line [ i ].TabelTelop.tablename:='TelOp.db';

     Line [ i ].THold:=TTable.Create(MainForm);
//     Line [ i ].TabelTelop.Databasename:=Line [ i ].DriveSYSDBBox;
     Line [ i ].THold.tablename:='Hold.db';

//------------------------------------
    if Line [ i ].VflagDabir =1 then
     begin
     Line [ i ].TabelDabir:=TTable.Create(MainForm);
     Line [ i ].TabelDabir.Databasename:=Line [ i ].DriveDbirkhane;
     Line [ i ].TabelDabir.tablename:='Dabir.db';
     end;
       Line [ i ].TabelInfo:=TTable.Create(MainForm);
       Line [ i ].TabelInfo.Databasename:=Line [ i ].DriveDBInfo;
       Line [ i ].TabelInfo.tablename:='Inform.db';
       Line [ i ].TabelInfo.open;
       Line [ i ].PointCurrentNod:=1;
       Line [ i ].DriveInfo:=Line [ i ].DriveInfo;
//**********************************************

//**********************************************
       Line [ i ].TabelInfoBox1:=TTable.Create(MainForm);
       Line [ i ].TabelInfoBox1.Databasename:=Line [ i ].DriveSYSDBBox;
       Line [ i ].TabelInfoBox1.tablename:='infobox.db';
       Line [ i ].TabelInfoBox1.open;
//**********************************************
       Line [ i ].TabelInfoBox2:=TTable.Create(MainForm);
       Line [ i ].TabelInfoBox2.Databasename:=Line [ i ].DriveSYSDBBox;
       Line [ i ].TabelInfoBox2.tablename:='infobox.db';
       Line [ i ].TabelInfoBox2.open;
//**********************************************
       Line [ i ].TabelMessBox1:=TTable.Create(MainForm);
       Line [ i ].TabelMessBox1.Databasename:=Line [ i ].DriveSYSDBBox;
       Line [ i ].TabelMessBox1.tablename:='messbox.db';
       Line [ i ].TabelMessBox1.open;
//**********************************************
       Line [ i ].TabelMessBox2:=TTable.Create(MainForm);
       Line [ i ].TabelMessBox2.Databasename:=Line [ i ].DriveSYSDBBox;
       Line [ i ].TabelMessBox2.tablename:='messbox.db';
       Line [ i ].TabelMessBox2.open;
//**********************************************
       Line [ i ].TabelRing:=TTable.Create(MainForm);
       Line [ i ].TabelRing.Databasename:=Line [ i ].DriveSYSDBBox;
       Line [ i ].TabelRing.tablename:='ring.db';
       Line [ i ].TabelRing.open;
//**********************************************
       Line [ i ].TabelErja:=TTable.Create(MainForm);
       Line [ i ].TabelErja.Databasename:=Line [ i ].DriveSYSDBBox;
       Line [ i ].TabelErja.tablename:='messrow.db';
       Line [ i ].TabelErja.open;

//**********************************************
       Line [ i ].TabelGroup:=TTable.Create(MainForm);
       Line [ i ].TabelGroup.Databasename:=Line [ i ].DriveSYSDBBox;
       Line [ i ].TabelGroup.tablename:='group.db';
       Line [ i ].TabelGroup.open;

//**********************************************
       Line [ i ].TabelGroupBox:=TTable.Create(MainForm);
       Line [ i ].TabelGroupBox.Databasename:=Line [ i ].DriveSYSDBBox;
       Line [ i ].TabelGroupBox.tablename:='groupbox.db';
       Line [ i ].TabelGroupBox.open;

//**************~!**************
    if Line [ i ].DriveSa='POST' then
    begin
       Line [ i ].TabeCod10:=TTable.Create(MainForm);
       Line [ i ].TabeCod10.Databasename:=Line [ i ].DriveDb+'cod10\';
       Line [ i ].TabeCod10.IndexName:='TEL';
       Line [ i ].TabeCod10.tablename:='tel.dbf';
       Line [ i ].TabeCod10.open;
//**************~!**************
       Line [ i ].TabePishCod10:=TTable.Create(MainForm);
       Line [ i ].TabePishCod10.Databasename:=Line [ i ].DriveDb+'cod10\';
    end;
//**************~!**************
    if Line [ i ].DriveSa='GANBAZ' then
    begin
       Line [ i ].TabeHogog:=TTable.Create(MainForm);
       Line [ i ].TabeHogog.Databasename:=Line [ i ].DriveDb;
//       Line [ i ].TabeHogog.IndexName:='TEL';
       Line [ i ].TabeHogog.tablename:='MOSTAMAR.DBF';
       Line [ i ].TabeHogog.open;
    end;
//**************~!**************
    if Line [ i ].DriveSa='KHOON' then
    begin
       Line [ i ].TabeKhoon:=TTable.Create(MainForm);
//       Line [ i ].TabeKhoon.Databasename:=Line [ i ].DriveDb;
       Line [ i ].TabeKhoon.Databasename:=Line [ i ].DriveSYSDBBox;
//       Line [ i ].TabeHogog.IndexName:='TEL';
       Line [ i ].TabeKhoon.tablename:='Khoon.DB';
       Line [ i ].TabeKhoon.open;
    end;
//**************~!**************
//    if Line [ i ].DriveSa='AMOZN' then
//    begin
       Line [ i ].TabelBakhsh:=TTable.Create(MainForm);
       Line [ i ].TabelBakhsh.Databasename:=Line [ i ].DriveSYSDBBox;
       Line [ i ].TabelBakhsh.tablename:='bakhsh.db';
       Line [ i ].TabelBakhsh.open;
//    end;
       //**********************************************
       Line [ i ].LineStat.State:=0;
       Line [ i ].TypeRingUsed:=1;
       Line [ i ].LineStat.LastState:=0;
       Line [ i ].LineStat.StartTime:=time;
       DecodeTime(Line[ i ].LineStat.StartTime,Line[i].LineStat.Hour,Line[i].LineStat.Min,Line[i].LineStat.Sec, Line[i].LineStat.MSec);
       Line [ i ].LineStat.EndEventTime:=time;
       DecodeTime(Line[i].LineStat.EndEventTime,Line[i].LineStat.Ev_Hour,Line[i].LineStat.Ev_Min,Line[i].LineStat.Ev_Sec,Line[i].LineStat.Ev_MSec);
       Line [ i ].LineStat.V_Line:=0;
       Line [ i ].LineStat.pfhandle:=0;
       Line [ i ].LineStat.State:=0;
       Line [ i ].ExitFlag:=false;
     end ;

LogOnOf:=0;
FlagLockCountVoice:=false;
FlagLockMessBox:=false;
FlagLockErja:=false;
FlagLockRing:=false;
FlaglinfoBox:=false;
FlaglinfoTree:=false;
FlagLocklogfile:=false;
FlagLockOpAct:=false;
FlagLockElam:=false;
FlagLockHold:=false;
FlagStartSystem:=false; //UnLock start system
FlagLockCountVoiceRFC:=false;
//**********~!**************
FlagLockTabeCod10:=false;
FlagLockTabePishCod10:=false;
//**********~!**************
FlagLockTabeDabir:=false;
//**********~!**************
FlagLockTabeBakhsh:=false;
//***************************
FlagLockTabeHogog:=false;
FlagLockTabeKhoon:=false;
//  table1.Databasename:=DriveLog;
//  table1.tablename:='logfile.db';
//  table1.open;

    for i:=0 to MainForm.ComponentCount-1 do
    begin
     if (MainForm.Components[i] is TStaticText ) then
      begin
        if MainForm.Components[i].tag <= ActiveChannels - 1 then
        Line[MainForm.Components[i].tag].FStatusLine := (MainForm.Components[i] as TStaticText);
      end;
   //*****************
      if (MainForm.Components[i] is TLabel ) then
      begin
        if MainForm.Components[i].tag <= ActiveChannels - 1 then
        Line[MainForm.Components[i].tag].FStatusLineFarsi := (MainForm.Components[i] as TLabel);
      end;
    end;


  MyThreadNazer:= TMyThreadNazer.Build();

TPath.close;

end ;



procedure TMainForm.FormShow(Sender: TObject);
begin
//if flaglockchek=1 then
// if SysHardLock1.CheckLock = false then
// MainForm.close
//else ;
end;

procedure TMainForm.BitBtn20Click(Sender: TObject);
begin
while MainForm.FlagLockOpAct do ;
MainForm.FlagLockOpAct:=True;
TabletELOP.ApplyUpdates;
TabletELOP.refresh;
TabletELOP.close;
Panel4.Visible:=false;
MainForm.FlagLockOpAct:=false;
end;

procedure TMainForm.TabletELOPAfterInsert(DataSet: TDataSet);
begin
TabletELOP.Cancel;
end;

procedure TMainForm.N3Click(Sender: TObject);
begin
Panel4.Visible:=true;
TabletELOP.open;
end;

procedure TMainForm.N4Click(Sender: TObject);
var i:integer;
begin
  if MaskEdit1.Text='09' then
  begin
    for i:=0 to ActiveChannels-1 do
      Line [ i].Local_Exit_Flag := not Line [ i].Local_Exit_Flag ;
    sleep(1000);
    for i:=0 to ActiveChannels-1 do
     Line [ i].Local_Exit_Flag := not Line [ i].Local_Exit_Flag ;
  end;
end;

procedure TMainForm.N5Click(Sender: TObject);
begin
  if MaskEdit1.Text='09' then
  begin
  TutilForm := TTutilForm.Create(Application);
  TutilForm.showmodal;
  TutilForm.Hide;
  TutilForm.Free;
  end;
end;

procedure TMainForm.N6Click(Sender: TObject);
begin

 if N6.Checked=true then
  N6.Checked:=false
else  N6.Checked:=true;

 if N6.Checked=true then
  Panel3.Visible:=true
else  Panel3.Visible:=false;

end;

procedure TMainForm.THOLDAfterInsert(DataSet: TDataSet);
begin
THold.Cancel;
end;

procedure TMainForm.BitBtn21Click(Sender: TObject);
begin
while MainForm.FlagLockHold do ;
MainForm.FlagLockHold:=True;
THold.ApplyUpdates;
THold.refresh;
THold.close;
Panel5.Visible:=false;
MainForm.FlagLockHold:=false;

end;

procedure TMainForm.N2Click(Sender: TObject);
begin
Panel5.Visible:=true;
THold.open;
end;

procedure TMainForm.N7Click(Sender: TObject);
var
  Count : integer ;
begin
  if MaskEdit1.Text='09' then
  begin
   Line [ 0 ].ExitFlag:=true ;
  MyThreadNazer.Terminate ;
  MyThreadNazer.suspend;
  MyThreadNazer.Destroy;
  for Count := 0 to ActiveChannels - 1 do
    begin
        Line [ Count ].ExitFlag:=true ;
        Line [ Count ].Terminate ;
        Line [ Count ].TabelInfo.close;
        Line [ Count ].TabelInfoBox1.close;
        Line [ Count ].TabelMessBox1.close;
        Line [ Count ].TabelInfoBox2.close;
        Line [ Count ].TabelMessBox2.close;
        Line [ Count ].TabelRing.close;
        Line [ Count ].TabelErja.close;
        Line [ Count ].TabelGroup.close;
        Line [ Count ].TabelGroupBox.close;
        //*******~!******************
      if Line [ Count ].DriveSa='POST' then
         Line [  Count  ].TabeCod10.Close;
        //*******~!******************
      if Line [ Count ].DriveSa='GANBAZ' then
         Line [  Count  ].TabeHogog.Close;
       //*******~!******************
      if Line [ Count ].DriveSa='AMOZN' then
         Line [  Count  ].TabelBakhsh.Close;
        //*******~!******************
      if Line [ Count ].DriveSa='KHOON' then
         Line [  Count  ].TabeKhoon.Close;

       Line [ Count ].suspend;
      //      Line [ Count ].Destroy;
      end;

    TabelCountVoic.close;

    Terminate_All_Channels;
 CLOSE;
end;
end;
procedure TMainForm.CheckBox2Click(Sender: TObject);
var i:integer;
begin
   if CheckBox2.Checked=false then
   for i:=0 to ActiveChannels-1 do
   Line [ i ].FStatusLineFarsi.Caption :=  '';

end;

end.


