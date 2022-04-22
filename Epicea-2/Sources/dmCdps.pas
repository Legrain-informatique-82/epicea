unit dmCdps;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TdmCdp = class(TDataModule)
    qRechercheFils_TypeFils: TQuery;
    qRechercheFils_TypeFilsFils: TStringField;
    qRechercheFils_TypeFilsTypeFils: TSmallintField;
    qRechercheFils_TypeFilsRatio: TFloatField;
    qCalculeRatioTotal: TQuery;
    qCalculeRatioTotalTotRatio: TFloatField;
    qEcritureCdp: TQuery;
    dsEcritureCdp: TDataSource;
    TaCdp: TTable;
    daCdp: TDataSource;
    TaCdpId: TIntegerField;
    TaCdpCdp: TStringField;
    TaCdpLibelleCdp: TStringField;
    qTrouveRelationCdp: TQuery;
    qTrouveRelationCdpCdp: TStringField;
    qMaxIdCdp: TQuery;
    qMaxIdCdpMaxId: TIntegerField;
    qTrouveCdp: TQuery;
    qTrouveCdpCdp: TStringField;
    TaCptAB_Cdp: TTable;
    daCptAB_Cdp: TDataSource;
    qTrouveFils: TQuery;
    qMaxIdCptAB_Cdp: TQuery;
    qMaxIdCptAB_CdpMaxId: TIntegerField;
    TaCptAB_CdpId: TIntegerField;
    TaCptAB_CdpCdp: TStringField;
    TaCptAB_CdpFils: TStringField;
    TaCptAB_CdpRatio: TFloatField;
    TaCptAB_CdpTypeFils: TSmallintField;
    procedure TaCdpBeforeDelete(DataSet: TDataSet);
    procedure TaCdpBeforeEdit(DataSet: TDataSet);
    procedure TaCdpBeforePost(DataSet: TDataSet);
    procedure TaCdpCdpValidate(Sender: TField);
    procedure TaCptAB_CdpBeforePost(DataSet: TDataSet);
    procedure TaCptAB_CdpFilsValidate(Sender: TField);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Debit, Credit, Ratio: Real;
    procedure TraiteCdp(Const Cdp: String);
    procedure ConstruitListe(ListeSource: TList);
    Procedure ListeFils_TypeFils(Const Cdp: String);
    function TrouveRelationCdp(Const Cdp: String): Boolean;
    function RechercheMaxIdCdp: Integer;
    function RechercheMaxIdCptAB_Cdp: Integer;
    function TrouveCdp(Const Cdp: String): Boolean;
    function TrouveFils(Const Cpt: String): Boolean;
  end;

var
  dmCdp: TdmCdp;

implementation

uses dmComptesA, dmComptesB;

Type
  PMaListeSource = ^AListeSource;
  AListeSource = record
                      Fils: String;
                      TypeFils: Integer;
                      Ratio: Real;
                end;

Var
   MaListeSource: TList;
   RecordListeSource: PMaListeSource;
   CptByte: Byte;

{$R *.DFM}

//******************************************************************************
procedure TdmCdp.ConstruitListe(ListeSource: TList);
var
   B: Byte;
   RatioTotal: Real;
   AncienRatio: Real;
begin
     For B := CptByte to (ListeSource.Count - 1) do
     begin
          RecordListeSource := ListeSource.Items[B];
          If (RecordListeSource^.TypeFils = 0) Then
          begin
               // Calcul du ratio total
               qCalculeRatioTotal.Close;
               qCalculeRatioTotal.Params.ParamByName('vCdp').AsString := RecordListeSource^.Fils;
               qCalculeRatioTotal.open;
               RatioTotal := qCalculeRatioTotal.fieldByName('TotRatio').AsFloat;

               AncienRatio := RecordListeSource^.Ratio;

               ListeFils_TypeFils(RecordListeSource^.Fils);
               ListeSource.Delete(B);
               With qRechercheFils_TypeFils do
               begin
                    First;
                    While not eof do
                    begin
                         New(RecordListeSource);
                         RecordListeSource^.Fils := FieldByName('Fils').AsString;
                         RecordListeSource^.TypeFils := FieldByName('TypeFils').AsInteger;
                         RecordListeSource^.Ratio := AncienRatio * (FieldByName('Ratio').AsFloat / RatioTotal);
                         ListeSource.Add(RecordListeSource);
                         next;
                    end;
                    CptByte := B;
                    // appel récurssif à la procédure
                    construitListe(ListeSource)
               end;
          end;
     end;
end;


//******************************************************************************
procedure TdmCdp.TraiteCdp(Const Cdp: String);
var
   B: Byte;
   RatioTotal: Real;
   MaRequete: TStringList;
begin
     MaRequete := TStringList.Create;
     MaListeSource := TList.Create;
     Try
        // Calcul du ratio total
        qCalculeRatioTotal.Close;
        qCalculeRatioTotal.Params.ParamByName('vCdp').AsString := Cdp;
        qCalculeRatioTotal.open;
        RatioTotal := qCalculeRatioTotal.fieldByName('TotRatio').AsFloat;

        ListeFils_TypeFils(cdp);
        // Remplissage de la liste sources
        With qRechercheFils_TypeFils do
        begin
             First;
             While not eof do
             begin
                  New(RecordListeSource);
                  RecordListeSource^.Fils := FieldByName('Fils').AsString;
                  RecordListeSource^.TypeFils := FieldByName('TypeFils').AsInteger;
                  RecordListeSource^.Ratio := FieldByName('Ratio').AsFloat / RatioTotal;
                  MaListeSource.Add(RecordListeSource);
                  next;
             end;
        end;
        CptByte := 0;

        ConstruitListe(MaListeSource);

        // Calcul du débit/Crédit du Cdp
        Debit  := 0;
        Credit := 0;
        MaRequete.Clear;
        For B := 0 To (MaListeSource.Count - 1) do
        begin
             RecordListeSource := MaListeSource.Items[B];
             Ratio := recordListeSource^.Ratio;
             Case RecordListeSource^.TypeFils of
                  -1: begin
                           // Gestion des compteA
                           dmCompteA.CalculDebitCreditCompteA(RecordListeSource^.Fils,0);
                           // Gestion de la requete
                           If MaRequete.Text <> '' Then
                              MaRequete.Add(' UNION ALL');
                           MaRequete.Add('Select CptCptA.CompteA, E.Libelle, E.Compte, E.Credit, ');
                           MaRequete.Add('  E.Debit, (CptCptA.Ratio * ' +  FloatToStr(Ratio) +') As Ratio');
                           MaRequete.Add('From CompteA CptA ');
                           MaRequete.Add('  Join Cpt_CptA CptCptA On (CptA.Id = CptCptA.IdCompteA) ');
                           MaRequete.Add('  Join Ecriture E On (E.Compte = CptCptA.Compte) ');
                           MaRequete.Add('Where CptA.CompteA = ''' + RecordListesource^.Fils + '''');
                      end;
                   0: ShowMessage('Ne peut traiter les cdp');
                   1: begin
                           // Gestion des comptesB
                           dmCompteB.CalculDebitCreditCompteB(RecordListeSource^.Fils,0);
                           // Gestion de la requete
                           If MaRequete.Text <> '' Then
                              MaRequete.Add(' UNION ALL');
                           MaRequete.Add('Select CptCptB.CompteB, E.Libelle, E.Compte, E.Credit, ');
                           MaRequete.Add('  E.Debit, (CptCptB.Ratio * ' +  FloatToStr(Ratio) +') As Ratio');
                           MaRequete.Add('From CompteB CptB ');
                           MaRequete.Add('  Join Cpt_CptB CptCptB On (CptB.Id = CptCptB.IdCompteB) ');
                           MaRequete.Add('  Join Ecriture E On (E.Compte = CptCptB.Compte) ');
                           MaRequete.Add('Where CptB.CompteB = ''' + RecordListesource^.Fils + '''');
                      end;
             end;
        end;

        qEcritureCdp.Close;
        qEcritureCdp.sql.clear;
        qEcritureCdp.sql.Text := MaRequete.Text;
        qEcritureCdp.open;

        // Libération de la mémoire
        For B := 0 to (MaListeSource.Count - 1) do
        begin
             RecordListeSource := MaListeSource.Items[B];
             Dispose(RecordListeSource);
        end;
     Finally
        qRechercheFils_TypeFils.Close;
        MaRequete.Free;
        MaListeSource.Free;
     end;
end;

//******************************************************************************
procedure TdmCdp.ListeFils_TypeFils(Const Cdp: String);
begin
     With qRechercheFils_TypeFils do
     begin
          If Active Then Close;
          Params.ParamByName('vCdp').AsString := Trim(Cdp);
          Open;
     end;
end;

//******************************************************************************
function TdmCdp.TrouveRelationCdp(Const Cdp: String): Boolean;
begin
     with qTrouveRelationCdp do
     begin
          If Active Then Close;
          Params.ParamByName('vCdp').AsString := Trim(Cdp);
          Open;
          Result := Not IsEmpty;
          Close;
     end;
end;

//******************************************************************************
procedure TdmCdp.TaCdpBeforeDelete(DataSet: TDataSet);
begin
     If TrouveRelationCdp(TaCdp.FieldByName('Cdp').AsString) Then
        Raise Exception.Create('Suppression impossible: ce cdp est dans une table de relation');

end;

//******************************************************************************
procedure TdmCdp.TaCdpBeforeEdit(DataSet: TDataSet);
begin
     If TrouveRelationCdp(TaCdp.FieldByName('Cdp').AsString) Then
        Raise Exception.Create('Modification impossible: ce cdp est dans une table de relation');
end;

//******************************************************************************
procedure TdmCdp.TaCdpBeforePost(DataSet: TDataSet);
begin
     // Affectation Id en mode Insertion
     If DataSet.State = dsInsert Then
        DataSet.FieldByName('Id').AsInteger := RechercheMaxIdCdp + 1;
end;

//******************************************************************************
//  Fonction qui permet de rechercher le max Id de la table Cdp
//******************************************************************************
function TdmCdp.RechercheMaxIdCdp: Integer;
begin
     with qMaxIdCdp do
     begin
          If Active then close;
          Open;
          Result := FieldByName('MaxId').AsInteger;
          Close;
     end;
end;

//******************************************************************************
function TdmCdp.TrouveCdp(Const Cdp: String): Boolean;
begin
     With qTrouveCdp do
     begin
          If Active Then Close;
          Params.ParamByName('vCdp').AsString := Trim(Cdp);
          Open;
          Result := Not IsEmpty;
          Close;
     end;
end;

//******************************************************************************
procedure TdmCdp.TaCdpCdpValidate(Sender: TField);
begin
     If TrouveCdp(TaCdp.FieldByName('Cdp').AsString) Then
        Raise Exception.Create('Ce cdp existe déjà');
end;

//******************************************************************************
function TdmCdp.TrouveFils(Const Cpt: String): Boolean;
begin
     With qTrouveFils do
     begin
          If Active Then Close;
          Params.ParamByName('vFils').AsString := Trim(Cpt);
          Open;
          Result := Not IsEmpty;
          Close;
     end;
end;

//******************************************************************************
procedure TdmCdp.TaCptAB_CdpBeforePost(DataSet: TDataSet);
begin
     If Not TrouveFils(DataSet.FieldByName('Fils').AsString) Then
     begin
          Raise Exception.Create('Ce fils n''existe pas');
     end;
     // Affectation Id en mode insertion
     If DataSet.State = dsInsert Then
     begin
          DataSet.FieldByName('Id').AsInteger := RechercheMaxIdCptAB_Cdp + 1;
          DataSet.FieldByName('Cdp').AsString := TaCdp.FieldByName('Cdp').AsString;
     end;
end;

//******************************************************************************
function TdmCdp.RechercheMaxIdCptAB_Cdp: Integer;
begin
     with qMaxIdCptAB_Cdp do
     begin
          If Active then close;
          Open;
          Result := FieldByName('MaxId').AsInteger;
          Close;
     end;
end;

//******************************************************************************
procedure TdmCdp.TaCptAB_CdpFilsValidate(Sender: TField);
begin
     If Not TrouveFils(TaCptAB_Cdp.FieldByName('Fils').AsString) Then
        Raise Exception.Create('Ce fils n''existe pas');
end;

end.
