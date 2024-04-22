program voice;

uses
  Forms,
  UMain in 'uMain.pas' {MainForm},
  splashu in 'splashu.pas' {Splash},
  TutilFom in 'TutilFom.pas' {TutilForm};

{$R *.RES}

begin                                     
  Application.Initialize;
  Splash := TSplash.Create(Application);
  TutilForm := TTutilForm.Create(Application);
  Splash.Show;
  TutilForm.show;
  TutilForm.Repaint;
  TutilForm.RebuildAll;
  TutilForm.Close;
  TutilForm.Hide;
  TutilForm.Free;

  Splash.Repaint;
  Application.CreateForm(TMainForm, MainForm);
  Splash.Hide;
  Splash.Free;
  Application.Run;
end.
