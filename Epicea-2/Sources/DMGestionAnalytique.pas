{ Requete ordonneé par : Activité
                         Atelier
                         Compte comptable
Select
cdp.Cdp, CompteA.CompteA, E.Compte, E.Id, CptCptA.Ratio,
  Sum(E.Credit) As TotCredit,
  Sum(E.debit) As TotDebit
From CompteA CptA
  Join Cpt_CptA CptCptA On (CptA.Id = CptCptA.IdCompteA)
  Join Ecriture E On (E.Compte = CptCptA.Compte)
  join Cdp Cd on (Cdp.id = CptCptA.IDCdpPere)
 where E.Id not in (select LCpt_CptA.IDLigne from LCpt_CptA )
Group by cdp.Cdp, E.Compte,CompteA.CompteA,E.Id,CptCptA.Ratio

union

Select
cdp.Cdp, CompteA.CompteA, E.Compte, E.Id, LCptCptA.Ratio,
  Sum(E.Credit) As TotCredit,
  Sum(E.debit) As TotDebit
From CompteA CptA
  Join LCpt_CptA LCptCptA On (CptA.Id = LCptCptA.IdCompteA)
  Join Ecriture E On (E.Id = LCptCptA.IDLigne)
  join Cdp Cd on (Cdp.id = LCptCptA.IDCdpPere)
Group by cdp.Cdp, E.Compte,CompteA.CompteA,E.Id,LCptCptA.Ratio
}

{ Requete ordonneé par : Activité
                         Compte comptable
                         Atelier
Select
cdp.Cdp, E.Compte, CompteA.CompteA, E.Id, CptCptA.Ratio,
  Sum(E.Credit) As TotCredit,
  Sum(E.debit) As TotDebit
From CompteA CptA
  Join Cpt_CptA CptCptA On (CptA.Id = CptCptA.IdCompteA)
  Join Ecriture E On (E.Compte = CptCptA.Compte)
  join Cdp Cd on (Cdp.id = CptCptA.IDCdpPere)
 where E.Id not in (select LCpt_CptA.IDLigne from LCpt_CptA )
Group by cdp.Cdp, E.Compte,CompteA.CompteA,E.Id,CptCptA.Ratio

union

Select
cdp.Cdp, E.Compte, CompteA.CompteA, E.Id, LCptCptA.Ratio,
  Sum(E.Credit) As TotCredit,
  Sum(E.debit) As TotDebit
From CompteA CptA
  Join LCpt_CptA LCptCptA On (CptA.Id = LCptCptA.IdCompteA)
  Join Ecriture E On (E.Id = LCptCptA.IDLigne)
  join Cdp Cd on (Cdp.id = LCptCptA.IDCdpPere)
Group by cdp.Cdp, E.Compte,CompteA.CompteA,E.Id,LCptCptA.Ratio
}

unit DMGestionAnalytique;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db,LibSQL,Gr_Librairie_Obj,LibZoneSaisie,E2_Decl_Records;

type
  TParamGestAnal = record
   Code : string;
   Id   : Integer;
   end;
   
  TDMGestionAnal = class(TDataModule)
    quSumRatioPlanCpt: TQuery;
    quSumRatioPlanCptTotRatio: TFloatField;
    quSumEcriture: TQuery;
    quSumEcritureTotCredit: TCurrencyField;
    quSumEcritureTotDebit: TCurrencyField;
    TaEcritureAnal: TTable;
    quSumLRatioPlanCpt: TQuery;
    FloatField1: TFloatField;
    quSumEcritureId: TIntegerField;
    quSumEcritureCompte: TStringField;
    quSumEcritureRatio: TFloatField;
    quSumEcritureCompteA: TStringField;
    quSumEcritureMontantAffecteDebit: TCurrencyField;
    quSumEcritureMontantAffecteCredit: TCurrencyField;
    DaSumEcriture: TDataSource;
    quSumRatioPlanCptCompte: TStringField;
    quSumLRatioPlanCptIDLigne: TIntegerField;
    TaCdp: TTable;
    TaCompteA: TTable;
    DaCdp: TDataSource;
    DaCompteA: TDataSource;
    TaPlancptAnal: TTable;
    DaPlancptAnal: TDataSource;
    TaCdpAffectation: TTable;
    DaCdpAffectation: TDataSource;
    TaCompteAAffectation: TTable;
    DaCompteAAffectation: TDataSource;
    TaCpt_CptA: TTable;
    DaCpt_CptA: TDataSource;
    QuSuppresionAffectationCompte: TQuery;
    DaEcritureAnal: TDataSource;
    TaCdpAffectationL: TTable;
    DaCdpAffectationL: TDataSource;
    TaCompteAAffectationL: TTable;
    DaCompteAAffectationL: TDataSource;
    TaCpt_CptAL: TTable;
    DaCpt_CptAL: TDataSource;
    QuSuppresionAffectationLigne: TQuery;
    TaCpt_CptALId: TIntegerField;
    TaCpt_CptALIDCompteA: TIntegerField;
    TaCpt_CptALIDCdpPere: TIntegerField;
    TaCpt_CptALIDLigne: TIntegerField;
    TaCpt_CptALCompteA: TStringField;
    TaCpt_CptALRatio: TFloatField;
    TaCpt_CptAId: TIntegerField;
    TaCpt_CptAIDCompteA: TIntegerField;
    TaCpt_CptAIDCdpPere: TIntegerField;
    TaCpt_CptACompte: TStringField;
    TaCpt_CptACompteA: TStringField;
    TaCpt_CptARatio: TFloatField;
    quSumEcritureCdp: TStringField;
    TaCdpCalc: TTable;
    TaCompteACalc: TTable;
    DaCdpCalc: TDataSource;
    DaCompteACalc: TDataSource;
    TaCdpId: TIntegerField;
    TaCdpCdp: TStringField;
    TaCdpLibelleCdp: TStringField;
    TaCdpUnite: TStringField;
    TaCdpLibelleUnite: TStringField;
    TaPlancptAnalEcriture: TIntegerField;
    TaPlancptAnalCompte: TStringField;
    procedure quSumEcritureCalcFields(DataSet: TDataSet);
    procedure quSumEcritureBeforeOpen(DataSet: TDataSet);
    procedure quSumEcritureAfterClose(DataSet: TDataSet);
    procedure TaCdpAfterPost(DataSet: TDataSet);
    procedure TaCdpBeforePost(DataSet: TDataSet);
    procedure TaCdpAfterCancel(DataSet: TDataSet);
    procedure TaCompteABeforeCancel(DataSet: TDataSet);
    procedure TaCdpBeforeScroll(DataSet: TDataSet);
    procedure TaCompteAAfterInsert(DataSet: TDataSet);
    procedure TaPlancptAnalBeforeEdit(DataSet: TDataSet);
    procedure TaCompteABeforeDelete(DataSet: TDataSet);
    procedure TaPlancptAnalBeforeDelete(DataSet: TDataSet);
    procedure TaPlancptAnalBeforeInsert(DataSet: TDataSet);
    procedure TaPlancptAnalBeforePost(DataSet: TDataSet);
    procedure TaCpt_CptABeforeInsert(DataSet: TDataSet);
    procedure TaEcritureAnalBeforeDelete(DataSet: TDataSet);
    procedure TaEcritureAnalBeforeEdit(DataSet: TDataSet);
    procedure TaEcritureAnalBeforeInsert(DataSet: TDataSet);
    procedure TaEcritureAnalBeforePost(DataSet: TDataSet);
    procedure TaCpt_CptALBeforeInsert(DataSet: TDataSet);
    procedure GestionAnalCreate(Sender: TObject);
    procedure GestionAnalDestroy(Sender: TObject);
    procedure quSumEcritureFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TaCdpAfterOpen(DataSet: TDataSet);
    procedure TaCompteAAfterOpen(DataSet: TDataSet);
    Function CtrlSaisieCdp(CCourant:TField):TExceptLGR;
  private
    { Déclarations privées }
   OldStateTaCdp:TDataSetState;
   IDDernierCdpAjout:Integer;
   DernierParamGestAnalCompte,DernierParamGestAnalLigne:TParamGestAnal;
  public
    { Déclarations publiques }
    ListeActiviteResult,ListeAtelierResult:TStringList;
  end;

var
  DMGestionAnal: TDMGestionAnal;

implementation

uses DMRecherche;

{$R *.DFM}

procedure TDMGestionAnal.quSumEcritureCalcFields(DataSet: TDataSet);
begin
// Si l'ecriture en cours est une ligne affecté Manuellement

if quSumLRatioPlanCpt.Locate('IDLigne',DataSet.FindField('ID').AsInteger,[]) then
 begin
  DataSet.FindField('MontantAffecteDebit').AsCurrency:=0;
  if not VerifFNumeric(quSumLRatioPlanCpt.FindField('TotRatio')).VideOUZero then
   DataSet.FindField('MontantAffecteDebit').AsCurrency:=quSumEcritureTotDebit.AsCurrency *(DataSet.FindField('Ratio').AsCurrency / quSumLRatioPlanCpt.FindField('TotRatio').AsCurrency);
  DataSet.FindField('MontantAffecteCredit').AsCurrency:=0;
  if not VerifFNumeric(quSumLRatioPlanCpt.FindField('TotRatio')).VideOUZero then
   DataSet.FindField('MontantAffecteCredit').AsCurrency:=quSumEcritureTotCredit.AsCurrency *(DataSet.FindField('Ratio').AsCurrency / quSumLRatioPlanCpt.FindField('TotRatio').AsCurrency);
 end
 else
 if quSumRatioPlanCpt.Locate('Compte',DataSet.FindField('Compte').AsInteger,[]) then
 begin
   DataSet.FindField('MontantAffecteDebit').AsCurrency:=0;
   if not VerifFNumeric(quSumRatioPlanCpt.FindField('TotRatio')).VideOUZero then
   DataSet.FindField('MontantAffecteDebit').AsCurrency:=quSumEcritureTotDebit.AsCurrency *(DataSet.FindField('Ratio').AsCurrency / quSumRatioPlanCpt.FindField('TotRatio').AsCurrency);

   DataSet.FindField('MontantAffecteCredit').AsCurrency:=0;
   if not VerifFNumeric(quSumRatioPlanCpt.FindField('TotRatio')).VideOUZero then
   DataSet.FindField('MontantAffecteCredit').AsCurrency:=quSumEcritureTotCredit.AsCurrency *(DataSet.FindField('Ratio').AsCurrency / quSumRatioPlanCpt.FindField('TotRatio').AsCurrency);
 end
// quSumEcritureMontantAffecteCredit.AsCurrency:=quSumEcritureTotCredit.AsCurrency*(quSumEcritureRatio.AsCurrency / quSumRatioPlanCpt.FindField('TotRatio').AsCurrency);
end;

procedure TDMGestionAnal.quSumEcritureBeforeOpen(DataSet: TDataSet);
begin
quSumRatioPlanCpt.Open;
quSumLRatioPlanCpt.Open;
end;

procedure TDMGestionAnal.quSumEcritureAfterClose(DataSet: TDataSet);
begin
quSumRatioPlanCpt.Close;
quSumLRatioPlanCpt.Close;
end;

procedure TDMGestionAnal.TaCdpAfterPost(DataSet: TDataSet);
begin
if OldStateTaCdp = dsInsert then
 if TaCompteA.State <> dsInsert then
   TaCompteA.Insert;
if TaCompteA.State = dsInsert then
 begin
   TaCompteA.Fields[1].FocusControl;
   TaCompteA.FindField('ID').AsInteger:=MaxId_Query(TaCompteA,'Id');
   TaCompteA.FindField('IDCdpPere').AsInteger:=DataSet.FindField('ID').AsInteger;
   TaCompteA.FindField('CompteA').AsString:='ATL'+IntToStr(TaCompteA.RecordCount+1);
   TaCompteA.FindField('LibelleA').AsString:='Atelier '+IntToStr(TaCompteA.RecordCount+1);

//   TaCptAB_Cdp.Insert;
//   TaCptAB_Cdp.FindField('ID').AsInteger:=MaxId_Query(TaCptAB_Cdp,'ID');
//   TaCptAB_Cdp.FindField('IDCdp').AsInteger:=DataSet.FindField('ID').AsInteger;
//   TaCptAB_Cdp.FindField('Cdp').AsString:=DataSet.FindField('Cdp').AsString;
//   TaCptAB_Cdp.FindField('IDFils').AsInteger:=TaCompteA.FindField('ID').AsInteger;
//   TaCptAB_Cdp.FindField('Fils').AsString:=TaCompteA.FindField('CompteA').AsString;
 end;
OldStateTaCdp:= dsbrowse;
end;

procedure TDMGestionAnal.TaCdpBeforePost(DataSet: TDataSet);
var
i:integer;
ExceptLGR:TExceptLGR;
begin
OldStateTaCdp:=DataSet.State;
case DataSet.State of
   dsInsert:Begin
              // Vérification des données utilisateur
              for i:=0 to dataset.FieldCount-1 do
               Begin
                  try
                  ExceptLGR:=CtrlSaisieCdp(dataset.Fields[i]);
                  except
                   case ExceptLGR.NumErreur of
                      1001,1002:begin
                                 dataset.Fields[i].FocusControl;
                                 abort;
                                end;
                      2001:begin
                            dataset.Fields[i].FocusControl;
                            abort;
                            end;
                   end;
                  end;
               end;
               // Initialiation des champs programme
               try
                DataSet.FindField('ID').AsInteger:=MaxId_Query(TaCdp,'ID');
               except
                 messageDlg('Erreur lors de l''initialisation des données dans Cdp.BeforePost !',mtError,[mbok],0);
                 abort;
               end;
            End;
   dsEdit:Begin
              // Vérification des données utilisateur
              for i:=0 to dataset.FieldCount-1 do
               Begin
                  try
                  ExceptLGR:=CtrlSaisieCdp(dataset.Fields[i]);
                  except
                   case ExceptLGR.NumErreur of
                      1001,1002:begin
                                 dataset.Fields[i].FocusControl;
                                 abort;
                                end;
                      2001:begin
                            dataset.Fields[i].FocusControl;
                            abort;
                            end;
                   end;
                  end;
               end;
          End;
end;

end;

procedure TDMGestionAnal.TaCdpAfterCancel(DataSet: TDataSet);
begin
OldStateTaCdp:= dsbrowse;
if TaCompteA.State = dsInsert then
     TaCompteA.Cancel;
end;

procedure TDMGestionAnal.TaCompteABeforeCancel(DataSet: TDataSet);
begin
if ((DAtaSet.State = dsInsert) and (OldStateTaCdp = dsInsert)) then
 begin
  if DAtaSet.RecordCount = 0 then
   begin
    if Application.MessageBox(PChar('Êtes-vous sûr de vouloir abandonner la création de cette activité ? '),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
    begin
    //   TaCdp.Locate('ID',TaCptAB_Cdp.findField('IDCdp').AsInteger,[]);
    //   TaCdp.Delete;
    //   TaCptAB_Cdp.Cancel;
    end
    else
    begin
     abort;
    end;
   end;
   end
   else
   if ((DAtaSet.State = dsInsert) and (OldStateTaCdp = dsbrowse)) then
   begin
    if DAtaSet.RecordCount = 0 then
     begin
      if Application.MessageBox(PChar('Êtes-vous sûr de vouloir abandonner la création de cette activité ? '),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
      begin
      //   TaCdp.Locate('ID',TaCptAB_Cdp.findField('IDCdp').AsInteger,[]);
         TableGereDelete(TaCdp);
      //   TaCptAB_Cdp.Cancel;
      end
      else
      begin
       abort;
      end;
     end;
   end;
//if OldStateTaCdp = dsInsert then
////if TaCptAB_Cdp.State = dsInsert then
//begin
//  if Application.MessageBox(PChar('Etes-vous sûr de vouloir abandonner la création de cette activité ? '),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
//  begin
////   TaCdp.Locate('ID',TaCptAB_Cdp.findField('IDCdp').AsInteger,[]);
////   TaCdp.Delete;
////   TaCptAB_Cdp.Cancel;
//  end
//  else
//  begin
//   abort;
//  end;
//end;
end;

procedure TDMGestionAnal.TaCdpBeforeScroll(DataSet: TDataSet);
begin
if OldStateTaCdp = dsInsert then
 begin
  OldStateTaCdp:=DataSet.State;
  abort;
 end;

end;

procedure TDMGestionAnal.TaCompteAAfterInsert(DataSet: TDataSet);
begin
TaCdpAfterPost(TaCdp);
end;

procedure TDMGestionAnal.TaPlancptAnalBeforeEdit(DataSet: TDataSet);
begin
// sauvegarde du paramètre en cours du compte
DernierParamGestAnalCompte.Code:=DataSet.findField('CODE_GESTANAL').AsString;
DernierParamGestAnalCompte.Id:=DataSet.findField('ID_GESTANAL').AsInteger;
end;

procedure TDMGestionAnal.TaCompteABeforeDelete(DataSet: TDataSet);
begin
 if DAtaSet.RecordCount = 1 then
  begin
   if Application.MessageBox(PChar('Êtes-vous sûr de vouloir supprimer cette activité ? '),'Confirmation',MB_YESNO+MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
   begin
     TableGereDelete(TaCdp);
   end
   else
   begin
    abort;
   end;
  end;

end;

procedure TDMGestionAnal.TaPlancptAnalBeforeDelete(DataSet: TDataSet);
begin
abort;
end;

procedure TDMGestionAnal.TaPlancptAnalBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMGestionAnal.TaPlancptAnalBeforePost(DataSet: TDataSet);
var
i:integer;
//NumCpt:String;
begin
//NumCpt:=DataSet.findField('Compte').AsString;
// Si changement du paramètre du compte, alors proposer l'écran de répartition dans l'activité !
//if not empty(DernierParamGestAnalCompte.Code) then
if DernierParamGestAnalCompte.Code <> DataSet.findField('CODE_GESTANAL').AsString then
 begin
  QuSuppresionAffectationCompte.Close;
  QuSuppresionAffectationCompte.ParamByName('Cpt').AsString:=DataSet.findField('Compte').AsString;
//  QuSuppresionAffectationCompte.ParamByName('IdCdpPere').AsInteger:=DernierParamGestAnalCompte.Id;
  if not QuSuppresionAffectationCompte.Prepared then QuSuppresionAffectationCompte.Prepare;
  QuSuppresionAffectationCompte.ExecSQL;
  QuSuppresionAffectationCompte.Close;

  if DataSet.findField('ID_GESTANAL').AsInteger <> 0 then
   begin
    TaCompteAAffectation.First;
    TaCpt_CptA.BeforeInsert:=nil;
    while not TaCompteAAffectation.EOF do
     begin
       TaCpt_CptA.Insert;
       InitChampAfterInsert([MAxId_Query(TaCpt_CptA,'id'),
                            TaCompteAAffectation.FindField('Id').AsInteger,
                            DataSet.findField('ID_GESTANAL').AsInteger,
                            DataSet.findField('Compte').AsString,
                            TaCompteAAffectation.FindField('CompteA').AsString,
                            TaCompteAAffectation.FindField('Ratio').AsFloat],
                            TaCpt_CptA);
       TableGerePost(TaCpt_CptA);
       TaCompteAAffectation.Next;
     end;
    TaCpt_CptA.BeforeInsert:=TaCpt_CptABeforeInsert;
   end;
 end;
//DataSet.Locate('Compte',NumCpt,[]);
//DernierParamGestAnalCompte.Id:=DataSet.findField('ID_GESTANAL').AsInteger;

end;

procedure TDMGestionAnal.TaCpt_CptABeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMGestionAnal.TaEcritureAnalBeforeDelete(DataSet: TDataSet);
begin
abort;
end;

procedure TDMGestionAnal.TaEcritureAnalBeforeEdit(DataSet: TDataSet);
begin
// sauvegarde du paramètre en cours de la ligne
DernierParamGestAnalLigne.Code:=DataSet.findField('CODE_GESTANAL').AsString;
DernierParamGestAnalLigne.Id:=DataSet.findField('ID_GESTANAL').AsInteger;
end;

procedure TDMGestionAnal.TaEcritureAnalBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMGestionAnal.TaEcritureAnalBeforePost(DataSet: TDataSet);
begin
// Si changement du paramètre de la ligne, alors proposer l'écran de répartition dans l'activité !
if DernierParamGestAnalLigne.Code <> DataSet.findField('CODE_GESTANAL').AsString then
 begin
  QuSuppresionAffectationLigne.Close;
  QuSuppresionAffectationLigne.ParamByName('ID_Ligne').AsInteger:=DataSet.findField('Id').AsInteger;
  QuSuppresionAffectationLigne.ParamByName('IdCdpPere').AsInteger:=DernierParamGestAnalLigne.Id;
  if not QuSuppresionAffectationLigne.Prepared then QuSuppresionAffectationLigne.Prepare;
  QuSuppresionAffectationLigne.ExecSQL;
  QuSuppresionAffectationLigne.Close;

  TaCompteAAffectationL.First;
  TaCpt_CptAL.BeforeInsert:=nil;
  while not TaCompteAAffectationL.EOF do
   begin
     TaCpt_CptAL.Insert;
     InitChampAfterInsert([MAxId_Query(TaCpt_CptAL,'id'),
                          TaCompteAAffectationL.FindField('Id').AsInteger,
                          DataSet.findField('ID_GESTANAL').AsInteger,
                          DataSet.findField('Id').AsInteger,
                          TaCompteAAffectationL.FindField('CompteA').AsString,
                          TaCompteAAffectationL.FindField('Ratio').AsFloat],
                          TaCpt_CptAL);
     TableGerePost(TaCpt_CptAL);
     TaCompteAAffectationL.Next;
   end;
  TaCpt_CptAL.BeforeInsert:=TaCpt_CptALBeforeInsert;
 end;
end;

procedure TDMGestionAnal.TaCpt_CptALBeforeInsert(DataSet: TDataSet);
begin
abort;
end;

procedure TDMGestionAnal.GestionAnalCreate(Sender: TObject);
begin
 ListeActiviteResult:=TStringList.Create;
 ListeAtelierResult:=TStringList.Create;
end;

procedure TDMGestionAnal.GestionAnalDestroy(Sender: TObject);
begin
 ListeActiviteResult.Free;
 ListeAtelierResult.Free;
 DMGestionAnal:=nil;
end;

procedure TDMGestionAnal.quSumEcritureFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=((ListeActiviteResult.IndexOf(DataSet.FindField('Cdp').AsString) <> -1)
         and (ListeAtelierResult.IndexOf(DataSet.FindField('CompteA').AsString) <> -1));
end;

procedure TDMGestionAnal.TaCdpAfterOpen(DataSet: TDataSet);
begin
DataSet.FindField('Cdp').ValidChars:=['0'..'9','A'..'Z','a'..'z'];
//DataSet.FindField('Cdp').EditMask:='>aaaaaaaaaa';
end;

procedure TDMGestionAnal.TaCompteAAfterOpen(DataSet: TDataSet);
begin
//DataSet.FindField('CompteA').ValidChars:=['0'..'9','A'..'Z'];
DataSet.FindField('CompteA').EditMask:='>aaaaaaaaaa';
end;

Function TDMGestionAnal.CtrlSaisieCdp(CCourant:TField):TExceptLGR;
Begin
//try
   case CCourant.DataSet.State of
      dsInsert:Begin
                case CCourant.Index of
                   // Traitement Cdp
                   //*************************************************************************
                   1:Begin
                       DeFiltrageDataSet(DMRech.TaCdp);
                       if empty(CCourant.DataSet.FindField('Cdp').AsString) then
                          raise ExceptLGR.Create('Le Code de l''activité est obligatoire !',1001,true,mtError,result);

                       if DMRech.TaCdp.Locate('Cdp',CCourant.DataSet.FindField('Cdp').AsString,[loCaseInsensitive]) then
                          raise ExceptLGR.Create('Ce Code d''activité existe déjà !',1002,true,mtError,result);
                     End;
                   //*************************************************************************

                   // Traitement LibelleCDP
                   //*************************************************************************
                   2:Begin
                       if empty(CCourant.DataSet.FindField('LibelleCdp').AsString) then
                          raise ExceptLGR.Create('Le Libellé de l''activité est obligatoire !',2001,true,mtError,result);
                     End;
                   //*************************************************************************
                end;
               End;
      dsEdit:Begin
                case CCourant.Index of
                   // Traitement Cdp
                   //*************************************************************************
                   1:Begin
                       if empty(CCourant.DataSet.FindField('Cdp').AsString) then
                          raise ExceptLGR.Create('Le Code de l''activité est obligatoire !',1001,true,mtError,result);

                      FiltrageDataSet(DMRech.TaCdp,'Cdp = '''+CCourant.DataSet.FindField('Cdp').AsString+''' and id <> '+CCourant.DataSet.FindField('Id').AsString+'');
                      if DMRech.TaCdp.RecordCount > 0 then
                          raise ExceptLGR.Create('Ce Code d''activité existe déjà !',1002,true,mtError,result);

                     End;
                   //*************************************************************************

                   // Traitement LibelleCDP
                   //*************************************************************************
                   2:Begin
                      if empty(CCourant.DataSet.FindField('LibelleCdp').AsString) then
                          raise ExceptLGR.Create('Le Libellé de l''activité est obligatoire !',2001,true,mtError,result);
                     End;
                   //*************************************************************************
                end;
             End;
   end;
//except
//// ExceptLGR.
// On ExceptLGR do
//   case  of
//      1:showmessage('Coucou');
//////      : ;
//   end;
//
//end;
End;

end.
