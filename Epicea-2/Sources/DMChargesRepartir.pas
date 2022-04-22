{-----------------------------------------------------------------------------
 Unit Name: DMStocks
 Author:    Blanc Philippe
 Purpose:
 History:
 Initialisation de la Function InitialiseDMChargeARepartir avec TParamDMChargeARepartir
   Quand:Integer; Détermine si l'on est en Ouverture ou en cloture
   ChargeARepartirDataStateChange:TNotifyEvent; : évènement à lier avec le dataset
   GEstInterfaceEvent:TGEstInterfaceEvent; évènement à lier avec le DataModule
                                           CEt évènement doit être créé dans le DM


   Création de l'évènement OnGEstInterfaceEvent
  private
     Déclarations privées
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;

  Protected
     Déclarations protégées
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
-----------------------------------------------------------------------------}
unit DMChargesRepartir;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  Gr_Librairie_obj,
  E2_Librairie_obj,
  Grids,
  DBGrids,
  Db,
  DBTables,
  E2_AideCompte,
  LibSQL,
  Menus,
  Buttons,
  Gr_MiseAJourBalance,
  RxMemDS,
  DMClotures,
  DMPlanCpt,
  LibDates,
  E2_Decl_Records,
  DMRecherche,
  E2_LibInfosTable,
  Editions,
  ShellApi,
  Lib_Chaine,
  LibRessourceString,
  ObjetEdition,
  DMConstantes;


type
  TParamDMChargeRepartir=Record
   Quand:Integer;
   ChargeARepartirDataStateChange:TNotifyEvent;
   GEstInterfaceEvent:TGEstInterfaceEvent;
  end;

  TInfosDMChargeRepartir=Record
    Retour:Boolean;
   end;

  TDMChargeRepartir = class(TDataModule)
    DataCar: TDataSource;
    TaCar: TTable;
    TaCarID: TIntegerField;
    TaCarMtTotalCharge: TCurrencyField;
    TaCarMtBilanOuverture: TCurrencyField;
    TaCarMontantReprise: TCurrencyField;
    TaCarDateSysteme: TDateTimeField;
    TaCarDateSaisie: TDateField;
    TaCarCompte: TStringField;
    TaCarReference: TStringField;
    TaCarDesignation: TStringField;
    TaCarReprise: TBooleanField;
    TaCarReprise2: TStringField;
    TaCarMtRestant: TCurrencyField;
    QuChargeRepartirEdition: TQuery;
    QuListeValRupt: TQuery;
    QuSousTotal: TQuery;
    QuTotalG: TQuery;
    procedure DMChargeRepartirCreate(Sender: TObject);
    Function CtrlSaisieChargesRepartir(CCourant:Tfield):TErreurSaisie;
    procedure DMChargeRepartirDestroy(Sender: TObject);
    procedure TaCarBeforePost(DataSet: TDataSet);
    procedure TaCarBeforeDelete(DataSet: TDataSet);
    procedure TaCarAfterPost(DataSet: TDataSet);
    procedure AfterEnregistrementModif;
    procedure TaCarAfterDelete(DataSet: TDataSet);
//    procedure FiltrageTable;
//    function RechercheDesignation(chaine:string):integer;
    function FiltrageTablePourRepriseCloture:boolean;
    function FiltrageTablePourRepriseouverture:boolean;
    Procedure EcritureReference(ID:integer;Ref:string);
    procedure TaCarBeforeEdit(DataSet: TDataSet);
    procedure CreationODChargeCloture;
    procedure CreationODChargeOuverture;
    function CreationListeOD:TStringList;
    procedure DemandeAffichageReprise;
    procedure Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
//    procedure TaRecupFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure TaCarPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaCarDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaCarBeforeInsert(DataSet: TDataSet);

    procedure TaCarBeforeEIDOuv_Abort(DataSet: TDataSet);
    procedure TaCarBeforeEIDClo_Abort(DataSet: TDataSet);

    Procedure TraitementCloture4000(sender:Tobject);
    procedure CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure CreationODOuverture_avecObjet(TableEnCours:TTable;ODModif:string);
    procedure TaCarAfterInsert(DataSet: TDataSet);
    procedure TaCarCalcFields(DataSet: TDataSet);
    procedure TaCarFilterRecordPourNouvelExo(DataSet: TDataSet; var Accept: Boolean);

    procedure GestionAccesChargesRepartir;
    procedure QuChargeRepartirEditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);


  private
    { Déclarations privées }
    FOnGEstInterfaceEvent:TGEstInterfaceEvent;

  Protected
    { Déclarations protégées }

  public
    { Déclarations publiques }
    CompteChargeARepartir:string;
    Quand:Integer;
    ListeEdit:TStringList;
    property OnGEstInterfaceEvent:TGEstInterfaceEvent read FOnGEstInterfaceEvent write FOnGEstInterfaceEvent;
    Procedure ImportsChargeRepartir(Valeurs:array of const;DataSet:TDataSet);
  end;

var
  DMChargeRepartir: TDMChargeRepartir;
  EtatTable:TDataSetState;

  MontantTmp,MontantTmp1: Currency;
  DesignationTmp: String;
  OD,compte:string;
  montantBilan:currency;
  affichageOD:boolean;

    Function EditionChargeRepartir(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
    Function InitialiseDMChargeARepartir(ParamDMChargeARepartir:TParamDMChargeRepartir):TInfosDMChargeRepartir;

    function VerifRepriseChargesARepartir(var messageTmp:Tmessages):boolean;
    function VerifExistChargesARepartir(var messageTmp:Tmessages;Mess:boolean):boolean;
    function VerifExistChargesARepartirAReprendre(var messageTmp:Tmessages;Mess:boolean):boolean;

    Function EditionChargeRepartirL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;ListeidCharge:TStringList;Site:TEditLien):Boolean;overload;
    Function EditionChargeRepartirL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;idCharge:String;Site:TEditLien):Boolean;overload;

implementation

 uses DMPiece, DMBalances,DMEcriture, E2_Main, DMImportation,DMBaseDonnee,DMDiocEtatBalance,
  E2_VisuListeView,LibZoneSaisie;

{$R *.DFM}

// C_Ouverture = 0;
// C_Cloture = 1;
// C_Mouvement = 2;

Function InitialiseDMChargeARepartir(ParamDMChargeARepartir:TParamDMChargeRepartir):TInfosDMChargeRepartir;
Begin
 if DMChargeRepartir=nil then DMChargeRepartir:=TDMChargeRepartir.Create(Application.MainForm);
 if DMRech = Nil then DMRech:=TDMRech.Create(Application.MainForm);
 if AideCompte=nil then AideCompte:=TAideCompte.Create(DMChargeRepartir);
 DMChargeRepartir.OnGEstInterfaceEvent := ParamDMChargeARepartir.GEstInterfaceEvent;
 DMChargeRepartir.DataCar.OnStateChange := ParamDMChargeARepartir.ChargeARepartirDataStateChange;
 DMChargeRepartir.Quand := ParamDMChargeARepartir.Quand;
 Case DMChargeRepartir.Quand Of
      C_Ouverture: Begin //si ouverture
           //on affiche les données dont la date de saisie
           //correspond à la date de début d'exercice
           FiltrageDataSet(DMChargeRepartir.tacar,'DateSaisie = '''+DateToStr(E.DatExoDebut-1)+'''');
         End;
      C_Cloture: Begin //si clôture
           DeFiltrageDataSet(DMChargeRepartir.tacar);
         End;
 End;
End;


Function EditionChargeRepartir(TypeEdition : integer; Quand : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
var
NomFich,Chemin:String;
Begin
  Chemin :=E.RepertoireComptaWeb;
 case Quand of
    C_Ouverture:NomFich:='ChargeRepartirOuv';
    C_Cloture:NomFich:='ChargeRepartirClo';
 end;

 if DMChargeRepartir=nil then DMChargeRepartir:=TDMChargeRepartir.Create(Application.MainForm);
 if dataset = nil then
  begin
   // Prevu pour passer le dataset concerné
   // Inutile dans ChargeRepartir pour l'instant
  end;
 case Quand of
    C_Ouverture:begin
                 DMChargeRepartir.QuListeValRupt.SQL.Clear;
                 DMChargeRepartir.QuListeValRupt.SQL.Add('select distinct compte from ChargesRepartir.db where ');
                 DMChargeRepartir.QuListeValRupt.SQL.Add(' DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMChargeRepartir.QuListeValRupt.Open;

                 DMChargeRepartir.QuSousTotal.SQL.Clear;
                 DMChargeRepartir.QuSousTotal.Params.Clear;
                 DMChargeRepartir.QuSousTotal.SQL.Add('select sum(MtTotalCharge), sum(MtBilanOuverture) ');
                 DMChargeRepartir.QuSousTotal.SQL.Add('from ChargesRepartir.db where compte =:compte ');
                 DMChargeRepartir.QuSousTotal.SQL.Add('and DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMChargeRepartir.QuSousTotal.Params[0].DataType := ftString;
                 DMChargeRepartir.QuSousTotal.Open;

                 DMChargeRepartir.QuTotalG.SQL.Clear;
                 DMChargeRepartir.QuTotalG.SQL.Add('select sum(MtTotalCharge),sum(MtBilanOuverture) from ChargesRepartir.db where ');
                 DMChargeRepartir.QuTotalG.SQL.Add(' DateSaisie='''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMChargeRepartir.QuTotalG.Open;

                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Clear;
                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Add('Select ch.*,(Ch.MtBilanOuverture-Ch.MontantReprise) as MtRestant from ChargesRepartir ch where ');
                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Add('DateSaisie = '''+DateInfos(E.DatExoDebut-1).DatePourSQLStr+'''');
                 DMChargeRepartir.QuChargeRepartirEdition.Open;
                 case TypeEdition  of
                    C_EditionSimple:Begin
                                     Site.lien := false;
//                                     EditChargeRepartir(Chemin,NomFich,DMChargeRepartir.QuChargeRepartirEdition,'Compte',DMChargeRepartir.QuListeValRupt,DMChargeRepartir.QuSousTotal,DMChargeRepartir.QuTotalG,DateToStr(E.DatExoDebut),Site,C_Ouverture);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                                    End;
                    C_EditionWeb:Begin
                                     Site.lien := True;
//                                     EditChargeRepartir(NomMenuSiteWeb,DMChargeRepartir.QuChargeRepartirEdition,'Compte',DMChargeRepartir.QuListeValRupt,DMChargeRepartir.QuSousTotal,DMChargeRepartir.QuTotalG,DateToStr(E.DatExoDebut),Site);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///'+Chemin+NomFich+'.xml'),nil,sw_show);
                                 End;
                 end;
                 DMChargeRepartir.QuListeValRupt.Close;
                 DMChargeRepartir.QuSousTotal.Close;
                 DMChargeRepartir.QuTotalG.Close;
                 DMChargeRepartir.QuChargeRepartirEdition.Close;
                end;

    C_Cloture: begin
                 DMChargeRepartir.QuListeValRupt.SQL.Clear;
                 DMChargeRepartir.QuListeValRupt.SQL.Add('select distinct compte from ChargesRepartir.db ');
                 DMChargeRepartir.QuListeValRupt.Open;

                 DMChargeRepartir.QuSousTotal.SQL.Clear;
                 DMChargeRepartir.QuSousTotal.Params.Clear;
                 DMChargeRepartir.QuSousTotal.SQL.Add('select sum(MtTotalCharge), sum(MtBilanOuverture), sum(MontantReprise), sum(MtBilanOuverture-MontantReprise)');
                 DMChargeRepartir.QuSousTotal.SQL.Add('from ChargesRepartir.db where compte =:compte ');
                 DMChargeRepartir.QuSousTotal.Params[0].DataType := ftString;
                 DMChargeRepartir.QuSousTotal.Open;

                 DMChargeRepartir.QuTotalG.SQL.Clear;
                 DMChargeRepartir.QuTotalG.SQL.Add('select sum(MtTotalCharge), sum(MtBilanOuverture), sum(MontantReprise), sum(MtBilanOuverture-MontantReprise) from ChargesRepartir.db ');
                 DMChargeRepartir.QuTotalG.Open;

                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Clear;
                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Add('Select ch.*,(Ch.MtBilanOuverture-Ch.MontantReprise) as MtRestant from ChargesRepartir Ch');
                 DMChargeRepartir.QuChargeRepartirEdition.Open;

                 case TypeEdition  of
                    C_EditionSimple:Begin
                                     Site.lien := False;
//                                     EditChargeRepartir(Chemin,NomFich,DMChargeRepartir.QuChargeRepartirEdition,'Compte',DMChargeRepartir.QuListeValRupt,DMChargeRepartir.QuSousTotal,DMChargeRepartir.QuTotalG,DateToStr(E.DatExoFin),Site,C_Cloture);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                                    End;
                    C_EditionWeb:Begin
                                     Site.lien := False;
//                                     EditChargeRepartir(NomMenuSiteWeb,DMChargeRepartir.QuChargeRepartirEdition,'Compte',DMChargeRepartir.QuListeValRupt,DMChargeRepartir.QuSousTotal,DMChargeRepartir.QuTotalG,DateToStr(E.DatExoFin),Site);
                                     ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar('file:///'+Chemin+NomFich+'.xml'),nil,sw_show);
                                 End;
                 end;
                 DMChargeRepartir.QuListeValRupt.Close;
                 DMChargeRepartir.QuSousTotal.Close;
                 DMChargeRepartir.QuTotalG.Close;
                 DMChargeRepartir.QuChargeRepartirEdition.Close;
                end;
 end;
End;

function TDMChargeRepartir.CreationListeOD:TStringList;
begin
try
FiltrageDataSet(dmrech.TaChargesRepartirRech,'Reference <> ''''');
result:=TStringList.Create;
result.Clear;
 While (Not(dmrech.TaChargesRepartirRech.EOF)) Do
   Begin
   If result.IndexOf(dmrech.TaChargesRepartirRech.findfield('Reference').AsString) = -1 Then
      result.Add(dmrech.TaChargesRepartirRech.findfield('Reference').AsString);
   dmrech.TaChargesRepartirRech.Next;
   End;
except
  result.clear;
end;
end;


procedure TDMChargeRepartir.DemandeAffichageReprise;
begin
DMPieces.AffichageFeuilleReprise(0,CreationListeOD,nil,'Reprise des Charges A Répartir','','',false);
end;


procedure TDMChargeRepartir.CreationODChargeOuverture;
var
SoldeCompte:TSoldeCompte;
Except_LGR:TExceptLGR;
ParamAffichage:TParamAffichage;
begin
  try
    try
    Initialise_ExceptLGR(Except_LGR);
    TableGereStartTransaction(DMRech.TaChargesRepartirRech);
    DMRech.TaChargesRepartirRech.first;
    // Tant qu'il reste des enregistrements dans la table TaCAR
     While (Not(DMRech.TaChargesRepartirRech.EOF)) Do
     Begin
         Except_LGR:=PossibiliteRepriseCompte(DMRech.TaChargesRepartirRech.findfield('Compte').Asstring,DMRech.TaChargesRepartirRech,'D','charges à repartir');
//     try//except
//         Except_LGR.retour:=true;
//         Except_LGR.NumErreur:=0;
//         SoldeCompte:=DMBalance.RetourneSoldeCompteAvantReprise(DMRech.TaChargesRepartirRech.findfield('Compte').Asstring,DMRech.TaChargesRepartirRech,0,'D');
//         if ((SoldeCompte.SoldeBO.Retour)and(SoldeCompte.SoldeBalance.Retour)) then //importation
//           begin
//              if ((SoldeCompte.SoldeBO.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeBO.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
//                raise ExceptLGR.Create('',1,false,mtError,Except_LGR);
//              if ((SoldeCompte.SoldeCharge.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeCharge.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
//                raise ExceptLGR.Create('',2,false,mtError,Except_LGR);
//           end
//         else
//         if ((SoldeCompte.Soldecharge.Retour)and(SoldeCompte.SoldeBalance.Retour)) then //normal
//           begin
//              if ((SoldeCompte.SoldeCharge.Total<>SoldeCompte.SoldeBalance.Total)or(SoldeCompte.SoldeCharge.SensTotal<>SoldeCompte.SoldeBalance.SensTotal)) then
//                raise ExceptLGR.Create('',3,false,mtError,Except_LGR);
//           end
//         else
//            raise ExceptLGR.Create('',4,false,mtError,Except_LGR);
//     except
//       case Except_LGR.NumErreur of
//         1,2,3:begin
//                 if (MessageDlg('il existe une différence entre vos charges, le solde de la '+#13+#10+'balance et le solde du bilan d''''ouverture '+#13+#10+'sur le compte :'+#13+#10+'Vous ne pouvez pas reprendre vos charges sur ce '+#13+#10+'compte'+#13+#10+'Souhaitez vous visualiser ces différences ?', mtWarning, [mbYes,mbNo], 0) = mrYes) then
//                   begin
//                      Initialise_TParamAffichage(ParamAffichage);
//                      ParamAffichage.AffichModal := true;
//                      ParamAffichage.Titre:='Liste des Soldes du compte '+DMRech.TaChargesRepartirRech.findfield('Compte').Asstring;
//                      ParamAffichage.GestionAffichForm.Caption := ParamAffichage.Titre;
//                      AfficheVisuListView(ParamAffichage,['Ecran','Compte','Débit','Crédit'],
//                                                         [200,200,150,150],
//                                                         [SoldeCompte.ListeSolde],
//                                                         [taLeftJustify,taLeftJustify,taRightJustify,taRightJustify],
//                                                         [1..2],
//                                                         [3..4],[0]);
//                   end;
//               end;
//         4:begin
//             MessageDlg('il existe une différence entre le solde de la balance et le solde '+#13+#10+'de vos charges sur le compte :'+DMRech.TaChargesRepartirRech.findfield('Compte').Asstring+#13+#10+'Vous ne pouvez reprendre vos charges pour ce compte. ', mtWarning, [mbOK], 0);
//           end;
//       end;//fin du case ExceptLGR
//     end;
     if Except_LGR.retour then
       begin
       CreationODOuverture_avecObjet(DMRech.TaChargesRepartirRech,'');
       EcritureReference(DMRech.TaChargesRepartirRech.findfield('ID').AsInteger,DMImport.Piece_Import.Reference);
       end;
     DMRech.TaChargesRepartirRech.Next;
     end;
        TableGereCommit(DMRech.TaChargesRepartirRech);
        TableGereCommit(DMPieces.TaPiece);
    except
       begin
       showmessage('Problème à l''enregistrement des OD d''ouverture');
        TableGereRollBack(DMRech.TaChargesRepartirRech);
        TableGereRollBack(DMPieces.TaPiece);
       abort;
       end;
    end;//fin du try except
  finally
    //if SoldeCompte.ListeSolde<>nil then SoldeCompte.ListeSolde.Free;
  end;
end;


procedure TDMChargeRepartir.CreationODChargeCloture;
begin
    try
    TableGereStartTransaction(DMRech.TaChargesRepartirRech);
    DMRech.TaChargesRepartirRech.First;
        While (Not(DMRech.TaChargesRepartirRech.EOF)) Do
        Begin
        DMBalance.MAJBalance(true,'Qt1_base','Debit_base',DMRech.TaChargesRepartirRech.findfield('Compte').AsString,
        DMRech.TaChargesRepartirRech.findfield('Compte').AsString,0,0,DMRech.TaChargesRepartirRech.findfield('MtBilanOuverture').AsCurrency,
        DMRech.TaChargesRepartirRech.findfield('MtBilanOuverture').AsCurrency,dsbrowse);
        CreationODCloture_avecObjet(DMRech.TaChargesRepartirRech,'');
        EcritureReference(DMRech.TaChargesRepartirRech.findfield('ID').AsInteger,DMImport.Piece_Import.Reference);;
        DMRech.TaChargesRepartirRech.next;
        end;
        TableGereCommit(DMRech.TaChargesRepartirRech);
        TableGereCommit(DMPieces.TaPiece);
    except
        begin
        showmessage('Problème à l''enregistrement des OD de clôture');
        TableGereRollBack(DMRech.TaChargesRepartirRech);
        TableGereRollBack(DMPieces.TaPiece);
        abort;
        end;
    end;
end;



//***************************************************************
//Cette fonction permet de rechercher une désignation par rapport à
//une chaîne saisie et de renvoyer le recordcount
//s'il est égal à 1, on se position sur l'enregistrement correspondant
//******************* RechercheDesignation *************************

//function TDMChargeRepartir.RechercheDesignation(chaine:string):integer;
//begin
//result:=0;
//if query2.Active=true then
//query2.Active:=false;
//Query2.Params[0].AsString:='%'+ chaine +'%';
//Query2.Active:=true;
//result:=Query2.recordcount;
//
//  IF result=1 then
//    TaCar.Locate('Id', Query2Id.Value,[]);
//end;



//******************* FiltrageTablePourReprise *************************
//cette procedure sert dans la fenêtre de repriseChargeARepartir
//pour filtrer la table Tacar en fonction de la date ExoFin
//***********************************************************************
function TDMChargeRepartir.FiltrageTablePourRepriseCloture:boolean;
begin
     FiltrageDataSet(DMRech.TaChargesRepartirRech,'DateSaisie = '''+DatetimeToStr(E.DatExoFin)+''' And Reference = ''''');
     result:=DMRech.TaChargesRepartirRech.recordcount<>0;
end;


//******************* TDMChargeRepartir.FiltrageTablePourRepriseouverture *************************
//cette procedure permet de recuperer les enregistrements crées à l'ouverture
///*********************************************************************************
function TDMChargeRepartir.FiltrageTablePourRepriseouverture:boolean;
begin
     FiltrageDataSet(DMRech.TaChargesRepartirRech,'DateSaisie = '''+DatetimeToStr(E.DatExoDebut-1)+''' And MontantReprise <> 0  And Reference = ''''');
     result:=DMRech.TaChargesRepartirRech.recordcount<>0;
end;


//******************* EcritureReference *************************
//Cette fonction permet d'Ecrire la réference crée à la fermeture
//de la fenêtre des charges à Répartir (Clôture)
//***************************************************************
Procedure TDMChargeRepartir.EcritureReference(ID:integer;Ref:string);
begin
try
  tacar.BeforePost:=nil;
  tacar.AfterPost:=nil;
  tacar.BeforeEdit:=nil;
  tacar.DisableControls;
  if TaCar.Locate('ID',ID,[]) then
    begin
    TaCar.Edit;
    TaCARReference.Value:= Ref;
    TableGerePost(TaCar);
   end;
finally
  tacar.EnableControls;
  tacar.BeforePost:=TaCarBeforePost;
  tacar.AfterPost:=TaCarAfterPost;
  tacar.BeforeEdit:=TaCarBeforeEdit;
end;//fin du try finally
end;

//******************* TDMChargeRepartir.CtrlSaisieChargesRepartir *************************
//Cette fonction sert à vérifier tous les champs saisis avant l'enregistrement
//dans la table 'ChargesARepartir'

Function TDMChargeRepartir.CtrlSaisieChargesRepartir(CCourant:Tfield):TErreurSaisie;
var
infosCompte:TInfosplancpt;
begin // initialisation des variables de retour de fonction
 CtrlSaisieChargesRepartir.CodeErreur:=0;
 CtrlSaisieChargesRepartir.Retour:=True;
  if TaCar.State in [dsinsert,dsEdit] then
  begin //si état insertion ou modification
    case Quand of
    C_Ouverture: begin  // si ouverture
           case CCourant.Index of
           2: begin // si champ n° 3 (désignation)
               If Empty(CCourant.AsString) then
                Begin // si champ vide
                infosCompte:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[CompteChargeARepartir]);
                  if not (empty(infosCompte.Libelle)) then
                  ccourant.AsString:=infosCompte.Libelle +' N°: '+ IntTOStr(ccourant.DataSet.RecordCount+1)
                  else
                  begin
                  CtrlSaisieChargesRepartir.CodeErreur:=2100;
                  CtrlSaisieChargesRepartir.Retour:=False;
                  Application.Messagebox(Pchar('La saisie de la désignation est obligatoire !!!'),'Erreur de saisie',0);
                  end;
                end;//fin champ vide
               end;//fin champ3
           3: begin // si champ n° 3 (Montant total de la charge)
               if Empty(CCourant.AsString)or (CCourant.AsFloat =0) then
                  Begin // si champ vide
                  CtrlSaisieChargesRepartir.CodeErreur:=3100;
                  CtrlSaisieChargesRepartir.Retour:=False;
                  Application.Messagebox(Pchar('La saisie du Montant Total de la Charge est obligatoire !!!'),'Erreur de saisie',0);
                  end; //fin champ vide
               end;//fin champ 3
            4: begin  // si champ n° 4 (Montant du Bilan d''Ouverture)
                if Empty(CCourant.AsString)or (CCourant.AsFloat <=0) then
                  Begin // si champ vide
                     if (not(empty(TaCarMtTotalCharge.AsString)))and (TaCarMtTotalCharge.asfloat>0) then
                     CCourant.AsFloat:=TaCarMtTotalCharge.AsFloat
                     else
                     begin
                     CtrlSaisieChargesRepartir.CodeErreur:=4100;
                     CtrlSaisieChargesRepartir.Retour:=False;
                     Application.Messagebox(Pchar('La saisie du Montant du Bilan d''Ouverture est obligatoire et ne peut être égale à ''0'' !!!'),'Erreur de saisie',0);
                     end;
                  end; //fin champ vide
                if CCourant.AsFloat > CCourant.DataSet.Fields[3].AsFloat then
                   Begin // si champ 4 > champ 3
                  CtrlSaisieChargesRepartir.CodeErreur:=4102;
                  CtrlSaisieChargesRepartir.Retour:=False;
                  Application.Messagebox(Pchar('La saisie du Montant du Bilan d''Ouverture doit être inferieur ou égal à celui du total charges '' !!!'),'Erreur de saisie',0);
                  end; //fin champ 4 > champ 3
               end;//fin champ 5
           end;//fin du case
       end; // fin du case de l'ouverture
       C_Cloture: begin //si clôture
             case CCourant.Index of
           2: begin // si champ n° 3 (désignation)
               If Empty(CCourant.AsString) then
                Begin // si champ vide
                infosCompte:=Infos_TInfosplancpt(DMRech.TaPlanCptRech,'Compte',[CompteChargeARepartir]);
                  if not (empty(infosCompte.Libelle)) then
                  ccourant.AsString:=infosCompte.Libelle +' N°: '+IntTOStr(ccourant.DataSet.RecordCount+1)
                  else
                  begin
                  CtrlSaisieChargesRepartir.CodeErreur:=2200;
                  CtrlSaisieChargesRepartir.Retour:=False;
                  Application.Messagebox(Pchar('La saisie de la désignation est obligatoire !!!'),'Erreur de saisie',0);
                  end;
                end;//fin champ vide
               end;//fin champ3
              3: begin // si champ n° 3 (Montant total de la charge)
                  if Empty(CCourant.AsString)or (CCourant.AsFloat =0) then
                    Begin // si champ vide
                    CtrlSaisieChargesRepartir.CodeErreur:=3200;
                    CtrlSaisieChargesRepartir.Retour:=False;
                    Application.Messagebox(Pchar('La saisie du Montant Total de la Charge est obligatoire !!!'),'Erreur de saisie',0);
                    end; //fin champ vide
                  if  ((not(Empty(CCourant.AsString))) and ((CCourant.AsFloat >0) and (TaCarDateSaisie.AsDateTime>E.DatExoDebut-1))) then
                     begin //si champ ok
                      TaCarMtBilanOuverture.AsFloat:=CCourant.AsFloat;
                     end;
                  if  ((not(Empty(CCourant.AsString))) and ((CCourant.AsFloat >0) and (DateInfos(TaCarDateSaisie.AsDateTime).Vide))) then
                     begin //si champ ok
                      TaCarMtBilanOuverture.AsFloat:=CCourant.AsFloat;
                     end;
                  end;//fin champ 3
               4: begin  // si champ n° 4 (Montant restant à reprendre)
                   if Empty(CCourant.AsString)or (CCourant.AsFloat <=0) then
                     Begin // si champ vide
                        CtrlSaisieChargesRepartir.CodeErreur:=4200;
                        CtrlSaisieChargesRepartir.Retour:=False;
                        Application.Messagebox(Pchar('La saisie du Montant du Bilan d''Ouverture est obligatoire et ne peut être égale à ''0'' !!!'),'Erreur de saisie',0);
                     end; //fin champ vide
                     if CCourant.AsFloat > CCourant.DataSet.Fields[3].AsFloat then
                        Begin // si champ 4 > champ 3
                       CtrlSaisieChargesRepartir.CodeErreur:=4202;
                       CtrlSaisieChargesRepartir.Retour:=False;
                       Application.Messagebox(Pchar('La saisie du Montant du Bilan d''Ouverture doit être inferieur ou égal à celui du total charges '' !!!'),'Erreur de saisie',0);
                       end; //fin champ 4 > champ 3
                  end;//fin champ 4
               7: begin //si champ n°7 (Montant reprise)
                    if Empty(CCourant.AsString) then
                    begin //si champ vide
                     CCourant.AsFloat:=0;
                    end; //fin champ vide
                    if CCourant.AsFloat >cCourant.DataSet.Fields[4].AsFloat then
                    begin //si champ 7 sup au champ N°4
                    CtrlSaisieChargesRepartir.CodeErreur:=7203;
                    CtrlSaisieChargesRepartir.Retour:=False;
                    Application.Messagebox(Pchar('La saisie du Montant de la reprise doit être inférieure ou égale à celle restant à reprendre !!!'),'Erreur de saisie',0);
                    end; //fin champ 7 sup au champ N°4
                  end;//fin champ 7
             end;//fin du case
          end //fin du case de la clôture
  end; //fin de l'état insertion ou modification
end;
end;

//******************* TDMChargeRepartir.DMChargeRepartirCreate *************************
//cette procedure permet d'ouvrir toutes les tables et de créer des formats type de saisie
///*********************************************************************************
procedure TDMChargeRepartir.DMChargeRepartirCreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
 TaCar.FindField('MtTotalCharge').ValidChars:=['0'..'9',decimalseparator];
 TaCar.FindField('MtBilanOuverture').ValidChars:=['0'..'9',decimalseparator];
 TaCar.FindField('MontantReprise').ValidChars:=['0'..'9',decimalseparator];

 TaCarMtTotalCharge.DisplayFormat:=E.FormatMonnaie;
 TaCarMtTotalCharge.EditFormat:='0.00 ;-0.00 ';

 TaCarMtBilanOuverture.DisplayFormat:=E.FormatMonnaie;
 TaCarMtBilanOuverture.EditFormat:='0.00 ;-0.00 ';

 TaCarMontantReprise.DisplayFormat:=E.FormatMonnaie;
 TaCarMontantReprise.EditFormat:='0.00 ;-0.00 ';
CompteChargeARepartir:=DM_C_CompteChargeARepartir;
ListeEdit:=TStringList.Create;
end;

//******************* TDMChargeRepartir.DMChargeRepartirDestroy *************************
//cette procedure permet de fermer toutes tables
///*********************************************************************************
procedure TDMChargeRepartir.DMChargeRepartirDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
ListeEdit.Free;
DMChargeRepartir:=nil;
end;

//******************* FiltrageTable ************************************************
//cette procedure permet de filtrer les enregistrements selon si on est en ouverture
// ou clôture
///*********************************************************************************
//procedure TDMChargeRepartir.FiltrageTable;
//begin
//     Case Quand Of
//          1: Begin //si ouverture
//                   //on affiche les données dont la date de saisie
//                   //correspond à la date de début d'exercice
//                  TaCar.Filtered := False;
//                  TaCar.Filter := ('DateSaisie = '''+DateToStr(E.DatExoDebut)+'''');
//                  TaCar.Filtered := True;
//             End;
//          2: Begin //si clôture
//                  TaCar.Filtered := False;
//                  TaCar.Filter := '';
//                  TaCar.Filtered := True;
//             End;
//     End;
//end;




//******************* TDMChargeRepartir.TaCarBeforePost *************************
//Cette procedure permet de faire une vérification des saisie. Elle concerne l'ouverture
///*********************************************************************************
procedure TDMChargeRepartir.TaCarBeforePost(DataSet: TDataSet);
var
I:integer;
RetourFonction:TErreurSaisie;
var
ODModif:string;
begin
ODModif:='';
ODModif:=TaCarReference.AsString;
EtatTable:=TaCar.State;
  case TaCar.State of
  dsInsert: begin
             TaCARID.AsInteger := MaxId_Query(TaCAR,'ID');
             TaCARCompte.AsString := CompteChargeARepartir;
             TaCARDateSysteme.AsDateTime := Now;
                if Quand =C_Ouverture then
                TaCARDateSaisie.AsDateTime := E.DatExoDebut-1;
                if Quand=C_Cloture then
                TaCARDateSaisie.AsDateTime := E.DatExoFin;
            end;// fin de l'état insertion
  dsEdit: begin // etat modification
            TaCARDateSysteme.AsDateTime := Now;
          end; //fin de modification
  end;//fin du case
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,
        ET_Maint:    Begin
                        //début de la boucle de vérification des saisies
                        for I:=2 to 4 do //vérification du champ 2 à 4
                           begin
                           RetourFonction:=CtrlSaisieChargesRepartir(tacar.Fields[I]);
                             if  RetourFonction.Retour=false then
                                 case  RetourFonction.CodeErreur of
                                     2100,3100,4100,4102,4200,4202,2200,3200:
                                       begin // erreur de saisie, resaisir
                                        if assigned(FOnGEstInterfaceEvent) then
                                         FOnGEstInterfaceEvent(DataSet.Fields[i]);
//                                       DataSet.Fields[i].FocusControl;
                                       abort;
                                       end;
                                 end; //fin case
                           end; //fin boucle
                           if Quand= C_Cloture then  //si clôture
                           begin
                           RetourFonction:=CtrlSaisieChargesRepartir(tacar.Fields[7]);
                             if  RetourFonction.Retour=false then
                               begin
                                 if RetourFonction.CodeErreur= 7203 then
                                 abort; //continue la vérification sur le champ 7
                               end;
                            end;
                     end;
        ET_EnCloture,
        ET_MaintS:   Begin
                       //
                     end;
        ET_Cloture:  Begin
                       //
                     end;
        ET_Inconnu:  Begin
                       //
                     end;
      end;//fin du case E.TypeEtatExercice
TableGereStartTransaction(DataSet);
   try
      case E.TypeEtatExercice of
        ET_Importation,
        ET_Normal,ET_EnCloture,
        ET_Maint:    Begin
                        if tacar.State=dsinsert then //si insert
                        begin
                         if Quand= C_Ouverture then
                           begin //si ouverture
                               //Mise à jour balance sans OD
                               DMBalance.MAJBalance(false,'Qt1_Report','Debit_Report',TaCarCompte.AsString,TaCarCompte.AsString,
                               0,0,TaCarMtBilanOuverture.AsCurrency,TaCarMtBilanOuverture.AsCurrency,dsInsert);
                           end//fin ouverture
                         else
                           Begin
                               //Mise à jour balance sans OD
                               DMBalance.MAJBalance(false,'Qt1_base','Debit_base',TaCarCompte.AsString,TaCarCompte.AsString,
                               0,0,TaCarMtBilanOuverture.AsCurrency,TaCarMtBilanOuverture.AsCurrency,dsInsert);
                           End;
                        end;//fin si insert
                        if tacar.State=dsedit then //si modif
                        AfterEnregistrementModif;
                     end;
      end;//fin du case typeEtatExercice
   except
     TableGereRollBack(DataSet);
     TableGereRollBack(DMPieces.TaPiece);
     showmessage('Problème à la mise à jour de la balance !!!');
     abort;
   end;//fin du try
end;


//******************* TDMChargeRepartir.TaCarBeforeDelete *************************
//
///*********************************************************************************
procedure TDMChargeRepartir.TaCarBeforeDelete(DataSet: TDataSet);
var
MessageTmp:string;
begin
try//except
OD:='';
compte:='';
montantBilan:=0;
compte:=TaCarCompte.AsString;
montantBilan:=TaCarMtBilanOuverture.AsCurrency;
OD:=TaCarReference.AsString;
   case Quand of
      C_Ouverture: begin // si ouverture
           if VerifSiCompteSaisieDsBO(DataSet.FindField('Compte').AsString,False,DataSet) then
            begin
             Messagedlg(CompteImporte_DossierDos,mtInformation,[mbok],0);
             Abort;
            end;

           //si la charge n'a pas de référence
           if trim(TaCarReference.AsString) = '' then
             begin
                 MessageTmp:='Êtes-vous sûr de supprimer cette charge à répartir ?';
//                 if MessageDlg(,mtConfirmation,[mbYes,mbNo],0)= mrno then
//                  abort;
             end//fin de charge n'a pas de référence
            else //si la charge a une référence
             begin
                 messageTmp:='Attention, la reprise de cette charge a été effectué !!!'
                 +#10#13+'La suppression de cette charge entraînera la suppression de l''OD de reprise et la mise à jour de la balance !!!'
                 +#10#13+'Confirmer la suppression de cette charge à répartir ?'
//                 if MessageDlg(,mtConfirmation,[mbYes,mbNo],0)=mrno then
//                 abort;
             end; //fin charge a une référence
         end;//fin ouverture
      C_Cloture: begin // si clôture
           //si charge saisie dans l'ouverture
           if TaCarDateSaisie.AsDateTime=E.DatExoDebut-1 then
             begin
               MessageDlg('Opération impossible car cette charge à répartir a été saisie dans le menu Ouverture !!!'
               +#10#13+'La suppression de cette charge ne peut se faire que dans le menu d'+#39+'ouverture !!!',mtWarning,[mbOK],0);
               abort;
             end//fin charge saisie dans ouverture
           else
             begin //si charge saisie dans clôture
             //si charge n'a pas de référence
                 if TaCarReference.AsString='' then
                 begin
                      messageTmp:='Êtes-vous sûr de vouloir supprimer cette charge à répartir ?'
//                      if MessageDlg(,mtConfirmation,[mbYes,mbNo],0)=mrno then
//                      abort;
                 end//fin charge n'a pas de référence
                 else //si charge a une référence
                  begin
                       messageTmp:='Êtes-vous sûr de vouloir supprimer cette charge à répartir ?'+#10#13+'La suppression de cette charge entraînera la suppression de l''OD et la mise à jour de la balance !!!'+#10#13+'Confirmer la suppression de cette charge à répartir ?';
//                       If Messagedlg(,mtconfirmation,[mbyes,mbno],0) = mrno Then
//                        abort;
                  end;//fin charge a une référence
             end;//fin saisie dans clôture
         end;// fin Clôture
   end;// fin du case.Quand
Case E.TypeEtatExercice of
 ET_Importation:begin
                  //
                end;
  ET_Normal:    begin
                  if not empty(messageTmp)then
                    If Messagedlg(messagetmp,MtConfirmation,[mbyes,mbno],0) = mrno Then
                       abort;
                end;
end;//fin du case E.TypeEtatExercice

TableGereStartTransaction(DataSet);
  case Quand of
     C_Ouverture: begin // si ouverture
            try
             DMBalance.MAJBalance(true,'Qt1_Report','Debit_Report',compte,
             compte,0,0,montantBilan,montantBilan,dsBrowse);
             if not empty(OD)then //si la charge a une référence
                 // suppression en plus de l'OD
                 DMPieces.SuppressionOD(OD);
            except
               begin
                 TableGereRollBack(DataSet);
                 TableGereRollBack(DMPieces.TaPiece);
                 showmessage('Problème à la mise à jour de la balance d''ouverture');
                 abort;
               end;
            end;
        end;//fin ouverture
     C_Cloture: begin // si clôture
           try
           if not empty(OD)then //si charge a une référence
             DMPieces.SuppressionOD(TaCarReference.AsString)
           else
             DMBalance.MAJBalance(true,'Qt1_base','Debit_base',compte,
             compte,0,0,montantBilan,montantBilan,dsBrowse);
           except
              begin
                 TableGereRollBack(DataSet);
                 TableGereRollBack(DMPieces.TaPiece);
                 showmessage('Problème à la suppression de l''OD ');
                 abort;
              end;
           end;
        end;// fin Clôture
  end;// fin du case.Quand
except
 TableGereRollBack(DataSet);
 TableGereRollBack(DMPieces.TaPiece);
  abort;
end;
end;


//******************* TDMChargeRepartir.TaCarAfterPost *************************
//
///*********************************************************************************
procedure TDMChargeRepartir.TaCarAfterPost(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
end;


//******************* TDMChargeRepartir.AfterEnregistrementModif *************************
//
///*********************************************************************************
procedure TDMChargeRepartir.AfterEnregistrementModif;
var
ODModif:string;
begin
try
ODModif:='';
ODModif:=TaCarReference.AsString;
  case Quand of
     C_Ouverture:begin //si ouverture
          //Mise à jour balance ouverture
            DMBalance.MAJBalance(false,'Qt1_Report','Debit_Report',
            TaCarCompte.AsString,TaCarCompte.AsString,0,0,
            TaCarMtBilanOuverture.AsCurrency,MontantTmp,dsedit);
          if not empty(TaCarReference.AsString) then
          begin //si la charge a une OD
              //si le montantBilanOuverture a été modifié
            if MontantTmp<>TaCarMtBilanOuverture.AsCurrency then
             Begin
                //Modification Piece,Ecriture (Suppression)
                DMPieces.SuppressionOD(TaCarReference.AsString);
                TaCarReference.AsString:='';
                TaCarMontantReprise.AsFloat:=0;
                TaCarDateSysteme.AsDateTime:=now;
              end
              else //si la désignation a été modifié
              If DesignationTmp <> TaCarDesignation.AsString then
              begin
              //Modification Piece, Ecriture (Libelle)
              DMPieces.ModificationOD(TaCarReference.AsString,TaCarDesignation.AsString);
              end;

          end;//fin la charge a une OD
      end;//fin ouverture
    C_Cloture:begin //si clôture
        if empty(TaCarReference.AsString) then
          begin //si la charge n'a pas d'OD
          //Mise à jour balance 
            DMBalance.MAJBalance(false,'Qt1_base','Debit_base',
            TaCarCompte.AsString,TaCarCompte.AsString,0,0,
            TaCarMtBilanOuverture.AsCurrency,MontantTmp,dsedit);
          end //fin si la charge n'a pas d'OD
        else
        if not empty(TaCarReference.AsString) then
          begin //si la charge a une OD
          od:=TaCarReference.AsString;
           if TaCarDateSaisie.AsDateTime=E.DatExoFin then
             begin //si ligne de clôture
               if (TaCarMtTotalCharge.AsCurrency<>MontantTmp) or (TaCarMontantReprise.AsCurrency<>MontantTmp1) then
                 begin//si montant a changé
                 DMPieces.SuppressionOD(OD);
                 CreationODCloture_avecObjet(TaCar,OD);
                 affichageOD:=true;
                   //DemandeAffichageReprise;
                 end//fin montant a changé
                 else
                 if TaCarDesignation.AsString<>DesignationTmp then
                   begin //si désignation a changé
                     DMPieces.ModificationOD(OD,TaCarDesignation.AsString);
                   end;//fin désignation a changé
             end//fin ligne de clôture
             else
             begin//si ligne d'ouverture
               if TaCarMontantReprise.AsCurrency<>0 then
               begin //si montant reprise renseigné
                 DMPieces.SuppressionOD(OD);
                 CreationODOuverture_avecObjet(TaCar,OD);
                 affichageOD:=true;
               end //fin montant reprise renseigné
               else
               begin //si montant reprise pas renseigné
                 DMPieces.SuppressionOD(OD);
                 TaCarReference.Asstring:='';
                 TaCarDateSysteme.AsDateTime:=now;
               end;//fin montant reprise pas renseigné
             end;// fin ligne d'ouverture
          end;  //fin la charge a une OD
      end;//fin clôture
  end;//fin du case.Quand
except
   TableGereRollback(TaCar);
   TableGereRollback(DMPieces.TaPiece);
   abort;
end;
end;


//******************* TDMChargeRepartir.TaCarAfterDelete *************************
//on déclenche un changement de state,
///*********************************************************************************
procedure TDMChargeRepartir.TaCarAfterDelete(DataSet: TDataSet);
begin
TableGereCommit(DataSet);
TableGereCommit(DMPieces.TaPiece);
DataCar.OnStateChange(DataSet);
end;



//******************* TDMChargeRepartir.TaCarAfterEdit *************************
//  de suite après une modification on met une variable à true
///*********************************************************************************
procedure TDMChargeRepartir.TaCarBeforeEdit(DataSet: TDataSet);
begin
if inttostr(Quand) < inttostr(C_Cloture) then
  if VerifSiCompteSaisieDsBO(CompteChargeARepartir,true,DataSet) then
    begin
      abort;  //Compte déjà utilisé dans BO
    end;
//////
   case Quand of
      C_Ouverture: begin // si ouverture
           //si la charge n'a pas de référence
           if not empty(TaCarReference.AsString) then
             begin
                 if MessageDlg('Attention, la reprise de cette charge a été effectué !!!'
                 +#10#13+'La modification de cette charge entraînera la suppression de l''OD de reprise et la mise à jour de la balance !!!'
                 +#10#13+'Confirmer la modification de cette charge à répartir ?',mtConfirmation,[mbYes,mbNo],0)=mrno then
                 abort;
             end; //fin charge a une référence
         end;//fin ouverture
      C_Cloture: begin // si clôture
           //si charge saisie dans l'ouverture
           if ((TaCarDateSaisie.AsDateTime=E.DatExoDebut-1)and(not empty(TaCarReference.AsString))) then
             begin
                 if MessageDlg('Attention, la reprise de cette charge a été effectué !!!'
                 +#10#13+'La modification de cette charge entraînera la suppression de l''OD de reprise et la mise à jour de la balance !!!'
                 +#10#13+'Confirmer la modification de cette charge à répartir ?',mtConfirmation,[mbYes,mbNo],0)=mrno then
                 abort;
             end//fin charge saisie dans ouverture
           else
             if ((TaCarDateSaisie.AsDateTime>E.DatExoDebut-1)and(not empty(TaCarReference.AsString))) then //si charges de cloture
             begin //si charge saisie dans clôture
             //si charge n'a pas de référence
                 if TaCarMontantReprise.AsCurrency=0 then
                 begin
                 if MessageDlg('Attention, la modification de cette charge entraînera la suppression de l''OD de clôture et la mise à jour de la balance !!!'
                 +#10#13+'Confirmer la modification de cette charge à répartir ?',mtConfirmation,[mbYes,mbNo],0)=mrno then
                 abort;
                 end//fin charge n'a pas de référence
                 else //si charge a une référence
                  begin
                 if MessageDlg('Attention, la reprise de cette charge a été effectué !!!'
                 +#10#13+'La modification de cette charge entraînera la suppression de l''OD de reprise et la mise à jour de la balance !!!'
                 +#10#13+'Confirmer la modification de cette charge à répartir ?',mtConfirmation,[mbYes,mbNo],0)=mrno then
                 abort;
                  end;//fin charge a une référence
             end;//fin saisie dans clôture
         end;// fin Clôture
   end;// fin du case.Quand

MontantTmp := TaCARMtBilanOuverture.AsCurrency;
MontantTmp1 := TaCARMontantReprise.AsCurrency;
DesignationTmp := TaCARDesignation.AsString;


end;



procedure TDMChargeRepartir.Filtrage_EcriturePourNouvelExo(var tMem:TRxMemoryData;NouvelleDate:Tdatetime);
var
Calcul:tquery;
begin
try
   try
   if dmrech.TaChargesRepartirRech.Active then dmrech.TaChargesRepartirRech.Close;
   dmrech.TaChargesRepartirRech.OnFilterRecord:=TaCarFilterRecordPourNouvelExo;
   FiltrageDataSet(dmrech.TaChargesRepartirRech,'');
   Calcul:=tquery.Create(self);
   calcul.DatabaseName:=dmrech.TaChargesRepartirRech.DatabaseName;
   calcul.SQL.Add('Select (MtBilanOuverture-MontantReprise) as resultat from ChargesRepartir.db where MontantReprise<MtBilanOuverture');
   calcul.Open;
   TableGereStartTransaction(dmrech.TaChargesRepartirRech);
   if dmrech.TaChargesRepartirRech.RecordCount<>0 then
      begin
      tMem.LoadFromDataSet(dmrech.TaChargesRepartirRech,0,lmcopy);
      calcul.First;
      tMem.First;
      while not(tMem.EOF) do
         begin
         tMem.edit;
         tMem.FindField('MontantReprise').AsFloat:=0;
         tMem.FindField('MtBilanOuverture').AsFloat:=calcul.FindField('resultat').AsFloat;
         tMem.FindField('DateSysteme').AsDateTime:=now;
         tMem.FindField('DateSaisie').AsDateTime:=NouvelleDate;
         tMem.FindField('Reference').Asstring:='';
         tMem.Post;
         tmem.FieldCount;
         tMem.Next;
         calcul.Next;
         end;
      end;
      TableGereCommit(dmrech.TaChargesRepartirRech);
      TableGereCommit(DMPieces.TaPiece);
   except
   DeFiltrageDataSet(dmrech.TaChargesRepartirRech);
   dmrech.TaChargesRepartirRech.OnFilterRecord:=nil;
   TableGereRollBack(dmrech.TaChargesRepartirRech);
   TableGereRollback(DMPieces.TaPiece);
   showmessage('Problème à l''écriture dans la nouvelle table '+dmrech.TaChargesRepartirRech.TableName);
   abort;
   end;//fin du try
finally
   dmrech.TaChargesRepartirRech.Filtered:=false;
   dmrech.TaChargesRepartirRech.Filter:='';
   dmrech.TaChargesRepartirRech.OnFilterRecord:=nil;
end;
end;



procedure TDMChargeRepartir.TaCarPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMPieces.TaPiece);
end;

procedure TDMChargeRepartir.TaCarDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(DataSet);
TableGereRollBack(DMPieces.TaPiece);
end;


procedure TDMChargeRepartir.TaCarBeforeInsert(DataSet: TDataSet);
begin
if assigned(FOnGEstInterfaceEvent) then
 FOnGEstInterfaceEvent(DataSet.Fields[2]);     
//  dataset.Fields[2].focuscontrol;
if inttostr(Quand) < inttostr(C_Cloture) then
    if VerifSiCompteSaisieDsBO(CompteChargeARepartir,true,DAtaSet) then
      begin
        abort;  //Compte déjà utilisé dans BO
      end;
end;

procedure TDMChargeRepartir.TaCarBeforeEIDOuv_Abort(DataSet: TDataSet);
Begin
if not e.AccesOuverture then
 MessageDlg('Vous ne pouvez plus modifier les Charges à Répartir d''ouverture !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Charges à Répartir d''ouverture !', mtError, [mbOK], 0);
abort;
End;

procedure TDMChargeRepartir.TaCarBeforeEIDClo_Abort(DataSet: TDataSet);
Begin
if not e.AccesCloture then
 MessageDlg('Vous ne pouvez plus modifier les Charges à Répartir de clôture !', mtInformation, [mbOK], 0)
 else MessageDlg('Erreur Interne, vous ne devez pas pouvoir modifier les Charges à Répartir de clôture !', mtError, [mbOK], 0);
abort;
End;


function VerifRepriseChargesARepartir(var messageTmp:Tmessages):boolean;
Begin
if DMChargeRepartir=nil then DMChargeRepartir:=TDMChargeRepartir.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
   result:= VerifExistChargesARepartirAReprendre(messageTmp,false);
     if not result then
        begin
         messageTmp.MessageErreur:='Toutes Les Charges à Repartir n''ont pas été reprises.'+#10#13#10#13;
         messageTmp.MessageQuestion:='Voulez-vous les reprendre avant la clôture définitive ?';
        end
      else
         messageTmp.MessageErreur:='OK';
  except
   showmessage('problème lors de la vérification des reprises de Charges A Repartir');
   abort;
  end;
End;


function VerifExistChargesARepartir(var messageTmp:Tmessages;Mess:boolean):boolean;
Begin
if DMChargeRepartir=nil then DMChargeRepartir:=TDMChargeRepartir.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
     DeFiltrageDataSet(DMRech.TaChargesRepartirRech);
     result:= DMRech.TaChargesRepartirRech.RecordCount<>0 ;
      if ((not result)and(mess)) then
         messageTmp.MessageErreur:='Aucune Charge à répartir  n''a été saisie'
      else
          messageTmp.MessageErreur:='OK';
  except
   showmessage('problème lors de la vérification de l''existence des Charges à répartir');
   abort;
  end;
End;


function VerifExistChargesARepartirAReprendre(var messageTmp:Tmessages;Mess:boolean):boolean;
Begin
if DMChargeRepartir=nil then DMChargeRepartir:=TDMChargeRepartir.create(Application.MainForm);
if DMRech=nil then DMRech:=TDMRech.create(Application.MainForm);
  try
   result:= VerifExistChargesARepartir(messageTmp,false);
   if result then
     begin
       FiltrageDataSet(DMRech.TaChargesRepartirRech,'DateSaisie = '''+DatetimeToStr(E.DatExoDebut-1)+''' And (MontantReprise=null or MontantReprise=0)  And Reference = ''''');
       result:= dmrech.TaChargesRepartirRech.RecordCount=0 ;
        if ((not result)and(mess)) then
           messageTmp.MessageErreur:='Il reste des Charges à répartir à reprendre'
        else
           messageTmp.MessageErreur:='OK';
     end
   else
     result:=true;
  except
   showmessage('problème lors de la vérification de l''existence des reprises des Charges à répartir');
   abort;
  end;
end;

Procedure TDMChargeRepartir.TraitementCloture4000(sender:Tobject);
Begin
main.Chargesrpartir2Click(main.Chargesrpartir2);
End;


procedure TDMChargeRepartir.CreationODCloture_avecObjet(TableEnCours:TTable;ODModif:string);
var
OD:string;
ListeOd:TStringList;
SourceEcriture:TRecordEcriture;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang:integer;
tab:variant;
ValPieceAutoGen:TValPieceAutoGenere;
CompteReprise:TCompte1;
Begin
   try
     try
       CompteReprise:=dmplan.FiltrageSurComptePourOD(12,2,TableEnCours.findfield('Compte').AsString,e.regime);
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(TableEnCours);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=e.DatExoFin;
       SourcePiece.Validation:=e.DatExoFin;
       SourcePiece.Libelle:=TableEnCours.findfield('Designation').AsString;
       SourcePiece.Compte:=TableEnCours.findfield('Compte').AsString;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=ODModif;
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       if TableEnCours.findfield('MontantReprise').Ascurrency<>0 then
          begin
          //remplissage de 4 lignes pour l'OD
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteReprise.CompteDotation,'','',0,0,TableEnCours.findfield('MtBilanOuverture').AsCurrency,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteChargeARepartir,'','',0,0,-TableEnCours.findfield('MtBilanOuverture').AsCurrency,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteReprise.CompteReprise,'','',0,0,-TableEnCours.findfield('MontantReprise').AsCurrency,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteChargeARepartir,'','',0,0,TableEnCours.findfield('MontantReprise').AsCurrency,0,'','',0,'',''],true,false,-1);
          SourcePiece.TotalPiece:=TableEnCours.findfield('MtBilanOuverture').AsCurrency+TableEnCours.findfield('MontantReprise').AsCurrency;
          end
        else
          Begin
          //remplissage de 2 lignes pour l'OD
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteReprise.CompteDotation,'','',0,0,TableEnCours.findfield('MtBilanOuverture').AsCurrency,0,'','',0,'',''],true,false,-1);
          DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteChargeARepartir,'','',0,0,-TableEnCours.findfield('MtBilanOuverture').AsCurrency,0,'','',0,'',''],true,false,-1);
          SourcePiece.TotalPiece:=TableEnCours.findfield('MtBilanOuverture').AsCurrency;
          End;
       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if DMImport.messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMChargeRepartir,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;


procedure TDMChargeRepartir.CreationODOuverture_avecObjet(TableEnCours:TTable;ODModif:string);
var
OD:string;
ListeOd:TStringList;
SourceEcriture:TRecordEcriture;
SourcePiece:TRecordPiece;
listeFactice:Tlist;
rang:integer;
tab:variant;
ValPieceAutoGen:TValPieceAutoGenere;
CompteReprise:TCompte1;
Begin
   try
     try
       CompteReprise:=dmplan.FiltrageSurComptePourOD(12,2,TableEnCours.findfield('Compte').AsString,e.regime);
       listeFactice:=nil;
       DMPieces.Piece1.initialiseValPieceAutoGen(ValPieceAutoGen);
       ValPieceAutoGen:=ValAutoPieceGenere(TableEnCours);
       SourcePiece.IDJournal:=3;
       SourcePiece.Date:=e.DatExoDebut;
//       SourcePiece.Date:=e.DatExoFin;
       SourcePiece.Validation:=SourcePiece.Date;
       SourcePiece.Libelle:=TableEnCours.findfield('Designation').AsString;
       SourcePiece.Compte:=TableEnCours.findfield('Compte').AsString;
       SourcePiece.Journal:='OD';
       SourcePiece.Reference:=ODModif;
       DMImport.VerifCreationPieceEcriture;
       DMImport.Piece_Import.NouvellePiece(false);

       if DMImport.Ecriture_Import.ListeEcriturePiece=nil then
       DMImport.Ecriture_Import.ListeEcriturePiece:=tlist.Create;
       rang:=1;
       //remplissage ligne vide
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H'],true,false,-1);
       //remplissage de 2 lignes pour l'OD

       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteReprise.CompteReprise,'','',0,0,-TableEnCours.findfield('MontantReprise').AsCurrency,0,'','',0,'',''],true,false,-1);
       DMImport.Ecriture_Import.ListRecordEcritureAdd_Insert(listeFactice,['H',CompteChargeARepartir,'','',0,0,TableEnCours.findfield('MontantReprise').AsCurrency,0,'','',0,'',''],true,false,-1);
       SourcePiece.TotalPiece:=TableEnCours.findfield('MontantReprise').AsCurrency;
       DMImport.RecupPieceEcriture_SurRecords(false,SourcePiece,DMImport.Ecriture_Import.ListeEcriturePiece,ValPieceAutoGen,'','',0);
       ListeOd:=TStringList.Create;
       DMImport.EnregistrementPiece(false,nil,ListeOd,listeFactice);
     except
       if DMImport.messageTmp then
         showmessage('Problème lors de l''enregistrement d''une pièce');
       abort;
     end;//fin du try except
   finally
   Initialise_TList(DMImport.Ecriture_Import.ListeEcriturePiece,DMChargeRepartir,false);
//   if DMImport.Ecriture_Import.ListeEcriturePiece<>nil then
//     Begin
//        DMImport.Ecriture_Import.ListeEcriturePiece.Free;
//        DMImport.Ecriture_Import.ListeEcriturePiece:=nil;
//     End;
   end;//fin du try finally
End;


procedure TDMChargeRepartir.TaCarAfterInsert(DataSet: TDataSet);
begin
InitChampAfterInsert([nil,nil,nil,0,0,nil,nil,0,nil],DataSet);
end;

procedure TDMChargeRepartir.TaCarCalcFields(DataSet: TDataSet);
begin
//if Not empty(DataSet.findField('Reference').AsString) then
//TaCarReprise2.AsString:='Oui'
//else
//TaCarReprise2.AsString:='Non'
TaCarReprise.AsBoolean:=Not empty(DataSet.findField('Reference').AsString);
TaCarMtRestant.AsCurrency:=TaCarMtBilanOuverture.AsCurrency-TaCarMontantReprise.AsCurrency;
end;

procedure TDMChargeRepartir.TaCarFilterRecordPourNouvelExo(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  Begin//si
    accept:=dmrech.TaChargesRepartirRech.FindField('MontantReprise').AsCurrency
         < dmrech.TaChargesRepartirRech.FindField('MtBilanOuverture').AsCurrency;
  End;//fin si
end;

Procedure TDMChargeRepartir.ImportsChargeRepartir(Valeurs:array of const;DataSet:TDataSet);
Begin
case Quand of
   // ouverture
   C_Ouverture:Begin
      try
       ImportTable(Valeurs,DataSet);
      except
       abort;
      end;
     End;
   // Cloture
   C_Cloture:Begin
      try
       ImportTable(Valeurs,DataSet);
      except
       abort;
      end;
     End;
end;
End;

Procedure TDMChargeRepartir.GestionAccesChargesRepartir;
Begin
  case Quand of
     C_Ouverture:Begin
                  if E.AccesOuverture then
                   begin
                    TaCar.BeforeInsert := TaCarBeforeInsert;
                    TaCar.BeforeEdit := TaCarBeforeEdit;
                    TaCar.BeforeDelete := TaCarBeforeDelete;
                   end
                  else
                   begin
                    TaCar.BeforeInsert := TaCarBeforeEIDOuv_Abort;
                    TaCar.BeforeEdit := TaCarBeforeEIDOuv_Abort;
                    TaCar.BeforeDelete := TaCarBeforeEIDOuv_Abort;
                   end;
                 End;

     C_Cloture:Begin
                  if E.AccesCloture then
                   begin
                    TaCar.BeforeInsert := TaCarBeforeInsert;
                    TaCar.BeforeEdit := TaCarBeforeEdit;
                    TaCar.BeforeDelete := TaCarBeforeDelete;
                   end
                  else
                   begin
                    TaCar.BeforeInsert := TaCarBeforeEIDClo_Abort;
                    TaCar.BeforeEdit := TaCarBeforeEIDClo_Abort;
                    TaCar.BeforeDelete := TaCarBeforeEIDClo_Abort;
                   end;
               End;
  end;
End;


//function TDMChargeRepartir.RecupSoldeCompte(Compte:string;RepriseEnCours:currency):Tcalcul;
//begin
//  try//except
//    initialise_TCalcul(result);
//    QuSoldeCompte.Close;
//    QuSoldeCompte.ParamByName('Cpt').asstring:=compte;
//    QuSoldeCompte.open;
//    result.Retour:=QuSoldeCompte.recordcount<>0;
//    if result.retour then
//     begin
//       result.Total:=QuSoldeCompte.findfield('MontantRestant').ascurrency+RepriseEnCours;
//       result.SensTotal:=-1;
//     end;
//  except
//    result.Retour:=false;
//  end;//fin except
//end;
Function EditionChargeRepartirL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;idCharge:string;Site:TEditLien):Boolean;
Var
ListeidCharge:TStringList;
Begin
ListeidCharge:=TStringList.Create;
ListeidCharge.Add(idCharge);
EditionChargeRepartirL(TypeEdition,Quand,DataSet,ListeidCharge,Site);
End;

Function EditionChargeRepartirL(TypeEdition : integer; Quand : integer; DataSet:TDataSet;ListeidCharge:TStringList;Site:TEditLien):Boolean;
var
NomFich,Chemin:String;
NomMenuSiteWeb:TfileStream;
MtTotalCharge,MtBilanOuverture,MontantReprise,MtRestant:currency;
TotMtTotalCharge,TotMtBilanOuverture,TotMontantReprise,TotMtRestant:currency;
ListeValeur:TStringList;
ObjPrn:TObjetEdition;
TitreCompte:string;
Begin
try
 ObjPrn:=TObjetEdition.Create(application.MainForm);
 Chemin :=E.RepertoireComptaWeb;
 case Quand of
    C_Ouverture:NomFich:='ChargeRepartirOuv';
    C_Cloture:NomFich:='ChargeRepartirClo';
 end;

//MtTotalCharge:=0;
//MtBilanOuverture:=0;
//MontantReprise:=0;
MtRestant:=0;
TotMtTotalCharge:=0;
TotMtBilanOuverture:=0;
TotMontantReprise:=0;
TotMtRestant:=0;

 if DMChargeRepartir=nil then DMChargeRepartir:=TDMChargeRepartir.Create(Application.MainForm);
 if dataset = nil then
  begin
   // Prevu pour passer le dataset concerné
   // Inutile dans Stocks pour l'instant
  end;
 ListeValeur:=TStringList.Create;
 ObjPrn.FontLigneSeule.Style := [fsBold];

 DMChargeRepartir.QuChargeRepartirEdition.OnFilterRecord :=nil;

 if ListeidCharge <> nil then
  begin
   TitreCompte:='Du compte :'+ListeidCharge.Strings[0]+' au compte :'+ListeidCharge.Strings[ListeidCharge.count-1];
   DMChargeRepartir.ListeEdit.Assign(ListeidCharge);
   DeFiltrageDataSet(DMChargeRepartir.QuChargeRepartirEdition);
   DMChargeRepartir.QuChargeRepartirEdition.OnFilterRecord :=DMChargeRepartir.QuChargeRepartirEditionFilterRecord;
   FiltrageDataSet(DMChargeRepartir.QuChargeRepartirEdition,'');
  end
 else
  begin
    DMChargeRepartir.QuChargeRepartirEdition.OnFilterRecord :=nil;
    TitreCompte:=' Toutes les charges à répartir ';
  end;

 case Quand of
    C_Ouverture:begin

                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Clear;
                 DMChargeRepartir.QuChargeRepartirEdition.Params.Clear;
                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Add('select * from chargesRepartir.db ');
                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Add(' where DateSaisie <=:DateANouveau');
                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Add(' order by id');
                 DMChargeRepartir.QuChargeRepartirEdition.Params[0].DataType := ftDAte;
                 DMChargeRepartir.QuChargeRepartirEdition.Params[0].AsDate := E.DatExoDebut -1;
                 DMChargeRepartir.QuChargeRepartirEdition.Open;
                 if DMChargeRepartir.QuChargeRepartirEdition.recordcount<>0 then
                 begin
                 DMChargeRepartir.QuChargeRepartirEdition.First;
                 while not DMChargeRepartir.QuChargeRepartirEdition.Eof do
                   begin
                    TotMtTotalCharge:=TotMtTotalCharge+DMChargeRepartir.QuChargeRepartirEdition.FindField('MtTotalCharge').AsCurrency;
                    TotMtBilanOuverture:=TotMtBilanOuverture+DMChargeRepartir.QuChargeRepartirEdition.FindField('MtBilanOuverture').AsCurrency;
                    TotMontantReprise:=TotMontantReprise+DMChargeRepartir.QuChargeRepartirEdition.FindField('MontantReprise').AsCurrency;
                    MtRestant:=(DMChargeRepartir.QuChargeRepartirEdition.FindField('MtBilanOuverture').AsCurrency-DMChargeRepartir.QuChargeRepartirEdition.FindField('MontantReprise').AsCurrency);
                    TotMtRestant:=TotMtRestant+MtRestant;
                    ListeValeur.Add('0'+
                                     ';'+
                                     GereLibelle(DMChargeRepartir.QuChargeRepartirEdition.FindField('Compte').AsString)+
                                     ';'+
                                     GereLibelle(DMChargeRepartir.QuChargeRepartirEdition.FindField('Designation').AsString)+
                                     ';'+
                                     DMChargeRepartir.QuChargeRepartirEdition.FindField('MtTotalCharge').AsString+
                                     ';'+
                                     DMChargeRepartir.QuChargeRepartirEdition.FindField('MtBilanOuverture').AsString+
                                     ';'+
                                     DMChargeRepartir.QuChargeRepartirEdition.FindField('MontantReprise').AsString+
                                     ';'+
                                     currtostr(MtRestant)
                                     );
                    MtRestant:=0;
                    DMChargeRepartir.QuChargeRepartirEdition.Next;
                   end;
                 ListeValeur.Add('1;; @TOTAL DES CHARGES A REPARTIR : ;'+CurrToStr(TotMtTotalCharge)+';'+CurrToStr(TotMtBilanOuverture)+';' +CurrToStr(TotMontantReprise)+';'+CurrToStr(TotMtRestant));
                 DMChargeRepartir.QuChargeRepartirEdition.Close;
                 ObjPrn.FTitreEdition := 'Etat des charges à répartir à l''ouverture';
                 ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoDebut).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
                 ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
                 ListeValeur.Insert(0,' Compte ; Désignation ; Total Charge ; Restant à reprendre ; Reprise de l''exer. ; Solde fin exercice ');
                 ListeValeur.Insert(1,'0.6;2;1.2;1.2;1.2;1.2');
                 ListeValeur.Insert(2,'texte;texte;curr;curr;curr;curr');
                 end;
                 ObjPrn.AffichageImp(ListeValeur);
                end;

    C_Cloture: begin
                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Clear;
                 DMChargeRepartir.QuChargeRepartirEdition.Params.Clear;
                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Add('select * from ChargesRepartir.db ');
                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Add(' where DateSaisie <=:DateANouveau');
                 DMChargeRepartir.QuChargeRepartirEdition.SQL.Add(' order by id');
                 DMChargeRepartir.QuChargeRepartirEdition.Params[0].DataType := ftDAte;
                 DMChargeRepartir.QuChargeRepartirEdition.Params[0].AsDate := E.DatExoFin;
                 DMChargeRepartir.QuChargeRepartirEdition.Open;
                 if DMChargeRepartir.QuChargeRepartirEdition.recordcount<>0 then
                 begin
                 DMChargeRepartir.QuChargeRepartirEdition.First;
                 while not DMChargeRepartir.QuChargeRepartirEdition.Eof do
                   begin
                    TotMtTotalCharge:=TotMtTotalCharge+DMChargeRepartir.QuChargeRepartirEdition.FindField('MtTotalCharge').AsCurrency;
                    TotMtBilanOuverture:=TotMtBilanOuverture+DMChargeRepartir.QuChargeRepartirEdition.FindField('MtBilanOuverture').AsCurrency;
                    TotMontantReprise:=TotMontantReprise+DMChargeRepartir.QuChargeRepartirEdition.FindField('MontantReprise').AsCurrency;
                    MtRestant:=(DMChargeRepartir.QuChargeRepartirEdition.FindField('MtBilanOuverture').AsCurrency-DMChargeRepartir.QuChargeRepartirEdition.FindField('MontantReprise').AsCurrency);
                    TotMtRestant:=TotMtRestant+MtRestant;
                    ListeValeur.Add('0'+
                                     ';'+
                                     GereLibelle(DMChargeRepartir.QuChargeRepartirEdition.FindField('Compte').AsString)+
                                     ';'+
                                     GereLibelle(DMChargeRepartir.QuChargeRepartirEdition.FindField('Designation').AsString)+
                                     ';'+
                                     DMChargeRepartir.QuChargeRepartirEdition.FindField('MtTotalCharge').AsString+
                                     ';'+
                                     DMChargeRepartir.QuChargeRepartirEdition.FindField('MtBilanOuverture').AsString+
                                     ';'+
                                     DMChargeRepartir.QuChargeRepartirEdition.FindField('MontantReprise').AsString+
                                     ';'+
                                     currtostr(MtRestant)
                                     );
                    MtRestant:=0;
                    DMChargeRepartir.QuChargeRepartirEdition.Next;
                   end;
                 ListeValeur.Add('1;; @TOTAL DES CHARGES A REPARTIR : ;'+CurrToStr(TotMtTotalCharge)+';'+CurrToStr(TotMtBilanOuverture)+';' +CurrToStr(TotMontantReprise)+';'+CurrToStr(TotMtRestant));
                 DMChargeRepartir.QuChargeRepartirEdition.Close;
                 ObjPrn.FTitreEdition := 'Etat des charges à répartir à la clôture';
                 ObjPrn.FTitre2Edition :='Période du '+DateInfos(E.DatExoFin).DateStr+' au '+DateInfos(E.DatExoFin).DateStr;
                 ObjPrn.FTitre3Edition := 'Dossier : '+E.NomDossier;
                 ListeValeur.Insert(0,' Compte ; Désignation ; Total Charge ; Restant à reprendre ; Reprise de l''exer. ; Solde fin exercice ');
                 ListeValeur.Insert(1,'0.6;2;1.2;1.2;1.2;1.2');
                 ListeValeur.Insert(2,'texte;texte;curr;curr;curr;curr');
                 end;
                 ObjPrn.AffichageImp(ListeValeur);
                end;
 end;
Finally
   DeFiltrageDataSet(DMChargeRepartir.QuChargeRepartirEdition);
   DMChargeRepartir.QuChargeRepartirEdition.OnFilterRecord :=nil;
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
End;

procedure TDMChargeRepartir.QuChargeRepartirEditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept := ListeEdit.IndexOf(DAtaSet.findField('id').AsString) <> -1;
end;


end.

