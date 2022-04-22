program RestaureLGR;

uses
  Forms,
  SysUtils,
  dbTables,
  RestD3 in 'RestD3.pas' {Rest},
  R2_ListeFic in 'R2_ListeFic.pas' {ListeVLE},
  DialogEx in 'DialogEx.pas';
//
//var
// sDirEXE: string;
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TRest, Rest);
  Application.CreateForm(TListeVLE, ListeVLE);
  Application.Run;

//
//  sDirEXE := ExtractFileDir(Application.ExeName);
//  Session.NetFiledir:=sDirEXE;
end.
