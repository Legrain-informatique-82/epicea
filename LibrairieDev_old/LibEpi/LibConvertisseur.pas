unit LibConvertisseur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, CurrEdit, ExtCtrls,Gr_Librairie_Obj,
  dbgrids,
  Lib_Chaine,
  db,E2_Librairie_Obj,LibGestionParamXML, DMConstantes;

type
  TRetConvertisseur=record
   retour:boolean;
   ValeurDevise:Currency;
   NomDevise:string;
   ValeurCourante:Currency;
   MonnaieCourante:string;
   TauxDevise:currency;
   end;

  TConvertisseur = class(TForm)
    Panel1: TPanel;
    LaMonnaieEnCours: TLabel;
    Label1: TLabel;
    CurrencyEdit1: TCurrencyEdit;
    CurrencyEdit2: TCurrencyEdit;
    procedure CurrencyEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }

   NomDevise:string;
   TauxDevise:real;
   SigleDevise:char;
   ValeurCourante:Currency;
   MonnaieCourante:string;
  end;

var
  Convertisseur: TConvertisseur;

  Function Convertis:TRetConvertisseur;
  Procedure InitConvertisseur(NomDevise:string;TauxDevise:real;SigleDevise:char;ValeurCourante:Currency;MonnaieCourante:string);


implementation

{$R *.DFM}

Procedure InitConvertisseur(NomDevise:string;TauxDevise:real;SigleDevise:char;ValeurCourante:Currency;MonnaieCourante:string);
Begin
if Convertisseur = nil then Convertisseur:=TConvertisseur.Create(application.mainForm);
   Convertisseur.NomDevise:=NomDevise;
   Convertisseur.TauxDevise:=TauxDevise;
   Convertisseur.SigleDevise:=SigleDevise;
   Convertisseur.ValeurCourante:=ValeurCourante;
   Convertisseur.MonnaieCourante:=MonnaieCourante;
End;


Function Convertis:TRetConvertisseur;
var
Valeur:string;
ValeurC:Currency;
LastControl:TWincontrol;
LastForm:TCustomForm;
begin
if Convertisseur = nil then
    begin
     Convertisseur:=TConvertisseur.Create(application.mainForm);
     Application.MessageBox('Convertisseur Devise non initialisé','Attention',mb_OK); 
    end;
if (Screen.ActiveControl <> nil) then LastControl:=Screen.ActiveControl;
if (Screen.ActiveForm <> nil) then LastForm:=Screen.ActiveForm;
if not Convertisseur.Visible then
 begin
   if Convertisseur.Tag=0 then Convertisseur.Show;
   LastForm.SetFocus;
 end;
if ((Screen.ActiveControl <> nil) and (Screen.ActiveForm <> Convertisseur)) then
 Begin
    case RecupClassTypeComponent(Tcontrol(Screen.ActiveControl))of
      GTEdit:begin
             Try
              Valeur:=QueDesChiffres(TCustomEdit(Tcontrol(Screen.ActiveControl)).Text);
              if Valeur <> '' then
               begin
                  try
                   ValeurC:=StrToCurr_lgr(Valeur);
                   Convertisseur.CurrencyEdit1.Value:=ValeurC;
                   Convertisseur.CurrencyEdit2.Value:=ValeurC * Convertisseur.TauxDevise;
                  except
                   Convertisseur.CurrencyEdit1.Value:=0;
                   Convertisseur.CurrencyEdit2.Value:=0;
                  end;
               end;
              except;
              Convertisseur.CurrencyEdit1.Value:=0;
              Convertisseur.CurrencyEdit2.Value:=0;
              end;
              end;
//      GTGrGrid:with TGrgrid(Control) do Recherche(Cells[Col, Row]);
//      GTStringGrid: with TStringGrid(Control) do Recherche(Cells[Col, Row]);
        GTGrDBGrid:begin
                 Convertisseur.CurrencyEdit1.Value:=0;
                 result.ValeurCourante:=0;
                 result.ValeurDevise:=0;
                 if TCustomdbgrid(Tcontrol(Screen.ActiveControl)).SelectedField.DataType in [ftInteger,ftWord,ftFloat,ftCurrency] then
                 try
                 Valeur:=QueDesChiffres(TCustomdbgrid(Tcontrol(Screen.ActiveControl)).SelectedField.AsString);
              if Valeur <> '' then
               begin
                  try
                   ValeurC:=StrToCurr_lgr(Valeur);
                   Convertisseur.CurrencyEdit1.Value:=ValeurC;
                   Convertisseur.CurrencyEdit2.Value:=ValeurC * Convertisseur.TauxDevise;
                  except
                   Convertisseur.CurrencyEdit1.Value:=0;
                   Convertisseur.CurrencyEdit2.Value:=0;
                  end;
               end;
              except;
              Convertisseur.CurrencyEdit1.Value:=0;
              Convertisseur.CurrencyEdit2.Value:=0;
              end;
              end;
//
//      GTFieldString:recherche(TField(control).AsString);
    else
    end;
 End;

end;
procedure TConvertisseur.CurrencyEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
//
end;

procedure TConvertisseur.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
self.tag:=1;
end;

procedure TConvertisseur.FormShow(Sender: TObject);
begin
self.tag:=0;
end;

procedure TConvertisseur.FormCreate(Sender: TObject);
begin
  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
CurrencyEdit1.DisplayFormat:=E.FormatMonnaie;
end;

procedure TConvertisseur.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
Convertisseur:=nil;
end;

end.
