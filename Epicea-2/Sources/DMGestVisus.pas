unit DMGestVisus;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Gr_Librairie_Obj, E2_Librairie_Obj, LibSQL, ExtCtrls;

const

IntervalleTimer = 200;

type
  TDMGestVisu = class(TDataModule)
    QuGestVisuCompte: TQuery;
    QuGestVisuComptecompte: TStringField;
    DaGestVisuCompte: TDataSource;
    TaCompte: TTable;
    QuGestVisuTiers: TQuery;
    QuGestVisuTiersTiers: TStringField;
    QuGestVisuTiersNom: TStringField;
    QuGestVisuTiersCompte: TStringField;
    QuGestVisuTiersType: TStringField;
    QuGestVisuTiersActif: TBooleanField;
    DaGestVisuTiers: TDataSource;
    QuGestVisuEcr: TQuery;
    DaGestVisuEcr: TDataSource;
    QuGestVisuCompteLibelle: TStringField;
    TiCompte: TTimer;
    QuGestVisuJournaux: TQuery;
    DaGestVisuJournaux: TDataSource;
    QuGestVisuPiece: TQuery;
    DaGestVisuPiece: TDataSource;
    TiJournaux: TTimer;
    TiTiers: TTimer;
    TiPiece: TTimer;

    Procedure VisuCompteDuJournal(Query:TQuery;DateDeb,DateFin:TDate;Code_Journal:string;ChangeQuery:Boolean);
    Procedure VisuCompteAvecEcriture(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
    Procedure VisuCompteSansEcriture(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
    Procedure VisuCompteTous(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);

    Procedure VisuTiersAvecEcriture(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
    Procedure VisuTiersSansEcriture(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
    Procedure VisuTiersTous(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);

    Procedure VisuPieceJournal(Query:TQuery;DateDeb,DateFin:TDate;ID_Journal:Integer;ChangeQuery:Boolean);
    Procedure VisuPieceCompte(Query:TQuery;DateDeb,DateFin:TDate;Compte:String;ChangeQuery:Boolean);
    Procedure VisuPieceToutes(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);

    Procedure VisuEcritureJournal(Query:TQuery;DateDeb,DateFin:TDate;ID_Journal:Integer;ChangeQuery:Boolean);
    Procedure VisuEcritureCompte(Query:TQuery;DateDeb,DateFin:TDate;Compte:String;ChangeQuery:Boolean);
    Procedure VisuEcritureTiers(Query:TQuery;DateDeb,DateFin:TDate;Tiers:String;ChangeQuery:Boolean);
    Procedure VisuEcriturePiece(Query:TQuery;DateDeb,DateFin:TDate;ID_Piece:Integer;ChangeQuery:Boolean);
    Procedure VisuEcritureToutes(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);

    procedure DMGestVisuCreate(Sender: TObject);
    procedure QuGestVisuCompteAfterScroll(DataSet: TDataSet);
    procedure QuGestVisuTiersAfterScroll(DataSet: TDataSet);
    procedure TiCompteTimer(Sender: TObject);
    procedure QuGestVisuCompteBeforeScroll(DataSet: TDataSet);
    procedure QuGestVisuJournauxBeforeScroll(DataSet: TDataSet);
    procedure QuGestVisuJournauxAfterScroll(DataSet: TDataSet);
    procedure TiJournauxTimer(Sender: TObject);
    procedure TiTiersTimer(Sender: TObject);
    procedure TiPieceTimer(Sender: TObject);
    procedure QuGestVisuTiersBeforeScroll(DataSet: TDataSet);
    procedure QuGestVisuPieceBeforeScroll(DataSet: TDataSet);
    procedure QuGestVisuPieceAfterScroll(DataSet: TDataSet);
    procedure GestionDefiltrage;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    DateDebEcr,DateFinEcr:TDate;
    OrdreEcriture, OrdreCompte,OrdreTiers, OrdrePiece,OrdrePieceSiFiltre : string;
    OrdreCompteDesc,OrdreLibCompteDesc,OrdreEcrTiersDesc,OrdreTiersDesc:Boolean;
    OrdrePieceRefDesc : Boolean;
    LiaisonCompteTiers, LiaisonComptePiece, LiaisonCompteEcriture : Boolean;
    LiaisonTiersPiece, LiaisonTiersEcriture : Boolean;
    LiaisonPieceEcriture : Boolean;
    LiaisonTiersCompte,LiaisonJournauxCompte : Boolean;

  end;

var
  DMGestVisu: TDMGestVisu;

implementation

{$R *.DFM}

Procedure TDMGestVisu.VisuCompteAvecEcriture(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
      Query.SQL.Clear;

      Query.SQL.Add('select distinct E.compte, P.Libelle from Ecriture.db E '+
                    ' Join PlanCpt.db P On (E.Compte = P.Compte ) '+
                    ' where E."Date">=:DateDeb and E."Date"<=:DateFin'+
                    OrdreCompte);
    end;
   Query.ParamByName('DateDeb').AsDate := DateDeb;
   Query.ParamByName('DateFin').AsDate := DateFin;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuCompteSansEcriture(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
      Query.SQL.Clear;

      Query.SQL.Add('select P.compte, P.Libelle from PlanCpt.db P'+
                    ' where P.Compte not in(select Distinct E.Compte from Ecriture.db E where E."Date">=:DateDeb and E."Date"<=:DateFin)'+
                    OrdreCompte);
    end;
   Query.ParamByName('DateDeb').AsDate := DateDeb;
   Query.ParamByName('DateFin').AsDate := DateFin;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuCompteTous(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
      Query.SQL.Clear;
      Query.SQL.Add('select P.compte, P.Libelle from PlanCpt.db P'+OrdreCompte);
    end;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuCompteDuJournal(Query:TQuery;DateDeb,DateFin:TDate;Code_Journal:string;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
      Query.SQL.Clear;
      Query.SQL.Add('select distinct P.compte, P.Libelle from PlanCpt.db P'+
                    ' Join Ecriture.db E On (P.Compte = E.Compte ) '+
                    ' Join Piece.db Pi On (Pi.Id = E.Id_Piece ) '+
                    ' Join Model.db M On (Pi.Reference like(M.Journal+''%''))'+
                    ' where M.Journal = :Code_Journal and E.Id_Ligne = 0 '+
                    ' and E."Date">=:DateDeb and E."Date"<=:DateFin'+
                    OrdreCompte);
    end;
   Query.ParamByName('DateDeb').AsDate := DateDeb;
   Query.ParamByName('DateFin').AsDate := DateFin;
   Query.ParamByName('Code_Journal').AsString:=Code_Journal;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuTiersAvecEcriture(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
      Query.SQL.Clear;

      Query.SQL.Add('select distinct E.Tiers, T.Nom, T.Compte, T.Type, T.Actif from Ecriture.db E '+
                    ' Join Tiers.db P On (E.Tiers = P.Tiers ) '+
                    ' where E."Date">=:DateDeb and E."Date"<=:DateFin'+
                    OrdreTiers);
    end;
   Query.ParamByName('DateDeb').AsDate := DateDeb;
   Query.ParamByName('DateFin').AsDate := DateFin;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuTiersSansEcriture(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
      Query.SQL.Clear;

      Query.SQL.Add('select T.Tiers, T.Nom, T.Compte, T.Type, T.Actif from Tiers.db P'+
                    ' where T.Tiers not in(select Distinct E.Tiers from Ecriture.db E where E."Date">=:DateDeb and E."Date"<=:DateFin)'+
                    OrdreTiers);
    end;
   Query.ParamByName('DateDeb').AsDate := DateDeb;
   Query.ParamByName('DateFin').AsDate := DateFin;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuTiersTous(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
      Query.SQL.Clear;
      Query.SQL.Add('select T.Tiers, T.Nom, T.Compte, T.Type, T.Actif from Tiers.db T'+OrdreTiers);
    end;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuPieceJournal(Query:TQuery;DateDeb,DateFin:TDate;ID_Journal:Integer;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
     Query.SQL.Clear;
     Query.SQL.Add('select P.ID,P.Journal,P.Reference,P."Date",P.Libelle,P.Compte as CompteCP,E.Compte'+
                   ' From Piece P '+
                   ' Join Ecriture.db E on (P.Id = E.ID_Piece) '+
                   ' where '+
                   ' P.Journal=(:ID_Journal) '+
                   ' and P."Date" >=:DateDeb and P."Date" <=:DateFin '+
                   OrdrePiece);
     end;
   Query.ParamByName('DateDeb').AsDate := DateDeb;
   Query.ParamByName('DateFin').AsDate := DateFin;
   Query.ParamByName('ID_Journal').AsInteger:=ID_Journal;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

// Cette procedure fonctionne aussi bien pour les Compte que pour les Tiers
Procedure TDMGestVisu.VisuPieceCompte(Query:TQuery;DateDeb,DateFin:TDate;Compte:String;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
     Query.SQL.Clear;
     Query.SQL.Add('select P.ID,P.Journal,P.Reference,P."Date",P.Libelle,P.Compte as CompteCP,E.Compte'+
                   ' From Piece P '+
                   ' Join Ecriture.db E on (P.Id = E.ID_Piece) '+
                   ' where '+
                   ' P.Compte=(:Compte) '+
                   ' and P."Date" >=:DateDeb and P."Date" <=:DateFin '+
                   OrdrePiece);
     end;
   Query.ParamByName('DateDeb').AsDate := DateDeb;
   Query.ParamByName('DateFin').AsDate := DateFin;
   Query.ParamByName('Compte').AsString:=Compte;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuPieceToutes(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   // Toutes les écritures
   if not Query.Filtered then
    begin
      if ChangeQuery then
       begin
        Query.SQL.Clear;
        Query.SQL.Add('select P.ID,P.Journal,P.Reference,P."Date",P.Libelle,P.Compte as CompteCP'+
                      ' From Piece P '+
//                      ' Join Ecriture.db E on (P.Id = E.ID_Piece) '+
                      ' where '+
                      ' P."Date" >=:DateDeb and P."Date" <=:DateFin '+
                      OrdrePiece);
        end;
    end
   else
    begin
      if ChangeQuery then
       begin
        Query.SQL.Clear;
        Query.SQL.Add('select P.ID,P.Journal,P.Reference,P."Date",P.Libelle,P.Compte as CompteCP,E.Compte,E.Tiers'+
                      ' From Piece P '+
                      ' Join Ecriture.db E on (P.Id = E.ID_Piece) '+
                      ' where '+
                      ' P."Date" >=:DateDeb and P."Date" <=:DateFin '+
                      ' Group by P.Reference,P.ID,P.Journal,P."Date",P.Libelle,P.Compte,E.Compte,E.Tiers '+
                      OrdrePieceSiFiltre);
        end;
    end;
   Query.ParamByName('DateDeb').AsDate := DateDeb;
   Query.ParamByName('DateFin').AsDate := DateFin;
//   Query.ParamByName('Compte').AsString:=Compte;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuEcritureJournal(Query:TQuery;DateDeb,DateFin:TDate;ID_Journal:Integer;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
     Query.SQL.Clear;
     Query.SQL.Add('select E.ID,E.ID_Piece,P."Date",P.Quand,E.Quand,P.Reference,'+
                   'E.Id_Ligne,E."Date",E.Compte,E.Libelle,E.DebitSaisie,E.CreditSaisie,'+
                   'E.Qt1,E.Qt2, E.Tiers '+
                   ' From Piece P '+
                   '  Join Ecriture E On (P.Id = E.Id_Piece )'+
                   ' where '+
                   ' P.Journal=(:ID_Journal) '+
                   ' and E."Date" >=:DateDeb and E."Date" <=:DateFin '+
                   OrdreEcriture);
     end;
   Query.ParamByName('DateDeb').AsDate := DateDeb;
   Query.ParamByName('DateFin').AsDate := DateFin;
   Query.ParamByName('ID_Journal').AsInteger:=ID_Journal;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuEcritureCompte(Query:TQuery;DateDeb,DateFin:TDate;Compte:String;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
     Query.SQL.Clear;
     Query.SQL.Add('select E.ID,E.ID_Piece,P."Date",P.Quand,E.Quand,P.Reference,'+
                   'E.Id_Ligne,E."Date",E.Compte,E.Libelle,E.DebitSaisie,E.CreditSaisie,'+
                   'E.Qt1,E.Qt2, E.Tiers '+
                   ' From Piece P '+
                   '  Join Ecriture E On (P.Id = E.Id_Piece )'+
                   ' where '+
                   ' E.Compte=(:Compte) '+
                   ' and E."Date" >=:DateDeb and E."Date" <=:DateFin '+
                   OrdreEcriture);
     end;
   Query.ParamByName('DateDeb').AsDate := DateDeb;
   Query.ParamByName('DateFin').AsDate := DateFin;
   Query.ParamByName('Compte').AsString:=Compte;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuEcritureTiers(Query:TQuery;DateDeb,DateFin:TDate;Tiers:String;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
     Query.SQL.Clear;
     Query.SQL.Add('select E.ID,E.ID_Piece,P."Date",P.Quand,E.Quand,P.Reference,'+
                   'E.Id_Ligne,E."Date",E.Compte,E.Libelle,E.DebitSaisie,E.CreditSaisie,'+
                   'E.Qt1,E.Qt2, E.Tiers '+
                   ' From Piece P '+
                   '  Join Ecriture E On (P.Id = E.Id_Piece )'+
                   ' where '+
                   ' E.Tiers=(:Tier) '+
                   ' and E."Date" >=:DateDeb and E."Date" <=:DateFin '+
                   OrdreEcriture);
     end;
   Query.ParamByName('DateDeb').AsDate := DateDeb;
   Query.ParamByName('DateFin').AsDate := DateFin;
   Query.ParamByName('tier').AsString:=Tiers;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuEcriturePiece(Query:TQuery;DateDeb,DateFin:TDate;ID_Piece:Integer;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
     Query.SQL.Clear;
     Query.SQL.Add('select E.ID,E.ID_Piece,P."Date",P.Quand,E.Quand,P.Reference,'+
                   'E.Id_Ligne,E."Date",E.Compte,E.Libelle,E.DebitSaisie,E.CreditSaisie,'+
                   'E.Qt1,E.Qt2, E.Tiers '+
                   ' From Piece P '+
                   '  Join Ecriture E On (P.Id = E.Id_Piece )'+
                   ' where '+
                   ' E.ID_Piece=(:ID_Piece) '+
//                   ' and E."Date" >=:DateDeb and E."Date" <=:DateFin '+
                   OrdreEcriture);
     end;
//   Query.ParamByName('DateDeb').AsDate := DateDeb;
//   Query.ParamByName('DateFin').AsDate := DateFin;
   Query.ParamByName('ID_Piece').AsInteger:=ID_Piece;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

Procedure TDMGestVisu.VisuEcritureToutes(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
Begin
 Try
   ProtectObjetNil([Query]);
   Query.DisableControls;
   Query.Close;
   if ChangeQuery then
    begin
     Query.SQL.Clear;
     Query.SQL.Add('select E.ID,E.ID_Piece,P."Date",P.Quand,E.Quand,P.Reference,'+
                   'E.Id_Ligne,E."Date",E.Compte,E.Libelle,E.DebitSaisie,E.CreditSaisie,'+
                   'E.Qt1,E.Qt2, E.Tiers '+
                   ' From Ecriture E '+
                   '  Join Piece P On (P.Id = E.Id_Piece ) '+
                   OrdreEcriture);
     end;
//   Query.ParamByName('DateDeb').AsDate := DateDeb;
//   Query.ParamByName('DateFin').AsDate := DateFin;
//   Query.ParamByName('ID_Piece').AsInteger:=ID_Piece;
   Query.Open;
   Query.EnableControls;
 except
   abort;
 end;

End;

procedure TDMGestVisu.DMGestVisuCreate(Sender: TObject);
begin
// Initialisation des valeurs des paramètres des Query Par défaut
DateDebEcr:=E.DatExoDebut;
DateFinEcr:=E.DatExoFin;

OrdrePiece := ' order by P.Reference ';
OrdrePieceSiFiltre := ' order by P.Reference,P.ID,P.Journal,P."Date",P.Libelle,P.Compte,E.Compte,E.Tiers ';
OrdrePieceRefDesc := false;

OrdreEcriture :=' order by P.Reference ';
OrdreEcrTiersDesc:=False;

OrdreCompte := ' order by P.Compte ';
OrdreCompteDesc:=False;
OrdreLibCompteDesc:=False;

OrdreTiers := ' order by T.Tiers ';
OrdreTiersDesc:=False;


// Initialisation des Timer
TiCompte.Interval :=IntervalleTimer;
TiPiece.Interval := IntervalleTimer;

// Liaison Descendante entre Query
LiaisonCompteTiers := False;
LiaisonComptePiece:= False;
LiaisonCompteEcriture := False;

LiaisonTiersPiece:= False;
LiaisonTiersEcriture := False;

LiaisonPieceEcriture := False;

// Liaison Ascendante entre Query
LiaisonTiersCompte := False;

LiaisonJournauxCompte := false;

// Ouverture des Query
//VisuEcritureTiers(QuGestVisuEcrTiers,DateDebEcr,DateFinEcr,True);
QuGestVisuJournaux.Open;

VisuCompteTous(QuGestVisuCompte,DateDebEcr,DateFinEcr,true);

//VisuTiersAvecEcriture(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
//VisuTiersSansEcriture(Query:TQuery;DateDeb,DateFin:TDate;ChangeQuery:Boolean);
VisuTiersTous(QuGestVisuTiers,DateDebEcr,DateFinEcr,true);

VisuPieceToutes(QuGestVisuPiece,DateDebEcr,DateFinEcr,true);

VisuEcritureToutes(QuGestVisuEcr,DateDebEcr,DateFinEcr,true);

end;

procedure TDMGestVisu.QuGestVisuCompteAfterScroll(DataSet: TDataSet);
begin
TiCompte.Enabled := not (Not LiaisonCompteTiers and not LiaisonComptePiece and not LiaisonCompteEcriture);
end;

procedure TDMGestVisu.QuGestVisuTiersAfterScroll(DataSet: TDataSet);
begin
TiTiers.Enabled := not (Not LiaisonTiersPiece and not LiaisonTiersEcriture);
//GestionDefiltrage;

// VisuEcritureTiers(QuGestVisuEcr,DateDebEcr,DateFinEcr,QuGestVisuTiers.findfield('Tiers').AsString,False);
// If LiaisonTiersCompte then
//  GrLocate(DMGestVisu.QuGestVisuCompte,'Compte',[DMGestVisu.QuGestVisuTiers.findfield('Compte').AsString])
end;

procedure TDMGestVisu.QuGestVisuJournauxAfterScroll(DataSet: TDataSet);
begin
TiJournaux.Enabled := LiaisonJournauxCompte;
end;

procedure TDMGestVisu.TiCompteTimer(Sender: TObject);
begin
if LiaisonCompteTiers then
 begin
   FiltrageDataSet(QuGestVisuTiers,'Compte = '''+QuGestVisuCompte.findfield('Compte').AsString+'''');
 end;

if LiaisonComptePiece then
 begin
   QuGestVisuPiece.filtered:=true;
   VisuPieceToutes(QuGestVisuPiece,DateDebEcr,DateFinEcr,true);
   FiltrageDataSet(QuGestVisuPiece,'Compte = '''+QuGestVisuCompte.findfield('Compte').AsString+'''');
 end;

if LiaisonCompteEcriture then
 begin
   FiltrageDataSet(QuGestVisuEcr,'Compte = '''+QuGestVisuCompte.findfield('Compte').AsString+'''');
 end;

TiCompte.Enabled := False;
end;

procedure TDMGestVisu.QuGestVisuCompteBeforeScroll(DataSet: TDataSet);
begin
 TiCompte.Enabled := false;
end;

procedure TDMGestVisu.QuGestVisuJournauxBeforeScroll(DataSet: TDataSet);
begin
TiJournaux.Enabled := False;
end;

procedure TDMGestVisu.TiJournauxTimer(Sender: TObject);
begin
VisuCompteDuJournal(QuGestVisuCompte,DateDebEcr,DateFinEcr,QuGestVisuJournaux.findField('Journal').AsString,true);
//QuGestVisuTiers.DisableControls;
//FiltrageDataSet(QuGestVisuTiers,'Compte = '''+QuGestVisuCompte.findfield('Compte').AsString+'''');
//QuGestVisuTiers.EnableControls;
TiJournaux.Enabled := False;
end;

procedure TDMGestVisu.TiTiersTimer(Sender: TObject);
var
TiersStr:string;
begin
if LiaisonTiersPiece then
 begin
   QuGestVisuPiece.filtered:=true;
   VisuPieceToutes(QuGestVisuPiece,DateDebEcr,DateFinEcr,true);
   TiersStr:=QuGestVisuTiers.findfield('Tiers').AsString;
   if empty(TiersStr) then TiersStr := '-1';
   FiltrageDataSet(QuGestVisuPiece,'Tiers = '''+TiersStr+'''');
 end;

if LiaisonTiersEcriture then
 begin
   FiltrageDataSet(QuGestVisuEcr,'Tiers = '''+QuGestVisuTiers.findfield('Tiers').AsString+'''');
 end;

TiTiers.Enabled := False;
end;

procedure TDMGestVisu.TiPieceTimer(Sender: TObject);
var
ID_Piece:String;
begin
TiPiece.Enabled := False;
if LiaisonPieceEcriture then
 begin
   Id_Piece:=QuGestVisuPiece.findfield('ID').AsString;
   if empty(Id_Piece) then Id_Piece:='-1';
   FiltrageDataSet(QuGestVisuEcr,'ID_Piece = '+ID_Piece);
 end;
end;

procedure TDMGestVisu.QuGestVisuTiersBeforeScroll(DataSet: TDataSet);
begin
TiTiers.Enabled := False;
end;

procedure TDMGestVisu.QuGestVisuPieceBeforeScroll(DataSet: TDataSet);
begin
TiPiece.Enabled := False;
end;

procedure TDMGestVisu.QuGestVisuPieceAfterScroll(DataSet: TDataSet);
begin
TiPiece.Enabled := LiaisonPieceEcriture;
end;

procedure TDMGestVisu.GestionDefiltrage;
Begin
// Defiltrage QuGestVisuTiers
if (not LiaisonCompteTiers) then
 begin
  DeFiltrageDataSet(QuGestVisuTiers);
 end;

if (LiaisonCompteTiers or LiaisonComptePiece or LiaisonCompteEcriture) then
 begin
  QuGestVisuCompteAfterScroll(DMGestVisu.QuGestVisuCompte);
 end;
// Defiltrage QuGestVisuPiece
if (not LiaisonComptePiece and not LiaisonTiersPiece) then
begin
 DeFiltrageDataSet(QuGestVisuPiece);
 VisuPieceToutes(QuGestVisuPiece,DateDebEcr,DateFinEcr,true);
end;

if (LiaisonTiersPiece or LiaisonTiersEcriture) then
 QuGestVisuTiers.AfterScroll(QuGestVisuTiers);
// defiltrage QUGestVisuEcr
if (Not LiaisonCompteEcriture and not LiaisonTiersEcriture and not LiaisonPieceEcriture) then
 DeFiltrageDataSet(QuGestVisuEcr);

if LiaisonPieceEcriture then
 QuGestVisuPiece.AfterScroll(QuGestVisuPiece);

End;

end.
