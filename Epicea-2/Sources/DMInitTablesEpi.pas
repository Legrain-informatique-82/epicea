unit DMInitTablesEpi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables,E2_InitTAbleEpi,DMBaseDonnee;

type
  TDMInitTableEpi = class(TDataModule)
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMInitTableEpi: TDMInitTableEpi;

    Function InitDataBase(dbProgram,dbDossier,dbExo:TDataBase;Affiche:Boolean):boolean;
implementation

{$R *.DFM}

Function InitDataBase(dbProgram,dbDossier,dbExo:TDataBase;Affiche:Boolean):boolean;
var
MyStringList:TStringList;
i:integer;
Begin
     if DMInitTableEpi = nil then
         DMInitTableEpi:=TDMInitTableEpi.Create(Application.MainForm);
     if InitTableEpi = nil then
         InitTableEpi:=TInitTableEpi.Create(Application.MainForm);

     with DMInitTableEpi do
      Begin
        MyStringList := TStringList.Create;
        try
          InitTableEpi.dbProgramme:=dbProgram;
          InitTableEpi.dbDossier:=dbDossier;
          InitTableEpi.dbExercice:=dbExo;

          // Programme
          Session.GetTableNames(dbProgram.DatabaseName, '*.db',True, False, MyStringList);
          InitTableEpi.CheckListBox1.Items := MyStringList;
          MyStringList.Clear;
          for i:=0 to  InitTableEpi.CheckListBox1.Items.Count - 1 do
          InitTableEpi.ListBox1.Items.Add(Inttostr(IndexTableEpicea(InitTableEpi.CheckListBox1.Items[i])));

          // Dossier
          Session.GetTableNames(dbDossier.DatabaseName, '*.db',true, False, MyStringList);
          InitTableEpi.CheckListBox2.Items := MyStringList;
          MyStringList.Clear;

          // Exercice
          Session.GetTableNames(dbExo.DatabaseName, '*.db',true, False, MyStringList);
          InitTableEpi.CheckListBox3.Items := MyStringList;
          MyStringList.Clear;
        finally
         if Affiche then InitTableEpi.Show;
          MyStringList.Free;
        end;
//      dbProgram.DataSetCount
//       DbInitProgram.DatabaseName:=dbProgram.DatabaseName;
//       DbInitDossier.DatabaseName:=dbProgram.DatabaseName;
//       dbInitExo
      End;

End;

end.
