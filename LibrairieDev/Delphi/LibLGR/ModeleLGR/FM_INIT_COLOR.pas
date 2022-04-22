unit FM_INIT_COLOR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Menus,
  ComCtrls,
  ExtCtrls,
  StdCtrls,
  DBCtrls,
  RXDBCtrl,
  RXCtrls,
  Mask,
  GrDBGrid,
  DB,
  Dialogs;

Const
  C_MODELE_COLORBASE=0;
  C_MODELE_COLOREPI=1;

type

TWinLGR = class(TWinControl)
 public
  property OnEnter;
  Property OnExit;
 end;

 //TGRDBColorGrid
//TVarColorGrid= Record
//    LigneContour:TColor;
//    CelActiveContour:TColor;
//    CelActiveColorFond:TColor;
//    CelActiveColorFont:TColor;
//    CelActiveSAisieColorFont:TColor;
//    CelActiveSAisieColorFond:TColor;
//    CelFixeColorFond:TColor;
//    CelFixeColorFont:TColor;
//    GrilleColorFond:TColor;
//    GrilleColorFont:TColor;
//    end;


  TT_INIT_COLOR = class(TForm)
    Btn_Modele_FM_INIT_COLOR: TButton;
    La_AP_Modele_ArrierePlanEdit: TLabel;
    Ed_Modele_FM_INIT_COLOR: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BtnEnter(Sender: TObject);
    procedure BtnExit(Sender: TObject);
    procedure Ed_Modele_FM_INIT_COLOREnter(Sender: TObject);
    procedure Ed_Modele_FM_INIT_COLORExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
//    BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer : TButton;
    ListeWinControlLabel:TStringList;
    Function InitialiseColorForm(TypeInit:Integer):Boolean;
    Function InitialiseLibelleForm(TypeInit:Integer):Boolean;
  public
    { Déclarations publiques }
    TypeInitForm:Integer;
    // Panel
    ColorPaBtn:TColor;
    ColorPaTitre:TColor;
    ColorPaTools:TColor;
    ColorPaPTitre:TColor;
    ColorPaTotaux:TColor;
    ColorPaBas:TColor;
    ColorPaFd:TColor;
    // Boutton
    CaptionBtnAnnuler:TCaption;
    CaptionBtnEnregistrer:TCaption;
    CaptionBtnFermer:TCaption;
    CaptionBtnImprimer:TCaption;
    CaptionBtnInserer:TCaption;
    CaptionBtnModifier:TCaption;
    CaptionBtnSupprimer:TCaption;
    CaptionBtnRafraichir:TCaption;

   DBBevelEdges : TBevelEdges;
   DBBevelInner :TBevelCut;
   DBBevelKind :TBevelKind;
   DBBevelOuter :TBevelCut;
   DBBevelWidth :Integer;
   EDBorderStyle :TBorderStyle;
   EDColor : TColor;
   EDFontStyle:TFontStyles;
   EDControl3D : Boolean;

   ColorEnter,ColorExit:TColor;
   LabelWincontrolFontColor:TColor;
   LabelWincontrolFontStyle : TFontStyles;
   VarColorGrid:TVarColorGrid;
   Procedure AssocierLabelWinControl(LabelAAssocier:TLabel;WinControl:TWinControl);
  end;

var
  T_INIT_COLOR: TT_INIT_COLOR;

    Procedure BouttonAgrandit(Boutton:TButton);
    Procedure BouttonDiminue(Boutton:TButton);

implementation


{$R *.dfm}

Function TT_INIT_COLOR.InitialiseLibelleForm(TypeInit:Integer):Boolean;
Begin
//if FindComponent('BtnEnregistrer') <> nil then
// if FindComponent('BtnEnregistrer').ClassType = TButton then
//    (FindComponent('BtnEnregistrer') as TButton).Caption :='Enregistrer [F3]';

End;

Function TT_INIT_COLOR.InitialiseColorForm(TypeInit:Integer):Boolean;
var
i,j:integer;
Begin
// ListeWinControlLabel.Clear;
 case TypeInit of
    C_MODELE_COLORBASE:Begin
                        if FindComponent('PaBtn') <> nil then
                         if FindComponent('PaBtn').ClassType = TPanel then
                            (FindComponent('PaBtn') as TPanel).color :=ColorPaBtn;
                       End;

     C_MODELE_COLOREPI:Begin
                         for i:=0 to self.ComponentCount -1 do
                          begin
//                          // Remplit la liste des Wincontrol pour leur affecter un TLabel
//                          if (self.Components[i] is TWinControl)then
//                           ListeWinControlLabel.Add(self.Components[i].Name);

                           // Panel PaBtn
                           if (UpperCase(self.Components[i].Name) = UpperCase('PaBtn')) then
                            begin
                             if self.Components[i].ClassType = TPanel then
                                (self.Components[i] as TPanel).color :=ColorPaBtn;
                                continue;
                            end;

                           // Panel PaTitre
                           if (UpperCase(self.Components[i].Name) = UpperCase('PaTitre')) then
                            begin
                             if self.Components[i].ClassType = TPanel then
                                (self.Components[i] as TPanel).color :=ColorPaTitre;
                                continue;
                            end;

                           // Panel PaTools
                           if (UpperCase(self.Components[i].Name) = UpperCase('PaTools')) then
                            begin
                             if self.Components[i].ClassType = TPanel then
                                (self.Components[i] as TPanel).color :=ColorPaTools;
                                continue;
                            end;

                           // Panel Petit Titre
                           if (copy(UpperCase(self.Components[i].Name),1,4) = UpperCase('PaPT')) then
                            begin
                             if self.Components[i].ClassType = TPanel then
                                (self.Components[i] as TPanel).color :=ColorPaPTitre;
                                continue;
                            end;

                           // Panel Totaux
                           if (copy(UpperCase(self.Components[i].Name),1,5) = UpperCase('PaTot')) then
                            begin
                             if self.Components[i].ClassType = TPanel then
                                (self.Components[i] as TPanel).color :=ColorPaTotaux;
                                continue;
                            end;

                           // Panel PaBas
                           if (UpperCase(self.Components[i].Name) = UpperCase('PaBas')) then
                            begin
                             if self.Components[i].ClassType = TPanel then
                                (self.Components[i] as TPanel).color :=ColorPaBas;
                                continue;
                            end;

                           // Panel PaFd
                           if (copy(UpperCase(self.Components[i].Name),1,4) = UpperCase('PaFd')) then
                            begin
                             if self.Components[i].ClassType = TPanel then
                                (self.Components[i] as TPanel).color :=ColorPaFd;
                                continue;
                            end;

                           // Aspect général des Label d'arrière plan
                           if self.Components[i].ClassType = TLabel then
                            begin
                              if (copy(UpperCase(self.Components[i].Name),1,5) = UpperCase('La_AP')) then
                               begin
                                 (self.Components[i] as TLabel).Color := La_AP_Modele_ArrierePlanEdit.Color;
                                 (self.Components[i] as TLabel).Font.Color := La_AP_Modele_ArrierePlanEdit.Font.Color;
                                 (self.Components[i] as TLabel).Transparent := La_AP_Modele_ArrierePlanEdit.Transparent;
//                                continue;
                               end;
                            end;

                           // Aspect général des buttons
                           if self.Components[i].ClassType = TButton then
                            begin
                              (self.Components[i] as TButton ).Font.Style := Btn_Modele_FM_INIT_COLOR.Font.Style;
                            end;

                           // Boutton Annuler
                           if (UpperCase(self.Components[i].Name) = UpperCase('BtnAnnuler')) then
                            begin
                             if self.Components[i].ClassType = TButton then
                              begin
                                (self.Components[i] as TButton ).Caption := CaptionBtnAnnuler;
                                if @(self.Components[i] as TButton ).OnEnter = nil then
                                     (self.Components[i] as TButton ).OnEnter := BtnEnter;
                                if @(self.Components[i] as TButton ).OnExit = nil then
                                     (self.Components[i] as TButton ).OnExit := BtnExit;
//                                BtnAnnuler :=(self.Components[i] as TButton );

                              end;
                                continue;
                            end;

                           // Boutton Enregistrer
                           if (UpperCase(self.Components[i].Name) = UpperCase('BtnEnregistrer')) then
                            begin
                             if self.Components[i].ClassType = TButton then
                              begin
                                (self.Components[i] as TButton ).Caption :=CaptionBtnEnregistrer;
                                if @(self.Components[i] as TButton ).OnEnter = nil then
                                     (self.Components[i] as TButton ).OnEnter := BtnEnter;
                                if @(self.Components[i] as TButton ).OnExit = nil then
                                     (self.Components[i] as TButton ).OnExit := BtnExit;
//                                BtnEnregistrer :=(self.Components[i] as TButton );
                              end;
                                continue;
                            end;

                           // Boutton Fermer
                           if (UpperCase(self.Components[i].Name) = UpperCase('BtnFermer')) then
                            begin
                             if self.Components[i].ClassType = TButton then
                              begin
                                (self.Components[i] as TButton ).Caption :=CaptionBtnFermer;
                                if @(self.Components[i] as TButton ).OnEnter = nil then
                                     (self.Components[i] as TButton ).OnEnter := BtnEnter;
                                if @(self.Components[i] as TButton ).OnExit = nil then
                                     (self.Components[i] as TButton ).OnExit := BtnExit;
//                                BtnFermer :=(self.Components[i] as TButton );
                              end;
                                continue;
                            end;
                           // Boutton Imprimer
                           if (UpperCase(self.Components[i].Name) = UpperCase('BtnImprimer')) then
                            begin
                             if self.Components[i].ClassType = TButton then
                             begin
                                (self.Components[i] as TButton ).Caption :=CaptionBtnImprimer;
                                if @(self.Components[i] as TButton ).OnEnter = nil then
                                     (self.Components[i] as TButton ).OnEnter := BtnEnter;
                                if @(self.Components[i] as TButton ).OnExit = nil then
                                     (self.Components[i] as TButton ).OnExit := BtnExit;
//                                BtnImprimer :=(self.Components[i] as TButton );
                              end;
                                continue;
                            end;
                           // Boutton Inserer
                           if (UpperCase(self.Components[i].Name) = UpperCase('BtnInserer')) then
                            begin
                             if self.Components[i].ClassType = TButton then
                              begin
                                (self.Components[i] as TButton ).Caption :=CaptionBtnInserer;
                                if @(self.Components[i] as TButton ).OnEnter = nil then
                                     (self.Components[i] as TButton ).OnEnter := BtnEnter;
                                if @(self.Components[i] as TButton ).OnExit = nil then
                                     (self.Components[i] as TButton ).OnExit := BtnExit;
//                                BtnInserer :=(self.Components[i] as TButton );
                              end;
                                continue;
                            end;
                           // Boutton Modifier
                           if (UpperCase(self.Components[i].Name) = UpperCase('BtnModifier')) then
                            begin
                             if self.Components[i].ClassType = TButton then
                              begin
                                (self.Components[i] as TButton ).Caption :=CaptionBtnModifier;
                                if @(self.Components[i] as TButton ).OnEnter = nil then
                                     (self.Components[i] as TButton ).OnEnter := BtnEnter;
                                if @(self.Components[i] as TButton ).OnExit = nil then
                                     (self.Components[i] as TButton ).OnExit := BtnExit;
//                                BtnModifier :=(self.Components[i] as TButton );
                              end;
                                continue;
                            end;
                           // Boutton Supprimer
                           if (UpperCase(self.Components[i].Name) = UpperCase('BtnSupprimer')) then
                            begin
                             if self.Components[i].ClassType = TButton then
                              begin
                                (self.Components[i] as TButton ).Caption :=CaptionBtnSupprimer;
                                if @(self.Components[i] as TButton ).OnEnter = nil then
                                     (self.Components[i] as TButton ).OnEnter := BtnEnter;
                                if @(self.Components[i] as TButton ).OnExit = nil then
                                     (self.Components[i] as TButton ).OnExit := BtnExit;
//                                BtnSupprimer :=(self.Components[i] as TButton );
                              end;
                                continue;
                            end;

                           // Boutton Rafraichir
                           if (UpperCase(self.Components[i].Name) = UpperCase('BtnRafraichir')) then
                            begin
                             if self.Components[i].ClassType = TButton then
                              begin
                                (self.Components[i] as TButton ).Caption :=CaptionBtnRafraichir;
                                if @(self.Components[i] as TButton ).OnEnter = nil then
                                     (self.Components[i] as TButton ).OnEnter := BtnEnter;
                                if @(self.Components[i] as TButton ).OnExit = nil then
                                     (self.Components[i] as TButton ).OnExit := BtnExit;
                              end;
                                continue;
                            end;


                           if self.Components[i].ClassType = TLabelEdEdit then
                            begin
                             (self.Components[i] as TLabelEdEdit).BevelEdges := DBBevelEdges;
                             (self.Components[i] as TLabelEdEdit).BevelInner := DBBevelInner;
                             (self.Components[i] as TLabelEdEdit).BevelKind := DBBevelKind;
                             (self.Components[i] as TLabelEdEdit).BevelOuter := DBBevelOuter;
//                             (self.Components[i] as TLabelEdEdit).BevelWidth := DBBevelWidth;
                             (self.Components[i] as TLabelEdEdit).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TLabelEdEdit).Color := EDColor;
                             (self.Components[i] as TLabelEdEdit).Font.Style :=EDFontStyle;
                             (self.Components[i] as TLabelEdEdit).Ctl3D:=EDControl3D;
                              if @(self.Components[i] as TLabelEdEdit).OnEnter = nil then
                                 (self.Components[i] as TLabelEdEdit).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
                              if @(self.Components[i] as TLabelEdEdit).OnExit = nil then
                                 (self.Components[i] as TLabelEdEdit).OnExit := Ed_Modele_FM_INIT_COLORExit;
                              continue;
                            end;

                           if self.Components[i].ClassType = TEdit then
                            begin
                             (self.Components[i] as TEdit).BevelEdges := DBBevelEdges;
                             (self.Components[i] as TEdit).BevelInner := DBBevelInner;
                             (self.Components[i] as TEdit).BevelKind := DBBevelKind;
                             (self.Components[i] as TEdit).BevelOuter := DBBevelOuter;
//                             (self.Components[i] as TEdit).BevelWidth := DBBevelWidth;
                             (self.Components[i] as TEdit).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TEdit).Color := EDColor;
                             (self.Components[i] as TEdit).Font.Style :=EDFontStyle;
                             (self.Components[i] as TEdit).Ctl3D:=EDControl3D;
                              if @(self.Components[i] as TEdit).OnEnter = nil then
                                 (self.Components[i] as TEdit).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
                              if @(self.Components[i] as TEdit).OnExit = nil then
                                 (self.Components[i] as TEdit).OnExit := Ed_Modele_FM_INIT_COLORExit;
                              continue;
                            end;

                           if self.Components[i].ClassType = TDBEdit then
                            begin
                             (self.Components[i] as TDBEdit).BevelEdges := DBBevelEdges;
                             (self.Components[i] as TDBEdit).BevelInner := DBBevelInner;
                             (self.Components[i] as TDBEdit).BevelKind := DBBevelKind;
                             (self.Components[i] as TDBEdit).BevelOuter := DBBevelOuter;
                             (self.Components[i] as TDBEdit).BevelWidth := DBBevelWidth;
                             (self.Components[i] as TDBEdit).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TDBEdit).Color := EDColor;
                             (self.Components[i] as TDBEdit).Font.Style :=EDFontStyle;
                             (self.Components[i] as TDBEdit).Ctl3D:=EDControl3D;
                              if @(self.Components[i] as TDBEdit).OnEnter = nil then
                                 (self.Components[i] as TDBEdit).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
                              if @(self.Components[i] as TDBEdit).OnExit = nil then
                                 (self.Components[i] as TDBEdit).OnExit := Ed_Modele_FM_INIT_COLORExit;
                              continue;
                            end;

                           if self.Components[i].ClassType = TDBDateEdit then
                            begin
                             (self.Components[i] as TDBDateEdit).BevelEdges := DBBevelEdges;
                             (self.Components[i] as TDBDateEdit).BevelInner := DBBevelInner;
                             (self.Components[i] as TDBDateEdit).BevelKind := DBBevelKind;
                             (self.Components[i] as TDBDateEdit).BevelOuter := DBBevelOuter;
                             (self.Components[i] as TDBDateEdit).BevelWidth := DBBevelWidth;
                             (self.Components[i] as TDBDateEdit).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TDBDateEdit).Color := EDColor;
                             (self.Components[i] as TDBDateEdit).Font.Style :=EDFontStyle;
                             (self.Components[i] as TDBDateEdit).Ctl3D:=EDControl3D;
                              if @(self.Components[i] as TDBDateEdit).OnEnter = nil then
                                 (self.Components[i] as TDBDateEdit).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
                              if @(self.Components[i] as TDBDateEdit).OnExit = nil then
                                 (self.Components[i] as TDBDateEdit).OnExit := Ed_Modele_FM_INIT_COLORExit;
                             continue;
                            end;

                           if self.Components[i].ClassType = TMaskEdit then
                            begin
                             (self.Components[i] as TMaskEdit).BevelEdges := DBBevelEdges;
                             (self.Components[i] as TMaskEdit).BevelInner := DBBevelInner;
                             (self.Components[i] as TMaskEdit).BevelKind := DBBevelKind;
                             (self.Components[i] as TMaskEdit).BevelOuter := DBBevelOuter;
                             (self.Components[i] as TMaskEdit).BevelWidth := DBBevelWidth;
                             (self.Components[i] as TMaskEdit).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TMaskEdit).Color := EDColor;
                             (self.Components[i] as TMaskEdit).Font.Style :=EDFontStyle;
                             (self.Components[i] as TMaskEdit).Ctl3D:=EDControl3D;
                              if @(self.Components[i] as TMaskEdit).OnEnter = nil then
                                 (self.Components[i] as TMaskEdit).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
                              if @(self.Components[i] as TMaskEdit).OnExit = nil then
                                 (self.Components[i] as TMaskEdit).OnExit := Ed_Modele_FM_INIT_COLORExit;
                             continue;
                            end;

                           if self.Components[i].ClassType = TComboBox then
                            begin
                             (self.Components[i] as TComboBox).BevelEdges := DBBevelEdges;
                             (self.Components[i] as TComboBox).BevelInner := DBBevelInner;
                             (self.Components[i] as TComboBox).BevelKind := DBBevelKind;
                             (self.Components[i] as TComboBox).BevelOuter := DBBevelOuter;
//                             (self.Components[i] as TComboBox).BevelWidth := DBBevelWidth;
//                             (self.Components[i] as TComboBox).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TComboBox).Color := EDColor;
                             (self.Components[i] as TComboBox).Font.Style :=EDFontStyle;
                             (self.Components[i] as TComboBox).Ctl3D:=EDControl3D;
                              if @(self.Components[i] as TComboBox).OnEnter = nil then
                                 (self.Components[i] as TComboBox).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
                              if @(self.Components[i] as TComboBox).OnExit = nil then
                                 (self.Components[i] as TComboBox).OnExit := Ed_Modele_FM_INIT_COLORExit;
                             continue;
                            end;

                           if self.Components[i].ClassType = TDBComboBox then
                            begin
                             (self.Components[i] as TDBComboBox).BevelEdges := DBBevelEdges;
                             (self.Components[i] as TDBComboBox).BevelInner := DBBevelInner;
                             (self.Components[i] as TDBComboBox).BevelKind := DBBevelKind;
                             (self.Components[i] as TDBComboBox).BevelOuter := DBBevelOuter;
//                             (self.Components[i] as TComboBox).BevelWidth := DBBevelWidth;
//                             (self.Components[i] as TComboBox).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TDBComboBox).Color := EDColor;
                             (self.Components[i] as TDBComboBox).Font.Style :=EDFontStyle;
                             (self.Components[i] as TDBComboBox).Ctl3D:=EDControl3D;
                              if @(self.Components[i] as TDBComboBox).OnEnter = nil then
                                 (self.Components[i] as TDBComboBox).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
                              if @(self.Components[i] as TDBComboBox).OnExit = nil then
                                 (self.Components[i] as TDBComboBox).OnExit := Ed_Modele_FM_INIT_COLORExit;
                             continue;
                            end;


                           if self.Components[i].ClassType = TRxDBComboEdit then
                            begin
                             (self.Components[i] as TRxDBComboEdit).BevelEdges := DBBevelEdges;
                             (self.Components[i] as TRxDBComboEdit).BevelInner := DBBevelInner;
                             (self.Components[i] as TRxDBComboEdit).BevelKind := DBBevelKind;
                             (self.Components[i] as TRxDBComboEdit).BevelOuter := DBBevelOuter;
//                             (self.Components[i] as TComboBox).BevelWidth := DBBevelWidth;
//                             (self.Components[i] as TComboBox).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TRxDBComboEdit).Color := EDColor;
                             (self.Components[i] as TRxDBComboEdit).Font.Style :=EDFontStyle;
                             (self.Components[i] as TRxDBComboEdit).Ctl3D:=EDControl3D;
                              if @(self.Components[i] as TRxDBComboEdit).OnEnter = nil then
                                 (self.Components[i] as TRxDBComboEdit).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
                              if @(self.Components[i] as TRxDBComboEdit).OnExit = nil then
                                 (self.Components[i] as TRxDBComboEdit).OnExit := Ed_Modele_FM_INIT_COLORExit;
                             continue;
                            end;

                           if self.Components[i].ClassType = TCheckBox then
                            begin
//                             (self.Components[i] as TCheckBox).BevelEdges := DBBevelEdges;
//                             (self.Components[i] as TCheckBox).BevelInner := DBBevelInner;
//                             (self.Components[i] as TCheckBox).BevelKind := DBBevelKind;
//                             (self.Components[i] as TCheckBox).BevelOuter := DBBevelOuter;
//                             (self.Components[i] as TComboBox).BevelWidth := DBBevelWidth;
//                             (self.Components[i] as TComboBox).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TCheckBox).Color := EDColor;
                             (self.Components[i] as TCheckBox).Font.Style :=EDFontStyle;
                             (self.Components[i] as TCheckBox).Ctl3D:=EDControl3D;
                              if @(self.Components[i] as TCheckBox).OnEnter = nil then
                                 (self.Components[i] as TCheckBox).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
                              if @(self.Components[i] as TCheckBox).OnExit = nil then
                                 (self.Components[i] as TCheckBox).OnExit := Ed_Modele_FM_INIT_COLORExit;
                             continue;
                            end;

                           if self.Components[i].ClassType = TDBCheckBox then
                            begin
//                             (self.Components[i] as TCheckBox).BevelEdges := DBBevelEdges;
//                             (self.Components[i] as TCheckBox).BevelInner := DBBevelInner;
//                             (self.Components[i] as TCheckBox).BevelKind := DBBevelKind;
//                             (self.Components[i] as TCheckBox).BevelOuter := DBBevelOuter;
//                             (self.Components[i] as TComboBox).BevelWidth := DBBevelWidth;
//                             (self.Components[i] as TComboBox).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TDBCheckBox).Color := EDColor;
                             (self.Components[i] as TDBCheckBox).Font.Style :=EDFontStyle;
                             (self.Components[i] as TDBCheckBox).Ctl3D:=EDControl3D;
                              if @(self.Components[i] as TDBCheckBox).OnEnter = nil then
                                 (self.Components[i] as TDBCheckBox).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
                              if @(self.Components[i] as TDBCheckBox).OnExit = nil then
                                 (self.Components[i] as TDBCheckBox).OnExit := Ed_Modele_FM_INIT_COLORExit;
                             continue;
                            end;

                           if self.Components[i].ClassType = TRichEdit then
                            begin
                             (self.Components[i] as TRichEdit).BevelEdges := DBBevelEdges;
                             (self.Components[i] as TRichEdit).BevelInner := DBBevelInner;
                             (self.Components[i] as TRichEdit).BevelKind := DBBevelKind;
                             (self.Components[i] as TRichEdit).BevelOuter := DBBevelOuter;
                             (self.Components[i] as TRichEdit).BevelWidth := DBBevelWidth;
                             (self.Components[i] as TRichEdit).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TRichEdit).Color := EDColor;
                             (self.Components[i] as TRichEdit).Font.Style :=EDFontStyle;
                             (self.Components[i] as TRichEdit).Ctl3D:=EDControl3D;
                              if @(self.Components[i] as TRichEdit).OnEnter = nil then
                                 (self.Components[i] as TRichEdit).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
                              if @(self.Components[i] as TRichEdit).OnExit = nil then
                                 (self.Components[i] as TRichEdit).OnExit := Ed_Modele_FM_INIT_COLORExit;
                             continue;
                            end;

                           if self.Components[i].ClassType = TScrollBox then
                            begin
                             (self.Components[i] as TScrollBox).BevelEdges := DBBevelEdges;
                             (self.Components[i] as TScrollBox).BevelInner := DBBevelInner;
                             (self.Components[i] as TScrollBox).BevelKind := DBBevelKind;
                             (self.Components[i] as TScrollBox).BevelOuter := DBBevelOuter;
                             (self.Components[i] as TScrollBox).BevelWidth := DBBevelWidth;
                             (self.Components[i] as TScrollBox).BorderStyle := EDBorderStyle;
                             (self.Components[i] as TScrollBox).Color := ColorPaFd;;
                             (self.Components[i] as TScrollBox).Font.Style :=EDFontStyle;
                             (self.Components[i] as TScrollBox).Ctl3D:=EDControl3D;
//                              if @(self.Components[i] as TScrollBox).OnEnter = nil then
//                                 (self.Components[i] as TScrollBox).OnEnter := Ed_Modele_FM_INIT_COLOREnter;
//                              if @(self.Components[i] as TScrollBox).OnExit = nil then
//                                 (self.Components[i] as TScrollBox).OnExit := Ed_Modele_FM_INIT_COLORExit;
                             continue;
                            end;

                           if self.Components[i].ClassType = TGrDBGrid then
                            begin
                             (self.Components[i] as TGrDBGrid).ParamColor := true;
                             (self.Components[i] as TGrDBGrid).Param :=VarColorGrid;
                             (self.Components[i] as TGrDBGrid).UpDateColor;
//                             (self.Components[i] as TGrDBGrid).Param.CelActiveColorFond := VarColorGrid.CelActiveColorFond ;
//                             (self.Components[i] as TGrDBGrid).Param.CelActiveColorFont := VarColorGrid.CelActiveColorFont;
//                             (self.Components[i] as TGrDBGrid).Param.CelActiveContour := VarColorGrid.CelActiveContour;
//                             (self.Components[i] as TGrDBGrid).Param.CelActiveSAisieColorFond := VarColorGrid.CelActiveSAisieColorFond;
//                             (self.Components[i] as TGrDBGrid).Param.CelActiveSAisieColorFont := VarColorGrid.CelActiveSAisieColorFont;
//                             (self.Components[i] as TGrDBGrid).Param.CelFixeColorFond := VarColorGrid.CelFixeColorFond;
//                             (self.Components[i] as TGrDBGrid).Param.CelFixeColorFont := VarColorGrid.CelFixeColorFont;
//                             (self.Components[i] as TGrDBGrid).Param.GrilleColorFond := VarColorGrid.GrilleColorFond;
//                             (self.Components[i] as TGrDBGrid).Param.GrilleColorFont :=VarColorGrid.CelFixeColorFont;
//                             (self.Components[i] as TGrDBGrid).Param.LigneContour:=VarColorGrid.LigneContour;
                             continue;
                            end;

                           // Rend invisible les items d'un popmenu s'il n'y a pas de onCLikEvent
                           if self.Components[i].ClassType = TPopupMenu then
                            begin
                             for j:=0 to (self.Components[i] as TPopupMenu).items.Count-1 do
                             begin
                               (self.Components[i] as TPopupMenu).Items[j].Visible:=((@(self.Components[i] as TPopupMenu).Items[j].OnClick <> nil) and ((self.Components[i] as TPopupMenu).Items[j].Caption <> '-'))
                             end;
                             continue;
                            end;

                          end; // Fin du for (boucle sur les composants)

                       End;

 end;
End;

procedure TT_INIT_COLOR.FormCreate(Sender: TObject);
var
ListeCouleurDBGrid:TStringList;
i:integer;
begin
  TypeInitForm:=C_MODELE_COLORBASE;
  ListeWinControlLabel:=TStringList.Create;
  ColorPaBtn:=$00BDD8DF;
  ColorPaTitre:=$0070DBFF;
  ColorPaTools:=$00BDD8DF;
  ColorPaPTitre:=$0070DBFF;
  ColorPaTotaux := $00BDD8DF;
  ColorPaBas:= $00BDD8DF;
  ColorPaFd := $00EAFAFF;//$0099E5FF;

  Btn_Modele_FM_INIT_COLOR.Font.Style := [];
  CaptionBtnAnnuler := 'Annuler [Esc]';
  CaptionBtnEnregistrer:= 'Enregistrer [F3]';
  CaptionBtnFermer:= 'Fermer';
  CaptionBtnImprimer:= 'Imprimer [F11]';
  CaptionBtnInserer:= 'Insérer [F6]';
  CaptionBtnModifier:= 'Modifier [F2]';
  CaptionBtnSupprimer:= 'Supprimer [F10]';
  CaptionBtnRafraichir := 'Actualiser [F5]';

   DBBevelEdges := [beRight,beBottom];
   DBBevelInner := bvLowered;
   DBBevelKind := bkSoft;
   DBBevelOuter := bvLowered;//bvRaised;
   DBBevelWidth := 1;

   EDBorderStyle :=bsNone;
   EDColor := $0099E5FF;//clBtnFace;//clWindow;//$0099E5FF;
   EDFontStyle:=[FsBold];
   EDControl3D := True;

   La_AP_Modele_ArrierePlanEdit.Color := $00C1F0FF;//clBtnFace;
   La_AP_Modele_ArrierePlanEdit.Font.Color := clWindowText;
   La_AP_Modele_ArrierePlanEdit.Transparent := True;//False;

   ColorEnter := clYellow;
   ColorExit := EDColor;//clWindow;

   LabelWincontrolFontColor:= $000000D2; // Rouge foncé
   LabelWincontrolFontStyle := [fsUnderline];


  if FileExists(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+ 'Datadb.dat') then
  begin
  ListeCouleurDBGrid:=TStringList.Create;

  ListeCouleurDBGrid.LoadFromFile(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+ 'Datadb.dat');
//  showmessage('OK1');
  try
    for i:=0 to ListeCouleurDBGrid.Count-1 do
        begin
         case i of
            0:VarColorGrid.LigneContour:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            1:VarColorGrid.CelActiveContour:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            2:VarColorGrid.CelActiveColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            3:VarColorGrid.CelActiveColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            4:VarColorGrid.CelActiveSAisieColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            5:VarColorGrid.CelActiveSAisieColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            6:VarColorGrid.CelFixeColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            7:VarColorGrid.CelFixeColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            8:VarColorGrid.GrilleColorFond:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
            9:VarColorGrid.GrilleColorFont:=stringtocolor(ListeCouleurDBGrid.Strings[i]);
         end;
        end;
//    Panel1.Color:=CouleurDBGrid.GrilleColorFond;
    ListeCouleurDBGrid.Free;
   for i:=0 to self.ComponentCount -1 do
    begin
    // Remplit la liste des Wincontrol pour leur affecter un TLabel
    if (self.Components[i] is TWinControl)then
     ListeWinControlLabel.Add(self.Components[i].Name);
    end;
  except
  // DBGrid
//    showmessage('La lecture de certains paramètres à échouée, ceux par défaut ont été restaurés !');
    VarColorGrid.LigneContour:=clGreen;
    VarColorGrid.CelActiveContour:=$0000E600;
    VarColorGrid.CelActiveColorFond:=clactiveBorder;
    VarColorGrid.CelActiveColorFont:=clWhite;
    VarColorGrid.CelActiveSAisieColorFont:=clBlack;
    VarColorGrid.CelActiveSAisieColorFond:=$0000E600;
    VarColorGrid.CelFixeColorFond:=clBtnFace;
    VarColorGrid.CelFixeColorFont:=clWindowText;
    VarColorGrid.GrilleColorFond:=$00EAFAFF;
    VarColorGrid.GrilleColorFont:=clWindowText;
//    Panel1.Color:=CouleurDBGrid.GrilleColorFond;
    ListeCouleurDBGrid.Free;
  end;

  end;


end;

procedure TT_INIT_COLOR.BtnEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TT_INIT_COLOR.BtnExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;


Procedure BouttonAgrandit(Boutton:TButton);
Begin
with (Boutton as tbutton) do
 begin
  top:=top-3;
  left:=left-3;
  width:=width+6;
  height:=height+6;
 end;
End;

Procedure BouttonDiminue(Boutton:TButton);
Begin
with (Boutton as tbutton) do
 begin
  top:=top+3;
  left:=left+3;
  width:=width-6;
  height:=height-6;
 end;

End;


procedure TT_INIT_COLOR.Ed_Modele_FM_INIT_COLOREnter(Sender: TObject);
var
i:integer;
begin
if (sender is TWinControl) then
 begin
  (sender as TWinControl).Brush.Color := ColorEnter;
  if (Sender is TRichEdit) then
   (Sender as TRichEdit).Color := ColorEnter;
  // Font.color des CheckBox
  if (Sender is TCheckBox) then
   (Sender as TCheckBox).Font.Color := LabelWincontrolFontColor;
  if (Sender is TDBCheckBox) then
   (Sender as TDBCheckBox).Font.Color := LabelWincontrolFontColor;

  // Font.color des Label
  i:=ListeWinControlLabel.IndexOf((sender as TWinControl).Name);
//  ListeWinControlLabel.SaveToFile((sender as TWinControl).Name+'_Control.txt');
  if i <> -1 then
   begin
//    ListeWinControlLabel.SaveToFile(ListeWinControlLabel.Strings[i]+'test.txt');
    if ListeWinControlLabel.Objects[i] <> nil then
     begin
      TLabel(ListeWinControlLabel.Objects[i]).Font.Color := LabelWincontrolFontColor;
      TLabel(ListeWinControlLabel.Objects[i]).Font.Style := TLabel(ListeWinControlLabel.Objects[i]).Font.Style + LabelWincontrolFontStyle;
     end;
   end;
  (sender as TWinControl).Refresh;
 end;
end;

procedure TT_INIT_COLOR.Ed_Modele_FM_INIT_COLORExit(Sender: TObject);
var
i:integer;
Begin
if (sender is TWinControl) then
 begin
  (sender as TWinControl).Brush.Color := ColorExit;
  if (Sender is TRichEdit) then
   (Sender as TRichEdit).Color := ColorExit;

  // Font.color des CheckBox
  if (Sender is TCheckBox) then
   (Sender as TCheckBox).Font.Color := clWindowText;
  if (Sender is TDBCheckBox) then
   (Sender as TDBCheckBox).Font.Color := clWindowText;
  // Font.color des labels
  i:=ListeWinControlLabel.IndexOf((sender as TWinControl).Name);
  if i <> -1 then
   begin
    if ListeWinControlLabel.Objects[i] <> nil then
     begin
      TLabel(ListeWinControlLabel.Objects[i]).Font.Color := clWindowText;
      TLabel(ListeWinControlLabel.Objects[i]).Font.Style := TLabel(ListeWinControlLabel.Objects[i]).Font.Style - LabelWincontrolFontStyle;
     end;
   end;
  (sender as TWinControl).Refresh;
 end;
end;

procedure TT_INIT_COLOR.FormDestroy(Sender: TObject);
begin
if ListeWinControlLabel <> nil then ListeWinControlLabel.Free;
end;

Procedure TT_INIT_COLOR.AssocierLabelWinControl(LabelAAssocier:TLabel;WinControl:TWinControl);
var
i:integer;
Begin
i:=ListeWinControlLabel.IndexOf(WinControl.Name);
if i <> -1 then
 begin
  ListeWinControlLabel.Objects[i] := LabelAAssocier;
 end;
End;

procedure TT_INIT_COLOR.FormShow(Sender: TObject);
begin
 InitialiseColorForm(TypeInitForm);
end;

end.
