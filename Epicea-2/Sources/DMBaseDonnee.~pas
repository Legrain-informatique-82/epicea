unit DMBaseDonnee;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables,RxQuery, Db,E2_Decl_Records,LibSql,LibFichRep,Gr_Librairie_Obj,
  E2_Librairie_Obj,FileCtrl,Gr_MultDos,CreationPlanDioc,CreationPlanAGri,
  CreationTrameDioc,CreationTrameLDioc,CreationModel,CreationCodeTVAAgri,E2_LibInfosTable,
  DMRecherche,
  DMRecherche_Obj,
  Lib_Chaine,registry,E2_DosProtect,CreationModelAgri,CreationProgramme,FileUtil,
  xmldom, XMLIntf, oxmldom, XMLDoc,
  CreationPlanAgriCOGERE,
  CreationConstAnalCOGERE,
  CreationPlanIndus,
  LibRessourceString,
  CreationAtelierAnalCOGERE,
  CreationAtelier_ActiviteAnalCOGERE,
  CreationAtelier_CompteAnalCOGERE;

type
  TDMBD = class(TDataModule)
    dbNameProg: TDatabase;
    dbNameDossier: TDatabase;
    dbNameExo: TDatabase;
    DbNameExoN1: TDatabase;
    TaGestDosRecherche: TTable;
    TaGestDosRechercheID_Dossier: TIntegerField;
    TaGestDosRechercheID_Table: TIntegerField;
    TaGestDosRechercheNom_Dossier: TStringField;
    TaGestDosRechercheDir_Dossier: TStringField;
    TaGestDosRechercheNom_Exo: TStringField;
    TaGestDosRechercheDir_Exo: TStringField;
    TaGestDosRechercheAnnee_Dossier: TDateTimeField;
    TaGestDosRechercheDateUtil: TDateTimeField;
    TaGestDosRechercheCloture: TBooleanField;
    TaGestDosRechercheEXO_BASE: TStringField;
    TaGestDosRechercheEXO_SAISIE: TStringField;
    TaGestDosRechercheDATE_DEB_EXO: TDateField;
    TaGestDosRechercheDATE_FIN_EXO: TDateField;
    TaParcours: TTable;
  Function InitBDProgram(Path:string):boolean;
  Function InitBDDossier(Path:string):boolean;
  Function InitBDExercice(Path:string):boolean;
  Function InitBDExo_N1(Path:string;MessageAffiche:boolean=true):boolean;
  Function InitAllDB(PathProgram,PathDossier,PathExo:string):boolean;
  Function OpenAllTAble:boolean;
  Function OpenTableExercice:boolean;
  Function OpenTableDossier:boolean;
  Function CloseAllTAble:boolean;
  Function CloseAllTAbleExo(MessErreur:String):boolean;
  Function CloseAllTAbleDossier(MessErreur:String):boolean;
  function Raccordement_Vers_N1(IdDos,IdExo:Integer):boolean;
  function CloturerExercice_N(TableDossier:TTable;Dossier,Exo:integer):boolean;
  procedure DMBDDestroy(Sender: TObject);
  Procedure Verif_Init_Table_De_Base_Dossier_Non_Vide(Path:String);
  procedure DataModuleCreate(Sender: TObject);
  Procedure VerifAFaire(Type_Utilisation:Integer);

  //isa le 18/08/03
  Function BrancheTableVersN1(TableN1:TDataset):boolean;
  Function BrancheTableVersN(TableN1:TDataset):boolean;
  { isa  le  10/10/03 }
  Procedure Verif_Init_Table_De_Base_Exercice_Non_Vide(Path:String);
  ///////

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMBD: TDMBD;

  Function IndexTableEpicea(NomTable:string):Word;
  function ValAutoPieceGenere(Table:TTable):TValPieceAutoGenere;
  function GenereDMDossier:boolean;
implementation

uses E2_ParamProg, DMProgramme, DMParamEnt, DMConstantes,
  E2_GestionSauvegarde,  DMXMLs, DMAide, DMJournaux, DMPiece, DMEcriture,
  DMBalances, DMDiocEtatBalance, DMDiocEtatBalanceT, DMTier, ModuleTrame,
  DMTVA, DMPointages2, DMInitTablesEpi, LibClassObjetSenders, DMTTVA,
  DMImportation,   DMCorrection,DMPlanCpt, Lib1, DiversProjets,
  CreationPlanAsso;

{$R *.DFM}

function GenereDMDossier:boolean;
Begin

  if DMBD = nil then
  Application.CreateForm(TDMBD, DMBD);
  if DMRech=nil then
  Application.CreateForm(TDMRech,DMRech);
  if DMRech_Obj=nil then
  Application.CreateForm(TDMRech_Obj,DMRech_Obj);
  if DMPlan = nil then
  Application.CreateForm(TDMPlan,DMPlan);
  if DMAides = nil then
  Application.CreateForm(TDMAides, DMAides);
  if DMJournal = nil then
  Application.CreateForm(TDMJournal, DMJournal);
  if DMPieces = nil then
  Application.CreateForm(TDMPieces, DMPieces);
  if DMEcritures = nil then
  Application.CreateForm(TDMEcritures, DMEcritures);
  if DMBalance = nil then
  Application.CreateForm(TDMBalance, DMBalance);
  if DMDiocEtatBal = nil then
  Application.CreateForm(TDMDiocEtatBal, DMDiocEtatBal);
  if DMDiocEtatBalT = nil then
  Application.CreateForm(TDMDiocEtatBalT, DMDiocEtatBalT);
  if DMTiers = nil then
  Application.CreateForm(TDMTiers, DMTiers);
  if DMTrame = nil then
  Application.CreateForm(TDMTrame, DMTrame);
  if DMTVACode = nil then
  Application.CreateForm(TDMTVACode, DMTVACode);
  if DMPointage2 = nil then
  Application.CreateForm(TDMPointage2, DMPointage2);
  if DMTmTVA = nil then
  Application.CreateForm(TDMTmTVA, DMTmTVA);
  if DMImport = nil then
  Application.CreateForm(TDMImport, DMImport);
  if DMInitTableEpi = nil then
  Application.CreateForm(TDMInitTableEpi, DMInitTableEpi);

End;

Procedure TDMBD.VerifAFaire(Type_Utilisation:Integer);
Begin
  case Type_Utilisation of
    CT_DEVELOPPEMENT:Begin

                     End;

    CT_DISTRIBUTION:Begin
//                     showmessage('Penser à définir le type de client, comme COGERE, Bloquel');
//                     showmessage('Penser à définir si type_version_test_client');
                    End;

  else showmessage('Le type de l''exécutable n''est pas défini !');
  end;

End;


Function IndexTableEpicea(NomTable:string):Word;
begin
result:=0;

 //***************************************//
 // Table Program { niveau 1 } 12 Tables //
 //***************************************//

 if upperCase(NomTable)=upperCase('C_Tva.db') then
 Begin
   result:=101;
   exit;
 End;

 if upperCase(NomTable)=upperCase('Const.db') then
 Begin
   result:=102;
   exit;
 End;

 if upperCase(NomTable)=upperCase('CreTables.db') then
 Begin
   result:=103;
   exit;
 End;

if upperCase(NomTable)=upperCase('Dev_Prix.DB') then
 Begin
   result:=104;
   exit;
 End;

if upperCase(NomTable)=upperCase('Devise.DB') then
 Begin
   result:=105;
   exit;
 End;

if upperCase(NomTable)=upperCase('GestDossier.db') then
 Begin
   result:=106;
   exit;
 End;

if upperCase(NomTable)=upperCase('Message.db') then
 Begin
   result:=107;
   exit;
 End;

if upperCase(NomTable)=upperCase('ParamCpt.db') then
 Begin
   result:=108;
   exit;
 End;

if upperCase(NomTable)=upperCase('PeriodeValidite.DB') then
 Begin
   result:=109;
   exit;
 End;

if upperCase(NomTable)=upperCase('PlagesAmortissement.DB') then
 Begin
   result:=110;
   exit;
 End;

if upperCase(NomTable)=upperCase('PlanCPTE.DB') then
 Begin
   result:=111;
   exit;
 End;

if upperCase(NomTable)=upperCase('T_Com.DB') then
 Begin
   result:=112;
   exit;
 End;

 //***************************************//
 // Table Dossier { niveau 2 } 18 Tables //
 //***************************************//

 if upperCase(NomTable)=upperCase('Echeance.db') then
 Begin
   result:=201;
   exit;
 End;

if upperCase(NomTable)=upperCase('EchEmp.db') then
 Begin
   result:=202;
   exit;
 End;

if upperCase(NomTable)=upperCase('H_Tva.db') then
 Begin
   result:=203;
   exit;
 End;

if upperCase(NomTable)=upperCase('Immos.db') then
 Begin
   result:=204;
   exit;
 End;

if upperCase(NomTable)=upperCase('Piece.db') then
 Begin
   result:=205;
   exit;
 End;

if upperCase(NomTable)=upperCase('Ecriture.db') then
 Begin
   result:=206;
   exit;
 End;

 if upperCase(NomTable)=upperCase('Dec_Tva.db') then
 Begin
   result:=207;
   exit;
 End;

if upperCase(NomTable)=upperCase('Det_Cre.db') then
 Begin
   result:=208;
   exit;
 End;

if upperCase(NomTable)=upperCase('TvaCode.db') then
 Begin
   result:=209;
   exit;
 End;

if upperCase(NomTable)=upperCase('Model.db') then
 Begin
   result:=210;
   exit;
 End;

if upperCase(NomTable)=upperCase('ModelL.db') then
 Begin
   result:=211;
   exit;
 End;

if upperCase(NomTable)=upperCase('Param_Dossier.db') then
 Begin
   result:=212;
   exit;
 End;
 if upperCase(NomTable)=upperCase('Plancpt.db') then
 Begin
   result:=C_IPlanCpt;
   exit;
 End;

if upperCase(NomTable)=upperCase('Pointage.db') then
 Begin
   result:=214;
   exit;
 End;

if upperCase(NomTable)=upperCase('ResteDC.db') then
 Begin
   result:=215;
   exit;
 End;

if upperCase(NomTable)=upperCase('Tiers.db') then
 Begin
   result:=216;
   exit;
 End;

if upperCase(NomTable)=upperCase('Trame.db') then
 Begin
   result:=217;
   exit;
 End;

if upperCase(NomTable)=upperCase('TrameL.db') then
 Begin
   result:=218;
   exit;
 End;

if upperCase(NomTable)=upperCase('Emprunts.db') then
 Begin
   result:=306;
   exit;
 End;

if upperCase(NomTable)=upperCase('H_PieceTva.db') then
 Begin
   result:=219;
   exit;
 End;

if upperCase(NomTable)=upperCase('H_Tva_Fin.db') then
 Begin
   result:=220;
   exit;
 End;

if upperCase(NomTable)=upperCase('H_Tva_Report.db') then
 Begin
   result:=221;
   exit;
 End;

if upperCase(NomTable)=upperCase('TA_Activite.db') then
 Begin
   result:=222;
   exit;
 End;

if upperCase(NomTable)=upperCase('T_Affect_Atelier.db') then
 Begin
   result:=223;
   exit;
 End;

if upperCase(NomTable)=upperCase('TA_Atelier.db') then
 Begin
   result:=224;
   exit;
 End;

if upperCase(NomTable)=upperCase('Piece_Import.db') then
 Begin
   result:=225;
   exit;
 End;

 //***************************************//
 // Table Exercice { niveau 3 } 13 Tables //
 //***************************************//

 if upperCase(NomTable)=upperCase('ChargeAPayer.db') then
 Begin
   result:=301;
   exit;
 End;

 if upperCase(NomTable)=upperCase('ChargesRepartir.db') then
 Begin
   result:=302;
   exit;
 End;

 if upperCase(NomTable)=upperCase('DepensesEntreprises.db') then
 Begin
   result:=303;
   exit;
 End;

if upperCase(NomTable)=upperCase('Balance.DB') then
 Begin
   result:=304;
   exit;
 End;

if upperCase(NomTable)=upperCase('BalanceTiers.DB') then
 Begin
   result:=305;
   exit;
 End;


if upperCase(NomTable)=upperCase('Immos_clot.db') then
 Begin
   result:=307;
   exit;
 End;

if upperCase(NomTable)=upperCase('PCA.db') then
 Begin
   result:=308;
   exit;
 End;

if upperCase(NomTable)=upperCase('Provisions.db') then
 Begin
   result:=309;
   exit;
 End;

if upperCase(NomTable)=upperCase('Stock.DB') then
 Begin
   result:=310;
   exit;
 End;

if upperCase(NomTable)=upperCase('Reglemnt.DB') then
 Begin
   result:=311;
   exit;
 End;

if upperCase(NomTable)=upperCase('TA_Atelier_Activite.DB') then
 Begin
   result:=312;
   exit;
 End;

if upperCase(NomTable)=upperCase('TA_Compte_Atelier.DB') then
 Begin
   result:=313;
   exit;
 End;

if upperCase(NomTable)=upperCase('TA_Ecriture_Atelier.DB') then
 Begin
   result:=314;
   exit;
 End;

if upperCase(NomTable)=upperCase('Report.DB') then
 Begin
   result:=315;
   exit;
 End;

end;



function ValAutoPieceGenere(Table:TTable):TValPieceAutoGenere;
Begin
result.TableGen:=false;
result.Champ_Gen:='';
result.Table_Gen:='';
result.Val_Champ_Gen:='';
if table<>nil then
case IndexTableEpicea(Table.TableName) of
   0:;

   301:Begin
       result.TableGen:=True;
       result.Champ_Gen:='ID';
       result.Table_Gen:='ChargeAPayer.db';
       result.Val_Champ_Gen:=Table.findfield('ID').AsString;
      End;

   302: Begin
       result.TableGen:=True;
       result.Champ_Gen:='ID';
       result.Table_Gen:='ChargesRepartir.db';
       result.Val_Champ_Gen:=Table.findfield('ID').AsString;
      End;

   303: Begin
       result.TableGen:=True;
       result.Champ_Gen:='ID';
       result.Table_Gen:='DepensesEntreprises.db';
       result.Val_Champ_Gen:=Table.findfield('ID').AsString;
      End;

   201: Begin
       result.TableGen:=True;
       result.Champ_Gen:='ID_Ecriture';
       result.Table_Gen:='Echeance.db';
       result.Val_Champ_Gen:=Table.findfield('ID_Ecriture').AsString;
      End;

   202: Begin
       result.TableGen:=True;
       result.Champ_Gen:='ID';
       result.Table_Gen:='EchEmp.db';
       result.Val_Champ_Gen:=Table.findfield('ID_Annuite').AsString;
      End;


   306: Begin
       result.TableGen:=True;
       result.Champ_Gen:='ID';
       result.Table_Gen:='Emprunts.db';
       result.Val_Champ_Gen:=Table.findfield('ID').AsString;
      End;

   203: Begin
       result.TableGen:=True;
       result.Champ_Gen:='ID_Declaration';
       result.Table_Gen:='H_Tva.db';
       result.Val_Champ_Gen:=Table.findfield('ID_Declaration').AsString;
      End;

   204: Begin
       result.TableGen:=True;
       result.Champ_Gen:='ID';
       result.Table_Gen:='Immos.db';
       result.Val_Champ_Gen:=Table.findfield('ID').AsString;
      End;

   307: Begin
       result.TableGen:=True;
       result.Champ_Gen:='ID';
       result.Table_Gen:='Immos_clot.db';
       result.Val_Champ_Gen:=Table.findfield('ID').AsString;
      End;

   308: Begin
        result.TableGen:=True;
        result.Champ_Gen:='ID';
        result.Table_Gen:='PCA.db';
        result.Val_Champ_Gen:=Table.findfield('ID').AsString;
      End;

   309: Begin
        result.TableGen:=True;
        result.Champ_Gen:='ID';
        result.Table_Gen:='Provisions.db';
        result.Val_Champ_Gen:=Table.findfield('ID').AsString;
       End;

   310: Begin
        result.TableGen:=True;
        result.Champ_Gen:='ID';
        result.Table_Gen:='Stock.DB';
        result.Val_Champ_Gen:=Table.findfield('ID').AsString;
       End;

   // Retourne les valeurs pour la table Ecriture
   206: Begin
        if Table.Active then
         begin
           result.TableGen:=True;
           result.Champ_Gen:=Table.findfield('Table_Gen').AsString;
           result.Table_Gen:=Table.findfield('Champ_Gen').AsString;
           result.Val_Champ_Gen:=Table.findfield('Val_Champ_Gen').AsString;
         end;
       End;

   // Retourne les valeurs pour la table Piece
   205: Begin
        if Table.Active then
         begin
           result.TableGen:=True;
           result.Champ_Gen:=Table.findfield('Table_Gen').AsString;
           result.Table_Gen:=Table.findfield('Champ_Gen').AsString;
           result.Val_Champ_Gen:=Table.findfield('Val_Champ_Gen').AsString;
         end;
       End;
end;//fin du case
if result.TableGen then
  result.Val_Champ_Gen:=result.Val_Champ_Gen+';'+Nous;
End;

Function TDMBD.InitBDProgram(Path:string):boolean;
Begin
try
  result:=true;
  // Création éventuelle des table généré pour la base Programme
//  showmessage('Init0');
  CreateTablesProg(Path);
  // Initialisation BD Programme
//  showmessage('Init1');
   DMBD.dbNameProg.close;
//  showmessage('Init2');
   DMBD.dbNameProg.Session.DropConnections;
//  showmessage('Init3');
  try
       if not DMBD.dbNameProg.Session.IsAlias('Program') then
       begin
//  showmessage('Init3.5');
         with DMBD.dbNameProg.Session do
            begin
              ConfigMode := cmVirtual;
//  showmessage('Init3.6');
              try
               try
//  showmessage('Init4');
                AddStandardAlias('Program', path, 'PARADOX');
                SaveConfigFile;
               except
//  showmessage('Except4');
               end;
              finally
                ConfigMode := cmVirtual;
    //            abort;
              end;
            end;
       end;
  except

//    showmessage('Except IF');
  end;
//  showmessage('Init5');
   DMBD.dbNameProg.Params[0]:= 'PATH=' + Path;
//  showmessage('Init6');
   DMBD.dbNameProg.TransIsolation:=tiDirtyRead;
//  showmessage('Init7');
   DMBD.dbNameProg.Session.AddPassword('lepelet');
//  showmessage('Init8');
   DMBD.dbNameProg.open;
except
   DMBD.dbNameProg.Params[0]:= 'PATH=' + Path;
   DMBD.dbNameProg.TransIsolation:=tiDirtyRead;
   DMBD.dbNameProg.Session.AddPassword('lepelet');
   DMBD.dbNameProg.open;
  if DMProg = nil then
    DMProg:=TDMProg.Create(Application.MainForm);

Application.MessageBox(Pchar('Erreur à la création de la base programme'),'Attention',MB_ICONERROR);
// MessageDlg('Erreur à la création de la base programme',mtError,[mbOK],0);
 result:=False;
end;
End;

Function TDMBD.InitBDDossier(Path:string):boolean;
Begin
  try
  if CreeNouveauDossier(E.RepertoireDossier,false,true) then
   begin
     CreeNouveauExo(E.RepertoireExercice,false,true);
   end;
//  // On verifie systematiquement si le dossier demo existe pour la version en cours
//  case E.TypeDossier of
//    VerDemoAgri,VerDemoGeneral,VerAgricole,VerGeneral:begin
//                 if not DirectoryExists(ExtractFilePath(Application.ExeName)+ 'Demo\') then
//                  Begin
//                   //ForceDirectories(ExtractFilePath(Application.ExeName)+ 'DosParoisse\ExoParoisse\');
//                   if CreeNouveauDossier(ExtractFilePath(Application.ExeName)+ 'Demo',false,true) then
//                    begin
//                      CreeNouveauExo(ExtractFilePath(Application.ExeName)+ 'Demo\ExoDemo',false,true);
//                    end
//                    else
//                    Begin
//
//                    End;
//                  End
//                  else
//                  begin
//                     if CreeNouveauDossier(E.RepertoireDossier,false,true) then
//                      begin
//                        CreeNouveauExo(E.RepertoireExercice,false,true);
//                      end;
//                  end;
//                end;
//    VerDemoDioc,VerDiocese,VerDiocAdmin:
//                begin
//                 if not DirectoryExists(ExtractFilePath(Application.ExeName)+ 'DosParoisse\') then
//                  Begin
//                   //ForceDirectories(ExtractFilePath(Application.ExeName)+ 'DosParoisse\ExoParoisse\');
//                   if CreeNouveauDossier(ExtractFilePath(Application.ExeName)+ 'DosParoisse',false,True) then
//                    begin
//                      CreeNouveauExo(ExtractFilePath(Application.ExeName)+ 'DosParoisse\ExoParoisse',false,True);
//                    end
//                  End
//                  else
//                  begin
//                     if CreeNouveauDossier(E.RepertoireDossier,false,true) then
//                      begin
//                        CreeNouveauExo(E.RepertoireExercice,false,true);
//                      end;
//                  end;
//                end;
//  end;
  result:=true;
  // Initialisation BD Dossier
   DMBD.dbNameDossier.Close;
   DMBD.dbNameDossier.Session.DropConnections;
   if not DMBD.dbNameDossier.Session.IsAlias('Dossier') then
   begin
     with DMBD.dbNameDossier.Session do
        begin
          ConfigMode := cmVirtual;	//cmSession;
          try
           try
            AddStandardAlias('Dossier', path, 'PARADOX');
            SaveConfigFile;
           except
           end;
          finally
            ConfigMode := cmVirtual;
          end;
        end;
   end;

   DMBD.dbNameDossier.Close;
   DMBD.dbNameDossier.Session.DropConnections;

   DMBD.dbNameDossier.Params[0]:= 'PATH=' + Path;
   DMBD.dbNameDossier.TransIsolation:=tiDirtyRead;
   DMBD.dbNameDossier.Session.AddPassword('lepelet');
   DMBD.dbNameDossier.Open;
   DMRech.OuvreTableRechDossier;

//   Verif_Init_Table_De_Base_Dossier_Non_Vide(path);
except
   DMBD.dbNameDossier.Close;
   DMBD.dbNameDossier.Session.DropConnections;

   DMBD.dbNameDossier.Params[0]:= 'PATH=' + Path;
   DMBD.dbNameDossier.TransIsolation:=tiDirtyRead;
   DMBD.dbNameDossier.Session.AddPassword('lepelet');
   DMBD.dbNameDossier.Open;
   DMRech.OuvreTableRechDossier;
//   Verif_Init_Table_De_Base_Dossier_Non_Vide(path);
Application.MessageBox(Pchar('Erreur à la création de la base dossier'),'Attention',MB_ICONERROR);
//   MessageDlg('Erreur à la création de la base dossier',mtError,[mbOK],0);
   result:=False;
end;

End;

Function TDMBD.InitBDExercice(Path:string):boolean;
Begin
try
//
 if CreeNouveauDossier(E.RepertoireDossier,false,true) then
  begin
    CreeNouveauExo(E.RepertoireExercice,false,true);
  end;
//  // On verifie systematiquement si le dossier demo existe pour la version en cours
//  case E.TypeDossier of
//    VerDemoAgri,VerDemoGeneral,VerAgricole,VerGeneral:begin
//                 if not DirectoryExists(ExtractFilePath(Application.ExeName)+ 'Demo\') then
//                  Begin
//                   if CreeNouveauDossier(ExtractFilePath(Application.ExeName)+ 'Demo',false,true) then
//                    begin
//                      CreeNouveauExo(ExtractFilePath(Application.ExeName)+ 'Demo\ExoDemo',false,true);
//                    end
//                    else
//                    Begin
//                     if CreeNouveauDossier(E.RepertoireDossier,false,true) then
//                      begin
//                        CreeNouveauExo(E.RepertoireExercice,false,true);
//                      end;
//
//                    End;
//                  End;
//                end;
//    VerDemoDioc,VerDiocese,VerDiocAdmin:begin
//                 if not DirectoryExists(ExtractFilePath(Application.ExeName)+ 'DosParoisse\') then
//                  Begin
//                   if CreeNouveauDossier(ExtractFilePath(Application.ExeName)+ 'DosParoisse',false,true) then
//                    begin
//                      CreeNouveauExo(ExtractFilePath(Application.ExeName)+ 'DosParoisse\ExoParoisse',false,true);
//                    end
//                    else
//                    Begin
//                     if CreeNouveauDossier(E.RepertoireDossier,false,true) then
//                      begin
//                        CreeNouveauExo(E.RepertoireExercice,false,true);
//                      end;
//                    End;
//                  End;
//                end;
//  end;
  result:=true;
  // Initialisation BD Exercice
   DMBD.dbNameExo.Close;
   DMBD.dbNameExo.Session.DropConnections;
   if not DMBD.dbNameExo.Session.IsAlias('Exercice') then
   begin
     with DMBD.dbNameExo.Session do
        begin
          ConfigMode := cmVirtual;
          try
           try
            AddStandardAlias('Exercice', path, 'PARADOX');
            SaveConfigFile;
           except

           end;
          finally
            ConfigMode := cmVirtual;
          end;
        end;
   end;
   DMBD.dbNameExo.Close;
   DMBD.dbNameExo.Session.DropConnections;

   DMBD.dbNameExo.Params[0]:= 'PATH=' + Path;
   DMBD.dbNameExo.TransIsolation:=tiDirtyRead;
   DMBD.dbNameExo.Session.AddPassword('lepelet');
   DMBD.dbNameExo.Open;
   DMRech.OuvreTableRechExercice;
except
   DMBD.dbNameExo.Close;
   DMBD.dbNameExo.Session.DropConnections;

   DMBD.dbNameExo.Params[0]:= 'PATH=' + Path;
   DMBD.dbNameExo.TransIsolation:=tiDirtyRead;
   DMBD.dbNameExo.Session.AddPassword('lepelet');
   DMBD.dbNameExo.Open;
Application.MessageBox(Pchar('Erreur à la création de la base Exercice'),'Attention',MB_ICONERROR);
//   MessageDlg('Erreur à la création de la base Exercice',mtError,[mbOK],0);
   result:=False;
end;

End;

Function TDMBD.OpenAllTAble:boolean;
var
i,j:integer;
Begin
result:=true;
  try
    for i:=0 to screen.DataModuleCount-1
        do
          begin
             try
//               CreerFichierTexte(E.RepertoireProgram+'0000000001\'+IntToStr(i)+'_'+screen.DataModules[i].Name+'.txt','');
//               showmessage(screen.DataModules[i].Name);
               OuvrirTouteTable('',TControl(screen.DataModules[i]));
             except
               result:=false;
               showmessage('PB Ouverture TAble');
             end;
          end;
  except
    result:=false;
  end;
End;

Function TDMBD.CloseAllTAble:boolean;
var
i,j:integer;
Begin
//screen.DefaultKbLayout
result:=true;
  try
    for i:=0 to screen.DataModuleCount-1
        do
          begin
             try
//               CreerFichierTexte(E.RepertoireProgram+'0000000001\'+IntToStr(i)+'_'+screen.DataModules[i].Name+'_Fermer.txt','');
               FermerTouteTable('',TControl(screen.DataModules[i]));
             except
               result:=false;
             end;
          end;
  except
    result:=false;
  end;
End;

Function TDMBD.CloseAllTAbleExo(MessErreur:String):boolean;
var
i,j:integer;
Begin
//screen.DefaultKbLayout
result:=true;
try
  try
    for i:=0 to screen.DataModuleCount-1
        do
          begin
             try
               for j:=0 to screen.DataModules[i].ComponentCount-1 do
                begin
                  if screen.DataModules[i].Components[j].ClassNameis('TTable') then
                   begin
                     case (screen.DataModules[i].Components[j] as TTable).State of
                        dsEdit:Begin
                                 Application.MessageBox(Pchar(MessErreur+
                                                              #13#10+
                                                              'La table : ' +
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Components[j].Name)+
                                                              #13#10#13#10+
                                                              'Dans le module : '+
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Name)
                                                              + #13#10#13#10+
                                                              'est en modification.'),'Attention',MB_ICONWARNING +MB_OK);
                               End;

                        dsInsert:Begin
                                 Application.MessageBox(Pchar(MessErreur+
                                                              #13#10+
                                                              'La table : ' +
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Components[j].Name)+
                                                              #13#10#13#10+
                                                              'Dans le module : '+
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Name) +
                                                              #13#10#13#10+
                                                              'est en insertion.'),'Attention',MB_ICONWARNING +MB_OK);
                                 End;

                        dsBrowse:begin
                                  if (screen.DataModules[i].Components[j] as TTable).DatabaseName = 'Exercice' then
                                  (screen.DataModules[i].Components[j] as TTable).close ;
                                  if (screen.DataModules[i].Components[j] as TTable).DatabaseName = 'ExoN1' then
                                  (screen.DataModules[i].Components[j] as TTable).close ;
                                 end;
                     end;
                   end;

                  if screen.DataModules[i].Components[j].ClassNameis('TQuery') then
                   begin
                     case (screen.DataModules[i].Components[j] as TQuery).State of
                        dsEdit:Begin
                                 Application.MessageBox(Pchar(MessErreur+
                                                              #13#10+
                                                              'La table : ' +
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Components[j].Name)+
                                                              #13#10#13#10+
                                                              'Dans le module : '+
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Name)
                                                              + #13#10#13#10+
                                                              'est en modification.'),'Attention',MB_ICONWARNING +MB_OK);
                               End;

                        dsInsert:Begin
                                 Application.MessageBox(Pchar(MessErreur+
                                                              #13#10+
                                                              'La table : ' +
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Components[j].Name)+
                                                              #13#10#13#10+
                                                              'Dans le module : '+
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Name) +
                                                              #13#10#13#10+
                                                              'est en insertion.'),'Attention',MB_ICONWARNING +MB_OK);
                                 End;

                        dsBrowse:begin
                                  if (screen.DataModules[i].Components[j] as TQuery).DatabaseName = 'Exercice' then
                                  (screen.DataModules[i].Components[j] as TQuery).close ;
                                  if (screen.DataModules[i].Components[j] as TQuery).DatabaseName = 'ExoN1' then
                                  (screen.DataModules[i].Components[j] as TQuery).close ;
                                 end;
                     end;
                   end;

                  end;
              except
                 begin
                 Application.MessageBox(Pchar(MessErreur+
                                              #13#10+
                                              'Erreur à la fermeture de la table : '+
                                              #13#10#13#10+
                                              UpperCase(screen.DataModules[i].Components[j].Name) +
                                              #13#10#13#10+
                                              'Dans le module : '+
                                              #13#10#13#10+
                                              UpperCase(screen.DataModules[i].Components[j].Name)),'Attention',MB_ICONWARNING +MB_OK);
                 end;
             end;
          end;
  except
    result:=false;
  end;
Finally
 dbNameExo.Close;
 DbNameExoN1.Close;
end;
End;

Function TDMBD.CloseAllTAbleDossier(MessErreur:String):boolean;
var
i,j:integer;
Begin
//screen.DefaultKbLayout
result:=true;
try
  try
    for i:=0 to screen.DataModuleCount-1
        do
          begin
             try
               for j:=0 to screen.DataModules[i].ComponentCount-1 do
                begin
                  if screen.DataModules[i].Components[j].ClassNameis('TTable') then
                   begin
                     case (screen.DataModules[i].Components[j] as TTable).State of
                        dsEdit:Begin
                                 Application.MessageBox(Pchar(MessErreur+
                                                              #13#10+
                                                              'La table : ' +
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Components[j].Name)+
                                                              #13#10#13#10+
                                                              'Dans le module : '+
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Name)
                                                              + #13#10#13#10+
                                                              'est en modification.'),'Attention',MB_ICONWARNING +MB_OK);
                               End;

                        dsInsert:Begin
                                 Application.MessageBox(Pchar(MessErreur+
                                                              #13#10+
                                                              'La table : ' +
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Components[j].Name)+
                                                              #13#10#13#10+
                                                              'Dans le module : '+
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Name) +
                                                              #13#10#13#10+
                                                              'est en insertion.'),'Attention',MB_ICONWARNING +MB_OK);
                                 End;

                        dsBrowse:begin
                                  if (screen.DataModules[i].Components[j] as TTable).DatabaseName = 'Dossier' then
                                  (screen.DataModules[i].Components[j] as TTable).close ;
                                 end;
                     end;
                   end;

                  if screen.DataModules[i].Components[j].ClassNameis('TQuery') then
                   begin
                     case (screen.DataModules[i].Components[j] as TQuery).State of
                        dsEdit:Begin
                                 Application.MessageBox(Pchar(MessErreur+
                                                              #13#10+
                                                              'La table : ' +
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Components[j].Name)+
                                                              #13#10#13#10+
                                                              'Dans le module : '+
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Name)
                                                              + #13#10#13#10+
                                                              'est en modification.'),'Attention',MB_ICONWARNING +MB_OK);
                               End;

                        dsInsert:Begin
                                 Application.MessageBox(Pchar(MessErreur+
                                                              #13#10+
                                                              'La table : ' +
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Components[j].Name)+
                                                              #13#10#13#10+
                                                              'Dans le module : '+
                                                              #13#10#13#10+
                                                              UpperCase(screen.DataModules[i].Name) +
                                                              #13#10#13#10+
                                                              'est en insertion.'),'Attention',MB_ICONWARNING +MB_OK);
                                 End;

                        dsBrowse:begin
                                  if (screen.DataModules[i].Components[j] as TQuery).DatabaseName = 'Dossier' then
                                  (screen.DataModules[i].Components[j] as TQuery).close ;
                                 end;
                     end;
                   end;

                  end;
              except
                 begin
                 Application.MessageBox(Pchar(MessErreur+
                                              #13#10+
                                              'Erreur à la fermeture de la table : '+
                                              #13#10#13#10+
                                              UpperCase(screen.DataModules[i].Components[j].Name) +
                                              #13#10#13#10+
                                              'Dans le module : '+
                                              #13#10#13#10+
                                              UpperCase(screen.DataModules[i].Components[j].Name)),'Attention',MB_ICONWARNING +MB_OK);
                 end;
             end;
          end;
  except
    result:=false;
  end;
Finally
 dbNameDossier.Close;
end;
End;



Function TDMBD.InitBDExo_N1(Path:string;MessageAffiche:boolean):boolean;
Begin
  try
    result:=true;
    // Initialisation BD Exercice
   DMBD.DbNameExoN1.Close;
   DMBD.DbNameExoN1.Session.DropConnections;
   if not DMBD.DbNameExoN1.Session.IsAlias('ExoN1') then
   begin
     with DMBD.DbNameExoN1.Session do
        begin
          ConfigMode := cmVirtual;
          try
           try
            AddStandardAlias('ExoN1', path, 'PARADOX');
            SaveConfigFile;
           except

           end;
          finally
            ConfigMode := cmVirtual;
          end;
        end;
   end;
   DMBD.DbNameExoN1.Close;
   DMBD.DbNameExoN1.Session.DropConnections;
   DMBD.DbNameExoN1.Params.Clear;
   DMBD.DbNameExoN1.Params.Add('PATH=' + Path);
   DMBD.DbNameExoN1.Params.Add('ENABLE BCD=FALSE');
   DMBD.DbNameExoN1.Params.Add('DEFAULT DRIVER=PARADOX');

   DMBD.DbNameExoN1.TransIsolation:=tiDirtyRead;
   DMBD.DbNameExoN1.Connected:=true;
   DMBD.DbNameExoN1.Open;
   DMRech.OuvreTableRechExercice;
  except
   if MessageAffiche then Application.MessageBox(Pchar('Erreur à la création de la base Exercice N+1'),'Attention',MB_ICONERROR);
   result:=False;
  end;
end;

function TDMBD.Raccordement_Vers_N1(IdDos,IdExo:Integer):boolean;
var
InfosGestDossier:TInfosGestDossier;
Begin
result:=false;
//E.
  try
   FiltrageDataSet(DMrech.TaGestDossierRech,'ID_Dossier='+IntTostr(IdDos));
   InfosGestDossier:=Infos_TInfosGestDossier(DMrech.TaGestDossierRech,'ID_DOSSIER;ID_TABLE;Cloture',[IdDos,(IDExo),false]);
   if InfosGestDossier.ResultInfos then
    begin
//  //filtrer taGestDossier par rapport à l'id dossier en cours
//  if not TaGestDosRecherche.active then
//    TaGestDosRecherche.open;
//  IDExo:=copy(IdDosExo,length(IDDos)+1,length(IdDosExo)-length(IDDos));
//  TaGestDosRecherche.Filtered:=false;
//  //** à Remettre ***  TaGestDosRecherche.filter:='ID_Dossier= '''+main.IDDos+'''and ID_Table<> '''+IDExo+'''';
//  TaGestDosRecherche.filter:='ID_Dossier=1 and ID_Table<>2';
//  TaGestDosRecherche.filtered:=true;
//
//  if TaGestDosRecherche.RecordCount<>0 then
//    Begin
      result:=InitBDExo_N1(InfosGestDossier.Dir_Exo);
    End
    else
    begin
     showmessage('Erreur à l''initialisation de la Base N+1 !');
    end;
  except
   //
   abort;
  end;
End;

Function TDMBD.InitAllDB(PathProgram,PathDossier,PathExo:string):boolean;
Begin
if not InitBDProgram(PathProgram) then
   application.Terminate;
InitBDDossier(PathDossier);
Verif_Init_Table_De_Base_Dossier_Non_Vide(PathDossier);
InitBDExercice(PathExo);
Verif_Init_Table_De_Base_Exercice_Non_Vide(PathExo);
BrancheTableVersN1(nil);
End;

procedure TDMBD.DMBDDestroy(Sender: TObject);
begin
if dbNameExo.InTransaction then dbNameExo.Commit;
if dbNameDossier.InTransaction then dbNameDossier.Commit;
if dbNameProg.InTransaction then dbNameProg.Commit;
DMBD:=nil;
end;

function TDMBD.CloturerExercice_N(TableDossier:TTable;Dossier,Exo:integer):boolean;
Begin
try
  if TableDossier<>nil then
    Begin
      if not TableDossier.Active then
        TableDossier.Open;
      TableDossier.Filter:='ID_Dossier = '''+inttostr(Dossier)+'''';
      TableDossier.Filtered:=true;
      if TableDossier.locate('ID_Table',Exo,[])then
        begin
          TableDossier.Edit;
          TableDossier.FindField('Cloture').AsBoolean:=true;
          TableGerePost(TableDossier);
          result:=true;
        end;
    End;
except
 result:=false;
 abort;
end;
End;

Procedure TDMBD.Verif_Init_Table_De_Base_Dossier_Non_Vide(Path:String);
var
InfosParam_Dossier:TInfosParam_Dossier;
Begin
if DMParamEntreprise = nil then DMParamEntreprise:=TDMParamEntreprise.Create(application);
try
case E.TypeDossier of

  VerAgricole:begin
              DeFiltrageDataSet(DMRech.TaParam_DossierRech);
              Remplit_TInfosParam_Dossier(DMRech.TaParam_DossierRech,InfosParam_Dossier);
              // Initialisation de E:TEntreprise;
              // A faire
              if InfosParam_Dossier.REGIME_Agr = 'A' then
               begin
               case E.TypeClient of
                  CL_Cogere:Begin  //,CL_Saisie_Cogere
                             CreateTablePlanAgriCOGERE(Path);
                             CreateTableConstAnalCOGERE(Path);
                             CreateTableActiviteAnalCOGERE(path);
                             CreateTableATelierAnalCOGERE(Path);
                            End;
                  //CL_Normal,CL_Isa,CL_Demo,Cl_Saisie
                 else Begin
                      if(e.TypeClient=Cl_Association)then
                        CreateTablePlanAsso(Path)
                      else
                        CreateTablePlanAgri(Path);
                      End;

               end;

                 CreateTableModelAgri(Path);
                 if not( e.TypeClient=Cl_Association)then CreateTableCodeTvaAgri(Path);
               end;
              end;
  VerDiocese:begin
               CreateTablePlanDioc(Path);
               CreateTableTrameDioc(Path);
               CreateTableTrameLDioc(Path);
               CreateTableModel(Path);
              end;
  VerDemoAgri:Begin
              if E.Regime = 'A' then
               begin
               case E.TypeClient of
                  CL_Cogere:Begin //,CL_Saisie_Cogere
                             CreateTablePlanAgriCOGERE(Path);
                             CreateTableConstAnalCOGERE(Path);
                             CreateTableActiviteAnalCOGERE(path);
                             CreateTableATelierAnalCOGERE(Path);
                            End;

                  //CL_Normal,CL_Isa,CL_Demo:
                  else Begin
                      if(e.TypeClient=Cl_Association)then
                        CreateTablePlanAsso(Path)
                      else
                          CreateTablePlanAgri(Path);
                       End;

               end;
                 CreateTableModelAgri(Path);
                 if not( e.TypeClient=Cl_Association)then CreateTableCodeTvaAgri(Path);
               end;
               end;
  VerDemoDioc:begin
               CreateTablePlanDioc(Path);
               CreateTableTrameDioc(Path);
               CreateTableTrameLDioc(Path);
               CreateTableModel(Path);
              end;

  VerGeneral,VerDemoGeneral:Begin
              if E.Regime = 'I' then
               begin
                   case E.TypeClient of
                      CL_Cogere:Begin  //,CL_Saisie_Cogere
                                 CreateTableConstAnalCOGERE(Path);
                                 CreateTableActiviteAnalCOGERE(path);
                                 CreateTableATelierAnalCOGERE(Path);
                                End;
                   end;
               if(e.TypeClient=Cl_Association)then
                  CreateTablePlanAsso(Path)
               else
                  CreateTablePlanIndus(Path);
               CreateTableModelAgri(Path);
               if not( e.TypeClient=Cl_Association)then CreateTableCodeTvaAgri(Path);
               end;
              End;

end;
except
abort;
end;
End;

Function TDMBD.OpenTableExercice:boolean;
var
i,j:integer;
Begin
result:=true;
  try
    for i:=0 to screen.DataModuleCount-1
        do
          begin
             try
               OuvrirTouteTable('',TControl(screen.DataModules[i]));
             except
               result:=false;
               showmessage('OpenTableExercice:PB Ouverture Table exercice');
             end;
          end;
  except
    result:=false;
  end;
End;

Function TDMBD.OpenTableDossier:boolean;
var
i,j:integer;
Begin
result:=true;
  try
    for i:=0 to screen.DataModuleCount-1
        do
          begin
             try
               OuvrirTouteTable('',TControl(screen.DataModules[i]));
             except
               result:=false;
               showmessage('OpenTableDossier:PB Ouverture Table Dossier');
             end;
          end;
  except
    result:=false;
  end;
End;

procedure TDMBD.DataModuleCreate(Sender: TObject);
var
 InfosGestDossier:TInfosGestDossier;
 Registre :TRegistry;
 IntegreHandle:Integer;
// ParamEnLigne:TParamEnLigne;
begin

Type_version_execution:=CT_DEVELOPPEMENT;
Type_version_execution:=CT_DISTRIBUTION;

VerifAFaire(Type_version_execution);
//VerDiocAdmin,VerDemo,VerDemoDioc
//  showmessage('0');
//TypeVersion:=VerAgricole;

// initialisation de la base programme
if not DMBD.InitBDProgram(ExtractFilePath(Application.ExeName)) then
   application.Terminate;

// Création des dossiers Importation et Exportation

 ForceDirectories(ExtractFilePath(Application.ExeName)+ 'Importation');
 ForceDirectories(ExtractFilePath(Application.ExeName)+ 'Exportation');
 ForceDirectories(ExtractFilePath(Application.ExeName)+ 'Sauvegarde');
 ForceDirectories(ExtractFilePath(Application.ExeName)+ 'ComptaWeb');
 ForceDirectories(ExtractFilePath(Application.ExeName)+ 'Fiscal');
 ForceDirectories(C_RepDossierDefaut);
//   IntegreHandle:=FindWindow('TMainILGR','LGRProtect');
//   if IntegreHandle = 0 then
//   Winexec(PChar(GetWindowsDir+'\Integre.exe'),SW_HIDE);

//  showmessage('1');

E:= TEntreprise.Create(Application);
E.VerifTEntreprise();
GestMessageLGR:=TGestMessageLGR.Create(Application);
GestMessageLGR.RepertoireMessage := E.RepertoireExportation;

//  showmessage('2');
ParamUtil := TParamUtil.Create(Application);
//  showmessage('3');
//E.RepertoireProgram:=ExtractFilePath(Application.ExeName);
//  showmessage('4');
Registre:= TRegistry.Create;
//  showmessage('5');
//ParamEnLigneLec(1);
//  showmessage('6');
// DMXml.GenereConfigUtil(e.RepertoireComptaWeb);


 //DMXml.IndexNomUtil('inconnu');
// showmessage(DMXml.Valeuritem('phil','name'));
// DMXml.ModifieItem('phil','nomecran','edition000');
// showmessage(DMXml.Valeuritem('phil','nomecran'));

 //DMXml.XMLDocument1.DocumentElement.ChildNodes['LastUser'].Text;
// E.User:=DMXml.XMLDocument1.DocumentElement.ChildNodes[0].ChildNodes['LastUser'].Text;
// E.User:='LastUser';

//////////// section init par base de registre // PB le 14/09/03
// with Registre do
//  begin
//   RootKey := HKEY_LOCAL_MACHINE;
//   OpenKey('\SOFTWARE\LGR\Epicea2\Defaut\', false);
//   try
//    E.RepertoireExercice:=ReadString('DirExo');
//    E.RepertoireDossier:=ReadString('DirDos');
//
//    E.NomExo:=ReadString('NomExo');
//    E.NomDossier:=ReadString('NomDos');
//   except
//    E.RepertoireExercice:='';
//    E.RepertoireDossier:='';
//
//    E.NomExo:='';
//    E.NomDossier:='';
//   end;
//
//  end;
//////////// fin section init par base de registre // PB le 14/09/03

//DMXml.ModifieVarEcran(E.User,self.Name,'DirDos',E.RepertoireDossier);
//DMXml.ModifieVarEcran(E.User,self.Name,'DirExo',E.RepertoireExercice);
//DMXml.ModifieVarEcran(E.User,self.Name,'DirImp',E.RepertoireImportEPI_DOS);
//DMXml.ModifieVarEcran(E.User,self.Name,'IDDOS',IntToStr(E.ID_Dos));
//DMXml.ModifieVarEcran(E.User,self.Name,'IDExo',IntToStr(E.ID_Exo));
//DMXml.ModifieVarEcran(E.User,self.Name,'NomDos',E.NomDossier);
//DMXml.ModifieVarEcran(E.User,self.Name,'NomExo',E.NomExo);
//DMXml.ModifieVarEcran(E.User,self.Name,'TypeDossier',IntToStr(E.TypeVersionToInt(E.TypeDossier)));
//DMXml.ModifieVarEcran(E.User,self.Name,'TypeDossierDemo',IntToStr(E.TypeVersionToInt(E.TypeDossierdemo)));}
  try
  // Peut-être inutile // PB le 15/09/03
////   E.User:=DMXml.UserDef;
//   E.User:=DMXml.RetourneValItemProgramme('LastUser');
//   E.RepertoireExercice:=DMXml.RetourneValItemProgramme('DirExo');
//   E.RepertoireDossier:=DMXml.RetourneValItemProgramme('DirDos');
//   E.NomExo:=DMXml.RetourneValItemProgramme('NomExo');
//   E.NomDossier:=DMXml.RetourneValItemProgramme('NomDos');
   E.User:=DMXml.RetourneValItemProgramme('LastUser');
   E.NomDossier:=DMXml.RetourneValItemVarEcran(E.User,'Main','NomDos');
   E.RepertoireDossier:=DMXml.RetourneValVarDos(E.NomDossier,CXML_DirDos);
   E.NomExo:=DMXml.RetourneValVarDos(E.NomDossier,'NomExo');
   E.RepertoireExercice:=DMXml.RetourneValItemVarExo(E.NomDossier,E.NomExo,'DirExo');
   E.DateVersion:=DMXml.RetourneValVarDos(E.NomDossier,CXML_DateVersion);
   E.Exo_A_Verifier:=DMXml.RetourneValVarDos(E.NomDossier,CXML_Exo_A_Verifier);
   
   E.RepertoireDossier:=DMXml.RetourneValItemVarEcran(E.User,'Main','DirDos');
  except
      E.RepertoireExercice:='';
      E.RepertoireDossier:='';

      E.NomExo:='';
      E.NomDossier:='';
  end;
  try
    ParamUtil.MaxDosMenu:=StrToInt(DMXml.RetourneValItemProgramme('MaxDosMenu'));
    E.Possibilite_Affectation:=Str_StrToBool(DMXml.RetourneValItemProgramme('Possibilite_Affectation'),'Oui','Non');
    E.RemiseAuto:=Str_StrToBool(DMXml.RetourneValItemProgramme('RemiseAuto'),'Oui','Non');
    E.SautDePageAutomatique:=Str_StrToBool(DMXml.RetourneValItemProgramme('SautDePageAutomatique'),'Oui','Non');
    ParamUtil.AffichIDPiece :=Str_StrToBool(DMXml.RetourneValItemProgramme('AfficheIDPiece'),'Oui','Non');
  except
    ParamUtil.MaxDosMenu:=CT_MaxDosMenu;
    ParamUtil.AffichIDPiece :=false;
  end;

//GestionSauvegardeAffiche(ParamUtil.GestionSauvegarde,CT_DOSSIER_COURANT);
//  showmessage('7');
if DMConst = nil then DMConst := TDMConst.Create(Self);
//  showmessage('8');
if DMRech=nil then DMRech:=TDMRech.create(self);
//  showmessage('9');




DeFiltrageDataSet(DMRech.TaGestDossierRech);

// Si pas première utilisation, affichage direct de DosProtect pour le choix du dossier à activer
// with Registre do
 begin
//   RootKey := HKEY_LOCAL_MACHINE;
//   OpenKey('\SOFTWARE\LGR\Epicea2\Defaut\', false);
   try
////    E.User:=ReadString('LastUser');
//    if empty(E.User) then E.User:='Anonyme';
//
//    E.ID_Exo:=ReadInteger('IDExo');
//    E.ID_Dos:=ReadInteger('IDDOS');
//
//    E.RepertoireExercice:=ReadString('DirExo');
//    E.RepertoireDossier:=ReadString('DirDos');
//    E.RepertoireImportEPI_DOS := ReadString('DirImp');
//    if empty(E.RepertoireImportEPI_DOS) then
//         E.RepertoireImportEPI_DOS := E.RepertoireProgram + 'Importation\';
//
//    E.NomExo:=ReadString('NomExo');
//    E.NomDossier:=ReadString('NomDos');
//
//    E.TypeDossier:=E.IntToTypeVersion(ReadInteger('TypeDossier'));
//    E.TypeDossierDemo:=E.IntToTypeVersion(ReadInteger('TypeDossierDemo'));
//
//    ParamUtil.OldScreenHeight:=ReadInteger('OldScH');
//    ParamUtil.OldScreenWidth:=ReadInteger('OldScW');

    // Impose une version
//    E.TypeDossier:=VerAgricole;
   E.User:=DMXml.RetourneValItemProgramme('LastUser');
   E.NomDossier:=DMXml.RetourneValItemVarEcran(E.User,'Main','NomDos');
   E.RepertoireDossier:=DMXml.RetourneValVarDos(E.NomDossier,CXML_DirDos);
   E.NomExo:=DMXml.RetourneValVarDos(E.NomDossier,'NomExo');
   E.RepertoireExercice:=DMXml.RetourneValItemVarExo(E.NomDossier,E.NomExo,'DirExo');
   E.DateVersion:=DMXml.RetourneValVarDos(E.NomDossier,CXML_DateVersion);
   E.Exo_A_Verifier:=DMXml.RetourneValVarDos(E.NomDossier,CXML_Exo_A_Verifier);

   E.ID_Dos:=StrToInt(DMXml.RetourneValVarDos(E.NomDossier,'IDDos'));

   E.ID_Exo:=StrToInt(DMXml.RetourneValItemVarExo(E.NomDossier,E.NomExo,'IDExo'));

    // Importation EPIDOS
    E.RepertoireImportationEpiDos := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepImportationEpiDos);
    if empty(E.RepertoireImportationEpiDos) then
          E.RepertoireImportationEpiDos := C_RepImportationEpiDos;

    // Importation SIEA
    E.RepertoireImportationSIEA := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepImportationSIEA);
    if empty(E.RepertoireImportationSIEA) then
          E.RepertoireImportationSIEA := E.RepertoireProgram + C_RepImportationSIEA;

    // Importation En Général
    E.RepertoireImportation := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepImportation);
    if empty(E.RepertoireImportation) then
          E.RepertoireImportation := E.RepertoireDossier + C_RepImportation;

   E.RepertoireImportEPI_DOS := DMXml.RetourneValVarDos(E.NomDossier,'DirImp');
   if empty(E.RepertoireImportEPI_DOS) then
       E.RepertoireImportEPI_DOS := E.RepertoireProgram + 'Importation\';

   // Repertoire Exportation Balance
   E.RepertoireExportBalance := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationBalance);
    if empty(E.RepertoireExportBalance) then
          E.RepertoireExportBalance := E.RepertoireProgram + C_RepExportation;

   // Repertoire Exportation RelanceTiers
   E.RepertoireRelanceTiers:=DMXml.RetourneValVarDos(E.NomDossier,CXML_RepRelanceTiers);
    if empty(E.RepertoireRelanceTiers) then
          E.RepertoireRelanceTiers := E.RepertoireDossier + C_RepExportation;

   // fichier de paramètres FTP
   E.ParamFTP.Fichier:=DMXml.RetourneValVarDos(E.NomDossier,CXML_ParamFTP);
//   AjouterFichierTexte('C:\messagesEpicea','E.NomDossier : '+E.NomDossier+' - DMXml.RetourneValVarDos(E.NomDossier,CXML_ParamFTP) : '+E.ParamFTP.Fichier);
    if empty(E.ParamFTP.Fichier) then
          E.ParamFTP.Fichier := E.RepertoireDossier + C_ParamFTP;
//    AjouterFichierTexte('C:\messagesEpicea','(DataModuleCreate)E.RepertoireDossier + C_ParamFTP :'+E.ParamFTP.Fichier);
     E.RepTelechargementReleve:=DMXml.RetourneValVarDos(E.NomDossier,CXML_RepTelechargementReleve);

   // Repertoire Exportation Liasse
   E.RepertoireExportLiasse := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationLiasse);
    if empty(E.RepertoireExportLiasse) then
          E.RepertoireExportLiasse := E.RepertoireProgram + C_RepExportationLiasse;

   // Repertoire Exportation Dossier
   E.RepertoireExportDossier := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationDossier);
    if empty(E.RepertoireExportDossier) then
          E.RepertoireExportDossier := E.RepertoireDossier + C_RepExportation;


   E.RepertoireDblSauvegarde:= DMXml.RetourneValVarDos(E.NomDossier,CXML_RepDblSauvegarde);
      E.RepertoireSauvegardeFermture:= DMXml.RetourneValItemProgramme(CXML_RepSauvegardeFermeture);
   E.RepertoireSauvegardeFermtureCloud:= DMXml.RetourneValItemProgramme(CXML_RepSauvegardeFermetureCloud);
   if(E.RepertoireSauvegardeFermture=C_StrVide)then E.RepertoireSauvegardeFermture:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'SauvegardeFermeture';
//if(E.RepertoireSauvegardeFermtureCloud=C_StrVide)then E.RepertoireSauvegardeFermtureCloud:=IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'SauvegardeFermetureCloud';
   if(DMXml.RetourneValItemProgramme('AutoriserSauvegardeFermeture')<>C_StrVide)then
     E.AutoriserSauvegardeFermeture:=Str_StrToBool(DMXml.RetourneValItemProgramme('AutoriserSauvegardeFermeture'),'Oui','Non');
   if(DMXml.RetourneValItemProgramme('AfficherMessageSauvegardeFermeture')<>C_StrVide)then
     E.AfficherMessageSauvegardeFermeture:=Str_StrToBool(DMXml.RetourneValItemProgramme('AfficherMessageSauvegardeFermeture'),'Oui','Non');

              E.ExtensionFEC := DMXml.RetourneValVarDos(E.NomDossier,CXML_ExtensionFEC);
         E.SeparateurFEC := DMXml.RetourneValVarDos(E.NomDossier,CXML_SeparateurFEC);
         E.DatePieceFEC := StrToBool_Lgr(DMXml.RetourneValVarDos(E.NomDossier,CXML_DatePieceFEC),false);
         
   E.CompteBanqueDefaut := DMXml.RetourneValVarDos(E.NomDossier,CXML_CompteBanqueDefaut);
   E.ComptePointableCaisseEnregistreuse :=DMXml.RetourneValVarDos(E.NomDossier,CXML_ComptePointableCaisseEnregistreuse);
   E.TauxTvaCaisseEnregistreuse :=DMXml.RetourneValVarDos(E.NomDossier,CXML_TauxTvaCaisseEnregistreuse);

   if (empty(E.CompteBanqueDefaut ))and(str_recherchesouschaine(Uppercase(E.RepertoireProgram),'LGR\EPICEA').retour=true)then
        E.CompteBanqueDefaut := Infos_TInfosModel(DMRech.TaModelRech,'journal',['B1']).Compte;


        if empty(E.ExtensionFEC) then  E.ExtensionFEC := C_ExtensionFEC;
        if empty(E.SeparateurFEC) then  E.SeparateurFEC := C_SeparateurFEC;


          if empty(E.TauxTvaCaisseEnregistreuse) then  E.TauxTvaCaisseEnregistreuse := C_TauxTvaCaisseEnregistreuse;
          if empty(E.ComptePointableCaisseEnregistreuse) then E.ComptePointableCaisseEnregistreuse :=C_ComptePointableCaisseEnregistreuse;
   E.NomSauvegarde :=DMXml.RetourneValItemProgramme(CXML_NomSauvegarde);

   E.TypeDossier:=IntToTypeDossier(StrToInt(DMXml.RetourneValVarDos(E.NomDossier,'TypeDossier')));
   E.TypeDossierDemo:=IntToTypeDossier(StrToInt(DMXml.RetourneValVarDos(E.NomDossier,'TypeDossierDemo')));
   ParamUtil.PlanDeSaisie := Str_StrToBool(DMXml.RetourneValVarDos(E.NomDossier,CXML_PlanDeSaisie),'Oui','Non');
//     E.RepertoireExercice:=DMXml.RetourneValItemVarEcran(E.User,'Main','DirExo');
//     E.RepertoireDossier:=DMXml.RetourneValItemVarEcran(E.User,'Main','DirDos');
//     E.NomExo:=DMXml.RetourneValItemVarEcran(E.User,'Main','NomExo');
//     E.NomDossier:=DMXml.RetourneValItemVarEcran(E.User,'Main','NomDos');
//     E.ID_Exo:=StrToInt(DMXml.RetourneValItemVarEcran(E.User,'Main','IDExo'));
//     E.ID_Dos:=StrToInt(DMXml.RetourneValItemVarEcran(E.User,'Main','IDDos'));
//     E.RepertoireImportEPI_DOS := DMXml.RetourneValItemVarEcran(E.User,'Main','DirImp');
//     if empty(E.RepertoireImportEPI_DOS) then
//         E.RepertoireImportEPI_DOS := E.RepertoireProgram + 'Importation\';
//
//     E.TypeDossier:=E.IntToTypeVersion(StrToInt(DMXml.RetourneValItemVarEcran(E.User,'Main','TypeDossier')));
//     E.TypeDossierDemo:=E.IntToTypeVersion(StrToInt(DMXml.RetourneValItemVarEcran(E.User,'Main','TypeDossierDemo')));

     ParamUtil.OldScreenHeight:=StrToInt(DMXml.RetourneValItemVarEcran(E.User,'Main','OldScH'));
     ParamUtil.OldScreenWidth:=StrToInt(DMXml.RetourneValItemVarEcran(E.User,'Main','OldScW'));
//     // Lecture des paramètres en ligne
//     // si un nom de fichier est placé en paramètre, on récupère les valeurs pour remplir E
//     ParamEnLigne:=ParamEnLigneLec(1);
//     if ParamEnLigne.Retour then
//      begin
//     //  showmessage('ParamEnLigne.FichierEnParametre :'+ParamEnLigne.FichierEnParametre);
//       LitGestDossierFichier(ParamEnLigne.FichierEnParametre,E,True);
//       OuvreExercice(E.NomDossier,E.NomExo);
//      end
//     else
//      begin
//       DosProtectAffiche(E.User);
//      end;
////    Closekey;
//      if ((Type_version_execution<>CT_DEVELOPPEMENT) and (E.ControleDuDossier)and(E.ID_Dos<>0)) then
//       begin
//            if E.DateVersion<>C_Date+'-'+C_Version then
//              Begin
//                try//finally
//                    try //except
//    //                 showmessage('controle');
//    //                 PatienterAffich(true);
//                     if CorrectionTotal(nil,false).retour=false then
//                       abort;
//                    E.DateVersion:=C_Date+'-'+C_Version;
//                    except
//                        //MessageDlg('Le contrôle du dossier ne s''est pas déroulé correctement Erreur N° :'+inttostr(RetourCorrectionDossier.NumErreur) , mtWarning, [mbOK], 0);
//                    end;
//                finally
//    //              PatienterFermer;
//                end;
//              end;
//            else
//            //if ((E.ControleDuDossier)and(e.TypeClient=cl_isa)) then
//            if E.ControleDuDossier then
//              ReindexationTableProc(nil,nil,true,false);
//        end;
   except
   // Si première utilisation, affichage de Param Prog pour le choix du type de dossier demo à activer
    E.User:='Anonyme';
    E.ID_Exo:=0;
    E.ID_Dos:=0;
    E.TypeDossierDemo:=VerDemoAgri;
//    ParamUtil.OldScreenHeight:=ReadInteger('OldScH');
//    ParamUtil.OldScreenWidth:=ReadInteger('OldScW');

    if (ParamProg = nil) then ParamProg:=TParamProg.Create(self);
    if ParamProg.showModal <> mrOk then
     begin
      Application.Terminate;
      abort;
     end;

    if ParamProg.RadioGroup1.Buttons[1].Checked then E.TypeDossierDemo:=VerDemoAgri;
    if ParamProg.RadioGroup1.Buttons[2].Checked then
    begin
        E.TypeDossierDemo:=VerDemoGeneral;
        e.TypeClient:=Cl_Association;
    end;
     if ParamProg.RadioGroup1.Buttons[0].Checked then E.TypeDossierDemo:=VerDemoGeneral;

    E.TypeDossier:=E.TypeDossierDemo;


    case E.TypeDossierDemo of
    VerDemoAgri,VerDemoGeneral:begin

                 E.RepertoireExercice:=E.RepertoireProgram + 'Demo\ExoDemo\';
                 E.RepertoireDossier:=E.RepertoireProgram + 'Demo\';

                 E.NomExo:=DM_C_NomAliasExoDemo;
                 E.NomDossier:=DM_C_NomAliasDemo;
                 case E.TypeDossierDemo of
                   VerAgricole:begin
                                E.Regime:='A';
                               end;
                   VerDemoGeneral:begin
                                E.Regime:='I';
                               end;
                 end;


                end;
    VerDemoDioc:begin
                 E.RepertoireExercice:=E.RepertoireProgram + 'DosParoisse\ExoParoisse\';
                 E.RepertoireDossier:=E.RepertoireProgram+ 'DosParoisse\';

                 E.NomExo:='ExoParoisse';
                 E.NomDossier:='DosParoisse';
                 E.Regime:='D'
                end;
    end;
    // Importation EPIDOS
    if empty(E.RepertoireImportationEpiDos) then
          E.RepertoireImportationEpiDos := E.RepertoireProgram + C_RepImportationEpiDos;

    // Importation SIEA
    if empty(E.RepertoireImportationSIEA) then
          E.RepertoireImportationSIEA := E.RepertoireProgram + C_RepImportationSIEA;

    // Importation En Général
    if empty(E.RepertoireImportation) then
          E.RepertoireImportation := E.RepertoireDossier + C_RepImportation;

   if empty(E.RepertoireImportEPI_DOS) then
       E.RepertoireImportEPI_DOS := E.RepertoireProgram + 'Importation\';

   // Repertoire Exportation Balance
   E.RepertoireExportBalance := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationBalance);
    if empty(E.RepertoireExportBalance) then
          E.RepertoireExportBalance := E.RepertoireProgram + C_RepExportation;

   // fichier de paramètres FTP
   E.ParamFTP.Fichier:=DMXml.RetourneValVarDos(E.NomDossier,CXML_ParamFTP);
//   AjouterFichierTexte('C:\messagesEpicea','DMXml.RetourneValVarDos(E.NomDossier,CXML_ParamFTP) : '+E.ParamFTP.Fichier);
    if empty(E.ParamFTP.Fichier) then
          E.ParamFTP.Fichier := E.RepertoireDossier + C_ParamFTP;
//   AjouterFichierTexte('C:\messagesEpicea','(DataModuleCreate)E.RepertoireDossier + C_ParamFTP : '+E.ParamFTP.Fichier);
        E.RepTelechargementReleve:=DMXml.RetourneValVarDos(E.NomDossier,CXML_RepTelechargementReleve);

   // Repertoire de relance des tiers
   E.RepertoireRelanceTiers:=DMXml.RetourneValVarDos(E.NomDossier,CXML_RepRelanceTiers);
    if empty(E.RepertoireRelanceTiers) then
          E.RepertoireRelanceTiers := E.RepertoireDossier + C_RepExportation;

   // Repertoire Exportation Liasse
   E.RepertoireExportLiasse := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationLiasse);
    if empty(E.RepertoireExportLiasse) then
          E.RepertoireExportLiasse := E.RepertoireProgram + C_RepExportationLiasse;

   // Repertoire Exportation Dossier
   E.RepertoireExportDossier := DMXml.RetourneValVarDos(E.NomDossier,CXML_RepExportationDossier);
    if empty(E.RepertoireExportDossier) then
          E.RepertoireExportDossier := E.RepertoireDossier + C_RepExportation;
          
      E.CompteBanqueDefaut := DMXml.RetourneValVarDos(E.NomDossier,CXML_CompteBanqueDefaut);
   if (empty(E.CompteBanqueDefaut ))and(str_recherchesouschaine(Uppercase(E.RepertoireProgram),'LGR\EPICEA').retour=true)then
        E.CompteBanqueDefaut := Infos_TInfosModel(DMRech.TaModelRech,'journal',['B1']).Compte;

                 E.ExtensionFEC := DMXml.RetourneValVarDos(E.NomDossier,CXML_ExtensionFEC);
         E.SeparateurFEC := DMXml.RetourneValVarDos(E.NomDossier,CXML_SeparateurFEC);
         E.DatePieceFEC := StrToBool_Lgr(DMXml.RetourneValVarDos(E.NomDossier,CXML_DatePieceFEC),false);


                 if empty(E.ExtensionFEC) then  E.ExtensionFEC := C_ExtensionFEC;
        if empty(E.SeparateurFEC) then  E.SeparateurFEC := C_SeparateurFEC;

        
   E.ComptePointableCaisseEnregistreuse :=DMXml.RetourneValVarDos(E.NomDossier,CXML_ComptePointableCaisseEnregistreuse);
   E.TauxTvaCaisseEnregistreuse :=DMXml.RetourneValVarDos(E.NomDossier,CXML_TauxTvaCaisseEnregistreuse);
          if empty(E.TauxTvaCaisseEnregistreuse) then  E.TauxTvaCaisseEnregistreuse := C_TauxTvaCaisseEnregistreuse;
          if empty(E.ComptePointableCaisseEnregistreuse) then E.ComptePointableCaisseEnregistreuse :=C_ComptePointableCaisseEnregistreuse;   
           
        E.NomSauvegarde :=DMXml.RetourneValItemProgramme(CXML_NomSauvegarde);

//    DosProtectAffiche(E.User); enlever par isa le 14/08/2007 car sur 1ère utilisation, il s'affiché 2 fois

//    Closekey;
   end;
 end;
//// On verifie systematiquement si le dossier demo existe pour la version en cours
//case E.TypeDossier of
//  VerDemoAgri,VerDemoGeneral,VerAgricole,VerGeneral:begin
//               if not DirectoryExists(ExtractFilePath(Application.ExeName)+ 'Demo\') then
//                Begin
//                 //ForceDirectories(ExtractFilePath(Application.ExeName)+ 'DosParoisse\ExoParoisse\');
//                 if CreeNouveauDossier(ExtractFilePath(Application.ExeName)+ 'Demo',false) then
//                  begin
//                    CreeNouveauExo(ExtractFilePath(Application.ExeName)+ 'Demo\ExoDemo',false);
//                  end
//                  else
//                  Begin
//                   if CreeNouveauDossier(E.RepertoireDossier,false) then
//                    begin
//                      CreeNouveauExo(E.RepertoireExercice,false);
//                    end;
//
//                  End;
//                End;
//              end;
//  VerDemoDioc,VerDiocese,VerDiocAdmin:begin
//               if not DirectoryExists(ExtractFilePath(Application.ExeName)+ 'DosParoisse\') then
//                Begin
//                 //ForceDirectories(ExtractFilePath(Application.ExeName)+ 'DosParoisse\ExoParoisse\');
//                 if CreeNouveauDossier(ExtractFilePath(Application.ExeName)+ 'DosParoisse',false) then
//                  begin
//                    CreeNouveauExo(ExtractFilePath(Application.ExeName)+ 'DosParoisse\ExoParoisse',false);
//                  end
//                  else
//                  Begin
//                   if CreeNouveauDossier(E.RepertoireDossier,false) then
//                    begin
//                      CreeNouveauExo(E.RepertoireExercice,false);
//                    end;
//                  End;
//                End;
//              end;
//end;

end;


Function TDMBD.BrancheTableVersN1(TableN1:TDataset):boolean;
var
//ChangementExo:TChangtExo;
InfosGestDossier:TInfosGestDossier;
Begin
try
result:=true;
//  if TableN1=nil then
//    Begin
//       showmessage('La table est nil');
//       abort;
//    end;
  //récupérer l'id dos et id exo de N+1
  InfosGestDossier:=ChercheInfos_ExoN1(e.NomDossier);
  if(InfosGestDossier.ResultInfos=false)then abort;
  Raccordement_Vers_N1(InfosGestDossier.ID_Dossier,InfosGestDossier.ID_Table);
//  ChangementExo:=GestDossierInfosExoN1;
  if TableN1<>nil then
    begin
      TableN1.Close;
        if (TableN1 is TTable) then
          begin
            (TableN1 as TTable).DatabaseName:=DMBD.DbNameExoN1.DatabaseName;
            TableN1.Open;
          end;
        if (TableN1 is TQuery) then
          (TableN1 as TQuery).DatabaseName:=DMBD.DbNameExoN1.DatabaseName;
    end;
except
  showmessage('Erreur à l''initialisation de la Base N+1 !');
  result:=false;
  abort;
end;
End;


Function TDMBD.BrancheTableVersN(TableN1:TDataset):boolean;
Begin
try
result:=true;
  if TableN1<>nil then
    begin
     TableN1.close;
      if (TableN1 is TTable) then
        begin
          (TableN1 as TTable).DatabaseName:=DMBD.DbNameExo.DatabaseName;
          TableN1.Open;
        end;
      if (TableN1 is TQuery) then
        (TableN1 as TQuery).DatabaseName:=DMBD.DbNameExo.DatabaseName;
    end;
except
  showmessage('Erreur à l''initialisation de la Base N !');
  result:=false;
  abort;
end;
End;

Procedure TDMBD.Verif_Init_Table_De_Base_Exercice_Non_Vide(Path:String);
var
InfosParam_Dossier:TInfosParam_Dossier;
Begin
if DMParamEntreprise = nil then DMParamEntreprise:=TDMParamEntreprise.Create(application);
try
case E.TypeDossier of

  VerAgricole:begin
              DeFiltrageDataSet(DMRech.TaParam_DossierRech);
              Remplit_TInfosParam_Dossier(DMRech.TaParam_DossierRech,InfosParam_Dossier);
              // Initialisation de E:TEntreprise;
              // A faire
              if InfosParam_Dossier.REGIME_Agr = 'A' then
               begin
               case E.TypeClient of
                  CL_Cogere:Begin  //,CL_Saisie_Cogere
                             CreateTableAtelier_ActiviteAnalCOGERE(Path);
                             CreateTableAtelier_CompteAnalCOGERE(Path);
                            End;

                 // CL_Normal,CL_Isa,CL_Demo:
                 else Begin
                                        End;

               end;
               end;
              end;
  VerDiocese:begin
              end;
  VerDemoAgri:Begin
              if E.Regime = 'A' then
               begin
               case E.TypeClient of
                  CL_Cogere:Begin   //,CL_Saisie_Cogere
                             CreateTableAtelier_ActiviteAnalCOGERE(Path);
                             CreateTableAtelier_CompteAnalCOGERE(Path);
                            End;

//                  CL_Normal,CL_Isa,CL_Demo:
                  else Begin
                                        End;
               end;
               end;
               end;
  VerDemoDioc:begin
              end;

  VerGeneral,VerDemoGeneral:Begin
              if E.Regime = 'I' then
               begin
               end;
              End;
end;
except
abort;
end;
End;

end.
