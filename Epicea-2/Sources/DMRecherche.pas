unit DMRecherche;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,
  E2_Librairie_Obj;

type
  TDMRech = class(TDataModule)
    TaTiersRech: TTable;
    TaEmpruntsRech: TTable;
    TaStockRech: TTable;
    TaPlanCptRech: TTable;
    TaBalanceRech: TTable;
    TaChargesRepartirRech: TTable;
    TaPCARech: TTable;
    TaChargeAPayerRech: TTable;
    TaProvisionsRech: TTable;
    TaPieceRech: TTable;
    TaEcritureRech: TTable;
    TaBalanceTiersRech: TTable;
    TaDepensesEntreprisesRech: TTable;
    TaImmos_clotRech: TTable;
    TaGestDossierRech: TTable;
    TaParam_DossierRech: TTable;
    TaPlanCPTERech: TTable;
    TaGestDossier_OK: TTable;
    TaModelRech: TTable;
    TaH_TVARech: TTable;
    TaTvaCodeRech: TTable;
    TaResteDCRech: TTable;
    TaCdp: TTable;
    TaCompteA: TTable;
    TaImmosRech: TTable;
    TaPointageRech: TTable;
    TaEchEmpRech: TTable;
    TaTA_ActiviteRech: TTable;
    TaTA_Affect_AtelierRech: TTable;
    TaTA_AtelierRech: TTable;
    TaTA_Atelier_ActiviteRech: TTable;
    TaTA_Compte_AtelierRech: TTable;
    TaTA_Ecriture_AtelierRech: TTable;
    TaAtelierDefautRech: TTable;
    TaPiece_ImportRech: TTable;
    TaParamCptRech: TTable;
    TaModelLRech: TTable;
    TaTrameRech: TTable;
    TaTrameLRech: TTable;
    TaReportRech: TTable;
    TaDec_TvaRech: TTable;
    TaGDossierRech: TTable;
    TaH_PieceTvaRech: TTable;
    TaMessageLGRRech: TTable;
    TaDeductionRech: TTable;
    TaUtilisation_deducRech: TTable;
    TaJuridiqueRech: TTable;
    TaVerifRech: TTable;
    TaReleveEbics: TTable;
    TaComplementEbics: TTable;
    TaComptesBancaire: TTable;
    procedure DMRechCreate(Sender: TObject);
    procedure DMRechDestroy(Sender: TObject);
    Procedure OuvreTableRechProgramme;
    Procedure OuvreTableRechDossier;
    Procedure OuvreTableRechExercice;
    procedure TaTA_AtelierRechBeforeOpen(DataSet: TDataSet);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMRech: TDMRech;
 function PeriodeEpure(DateDeb,DateFin:Tdate):Boolean;
implementation

uses LibSQL, DMConstantes, LibDates;
{$R *.DFM}

procedure TDMRech.DMRechCreate(Sender: TObject);
begin
OuvreTables('',[TaGestDossierRech]);
//OuvrirTouteTable('',TControl(self));
end;

procedure TDMRech.DMRechDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
DMRech:=nil;
end;

Procedure TDMRech.OuvreTableRechProgramme;
Begin
OuvreTables('',[TaGestDossierRech,TaPlanCPTERech]);
End;

Procedure TDMRech.OuvreTableRechDossier;
Begin
OuvreTables('',[TaTiersRech,TaPieceRech,TaEcritureRech,TaParam_DossierRech,TaPlanCptRech]);
End;

Procedure TDMRech.OuvreTableRechExercice;
Begin
OuvreTables('',[TaBalanceRech,
                TaBalanceTiersRech,
                TaChargeAPayerRech,
                TaChargesRepartirRech,
                TaDepensesEntreprisesRech,
                TaEmpruntsRech,
                TaImmos_clotRech,
                TaPCARech,
                TaProvisionsRech,
                TaReportRech,
                TaStockRech,
                TaImmosRech
                ]);
End;
procedure TDMRech.TaTA_AtelierRechBeforeOpen(DataSet: TDataSet);
begin
if ((e.ExerciceCloture)and(FileExists(E.RepertoireExercice+'Ta_Atelier.db'))) then
 DMRech.TaTA_AtelierRech.DatabaseName:='Exercice'
else
 DMRech.TaTA_AtelierRech.DatabaseName:='Dossier';
end;


function PeriodeEpure(DateDeb,DateFin:Tdate):Boolean;
var
retour:boolean;
Requete:TQuery;
exercice:String;
begin
retour:=false;
try
Requete:=TQuery.Create(application.MainForm);
Requete.DatabaseName:=DM_C_NomAliasProgram;
Requete.SQL.Clear;
Requete.SQL.Add('select dir_exo,date_deb_exo,date_fin_exo from GestDossier ');
Requete.SQL.Add(' where nom_Dossier like('''+e.NomDossier+''')');
Requete.SQL.Add(' and  (cast('''+DateToStr_SQL(DateDeb)+'''as date) between date_deb_exo and date_fin_exo ');
Requete.SQL.Add(' or cast('''+DateToStr_SQL(DateFin)+'''as date) between date_deb_exo and date_fin_exo)');
Requete.Open;
if(requete.RecordCount>0) then
begin
 requete.first;
 while (not requete.eof) and (retour=false)do
 begin
    retour:=(FileExists(Requete.findfield('dir_exo').AsString+'\Epure.txt'));
    requete.Next;
  end;
end;
Requete.close;
Requete.free;
finally
result:=retour;
end;
end;
end.
