program ViewZip;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  InstUnit in 'InstUnit.pas' {InstForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
