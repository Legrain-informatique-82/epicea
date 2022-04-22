unit ReindexationTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RXCtrls, ExtCtrls,
  E2_Librairie_Obj,
  dbiprocs,dbitypes,dbierrs,
  DMConstantes,
  lib_chaine,
  Menus, jpeg,
  DBTables,
  Gr_Librairie_Obj,
  LibGestionParamXML;





type
  TParamAffichageReindexation = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   TitreForm:String;
   SousTitreForm:String;
   SelectionListeTable:Tstringlist;
   dbProgram:TDataBase;
   dbDossier:TDataBase;
   dbExo:TDataBase;
   end;

   
  TReindexationTables = class(TForm)
    Panel10: TPanel;
    PaBtn: TPanel;
    BtnFermer: TButton;
    BtnAnnuler: TButton;
    PaBas: TPanel;
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    Valider1: TMenuItem;
    PaExercice: TPanel;
    RSExerciceTous: TRxSpeedButton;
    RSExerciceAucun: TRxSpeedButton;
    RSExerciceInverse: TRxSpeedButton;
    Panel6: TPanel;
    ChLBExercice: TRxCheckListBox;
    PaDossier: TPanel;
    PaProgram: TPanel;
    RSDossierTous: TRxSpeedButton;
    RSDossierAucun: TRxSpeedButton;
    RSDossierInverse: TRxSpeedButton;
    Panel8: TPanel;
    ChLBDossier: TRxCheckListBox;
    RSProgramTous: TRxSpeedButton;
    RSProgramAucun: TRxSpeedButton;
    RSProgramInverse: TRxSpeedButton;
    Panel1: TPanel;
    ChLBProgram: TRxCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure etatinitial;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RSExerciceTousClick(Sender: TObject);
    procedure RSExerciceAucunClick(Sender: TObject);
    procedure RSExerciceInverseClick(Sender: TObject);
    procedure RSDossierTousClick(Sender: TObject);
    procedure RSProgramTousClick(Sender: TObject);
    procedure RSDossierAucunClick(Sender: TObject);
    procedure RSProgramAucunClick(Sender: TObject);
    procedure RSDossierInverseClick(Sender: TObject);
    procedure RSProgramInverseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure initialiseListeSelection(itemsSelection:integer=-1);
    procedure ChLBExerciceClickCheck(Sender: TObject);
    procedure ChLBDossierClickCheck(Sender: TObject);
    procedure ChLBProgramClickCheck(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
        TitreForm,SousTitreForm:String;
        SelectionListeTable:Tstringlist;
   dbProgram:TDataBase;
   dbDossier:TDataBase;
   dbExo:TDataBase;

  end;

var
  ReindexationTables: TReindexationTables;

  Function CheckBoxCheckedAll(RxCheckListBox:TRxCheckListBox;SurSelection:boolean=false):boolean;
  Function CheckBoxdeCheckedAll(RxCheckListBox:TRxCheckListBox):boolean;
  Function CheckBoxInverseCheck(RxCheckListBox:TRxCheckListBox):boolean;
  function ReindexationTableAffiche(ParamAffichageReindexation:TParamAffichageReindexation):Texceptlgr;
                                      //()
implementation

uses DMCorrection, LibClassObjetSenders;

{$R *.dfm}
function ReindexationTableAffiche(ParamAffichageReindexation:TParamAffichageReindexation):Texceptlgr;
var
ParamDMcorrections:TParamDMcorrections;
Begin
 if (ReindexationTables = nil) then ReindexationTables:=TReindexationTables.Create(Application.MainForm);
 if not empty(ParamAffichageReindexation.TitreForm) then
   ReindexationTables.TitreForm:=ParamAffichageReindexation.TitreForm;
 ReindexationTables.SousTitreForm:=ParamAffichageReindexation.SousTitreForm;
 ParamDMcorrections.GEstInterfaceEvent := LibClassObjetSender.GEstInterfaceEvent;
 ReindexationTables.SelectionListeTable:=ParamAffichageReindexation.SelectionListeTable;

              ReindexationTables.dbProgram:=ParamAffichageReindexation.dbProgram;
              ReindexationTables.dbDossier:=ParamAffichageReindexation.dbDossier;
              ReindexationTables.dbExo:=ParamAffichageReindexation.dbExo;

 InitialiseDMcorrections(ParamDMcorrections);

ReindexationTables.etatinitial;

 if ParamAffichageReindexation.Affiche then
  begin
     result.retour:=ReindexationTables.ShowModal=mrOk;
  end;
end;


Function CheckBoxCheckedAll(RxCheckListBox:TRxCheckListBox;SurSelection:boolean):boolean;
var
i:integer;
Begin
result:=true;
try
  for i:=0 to RxCheckListBox.Items.Count - 1 do
   begin
    RxCheckListBox.Checked[i]:=true;
   end;
except
 showmessage('Erreur sur : CheckBoxCheckedAll');
 result:=false;
end;
End;

Function CheckBoxdeCheckedAll(RxCheckListBox:TRxCheckListBox):boolean;
var
i:integer;
Begin
result:=true;
try
  for i:=0 to RxCheckListBox.Items.Count - 1 do
   begin
    RxCheckListBox.Checked[i]:=False;
   end;
except
 showmessage('Erreur sur : CheckBoxdeCheckedAll');
 result:=false;
end;
End;

Function CheckBoxInverseCheck(RxCheckListBox:TRxCheckListBox):boolean;
var
i:integer;
Begin
result:=true;
try
  for i:=0 to RxCheckListBox.Items.Count - 1 do
   begin
    RxCheckListBox.Checked[i]:=not RxCheckListBox.Checked[i];
   end;
except
 showmessage('Erreur sur : CheckBoxInverseCheck');
 result:=false;
end;

End;

procedure TReindexationTables.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TReindexationTables.FormDestroy(Sender: TObject);
begin
  LibGestionParamXML.DestroyForm(Self,E.USer);
  LibereObjet(Tobject(SelectionListeTable),Self);
  ReindexationTables:=nil;
end;

procedure TReindexationTables.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
//etatinitial;
canclose:=true;
end;


procedure TReindexationTables.etatinitial;
var
DatabaseName,TableName,Cocher:string;
MyStringList:TStringList;
i:integer;
Begin
ChLBProgram.Items.Clear;
ChLBDossier.Items.Clear;
ChLBExercice.Items.Clear;

 if SelectionListeTable=nil then
     SelectionListeTable:=TStringList.Create;
 for i:=0 to SelectionListeTable.count-1 do
   begin
      DatabaseName:=str_getstringelement(SelectionListeTable.Strings[i],1,';');
      TableName:=str_getstringelement(SelectionListeTable.Strings[i],2,';');
      Cocher:=str_getstringelement(SelectionListeTable.Strings[i],3,';');
      if AnsiCompareStr(databasename,DM_C_NomAliasProgram)=0 then
        begin
           if not PaProgram.Visible then PaProgram.Visible:=true;
           ChLBProgram.Items.Add(tableName);
        end
      else
      if AnsiCompareStr(databasename,DM_C_NomAliasDossier)=0 then
        begin
           if not PaDossier.Visible then PaDossier.Visible:=true;
           ChLBDossier.Items.Add(tableName);
        end
      else
      if AnsiCompareStr(databasename,DM_C_NomAliasExercice)=0 then
        begin
           if not PaExercice.Visible then PaExercice.Visible:=true;
           ChLBExercice.Items.Add(tableName);
        end;
   end;
EnableWinControl([ChLBProgram,TWinControl(RSProgramTous),TWinControl(RSProgramAucun),TWinControl(RSProgramInverse)],ChLBProgram.Items.Count<>0);
EnableWinControl([ChLBDossier,TWinControl(RSDossierTous),TWinControl(RSDossierAucun),TWinControl(RSDossierInverse)],ChLBDossier.Items.Count<>0);
EnableWinControl([ChLBExercice,TWinControl(RSExerciceTous),TWinControl(RSExerciceAucun),TWinControl(RSExerciceInverse)],ChLBExercice.Items.Count<>0);

CheckBoxCheckedAll(ChLBProgram);
CheckBoxCheckedAll(ChLBDossier);
CheckBoxCheckedAll(ChLBExercice);
initialiseListeSelection;
End;


procedure TReindexationTables.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If Key = VK_ESCAPE Then
   Begin
      close;
   end;
end;

procedure TReindexationTables.RSExerciceTousClick(Sender: TObject);
begin
CheckBoxCheckedAll(ChLBExercice);
initialiseListeSelection;
end;

procedure TReindexationTables.RSExerciceAucunClick(Sender: TObject);
begin
CheckBoxdeCheckedAll(ChLBExercice);
initialiseListeSelection;
end;

procedure TReindexationTables.RSExerciceInverseClick(Sender: TObject);
begin
CheckBoxInverseCheck(ChLBExercice);
initialiseListeSelection;
end;

procedure TReindexationTables.RSDossierTousClick(Sender: TObject);
begin
CheckBoxCheckedAll(ChLBDossier);
initialiseListeSelection;
end;

procedure TReindexationTables.RSProgramTousClick(Sender: TObject);
begin
CheckBoxCheckedAll(ChLBProgram);
initialiseListeSelection;
end;

procedure TReindexationTables.RSDossierAucunClick(Sender: TObject);
begin
CheckBoxdeCheckedAll(ChLBDossier);
initialiseListeSelection;
end;

procedure TReindexationTables.RSProgramAucunClick(Sender: TObject);
begin
CheckBoxdeCheckedAll(ChLBProgram);
initialiseListeSelection;
end;

procedure TReindexationTables.RSDossierInverseClick(Sender: TObject);
begin
CheckBoxInverseCheck(ChLBDossier);
initialiseListeSelection;
end;

procedure TReindexationTables.RSProgramInverseClick(Sender: TObject);
begin
CheckBoxInverseCheck(ChLBProgram);
initialiseListeSelection;
end;




procedure TReindexationTables.Button1Click(Sender: TObject);
begin
modalresult:=mrOk;
end;


procedure TReindexationTables.initialiseListeSelection(itemsSelection:integer);
var
rang,i,Debut,Fin:integer;
Cocher,DatabaseName,TableName:string;
begin
Debut:=0;
Fin:=SelectionListeTable.count-1;
if itemsSelection<>-1 then
  begin //si items<>-1, on travail sur une table particuli�re
    Debut:=itemsSelection;
    Fin:=itemsSelection;
  end;//fin si items<>-1, on travail sur une table particuli�re
 for i:=debut to fin do
   begin
      DatabaseName:=str_getstringelement(SelectionListeTable.Strings[i],1,';');
      TableName:=str_getstringelement(SelectionListeTable.Strings[i],2,';');
      Cocher:=str_getstringelement(SelectionListeTable.Strings[i],3,';');
      if AnsiCompareStr(databasename,DM_C_NomAliasProgram)=0 then
        begin
           rang:=ChLBProgram.Items.IndexOf(tablename);
           if rang<>-1 then
             begin
               Cocher:=str_bool2str_LGR(ChLBProgram.Checked[rang],'1','0');
               SelectionListeTable.Strings[i]:=str_Setstringelement(SelectionListeTable.Strings[i],3,';',cocher);
             end;
        end
      else
      if AnsiCompareStr(databasename,DM_C_NomAliasDossier)=0 then
        begin
           rang:=ChLBDossier.Items.IndexOf(tablename);
           if rang<>-1 then
             begin
               Cocher:=str_bool2str_LGR(ChLBDossier.Checked[rang],'1','0');
               SelectionListeTable.Strings[i]:=str_Setstringelement(SelectionListeTable.Strings[i],3,';',cocher);
             end;
        end
      else
      if AnsiCompareStr(databasename,DM_C_NomAliasExercice)=0 then
        begin
           rang:=ChLBExercice.Items.IndexOf(tablename);
           if rang<>-1 then
             begin
               Cocher:=str_bool2str_LGR(ChLBExercice.Checked[rang],'1','0');
               SelectionListeTable.Strings[i]:=str_Setstringelement(SelectionListeTable.Strings[i],3,';',cocher);
             end;
        end;
   end;//fin du for
end;

procedure TReindexationTables.ChLBExerciceClickCheck(Sender: TObject);
begin
initialiseListeSelection(ChLBExercice.ItemIndex);
end;

procedure TReindexationTables.ChLBDossierClickCheck(Sender: TObject);
begin
initialiseListeSelection(ChLBDossier.ItemIndex);
end;

procedure TReindexationTables.ChLBProgramClickCheck(Sender: TObject);
begin
initialiseListeSelection(ChLBProgram.ItemIndex);
end;

end.