unit E2_GestVisu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, RXCtrls, Grids, DBGrids, RXDBCtrl, ExRxDBGrid, GrDBGrid,
  RxLookup, StdCtrls,Gr_Librairie_Obj,E2_Librairie_Obj,DMConstantes,
  RXSplit,DMGestVisus,db,LibSQL,E2_Recherche, LibGestionParamXML, Menus;

type
  TGestVisu = class(TForm)
    Patitre: TPanel;
    PaHaut: TPanel;
    PaBas: TPanel;
    PaTitreRecherche: TPanel;
    PaRecherche: TPanel;
    PaCentre: TPanel;
    PaEcrPie: TPanel;
    PaEcr: TPanel;
    PaTitreEcriture: TPanel;
    PaEcritures: TPanel;
    GrDBGridEcritures: TGrDBGrid;
    PaPie: TPanel;
    PaPieces: TPanel;
    GrDBGridPieces: TGrDBGrid;
    PaTitrePieces: TPanel;
    RxSplitter1: TRxSplitter;
    PaComptTie: TPanel;
    PaTie: TPanel;
    PaTitreTiers: TPanel;
    PaTiers: TPanel;
    GrDBGridTiers: TGrDBGrid;
    PaCompt: TPanel;
    PaTitreCompte: TPanel;
    PaCompte: TPanel;
    GrDBGridComptes: TGrDBGrid;
    RxSplitter2: TRxSplitter;
    RxSplitter3: TRxSplitter;
    RxSplitter4: TRxSplitter;
    RxSplitter5: TRxSplitter;
    PaSynth: TPanel;
    Panel2: TPanel;
    PaSynthese: TPanel;
    PaJourn: TPanel;
    PaJournaux: TPanel;
    PaTitreJournaux: TPanel;
    RxSplitter6: TRxSplitter;
    RxSBinv2: TRxSpeedButton;
    RxSBC2: TRxSpeedButton;
    RxSBJ4: TRxSpeedButton;
    RxSBJ3: TRxSpeedButton;
    RxSBinv3: TRxSpeedButton;
    RxSBinv4: TRxSpeedButton;
    RxSBC4: TRxSpeedButton;
    RxSBP4: TRxSpeedButton;
    RxSBT4: TRxSpeedButton;
    RxSBC3: TRxSpeedButton;
    RxSBT3: TRxSpeedButton;
    GrDBJournaux: TGrDBGrid;
    PopupMenu1: TPopupMenu;
    Aide1: TMenuItem;
    RxSBJ2: TRxSpeedButton;
    RxSBJ1: TRxSpeedButton;
    RxSBinv1: TRxSpeedButton;
    N1: TMenuItem;
    Insrer1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure GrDBGridComptesTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure GrDBGridComptesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure RxSBC2Click(Sender: TObject);
    procedure RxSBinv2Click(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure Insrer1Click(Sender: TObject);
    procedure RxSBJ1Click(Sender: TObject);
    procedure RxSBT3Click(Sender: TObject);
    procedure RxSBP4Click(Sender: TObject);
    Procedure GestionBouttonLiaison;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  protected
//    procedure ExitListBoxMessage(var Msg:Tmessage);message CM_MOUSELEAVE;
  end;

var
  GestVisu: TGestVisu;

implementation

uses  E2_Main;

{$R *.DFM}

//procedure TGestVisu.ExitListBoxMessage(var Msg:Tmessage);
//begin
//if TempoBoolean then
//   begin
//    RxChkLstJournaux.Visible:=false;
//    TempoBoolean:=false;
//   end;
//end;
Procedure TGestVisu.GestionBouttonLiaison;
Begin

//****************************************
// Déclenchement des liaisons descendante avec Compte
//****************************************
DMGestVisu.LiaisonCompteTiers:=RxSBC2.Down;
RxSBC2.Transparent:=not RxSBC2.Down;

DMGestVisu.LiaisonComptePiece:= RxSBC3.Down;
RxSBC3.Transparent:=not RxSBC3.Down;

DMGestVisu.LiaisonCompteEcriture :=RxSBC4.Down;
RxSBC4.Transparent:=not RxSBC4.Down;
//****************************************

//                *****

//****************************************
// Déclenchement des liaisons descendante avec Tiers
//****************************************
DMGestVisu.LiaisonTiersPiece := RxSBT3.Down;
RxSBT3.Transparent := not RxSBT3.Down;

DMGestVisu.LiaisonTiersEcriture :=RxSBT4.Down;
RxSBT4.Transparent := not RxSBT4.Down;
//****************************************

//                *****

//****************************************
// Déclenchement des liaisons descendante avec Piece
//****************************************
DMGestVisu.LiaisonPieceEcriture := RxSBP4.Down;
RxSBP4.Transparent := not RxSBP4.Down;
//****************************************


DMGestVisu.GestionDefiltrage;
End;


procedure TGestVisu.FormCreate(Sender: TObject);
begin
if DMGestVisu = nil then
    DMGestVisu:=TDMGestVisu.Create(Application.MainForm);

  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
//DMEcritures.QuGestVisuCompte.open;
end;

procedure TGestVisu.FormActivate(Sender: TObject);
begin
Initialiser_ShortCut_Main(true);
Patitre.visible:=Main.AfficheTitre;

GrDBGridComptes.ParamColor:=true;
GrDBGridComptes.Param:=ParamUtil.CouleurDBGrid;
GrDBGridComptes.UpDateColor;

GrDBGridTiers.ParamColor:=true;
GrDBGridTiers.Param:=ParamUtil.CouleurDBGrid;
GrDBGridTiers.UpDateColor;

GrDBGridPieces.ParamColor:=true;
GrDBGridPieces.Param:=ParamUtil.CouleurDBGrid;
GrDBGridPieces.UpDateColor;

GrDBGridEcritures.ParamColor:=true;
GrDBGridEcritures.Param:=ParamUtil.CouleurDBGrid;
GrDBGridEcritures.UpDateColor;

end;

Procedure TGestVisu.InitialiseTable_A_Nil;
Begin
 if DMGestVisu<>nil then
 InitDatasetEvent_A_Nil_Sur_Form([DMGestVisu.QuGestVisuCompte]);
End;

procedure TGestVisu.FormDestroy(Sender: TObject);
begin
InitialiseTable_A_Nil;
LibGestionParamXML.DestroyForm(Self,E.User);
GestVisu:=nil;
end;

procedure TGestVisu.GrDBGridComptesTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
var
ARect:TRect;
i,j:integer;
begin
//GrDBGridComptes.Brush.Bitmap.LoadFromFile('C:\Js\Epicea-2\Sources\Bitmaps\SORTDES.BMP');
case ACol of
   0:begin
       if not DMGestVisu.OrdreCompteDesc then
        begin
         DMGestVisu.OrdreCompte:=' order by P.compte desc';
         DMGestVisu.OrdreCompteDesc:=true;
         end
       else
        begin
         DMGestVisu.OrdreCompte:=' order by P.compte';
         DMGestVisu.OrdreCompteDesc:=False;
         end;
//       DMGestVisu.VisuCompteAvecEcriture(DMGestVisu.QuGestVisuCompte,E.DatExoDebut,E.DatExoFin,true);
//       DMGestVisu.VisuCompteSansEcriture(DMGestVisu.QuGestVisuCompte,E.DatExoDebut,E.DatExoFin,true);
       DMGestVisu.VisuCompteTous(DMGestVisu.QuGestVisuCompte,E.DatExoDebut,E.DatExoFin,true);
     end;
   1:Begin
      if Not DMGestVisu.OrdreLibCompteDesc then
       begin
         DMGestVisu.OrdreCompte:=' order by P.libelle desc';
         DMGestVisu.OrdreLibCompteDesc:=True;
       end
      else
      begin
         DMGestVisu.OrdreCompte:=' order by P.libelle ';
         DMGestVisu.OrdreLibCompteDesc:=False;
      end;
//       DMGestVisu.VisuCompteAvecEcriture(DMGestVisu.QuGestVisuCompte,E.DatExoDebut,E.DatExoFin,true);
//       DMGestVisu.VisuCompteSansEcriture(DMGestVisu.QuGestVisuCompte,E.DatExoDebut,E.DatExoFin,true);
       DMGestVisu.VisuCompteTous(DMGestVisu.QuGestVisuCompte,E.DatExoDebut,E.DatExoFin,true);
     End;
end;
//ARect:=GrDBGridComptes.CellRect(ACol,0);
//  begin
////      ARect:=Rect;
//      GrDBGridComptes.Canvas.Brush.Color := clBlack;
//      i := (ARect.Bottom - ARect.Top - 7) div 2;
//      j := (ARect.Right - ARect.Left - 7) div 2;
//      GrDBGridComptes.Canvas.Polygon([Point(ARect.Left + j, ARect.Top + i),
//          Point(ARect.Left + j + 7, ARect.Top + i),
//              Point(ARect.Left + j + (7 div 2), ARect.Bottom - i)]);
//  end;

end;

procedure TGestVisu.GrDBGridComptesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
//var
//ARect:TRect;
//i,j:integer;
begin
//if ((Datacol=0) and (state = [gdFixed])) then
// begin
//  ARect:=GrDBGridComptes.CellRect(Datacol,0);
////  begin
////      ARect:=Rect;
//      GrDBGridComptes.Canvas.Brush.Color := clBlack;
//      i := (ARect.Bottom - ARect.Top - 7) div 2;
//      j := (ARect.Right - ARect.Left - 7) div 2;
//      GrDBGridComptes.Canvas.Polygon([Point(ARect.Left + j, ARect.Top + i),
//          Point(ARect.Left + j + 7, ARect.Top + i),
//              Point(ARect.Left + j + (7 div 2), ARect.Bottom - i)]);
//  end;
//
end;

procedure TGestVisu.RxSBC2Click(Sender: TObject);
begin
GestionBouttonLiaison;

//DMGestVisu.QuGestVisuCompte.AfterScroll:=DMGestVisu.QuGestVisuCompteAfterScroll;
//DMGestVisu.QuGestVisuCompteAfterScroll(DMGestVisu.QuGestVisuCompte);

//if RxSBC2.Down then
// begin
//   RxSBC2.Font.Color := clBlack;
//   if RxSBinv2.Down then
//    begin
//     DMGestVisu.LiaisonCompteTiers:=False;
//     DMGestVisu.QuGestVisuCompte.AfterScroll:=nil;
//    end
//   else
//    begin
//     DMGestVisu.LiaisonCompteTiers:= true;
//     DMGestVisu.QuGestVisuCompte.AfterScroll:=DMGestVisu.QuGestVisuCompteAfterScroll;
//     DMGestVisu.QuGestVisuCompteAfterScroll(DMGestVisu.QuGestVisuCompte);
//    end;
// end
//  else
// begin
//   RxSBC2.Font.Color := clLime;
//   if RxSBinv2.Down then
//    begin
//       DMGestVisu.LiaisonTiersCompte := true;
//       DMGestVisu.QuGestVisuTiersAfterScroll(DMGestVisu.QuGestVisuTiers);
//    end
//   else
//    begin
//     DeFiltrageDataSet(DMGestVisu.QuGestVisuTiers);
//    end;
// end;
end;

procedure TGestVisu.RxSBinv2Click(Sender: TObject);
begin
  if RxSBC2.Down then
   begin
     if RxSBinv2.Down then
      begin
       DMGestVisu.LiaisonCompteTiers:=False;
       DMGestVisu.QuGestVisuCompte.AfterScroll:=nil;
       DMGestVisu.LiaisonTiersCompte := true;
       DMGestVisu.QuGestVisuTiersAfterScroll(DMGestVisu.QuGestVisuTiers);
       DeFiltrageDataSet(DMGestVisu.QuGestVisuTiers);
      end
     else
      begin
       DMGestVisu.LiaisonTiersCompte := False;
       DMGestVisu.LiaisonCompteTiers := true;
       DMGestVisu.QuGestVisuCompte.AfterScroll:=DMGestVisu.QuGestVisuCompteAfterScroll;
       DMGestVisu.QuGestVisuCompteAfterScroll(DMGestVisu.QuGestVisuCompte);
      end;
   end
  else
   Begin
     DMGestVisu.LiaisonCompteTiers:=False;
     DMGestVisu.QuGestVisuCompte.AfterScroll:=nil;
     if RxSBinv2.Down then
      begin
       DMGestVisu.LiaisonTiersCompte := true;
       DMGestVisu.QuGestVisuTiersAfterScroll(DMGestVisu.QuGestVisuTiers);
      end
     else
      begin
       DMGestVisu.LiaisonTiersCompte := False;
      end;
   End;
end;

procedure TGestVisu.Aide1Click(Sender: TObject);
begin
  if ActiveControl = GrDBGridComptes then
   begin
     case GrDBGridComptes.SelectedField.Index of
        0:RechercherQu(GrDBGridComptes,DMGestVisu.QuGestVisuCompte,
                       ['Compte','Libelle'],
                       ['Compte','Libellé'],
                       '',
                       0,
                       'PlanCpt.db');
        1:RechercherQu(GrDBGridComptes,DMGestVisu.QuGestVisuCompte,
                       ['Libelle','Compte'],
                       ['Libellé','Compte'],
                       '',
                       0,
                       'PlanCpt.db');
     end;
   end;

  if ActiveControl = GrDBGridTiers then
   begin
     case GrDBGridTiers.SelectedField.Index of
        0:RechercherQu(GrDBGridTiers,DMGestVisu.QuGestVisuTiers,
                       ['Tiers','Nom','Compte'],
                       ['Tiers','Nom',''],
                       '',
                       0,
                       'Tiers.db');
        1:RechercherQu(GrDBGridTiers,DMGestVisu.QuGestVisuTiers,
                       ['Nom','Tiers','Compte'],
                       ['Nom','Tiers',''],
                       '',
                       0,
                       'Tiers.db');
     end;
   end;

  if ActiveControl = GrDBGridPieces then
   begin
     case GrDBGridPieces.SelectedField.Index of
        2:RechercherQu(GrDBGridPieces,DMGestVisu.QuGestVisuPiece,
                       ['Reference','Date','Libelle','Compte'],
                       ['Référence','Date','Libellé','Compte'],
                       '',
                       0,
                       'Piece.db');
        3:RechercherQu(GrDBGridPieces,DMGestVisu.QuGestVisuPiece,
                       ['Date','Reference','Libelle','Compte'],
                       ['Date','Référence','Libellé','Compte'],
                       '',
                       0,
                       'Piece.db');
        4:RechercherQu(GrDBGridPieces,DMGestVisu.QuGestVisuPiece,
                       ['Libelle','Reference','Date','Compte'],
                       ['Libellé','Référence','Date','Compte'],
                       '',
                       0,
                       'Piece.db');
        6:RechercherQu(GrDBGridPieces,DMGestVisu.QuGestVisuPiece,
                       ['Compte','Reference','Date','Libelle'],
                       ['Compte','Référence','Date','Libellé'],
                       '',
                       0,
                       'Piece.db');
     end;
   end;

  if ActiveControl = GrDBGridEcritures then
   begin
     case GrDBGridEcritures.SelectedField.Index of
        8:RechercherQu(GrDBGridEcritures,DMGestVisu.QuGestVisuEcr,
                       ['Compte','Tiers','Libelle','DebitSaisie','CreditSaisie'],
                       ['Compte','Tiers','Libelle','Debit','Credit'],
                       '',
                       0,
                       'Ecriture.db');
        14:RechercherQu(GrDBGridEcritures,DMGestVisu.QuGestVisuEcr,
                       ['Tiers','Compte','Libelle','DebitSaisie','CreditSaisie'],
                       ['Tiers','Compte','Libelle','Debit','Credit'],
                       '',
                       0,
                       'Ecriture.db');
        9:RechercherQu(GrDBGridEcritures,DMGestVisu.QuGestVisuEcr,
                       ['Libelle','Compte','Tiers','DebitSaisie','CreditSaisie'],
                       ['Libelle','Compte','Tiers','Debit','Credit'],
                       '',
                       0,
                       'Ecriture.db');
        10:RechercherQu(GrDBGridEcritures,DMGestVisu.QuGestVisuEcr,
                       ['DebitSaisie','Compte','Tiers','Libelle','CreditSaisie'],
                       ['Debit','Compte','Tiers','Libelle','Credit'],
                       '',
                       0,
                       'Ecriture.db');
        11:RechercherQu(GrDBGridEcritures,DMGestVisu.QuGestVisuEcr,
                       ['CreditSaisie','Compte','Tiers','Libelle','DebitSaisie'],
                       ['Credit','Compte','Tiers','Libelle','Debit'],
                       '',
                       0,
                       'Ecriture.db');
     end;
   end;

end;

procedure TGestVisu.Insrer1Click(Sender: TObject);
begin
Main.mnSaisiePieceClick(Main.mnSaisiePiece);
end;

procedure TGestVisu.RxSBJ1Click(Sender: TObject);
begin
DMGestVisu.LiaisonJournauxCompte:= RxSBJ1.Down;
end;

procedure TGestVisu.RxSBT3Click(Sender: TObject);
begin
GestionBouttonLiaison;

//DMGestVisu.QuGestVisuTiers.AfterScroll:=DMGestVisu.QuGestVisuTiersAfterScroll;
//DMGestVisu.QuGestVisuTiersAfterScroll(DMGestVisu.QuGestVisuTiers);

end;

procedure TGestVisu.RxSBP4Click(Sender: TObject);
begin
GestionBouttonLiaison;
//DMGestVisu.LiaisonPieceEcriture := RxSBP4.Down;
//RxSBP4.Transparent:=not RxSBP4.Down;

//DMGestVisu.QuGestVisuPiece.AfterScroll:=DMGestVisu.QuGestVisuPieceAfterScroll;
//DMGestVisu.QuGestVisuPieceAfterScroll(DMGestVisu.QuGestVisuPiece);

//if not DMGestVisu.LiaisonPieceEcriture then
// DeFiltrageDataSet(DMGestVisu.QuGestVisuEcr);
end;

procedure TGestVisu.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
try
canclose:=true;
//// à finir
///
if canclose then InitialiseTable_A_Nil;{ isa  le  29/01/04 }
except
  canclose:=false;
end;
end;

end.
