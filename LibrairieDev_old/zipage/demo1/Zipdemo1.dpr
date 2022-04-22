program zipdemo1;

uses
  Forms,
  mainunit in 'mainunit.pas' {Mainform},
  msgunit in 'msgunit.pas' {Msgform},
  extrunit in 'extrunit.pas' {Extract},
  Addunit in 'Addunit.pas' {AddForm},
  sfxunit in 'sfxunit.pas' {MakeSFX};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Zip Demo 1';
  Application.CreateForm(TMainform, Mainform);
  Application.CreateForm(TMsgform, Msgform);
  Application.CreateForm(TExtract, Extract);
  Application.CreateForm(TAddForm, AddForm);
  Application.CreateForm(TMakeSFX, MakeSFX);
  Application.Run;
end.
