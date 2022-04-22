program MDCogere;

uses
  Forms,
  SysUtils,
  DBTables,
  Unit1 in 'Unit1.pas' {Restauration},
  DiversProjets in '..\..\..\LibrairieDev\Delphi\LibEpi\DiversProjets.pas',
  ImportDll in '..\..\..\LibrairieDev\Delphi\DLL\ImportDll.pas' {/,Decl_record in 'Decl_record.pas'
},
  RechercheRepDest in 'RechercheRepDest.pas',
  ZipMstr in 'ZipMstr.pas',
  LibDates in '..\..\..\LibrairieDev\Delphi\LibEpi\LibDates.pas',

ShellCtrls in '..\..\..\Program Files (x86)\Borland\Delphi7\Demos\ShellControls\ShellCtrls.pas';

var
 sDirEXE: string;

{$R *.res}


begin
  Application.Initialize;
  Application.Title := 'Restauration Epicéa ';

  sDirEXE := ExtractFileDir(Application.ExeName);
  Session.NetFiledir:=sDirEXE;

  Application.CreateForm(TRestauration, Restauration);
  //Application.CreateForm(TFormChoixRepDest, FormChoixRepDest);
  Restauration.ParamEnLigne:=ParamEnLigneLec(1);
  Application.Run;


end.
