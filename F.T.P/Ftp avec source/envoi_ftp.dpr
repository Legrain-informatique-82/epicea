program envoi_ftp;

uses
  Forms,
  ftp in 'ftp.pas' {Form1},
  UDMFtp in 'UDMFtp.pas' {DMFtp: TDataModule},
  LibFichRep in 'LibFichRep.pas',
  RechercheRep in 'RechercheRep.pas' {FormChoixRepSource},
  RechercheRepDest in 'RechercheRepDest.pas' {FormChoixRepDest},
  Aide in 'Aide.pas' {FormAide},
  DiversProjets in '..\..\..\LibrairieDev\Delphi\LibEpi\DiversProjets.pas',
  ShellCtrls in '..\..\..\Program Files (x86)\Borland\Delphi7\Demos\ShellControls\ShellCtrls.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'FTP';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
