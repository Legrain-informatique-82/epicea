unit DMJournaux;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,DMEcriture,LibRessourceString,E2_Decl_Records,LibSql,E2_LibInfosTable,E2_Librairie_Obj
  ,Gr_Librairie_Obj,DMRecherche,DMConstantes,LibZoneSaisie,E2_AideCompte,Lib_Chaine,editions,shellapi,
  ChoixPeriode,libdates,E2_AideModel,StdCtrls,ObjetEdition,LibChoixCompte;

type
  TDMJournal = class(TDataModule)
    TaJournal: TTable;
    DaJournal: TDataSource;
    TaJournalID: TIntegerField;
    TaJournalCode: TStringField;
    TaJournalLibelle_Model: TStringField;
    TaJournalLibelle: TStringField;
    TaJournalJournal: TStringField;
    TaJournalCompte: TStringField;
    TaJournalCompte_Reglement: TStringField;
    TaJournalMinimun: TBooleanField;
    TaJournalID_Devise: TIntegerField;
    TaJournalID_Journal: TIntegerField;
    TaJournalQui: TStringField;
    TaJournalQuand: TDateTimeField;
    TaJournalCODE_BANQUE_GESTCO: TStringField;
    TaJournalRech: TTable;
    QuJournaux: TQuery;
    QuListeValRupt: TQuery;
    QuSousTotal: TQuery;
    QuJournalPartEdition: TQuery;
    QuTotalG: TQuery;
    QuCode_Edition: TQuery;
    QuJournaux_Edition: TQuery;
    QuJournalPiece_Edition: TQuery;
    QuTrame_Edition: TQuery;
    procedure DMJournalCreate(Sender: TObject);
    procedure DMJournalDestroy(Sender: TObject);
    procedure TaJournalBeforeEdit(DataSet: TDataSet);
    procedure TaJournalBeforeInsert(DataSet: TDataSet);
    procedure TaJournalBeforeDelete(DataSet: TDataSet);
    Function InfosJournal_Reference(Reference : string):TInfosModel;
    procedure TaJournalAfterInsert(DataSet: TDataSet);
    Function CtrlSaisieDMJournal(CCourant:Tfield):TExceptLGR;
    Function AideDMJournal(CCourant:Tfield):boolean;
    procedure TaJournalBeforePost(DataSet: TDataSet);
    procedure TaJournalAfterOpen(DataSet: TDataSet);
    procedure CompteFilterRecord_TaJournal(DataSet: TDataSet;
    var Accept: Boolean);
    Function GenereCodeJournal(Journal:String):TExceptLGRJournal;
    procedure QuCode_EditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuJournalPiece_EditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure ReadOnlyChamps(DataSet: TDataSet; readOnly : boolean);
    procedure TaJournalAfterPost(DataSet: TDataSet);
    procedure QuTrame_EditionFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    function LibelleDuJournal(journal:string):string;
    function CompteDuJournal(journal:string):string;
    function JournalDuCompte(compte:string):string;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
   ListeFilterRecordJournaux,ListefilterRecordPieces,ListefilterRecordTrame:Tstringlist;
   Procedure ImportJournaux(Valeurs:array of const;DataSet:TDataSet);
  end;

  Function EditionJournaux(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  Function EditionJournalPiece(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  Function EditionSyntheseJournaux(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;

  Function EditionDesJournauxL(TypeEdition : integer; DemandePeriode:Boolean; Journal:TStringList;DataSet:TDataSet;Synthese : boolean = false):Boolean;overload;
  Function EditionDesJournauxL(TypeEdition : integer; DemandePeriode:Boolean; Journal:String;DataSet:TDataSet;Synthese : boolean = false):Boolean;overload;

  Function EditionDesPiecesL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:String;DataSet:TDataSet;DateDeb:Tdate=0;DateFin:TDate=0):Boolean;overload;
  Function EditionDesPiecesL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:TStringList;DataSet:TDataSet;DateDeb:Tdate=0;DateFin:TDate=0):Boolean;overload;

  Function EditionDesEcrituresL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:TStringList;DataSet:TDataSet;DateDeb:Tdate=0;DateFin:TDate=0):Boolean;overload;
  Function EditionDesEcrituresL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:string;DataSet:TDataSet;DateDeb:Tdate=0;DateFin:TDate=0):Boolean;overload;

  Function EditionDesRemisesL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:string;DataSet:TDataSet):Boolean;overload;
  Function EditionDesRemisesL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:TStringList;DataSet:TDataSet):Boolean;overload;

  Function EditionDesTrames(TypeEdition : integer; DemandePeriode:Boolean; Trame:string;DataSet:TDataSet):Boolean;overload;
  Function EditionDesTrames(TypeEdition : integer; DemandePeriode:Boolean; Trame:TStringList;DataSet:TDataSet):Boolean;overload;
var
  DMJournal: TDMJournal;

  Function Journal_Val_After_Insert(DataSet:TDataSet):TInfosJournal;
implementation

uses DMPlanCpt,DMExports, DMTier;

{$R *.DFM}

Function EditionSyntheseJournaux(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
var
NomFich,Chemin:String;
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
Begin

  Chemin :=E.RepertoireComptaWeb;
  NomFich:='SyntheseJournaux';
  Initialise_ParamAffichPeriode(ParamAffichPeriode);
  periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
  if periode.Retour then begin
      if DMJournal=nil then DMJournal:=TDMJournal.Create(Application.MainForm);
      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;

      //total general
      DMJournal.QuTotalG.SQL.Clear;
      DMJournal.QuTotalG.Params.Clear;
      DMJournal.QuTotalG.SQL.Add('select sum(debitsaisie),sum(creditsaisie),sum(qt1)');
      DMJournal.QuTotalG.SQL.Add(' from ecriture,piece,model');
      DMJournal.QuTotalG.SQL.Add(' where piece.journal=id_journal and id_piece=piece.id');
      DMJournal.QuTotalG.SQL.Add(' and piece."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DMJournal.QuTotalG.Open;

      DMJournal.QuJournalPartEdition.SQL.Clear;
      DMJournal.QuJournalPartEdition.Params.Clear;
      DMJournal.QuJournalPartEdition.SQL.Add('select model.Journal,libelle_model,model.compte,id_journal');
      DMJournal.QuJournalPartEdition.SQL.Add(' ,sum(debitsaisie) EV_Debit,sum(creditsaisie) EV_Credit ');
      DMJournal.QuJournalPartEdition.SQL.Add(' from ecriture,piece,model');
      DMJournal.QuJournalPartEdition.SQL.Add(' where piece.journal=id_journal and id_piece=piece.id');
      DMJournal.QuJournalPartEdition.SQL.Add(' and piece."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DMJournal.QuJournalPartEdition.SQL.Add(' group by model.Journal,libelle_model,model.compte,id_journal');
      DMJournal.QuJournalPartEdition.Open;

      case TypeEdition  of
          C_EditionSimple:Begin
                              Site.lien := false;
//                              EditSyntheseJournaux(Chemin,NomFich,DMJournal.QuJournalPartEdition,DMJournal.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),Site);
                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                          End;
          C_EditionWeb: Begin
                            Site.lien := false;
                            //LienEditJournalPart(NomMenuSiteWeb,Chemin,NomFich,DMJournal.QuJournalPartEdition,'date',DMJournal.QuListeValRupt,DMJournal.QuSousTotal,DMJournal.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),NomJournal,Site);
                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                        End;
      end;
      DMJournal.QuTotalG.Close;
      DMJournal.QuJournalPartEdition.Close;
  end;
End;

Function EditionJournaux(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  var NomFich,Chemin:String;
  var periode:TPeriode;
  var CodeJournal,
      NomJournal,IdJournal:String;  //afficher dans le titre de l'édition ("Journal des +NomJournal")
  i:integer;
  QuListeCode:TQuery;
  InfosModel:TInfosModel;
  journal:TEdit;
ParamAffichPeriode:TParamAffichPeriode;
Begin
try
  journal:=TEdit.Create(application.MainForm);
  Initialise_ParamAffichPeriode(ParamAffichPeriode);
  periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
  QuListeCode:=TQuery.Create(Application.MainForm);
  if periode.Retour then
  begin
      if DMJournal=nil then DMJournal:=TDMJournal.Create(Application.MainForm);
      if dataset = nil then
      begin
         // Prevu pour passer le dataset concerné
      end;
  if AideModelAffiche(journal,nil,false).retour then
    begin
      Chemin :=E.RepertoireComptaWeb;
      NomFich:='Journal';
      defiltragedataset(dmrech.TaModelRech);
      InfosModel:=Infos_TInfosModel(dmrech.TaModelRech,'Code',[journal.Text]);
      codejournal:=InfosModel.Journal;
      NomJournal:=InfosModel.Libelle_Model;
      IdJournal:=inttostr(InfosModel.ID_Journal);

      DMJournal.QuListeValRupt.SQL.Clear;
      DMJournal.QuListeValRupt.SQL.Add('select distinct( substring(cast(ecriture."Date" as Char(10)) from 4 for 2 ) ');
      DMJournal.QuListeValRupt.SQL.Add(' || ''/'' || substring(cast(ecriture."Date" as char(10)) from 9 for 2 )) ');
      DMJournal.QuListeValRupt.SQL.Add(' from ecriture,piece where id_piece=piece.id and substring(piece.Reference from 1 for 2) ='''+CodeJournal+''' and piece.journal='''+IdJournal+'''');
      DMJournal.QuListeValRupt.SQL.Add(' and piece."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DMJournal.QuListeValRupt.Open;


      //sous total
      DMJournal.QuSousTotal.SQL.Clear;
      DMJournal.QuSousTotal.Params.Clear;
      DMJournal.QuSousTotal.SQL.Add('select sum(debitsaisie),sum(creditsaisie),sum(qt1)');
      DMJournal.QuSousTotal.SQL.Add(' from ecriture,piece');
      DMJournal.QuSousTotal.SQL.Add(' where  id_piece=piece.id and substring(piece.Reference from 1 for 2) ='''+CodeJournal+''' and piece.journal='''+IdJournal+'''');
      DMJournal.QuSousTotal.SQL.Add(' and extract(month from ecriture."date")=:m ');
      DMJournal.QuSousTotal.SQL.Add(' and extract(year from ecriture."date")=:a');
      DMJournal.QuSousTotal.SQL.Add(' and piece."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DMJournal.QuSousTotal.Params[0].DataType := ftInteger;
      DMJournal.QuSousTotal.Params[1].DataType := ftInteger;
      DMJournal.QuSousTotal.Open;

      //total general
      DMJournal.QuTotalG.SQL.Clear;
      DMJournal.QuTotalG.Params.Clear;
      DMJournal.QuTotalG.SQL.Add('select sum(debitsaisie),sum(creditsaisie),sum(qt1)');
      DMJournal.QuTotalG.SQL.Add(' from ecriture,piece');
      DMJournal.QuTotalG.SQL.Add(' where  id_piece=piece.id and substring(piece.Reference from 1 for 2) ='''+CodeJournal+''' and piece.journal='''+IdJournal+'''');
      DMJournal.QuTotalG.SQL.Add(' and piece."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DMJournal.QuTotalG.Open;

      DMJournal.QuJournalPartEdition.SQL.Clear;
      DMJournal.QuJournalPartEdition.Params.Clear;
      DMJournal.QuJournalPartEdition.SQL.Add('select * from ecriture,piece');
      //DMJournal.QuJournalPartEdition.SQL.Add(' where piece.journal='''+CodeJournal+''' and id_piece=piece.id');
      DMJournal.QuJournalPartEdition.SQL.Add(' where id_piece=piece.id and substring(piece.Reference from 1 for 2) ='''+CodeJournal+''' and piece.journal='''+IdJournal+'''');
      DMJournal.QuJournalPartEdition.SQL.Add(' and piece."date" between '''+DateInfos(periode.DateDeb).DatePourSQLStr+''' and '''+DateInfos(periode.DateFin).DatePourSQLStr+'''');
      DMJournal.QuJournalPartEdition.SQL.Add(' order by piece."date",reference,creditsaisie');
      DMJournal.QuJournalPartEdition.Open;

      case TypeEdition  of
          C_EditionSimple:Begin
                              Site.lien := false;
//                              EditJournalPart(Chemin,NomFich,DMJournal.QuJournalPartEdition,'date',DMJournal.QuListeValRupt,DMJournal.QuSousTotal,DMJournal.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),NomJournal,Site);
                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                          End;
          C_EditionWeb: Begin
                            Site.lien := false;
                            //LienEditJournalPart(NomMenuSiteWeb,Chemin,NomFich,DMJournal.QuJournalPartEdition,'date',DMJournal.QuListeValRupt,DMJournal.QuSousTotal,DMJournal.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),NomJournal,Site);
                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                        End;
      end;
      DMJournal.QuListeValRupt.Close;
      DMJournal.QuSousTotal.Close;
      DMJournal.QuTotalG.Close;
      DMJournal.QuJournalPartEdition.Close;
      journal.Text:='';
      //    QuListeCode.next;
    end;//fin
  end;//fin si periode.Retour
finally
 if journal<>nil then journal.free;
end;
End;

Function EditionJournalPiece(TypeEdition : integer; DataSet:TDataSet;NomMenuSiteWeb:TfileStream;Site:TEditLien):Boolean;
  var NomFich,Chemin:String;
  var periode:TPeriode;
  var PieceDeb,PieceFin:String;

Begin
  Chemin :=E.RepertoireComptaWeb;
  NomFich:='Journal_piece';
  PieceDeb:='A';
  PieceFin:='Z';

      if DMJournal=nil then DMJournal:=TDMJournal.Create(Application.MainForm);
      if dataset = nil then begin
         // Prevu pour passer le dataset concerné
      end;

      DMJournal.QuListeValRupt.SQL.Clear;
      DMJournal.QuListeValRupt.SQL.Add('select distinct reference from piece');
      DMJournal.QuListeValRupt.SQL.Add('where reference>='''+PieceDeb+''' and reference<='''+PieceFin+'''');
      DMJournal.QuListeValRupt.Open;

      DMJournal.QuJournalPartEdition.SQL.Clear;
      DMJournal.QuJournalPartEdition.SQL.Add('select * from ecriture,piece');
      DMJournal.QuJournalPartEdition.SQL.Add(' where id_piece=piece.id');
      DMJournal.QuJournalPartEdition.SQL.Add(' and reference>='''+PieceDeb+''' and reference<='''+PieceFin+'''');
      DMJournal.QuJournalPartEdition.SQL.Add(' order by reference,piece."date",creditsaisie');
      DMJournal.QuJournalPartEdition.Open;

      case TypeEdition  of
          C_EditionSimple:Begin
                              Site.lien := false;
//                              EditJournalPiece(Chemin,NomFich,DMJournal.QuJournalPartEdition,'reference',DMJournal.QuListeValRupt,PieceDeb,PieceFin,Site);
                              ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                          End;
          C_EditionWeb: Begin
                            Site.lien := false;
                            //LienEditJournalPart(NomMenuSiteWeb,Chemin,NomFich,DMJournal.QuJournalPartEdition,'date',DMJournal.QuListeValRupt,DMJournal.QuSousTotal,DMJournal.QuTotalG,DateToStr(periode.DateDeb),DateToStr(periode.DateFin),NomJournal,Site);
                            ShellExecute(Application.Handle,nil,PChar('Mozilla.exe'),PChar(Str_Mozilla('file:///'+Chemin+NomFich+'.xml')),nil,sw_show);
                        End;
      end;
      DMJournal.QuListeValRupt.Close;
      DMJournal.QuJournalPartEdition.Close;
End;

Function TDMJournal.CtrlSaisieDMJournal(CCourant:Tfield):TExceptLGR;
var
i:integer;
ListeTmp:TStringList;
Begin
ListeTmp:=TStringList.Create;
try
Initialise_ExceptLGR(result);
 case CCourant.DataSet.State of
   dsInsert:Begin
             case CCourant.Index of
                // Traitement Code
                //*************************************************************************
                1:Begin
                   CCourant.AsString:=uppercase(CCourant.AsString);

                   if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('La saisie d''un code est obligatoire !',1000,true,mtError,result);

                   if not empty(CCourant.DataSet.findField('Journal').AsString) then
                    Begin
                      if (copy(CCourant.AsString,1,1) <> copy(CCourant.DataSet.findField('Journal').AsString,1,1)) then
                            raise ExceptLGR.Create('Les Codes et les Journaux doivent commencer par la même lettre !',1003,true,mtError,result);
                    End;

                   FiltrageDataSet(DMRech.TaModelRech,'Code = '''+CCourant.AsString+'''');
                   if DMRech.TaModelRech.RecordCount > 0 then
                      raise ExceptLGR.Create('Le Code : '+CCourant.AsString+' existe déjà !'+RetourChariotDouble+'Veuillez en saisir un autre.',1001,true,mtError,result);

                   if ListeJournalLettre.IndexOf(copy(CCourant.AsString,1,1)) = -1 then
                     raise ExceptLGR.Create('Les Lettres désignant les classes sont : '+ RetourChariotDouble+
                                            'A : Achats.'+ RetourChariotDouble+
                                            'B : Journaux Bancaire.'+ RetourChariotDouble+
                                            'C : Caisses.'+ RetourChariotDouble+
                                            'F : Factures importées.'+ RetourChariotDouble+
                                            'O : Opérations Diverses.'+ RetourChariotDouble+
                                            'V : Ventes.'+ RetourChariotDouble
                                            ,1002
                                            ,true
                                            ,mtError
                                            ,result
                                            );
                  End;
                //*************************************************************************

                // Traitement JOURNAL
                //*************************************************************************
                4:Begin

                  CCourant.AsString:=uppercase(CCourant.AsString);


                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('La saisie du Journal est obligatoire !',4000,true,mtError,result);

                  i:=ListeJournalLettre.IndexOf(copy(CCourant.AsString,1,1));
                  if i <> -1 then
                   Begin
                     Initialise_TStringlist(ListeTmp,DMJournal,false);
//                     ListeTmp.Clear;
                     ListeTmp.Assign(ListeJournalLettre_Plusieurs_Journal);
                     // Si on ne peut pas créer plus d'un journal dans la lettre courante de classes de journaux
                     if upperCase(ListeTmp.Strings[i]) = 'FAUX' then
                      begin
                        // on verifie s'il existe pas déjà dans la classe de la lettre courante
                        FiltrageDataSet(DMREch.TaModelRech,'Journal = '''+copy(CCourant.AsString,1,1)+'*''');
                        // s'il existe déjà
                        if DMREch.TaModelRech.RecordCount > 0 then
                         begin
                          raise ExceptLGR.Create('Vous ne pouvez pas créer d''autres Journaux pour la lettre : '+copy(CCourant.AsString,1,1)+' !',4001,true,mtError,result)
                         end
                        else
                         //Sinon, on vérifie que ce soit bien le journal autorisé, sinon, exception !
                         begin
//                           ListeTmp.Clear;
                           Initialise_TStringlist(ListeTmp,DMJournal,false);

                           ListeTmp.Assign(ListeJournalReserve);
                           if (CCourant.AsString <> ListeTmp.Strings[i]) then
                             raise ExceptLGR.Create('Dans cette classe de journaux, vous ne pouvez créer que le journal : '+ListeTmp.Strings[i]+' !',4005,true,mtError,result)
                         end;
                      end;
                   end;

                  if (length(CCourant.AsString) < 2) then
                     raise ExceptLGR.Create('Le Journal doit être sur 2 caractères !',4002,true,mtError,result);

                   FiltrageDataSet(DMRech.TaModelRech,'Journal = '''+CCourant.AsString+'''');
                   if DMRech.TaModelRech.RecordCount > 0 then
                      raise ExceptLGR.Create('Le Journal : '+CCourant.AsString+' existe déjà !'+RetourChariotDouble+'Veuillez en saisir un autre.',4004,true,mtError,result);

                   if ListeJournalLettre.IndexOf(copy(CCourant.AsString,1,1)) = -1 then
                     raise ExceptLGR.Create('Les Journaux doivent obligatoirement commencer par : '+ RetourChariotDouble+
                                            'A : Achats.'+ RetourChariotDouble+
                                            'B : Journaux Bancaire.'+ RetourChariotDouble+
                                            'C : Caisses.'+ RetourChariotDouble+
                                            'F : Factures importées.'+ RetourChariotDouble+
                                            'O : Opérations Diverses.'+ RetourChariotDouble+
                                            'V : Ventes.'+ RetourChariotDouble
                                            ,4003
                                            ,true
                                            ,mtError
                                            ,result
                                            );
                  // Génération du code par defaut
                  CCourant.DataSet.FindField('Code').AsString :=GenereCodeJournal(CCourant.AsString).CodeGenere;
                    // Cela permet de remplir ID_Journal pour savoir si le journal est de type Bancaire
                    // Si TypeBancaire alors le champ compte est obligatoire
                    CtrlSaisieDMJournal(CCourant.DataSet.FindField('ID_Journal'));

                  End;
                //*************************************************************************

                // Traitement Libelle_Model
                //*************************************************************************
                2:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('La saisie du libellé est obligatoire !',2000,true,mtError,result);

//                   FiltrageDataSet(DMRech.TaModelRech,'Libelle_Model = '''+Str_DoucleCar(CCourant.AsString,'''')+'''');
//                   if DMRech.TaModelRech.RecordCount > 0 then
//                      raise ExceptLGR.Create('Ce Libellé : '+CCourant.AsString+' existe déjà !'+RetourChariotDouble+'Veuillez en saisir un autre.',2001,true,mtError,result);

                  End;
                //*************************************************************************

                // Traitement Libelle
                //*************************************************************************
                3:Begin

                  End;
                //*************************************************************************

                // Traitement Compte
                //*************************************************************************
                5:Begin
                    if CCourant.DataSet.FindField('ID_Journal').AsInteger = 4 then
                     begin
                       DMPlan.FiltrageAideCompte(101,nil,DMPlan.TaCompteListeUtilFilterRecord);
                       if AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],false,MessDerSub,true,true,false,true,0)=false then
                                raise ExceptLGR.Create('Pas de message!',5000,False,mtError,result);

////// voir bug n° 1464 demandé par denis résolu le 16/10/2015                                
//                       FiltrageDataSet(DMRech.TaModelRech,'Compte = '''+CCourant.AsString+'''');
//                       if DMRech.TaModelRech.RecordCount > 0 then
//                        begin
//                          ShowMessage('Le Compte : '+CCourant.AsString+' est déjà utilisé dans un autre Journal !'+RetourChariotDouble+'Veuillez en choisir un autre.');
//                          DMPlan.FiltrageAideCompte(101,nil,DMPlan.TaCompteListeUtilFilterRecord);
//                          if AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],true,MessDerSub,true,true,false,true,0)=false then
//                             raise ExceptLGR.Create('Pas de message',5001,False,mtError,result)
//                             else
//                             begin
//                               // Permet de refaire un controle complet pour compte
//                               result:=CtrlSaisieDMJournal(CCourant);
//                               if not result.retour then
//                                    raise ExceptLGR.Create('Pas de message',Result.NumErreur,False,mtError,result)
//                             end;
//                        end;

                     end
                    else
                     begin
                        if not Empty(CCourant.AsString) then
                         begin
                           CCourant.AsString := '';
                           raise ExceptLGR.Create('La saisie d''un compte est réservé aux comptes Bancaire  !',5002,true,mtError,result);
                         end;
                     end;
                  End;
                //*************************************************************************

                // Traitement Compte_Reglement
                //*************************************************************************
                6:Begin

                  End;
                //*************************************************************************

                // Traitement ID_Journal
                //*************************************************************************
                9:Begin
                    CCourant.DataSet.FindField('ID_Journal').AsInteger:=0;
                    if not empty(CCourant.DataSet.FindField('Journal').AsString) then
                    begin
                      i:=ListeJournalLettre.IndexOf(copy(CCourant.DataSet.FindField('Journal').AsString,1,1));
                      if i <> -1 then
                       begin
                          Initialise_TStringlist(ListeTmp,DMJournal,false);
//                          ListeTmp.Clear;

                          ListeTmp.Assign(ListeJournalLettre_ID_Journal);
                          CCourant.DataSet.FindField('ID_Journal').AsInteger:=StrToInt_Lgr(ListeTmp.strings[i]);
                       end;
                     End;
                  End;
                //*************************************************************************

                // Traitement CODE_BANQUE_GESTCO
                //*************************************************************************
                12:Begin

                  End;
                //*************************************************************************

             End;
            End;
   dsEdit:Begin
             case CCourant.Index of
                // Traitement Code
                //*************************************************************************
                1:Begin
                  CCourant.AsString:=uppercase(CCourant.AsString);

                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('La saisie d''un code est obligatoire !',1000,true,mtError,result);

                   if not empty(CCourant.DataSet.findField('Journal').AsString) then
                    Begin
                      if (copy(CCourant.AsString,1,1) <> copy(CCourant.DataSet.findField('Journal').AsString,1,1)) then
                            raise ExceptLGR.Create('Les Codes et les Journaux doivent commencer par la même lettre !',1003,true,mtError,result);
                    End;

                   FiltrageDataSet(DMRech.TaModelRech,CCourant.FieldName+'='''+CCourant.AsString+ ''' and ID <> '''+CCourant.DataSet.FindField('ID').AsString+'''');
                   if DMRech.TaModelRech.RecordCount > 0 then
                      raise ExceptLGR.Create('Le Code : '+CCourant.AsString+' existe déjà !'+RetourChariotDouble+'Veuillez en saisir un autre.',1001,true,mtError,result);

                   if ListeJournalLettre.IndexOf(copy(CCourant.AsString,1,1)) = -1 then
                     raise ExceptLGR.Create('Les Lettres désignant les classes sont : '+ RetourChariotDouble+
                                            'A : Achats.'+ RetourChariotDouble+
                                            'B : Journaux Bancaire.'+ RetourChariotDouble+
                                            'C : Caisses.'+ RetourChariotDouble+
                                            'F : Factures importées.'+ RetourChariotDouble+
                                            'O : Opérations Diverses.'+ RetourChariotDouble+
                                            'V : Ventes.'+ RetourChariotDouble
                                            ,1002
                                            ,true
                                            ,mtError
                                            ,result
                                            );
                  End;
                //*************************************************************************

                // Traitement JOURNAL
                //*************************************************************************
                4:Begin
                  CCourant.AsString:=uppercase(CCourant.AsString);

                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('La saisie du Journal est obligatoire !',4000,true,mtError,result);

                  if (length(CCourant.AsString) < 2) then
                     raise ExceptLGR.Create('Le Journal doit être sur 2 caractères !',4000,true,mtError,result);

                   FiltrageDataSet(DMRech.TaModelRech,CCourant.FieldName+'='''+CCourant.AsString+ ''' and ID <> '''+CCourant.DataSet.FindField('ID').AsString+'''');
//                   FiltrageDataSet(DMRech.TaModelRech,'Journal = '''+CCourant.AsString+'''');
                   if DMRech.TaModelRech.RecordCount > 0 then
                      raise ExceptLGR.Create('Le Journal : '+CCourant.AsString+' existe déjà !'+RetourChariotDouble+'Veuillez en saisir un autre.',4001,true,mtError,result);

                   if ListeJournalLettre.IndexOf(copy(CCourant.AsString,1,1)) = -1 then
                     raise ExceptLGR.Create('Les Journaux doivent obligatoirement commencer par : '+ RetourChariotDouble+
                                            'A : Achats.'+ RetourChariotDouble+
                                            'B : Journaux Bancaire.'+ RetourChariotDouble+
                                            'C : Caisses.'+ RetourChariotDouble+
                                            'F : Factures importées.'+ RetourChariotDouble+
                                            'O : Opérations Diverses.'+ RetourChariotDouble+
                                            'V : Ventes.'+ RetourChariotDouble
                                            ,4002
                                            ,true
                                            ,mtError
                                            ,result
                                            );
                    // Génération du code par defaut
                    CCourant.DataSet.FindField('Code').AsString :=GenereCodeJournal(CCourant.AsString).CodeGenere;
                    // Cela permet de remplir ID_Journal pour savoir si le journal est de type Bancaire
                    // Si TypeBancaire alors le champ compte est obligatoire
                    CtrlSaisieDMJournal(CCourant.DataSet.FindField('ID_Journal'));
                  End;
                //*************************************************************************

                // Traitement Libelle_Model
                //*************************************************************************
                2:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('La saisie du libellé est obligatoire !',2000,true,mtError,result);

                   FiltrageDataSet(DMRech.TaModelRech,CCourant.FieldName+'='''+CCourant.AsString+ ''' and ID <> '''+CCourant.DataSet.FindField('ID').AsString+'''');
//                   FiltrageDataSet(DMRech.TaModelRech,'Libelle_Model = '''+CCourant.AsString+'''');
                   if DMRech.TaModelRech.RecordCount > 0 then
                      raise ExceptLGR.Create('Ce Libellé : '+CCourant.AsString+' existe déjà !'+RetourChariotDouble+'Veuillez en saisir un autre.',2001,true,mtError,result);

                  End;
                //*************************************************************************

                // Traitement Libelle
                //*************************************************************************
                3:Begin

                  End;
                //*************************************************************************

                // Traitement Compte
                //*************************************************************************
                5:Begin
//                    if CCourant.DataSet.FindField('ID_Journal').AsInteger = 4 then
//                     begin
//                       DMPlan.FiltrageAideCompte(101,nil,DMPlan.TaCompteListeUtilFilterRecord);
//                       if AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],false,MessDerSub,true,true,false,true,0)=false then
//                                raise ExceptLGR.Create('Pas de message!',5000,False,mtError,result);
//
//                       FiltrageDataSet(DMRech.TaModelRech,CCourant.FieldName+'='''+CCourant.AsString+ ''' and ID <> '''+CCourant.DataSet.FindField('ID').AsString+'''');
//                       if DMRech.TaModelRech.RecordCount > 0 then
//                          raise ExceptLGR.Create('Le Compte : '+CCourant.AsString+' est déjà utilisé dans un autre Journal !'+RetourChariotDouble+'Veuillez en choisir un autre.',5001,true,mtError,result);
//
//                     end
//                    else
//                     begin
//                        if not Empty(CCourant.AsString) then
//                         begin
//                           CCourant.AsString := '';
//                           raise ExceptLGR.Create('La saisie d''un compte est réservé aux comptes Bancaire  !',5002,true,mtError,result);
//                         end;
//                     end;
                    if CCourant.DataSet.FindField('ID_Journal').AsInteger = 4 then
                     begin
                       DMPlan.FiltrageAideCompte(101,nil,DMPlan.TaCompteListeUtilFilterRecord);
                       if AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],false,MessDerSub,true,true,false,true,0)=false then
                                raise ExceptLGR.Create('Pas de message!',5000,False,mtError,result);

                       FiltrageDataSet(DMRech.TaModelRech,CCourant.FieldName+'='''+CCourant.AsString+ ''' and ID <> '''+CCourant.DataSet.FindField('ID').AsString+'''');
                       if DMRech.TaModelRech.RecordCount > 0 then
                        begin
                          ShowMessage('Le Compte : '+CCourant.AsString+' est déjà utilisé dans un autre Journal !'+RetourChariotDouble+'Veuillez en choisir un autre.');
                          DMPlan.FiltrageAideCompte(101,nil,DMPlan.TaCompteListeUtilFilterRecord);
                          if AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],true,MessDerSub,true,true,false,true,0)=false then
                             raise ExceptLGR.Create('Pas de message',5001,False,mtError,result)
                             else
                             begin
                               // Permet de refaire un controle complet pour compte
                               result:=CtrlSaisieDMJournal(CCourant);
                               if not result.retour then
                                    raise ExceptLGR.Create('Pas de message',Result.NumErreur,False,mtError,result)
                             end;
                        end;

                     end
                    else
                     begin
                        if not Empty(CCourant.AsString) then
                         begin
                           CCourant.AsString := '';
                           raise ExceptLGR.Create('La saisie d''un compte est réservé aux comptes Bancaire  !',5002,true,mtError,result);
                         end;
                     end;
                  End;
                //*************************************************************************

                // Traitement Compte_Reglement
                //*************************************************************************
                6:Begin

                  End;
                //*************************************************************************

                // Traitement ID_Journal
                //*************************************************************************
                9:Begin
                    CCourant.DataSet.FindField('ID_Journal').AsInteger:=0;
                    if not empty(CCourant.DataSet.FindField('Journal').AsString) then
                    begin
                      i:=ListeJournalLettre.IndexOf(copy(CCourant.DataSet.FindField('Journal').AsString,1,1));
                      if i <> -1 then
                       begin
//                          ListeTmp.Clear;
                          Initialise_TStringlist(ListeTmp,DMJournal,false);
                          ListeTmp.Assign(ListeJournalLettre_ID_Journal);
                          CCourant.DataSet.FindField('ID_Journal').AsInteger:=StrToInt_Lgr(ListeTmp.strings[i]);
                       end;
                     End;
                  End;
                //*************************************************************************

                // Traitement CODE_BANQUE_GESTCO
                //*************************************************************************
                12:Begin

                  End;
                //*************************************************************************

             End;
          End;
 End;
finally
  defiltragedataset(dmrech.TaModelRech);
Initialise_TStringlist(ListeTmp);
//  if listeTmp<>nil then ListeTmp.Free;
end;
End;

Function TDMJournal.AideDMJournal(CCourant:Tfield):boolean;
Begin

case CCourant.DataSet.State of
   dsInsert:Begin
             case CCourant.Index of
                // Traitement Code
                //*************************************************************************
                1:Begin
                    Showmessage('Vous devez saisir un code commençant par : '+Copy(CCourant.Dataset.findField('Journal').AsString,1,1));
                  End;
                //*************************************************************************

                // Traitement Champ Libelle_Model
                //*************************************************************************
                2:Begin
                    ShowMessage('Veuillez saisir un libellé court pour le Journal en cours ');
                  End;
                //*************************************************************************

                // Traitement Champ Libelle
                //*************************************************************************
                3:Begin
                    ShowMessage('Vous pouvez saisir un libellé long pour le Journal en cours ');
                  End;
                //*************************************************************************

                // Traitement Champ Journal
                //*************************************************************************
                4:Begin
                  Showmessage('Choisissez parmi ces lettres pour créer votre journal : '+ RetourChariotDouble+
                                                     'A : Achats.'+ RetourChariotDouble+
                                                     'B : Journaux Bancaire.'+ RetourChariotDouble+
                                                     'C : Caisses.'+ RetourChariotDouble+
                                                     'F : Factures importées.'+ RetourChariotDouble+
                                                     'O : Opérations Diverses.'+ RetourChariotDouble+
                                                     'V : Ventes.'+ RetourChariotDouble);
                  End;
                //*************************************************************************

                // Traitement Champ Compte
                //*************************************************************************
                5:Begin
                    if CCourant.DataSet.FindField('ID_Journal').AsInteger = 4 then
                     begin
                       DMPlan.FiltrageAideCompte(101,nil,DMPlan.TaCompteListeUtilFilterRecord);
                       AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],true,MessDerSub,false,true,false,true,0);
                     end
                    else
                     begin
                       ShowMessage('La saisie d''un compte est réservé aux comptes Bancaire  !');
                     end;
                  End;
                //*************************************************************************

             else
               ShowMessage('Pas d''aide disponible pour ce champ !');
            End;
          end;
   dsEdit:Begin
             case CCourant.Index of
                // Traitement Champ :
                //*************************************************************************
                1:Begin
                    Showmessage('Vous devez saisir un code commençant par : '+Copy(CCourant.Dataset.findField('Journal').AsString,1,1));
                  End;
                //*************************************************************************

                // Traitement Champ Libelle_Model
                //*************************************************************************
                2:Begin
                    ShowMessage('Veuillez saisir un libellé court pour le Journal en cours ');
                  End;
                //*************************************************************************

                // Traitement Champ Libelle
                //*************************************************************************
                3:Begin
                    ShowMessage('Vous pouvez saisir un libellé long pour le Journal en cours ');
                  End;
                //*************************************************************************

                // Traitement Champ :
                //*************************************************************************
                4:Begin
                  Showmessage('Choisissez parmi ces lettres pour modifier votre journal : '+ RetourChariotDouble+
                                                     'A : Achats.'+ RetourChariotDouble+
                                                     'B : Journaux Bancaire.'+ RetourChariotDouble+
                                                     'C : Caisses.'+ RetourChariotDouble+
                                                     'F : Factures importées.'+ RetourChariotDouble+
                                                     'O : Opérations Diverses.'+ RetourChariotDouble+
                                                     'V : Ventes.'+ RetourChariotDouble);

                  End;
                //*************************************************************************

                // Traitement Champ : Compte
                //*************************************************************************
                5:Begin
                    if CCourant.DataSet.FindField('ID_Journal').AsInteger = 4 then
                     begin
                       DMPlan.FiltrageAideCompte(101,nil,DMPlan.TaCompteListeUtilFilterRecord);
                       AideCompteDansContexte(CCourant.AsString,ccourant,['Rac1'],true,MessDerSub,false,true,false,true,0);
                     end
                    else
                     begin
                       ShowMessage('La saisie d''un compte est réservé aux comptes Bancaire  !');
                     end;

                  End;
                //*************************************************************************

             else
               ShowMessage('Pas d''aide disponible pour ce champ !');
            End;
          End;
   dsBrowse:Begin
             case CCourant.Index of
                // Traitement Champ :
                //*************************************************************************
                1:Begin

                  End;
                //*************************************************************************

                // Traitement Champ :
                //*************************************************************************
                2:Begin

                  End;
                //*************************************************************************

                // Traitement Champ :
                //*************************************************************************
                3:Begin

                  End;
                //*************************************************************************

                // Traitement Champ :
                //*************************************************************************
                4:Begin

                  End;
                //*************************************************************************

                // Traitement Champ :
                //*************************************************************************
                5:Begin

                  End;
                //*************************************************************************

             else
               ShowMessage('Pas d''aide disponible pour ce champ !');
            End;
          End;
end;

End;



procedure TDMJournal.DMJournalCreate(Sender: TObject);
begin
 OuvrirTouteTable('',TControl(self));
 if ListeFilterRecordJournaux = nil then ListeFilterRecordJournaux:=Tstringlist.Create;
 if ListefilterRecordPieces = nil then ListefilterRecordPieces:=Tstringlist.Create;
 if ListefilterRecordTrame = nil then ListefilterRecordTrame := TStringList.Create;
end;

procedure TDMJournal.DMJournalDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
if ListeFilterRecordJournaux <> nil then ListeFilterRecordJournaux.Free;
if ListefilterRecordPieces <> nil then ListefilterRecordPieces.Free;
if ListefilterRecordTrame <> nil then ListefilterRecordTrame.Free;
DMJournal:=nil;
end;

procedure TDMJournal.TaJournalBeforeEdit(DataSet: TDataSet);
begin
//if DataSet.FindField('ID').AsInteger = DataSet.FindField('ID_Journal').AsInteger then
//   Begin
//    Showmessage('Vous ne pouvez pas modifier ce journal !');
//    abort;
//   End;
//if DetailEcritureJournal(DataSet.FindField('Journal').AsString,false) then
//   Begin
//    Showmessage('Vous ne pouvez pas modifier ce journal, il possède des écritures !');
//    abort;
//   End;
end;

procedure TDMJournal.TaJournalBeforeInsert(DataSet: TDataSet);
begin
//    DataSet.Fields[4].FocusControl;
end;

procedure TDMJournal.TaJournalBeforeDelete(DataSet: TDataSet);
begin
if DataSet.FindField('ID').AsInteger = DataSet.FindField('ID_Journal').AsInteger then
   Begin
    Showmessage('Vous ne pouvez pas supprimer ce journal !');
    abort;
   End;
if DetailEcritureJournal(DataSet.FindField('Journal').AsString,false) then
   Begin
    Showmessage('Vous ne pouvez pas supprimer ce journal, il possède des écritures !');
    abort;
   End;
Case E.TypeEtatExercice of
 ET_Importation:begin

                end;
  ET_Normal:    begin
                  If Messagedlg('Êtes-vous sûr de vouloir supprimer ce journal ?',MtConfirmation,[mbyes,mbno],0) = mrno Then
                     abort
                end;
end;//fin du case E.TypeEtatExercice
end;

Function Journal_Val_After_Insert(DataSet:TDataSet):TInfosJournal;
begin
    Initialise_TInfosJournal(result);
    InitChampAfterInsert([result.ID
                          ,Result.Code
                          ,result.Libelle_Model
                          ,result.Libelle
                          ,result.Journal
                          ,result.Compte
                          ,result.Compte_Reglement
                          ,result.Minimum
                          ,result.ID_Devise
                          ,result.ID_Journal
                          ,E.user
                          ,Now
                          ,result.CODE_BANQUE_GESTCO
                          ],DataSet);
 end;


Function TDMJournal.InfosJournal_Reference(Reference : string):TInfosModel;
Begin

if not TaJournalRech.Active then TaJournalRech.Open;
TaJournalRech.Filter:='';
TaJournalRech.Filtered:=false;
result:=Infos_TInfosModel(TaJournalRech,'Journal',[copy(Reference,1,2)]);

End;

//Procedure TDMJournal.Remplit_TInfosJournal(DataSet:TDataSet;var InfosJournal:TInfosJournal);
//Begin
//  InfosJournal.ID :=DataSet.FindField('ID').AsInteger;
//  InfosJournal.Code :=DataSet.FindField('Code').AsString;
//  InfosJournal.Libelle_Model :=DataSet.FindField('Libelle_Model').AsString;
//  InfosJournal.Libelle  :=DataSet.FindField('Libelle').AsString;
//  InfosJournal.Journal :=DataSet.FindField('Journal').AsString;
//  InfosJournal.Compte :=DataSet.FindField('Compte').AsString;
//  InfosJournal.Compte_Reglement :=DataSet.FindField('Compte_Reglement').AsString;
//  InfosJournal.Minimum :=DataSet.FindField('Minimun').AsBoolean;
//  InfosJournal.ID_Devise :=DataSet.FindField('ID_Devise').AsInteger;
//  InfosJournal.ID_Journal :=DataSet.FindField('ID_Journal').AsInteger;
//  InfosJournal.Qui :=DataSet.FindField('Qui').AsString;
//  InfosJournal.Quand :=DataSet.FindField('Quand').AsDateTime;
//  InfosJournal.CODE_BANQUE_GESTCO  :=DataSet.FindField('CODE_BANQUE_GESTCO').AsString;
//End;


procedure TDMJournal.TaJournalAfterInsert(DataSet: TDataSet);
begin
Journal_Val_After_Insert(DataSet);
end;


procedure TDMJournal.ReadOnlyChamps(DataSet: TDataSet; readOnly : boolean);
var
i:integer;
begin
for i:=0 to dataset.FieldCount-1 do
  begin
    if dataset.State in [dsinsert] then
    dataset.Fields[i].ReadOnly:=false
    else
    if not((dataset.Fields[i]=dataset.FieldByName('Libelle')) or (dataset.Fields[i]=dataset.FieldByName('Libelle_Model'))) then
      dataset.Fields[i].ReadOnly:=readOnly;
  end;
end;

procedure TDMJournal.TaJournalBeforePost(DataSet: TDataSet);
var
i:integer;
ExceptLGR:TExceptLGR;
begin
try
  case DataSet.State of
     dsInsert:Begin
                 // Initialiation des champs programme

                 try
//                 DataSet.FindField('ID').AsInteger:=0;
//                 if ListeJournalReserve.IndexOf(UpperCase(DataSet.FindField('Journal').asString)) <> -1 then
//                       DataSet.FindField('ID').AsInteger:=StrToInt_Lgr(ListeJournalReserveID.Strings[ListeJournalReserve.IndexOf(UpperCase(DataSet.FindField('Journal').asString))]);
                 if DataSet.FindField('ID').AsInteger = 0 then
                       DataSet.FindField('ID').AsInteger:=MaxId_Query(TaJournal,'ID')+4;
                 except
                   messageDlg('Erreur lors de l''initialisation des données dans TaJournal.BeforePost !',mtError,[mbok],0);
                   abort;
                 end;
                // Vérification des données utilisateur
                try
                  try
                  ExceptLGR:=CtrlSaisieDMJournal(dataset.Fields[4]);
                  except
                      dataset.Fields[4].FocusControl;
                      abort;
                  end;
                  for i:=0 to dataset.FieldCount-1 do
                   Begin
                      try
                      ExceptLGR:=CtrlSaisieDMJournal(dataset.Fields[i]);
                      except
                       case ExceptLGR.NumErreur of
                        1000,1001,1002,1003:begin
                                   dataset.Fields[1].FocusControl;
                                   abort;
                                  end;
                        2000,2001:begin
                                   dataset.Fields[2].FocusControl;
                                   abort;
                                  end;
                        4000,4001,4002,4003,4004,4005:begin
                              dataset.Fields[4].FocusControl;
                              abort;
                              end;
                        5000,5001:begin
                              dataset.Fields[5].FocusControl;
                              abort;
                              end;
                       end;
                      end;
                   end;
                except;
                 abort;
                end;
              End;
     dsEdit:Begin
                // Vérification des données utilisateur
                for i:=0 to dataset.FieldCount-1 do
                 Begin
                    try
                    ExceptLGR:=CtrlSaisieDMJournal(dataset.Fields[i]);
                    except
                     case ExceptLGR.NumErreur of
                      1000,1001,1002,1003:begin
                                 dataset.Fields[1].FocusControl;
                                 abort;
                                end;
                      2000,2001:begin
                                 dataset.Fields[2].FocusControl;
                                 abort;
                                end;
                      4000,4001,4002,4003,4004,4005:begin
                            dataset.Fields[4].FocusControl;
                            abort;
                            end;
                      5000,5001:begin
                            dataset.Fields[5].FocusControl;
                            abort;
                            end;
                     end;
                    end;
                 end;
            End;
  end;
except;
  abort;
end;
//AffichevaleurDsTable('',DataSet);
end;

procedure TDMJournal.TaJournalAfterOpen(DataSet: TDataSet);
begin
TaJournal.findField('CODE').ValidChars:=['a'..'z','A'..'Z','0'..'9'];
end;


procedure TDMJournal.CompteFilterRecord_TaJournal(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    try
      accept:=true;
      //((DataSet.FindField('immobilisation').asboolean)and(copy(DataSet.FindField('Compte').AsString,1,1)='2')and(length(DataSet.FindField('Compte').AsString)>2)) ;
    except
      accept:=False;
    end;
  end;
end;

Function TDMJournal.GenereCodeJournal(Journal:String):TExceptLGRJournal;
Begin
  Result.CodeGenere :='';
  if empty(Journal) then
       raise ExceptLGR.Create('Impossible de générer le code, le journal est vide  !',20000,true,mtError,Result.ExceptLGR);

  QuJournaux.Close;
  QuJournaux.SQL.Clear;
  QuJournaux.SQL.Add(' select count(code) as NBJournaux ,max(Code) as MaxCode from Model '+
                     ' where Journal like(:Lettre + ''%'') ');
  QuJournaux.ParamByName('Lettre').AsString := copy(Journal,1,1);
  QuJournaux.Open;

  result.MaxJournal :=(QuJournaux.FindField('NBJournaux').AsInteger = C_MaxNbJournaux);

  if result.MaxJournal then
      raise ExceptLGR.Create('Impossible de générer le code !'+RetourChariotDouble+'Vous avez atteint le nombre maximun de journaux',20001,true,mtError,Result.ExceptLGR);

  Result.CodeGenere :=Journal;
End;

Procedure TDMJournal.ImportJournaux(Valeurs:array of const;DataSet:TDataSet);
Begin
  try
  ReadOnlyChamps(dataset,false);
   ImportTable(Valeurs,DataSet);
  except
   abort;
  end;
End;

Function EditionDesJournauxL(TypeEdition : integer; DemandePeriode:Boolean; Journal:TStringList;DataSet:TDataSet;Synthese : boolean = false):Boolean;
var
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
i,NbPieceMois,TotalNbPiece,NbPieceJournal:integer;
NbEcritureMois,TotalNbEcriture,NbEcritureJournal:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeEdition:TStringList;
TotalMoisDebit,TotalMoisCredit,TotalPeriodeDebit,TotalPeriodeCredit,TotalQtePeriode,TotalQte:Currency;
TotalGPeriodeDebit,TotalGPeriodeCredit,TotalGQtePeriode:currency;
Mois,annee,Reference,ReferenceTmp,DateTmp,Date,JournalTmp:string;
LibelleCorrect:string;
TitreCompte:string;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
TotalMoisDebit:=0;
TotalMoisCredit:=0;
TotalQte:=0;
TotalPeriodeDebit:=0;
TotalPeriodeCredit:=0;
TotalQtePeriode:=0;

TotalGPeriodeDebit:=0;
TotalGPeriodeCredit:=0;
TotalGQtePeriode:=0;

NbEcritureMois:=0;
TotalNbEcriture:=0;
NbEcritureJournal:=0;
NbPieceMois:=0;
NbPieceJournal:=0;
TotalNbPiece:=0;
Mois:='';
annee:='';
reference:='';
ReferenceTmp:='';
DateTmp:='';
Date:='';
JournalTmp:='';
  if DemandePeriode then
  begin
    Initialise_ParamAffichPeriode(ParamAffichPeriode);
    periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
  end
   else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;
    if DMJournal=nil then DMJournal:=TDMJournal.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
       //on branche un filter record sur requete en passant une liste
        DMJournal.ListeFilterRecordJournaux.clear;
        if Journal<>nil then      // Tous les Journaux
         begin
          TitreCompte:='Du journal :'+Journal.Strings[0]+' au journal :'+Journal.Strings[Journal.count-1];
          DMJournal.ListeFilterRecordJournaux.Assign(Journal);
          DMJournal.QuCode_Edition.OnFilterRecord:=DMJournal.QuCode_EditionFilterRecord;
         end
        else
          begin
          DMJournal.QuCode_Edition.OnFilterRecord:=nil;
          TitreCompte:='Tous les journaux';
          end;

      DMJournal.QuCode_Edition.CLose;
      DMJournal.QuCode_Edition.ParamByName('DAteDeb').AsDate := E.DatExoDebut;
      DMJournal.QuCode_Edition.ParamByName('DAteFin').AsDate := E.DatExoFin;
      DMJournal.QuCode_Edition.filtered:=true;
      DMJournal.QuCode_Edition.Open;

      if DMJournal.QuCode_Edition.recordcount<>0 then
      begin
      ListeEdition.Add('Journal;date;référence;Compte;Tiers;Libelle;Débit;Crédit;Qté');
      While not DMJournal.QuCode_Edition.Eof do
       begin
          TotalPeriodeDebit:=0;
          TotalPeriodeCredit:=0;
          TotalQtePeriode:=0;
          NbEcritureMois:=0;
          NbEcritureJournal:=0;
          NbPieceJournal:=0;
          NbPieceMois:=0;
          journalTmp:=DMJournal.QuCode_Edition.findfield('journal').AsString;
          ListeValeur.Add('9;JOURNAL : '+journalTmp);
          DMJournal.QuJournaux_Edition.Close;
          DMJournal.QuJournaux_Edition.ParamByName('Journal').AsString := journalTmp;
          DMJournal.QuJournaux_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMJournal.QuJournaux_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          DMJournal.QuJournaux_Edition.Open;
          DMJournal.QuJournaux_Edition.First;
          while not DMJournal.QuJournaux_Edition.Eof do
            begin
              //remplir totaux mois en cours avant changement de mois et d'annee

              //ensuite passer à un autre mois
              NbPieceMois:=0;
              NbEcritureMois:=0;
              Mois:=dateinfos(DMJournal.QuJournaux_Edition.FindField('DAte_1').AsDateTime).MoisStr;
              annee:=dateinfos(DMJournal.QuJournaux_Edition.FindField('DAte_1').AsDateTime).AnStr;
              TotalMoisDebit:=0;
              TotalMoisCredit:=0;
              TotalQte:=0;
               while ((dateinfos(DMJournal.QuJournaux_Edition.FindField('DAte_1').AsDateTime).AnStr=annee)and(not DMJournal.QuJournaux_Edition.Eof)and(mois=dateinfos(DMJournal.QuJournaux_Edition.FindField('DAte_1').AsDateTime).MoisStr)) do
                  begin
                  TotalMoisDebit:=TotalMoisDebit+DMJournal.QuJournaux_Edition.FindField('DebitSaisie').AsCurrency;
                  TotalMoisCredit:=TotalMoisCredit+DMJournal.QuJournaux_Edition.FindField('CreditSaisie').AsCurrency;
                  TotalQte:=TotalQte+DMJournal.QuJournaux_Edition.FindField('Qt1').Asfloat;
                  if ReferenceTmp<>DMJournal.QuJournaux_Edition.FindField('Reference').AsString then
                    begin
                      inc(NbPieceMois);
                      reference:=DMJournal.QuJournaux_Edition.FindField('Reference').AsString;
                      ReferenceTmp:=reference;
                    end;
                    LibelleCorrect:=str_remplacesouschaine(DMJournal.QuJournaux_Edition.FindField('Libelle_1').AsString,';',',');
                    inc(NbEcritureMois);
                  if not Synthese then
                  begin
                  ListeEdition.Add(journalTmp+
                                   ';'+
                                   DMJournal.QuJournaux_Edition.FindField('DAte_1').AsString+
                                   ';'+
                                   reference+
                                   ';'+
                                   DMJournal.QuJournaux_Edition.FindField('Compte_1').AsString+
                                   ';'+
                                   GereLibelle(DMJournal.QuJournaux_Edition.FindField('Tiers').AsString)+
                                   ';'+
                                   LibelleCorrect+
                                   ';'+
                                   DMJournal.QuJournaux_Edition.FindField('DebitSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournaux_Edition.FindField('CreditSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournaux_Edition.FindField('Qt1').AsString
                                   );
                  ListeValeur.Add('0'+
                                   ';'+
                                   DMJournal.QuJournaux_Edition.FindField('DAte_1').AsString+
                                   ';'+
                                   reference+
                                   ';'+
                                   DMJournal.QuJournaux_Edition.FindField('Compte_1').AsString+
                                   ';'+
                                   GereLibelle(DMJournal.QuJournaux_Edition.FindField('Tiers').AsString)+
                                   ';'+
                                   LibelleCorrect+
                                   ';'+
                                   DMJournal.QuJournaux_Edition.FindField('DebitSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournaux_Edition.FindField('CreditSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournaux_Edition.FindField('Qt1').AsString
                                   );
                   end;
                   DMJournal.QuJournaux_Edition.Next;
                   reference:='';
               end;//fin du while
                   TotalPeriodeDebit:=TotalPeriodeDebit+TotalMoisDebit;
                   TotalPeriodeCredit:=TotalPeriodeCredit+TotalMoisCredit;
                   TotalQtePeriode:=TotalQtePeriode+TotalQte;
                   NbEcritureJournal:=NbEcritureJournal+NbEcritureMois;
                   NbPieceJournal:=NbPieceJournal+NbPieceMois;
                   ListeValeur.Add('4;;;;; @TOTAL DU MOIS DE - '+Mois+'/'+annee+' - '+IntToStr_Lgr(NbPieceMois)+' pièces - '+IntToStr_Lgr(NbEcritureMois)+' Ecritures : ;'+CurrToStr(TotalMoisDebit) +';'+CurrToStr(TotalMoisCredit)+';'+floatToStr(TotalQte));
            end;//fin du while not QuJournaux_Edition.eof
          ListeValeur.Add('1;;;;; @TOTAL DU JOURNAL '+journalTmp+' - '+IntToStr_Lgr(NbPieceJournal)+' pièces - '+IntToStr_Lgr(NbEcritureJournal)+' Ecritures : ;'+CurrToStr(TotalPeriodeDebit) +';'+CurrToStr(TotalPeriodeCredit)+';'+floatToStr(TotalQtePeriode));

          TotalGPeriodeDebit:=TotalGPeriodeDebit+TotalPeriodeDebit;
          TotalGPeriodeCredit:=TotalGPeriodeCredit+TotalPeriodeCredit;
          TotalGQtePeriode:=TotalGQtePeriode+TotalQtePeriode;

          DMJournal.QuCode_Edition.Next;
          TotalNbPiece:=TotalNbPiece+NbPieceJournal;
          TotalNbEcriture:=TotalNbEcriture+NbEcritureJournal;
       end;//fin du while not QuCode_Edition.eof

          ListeValeur.Add('1;;;;; @TOTAL DE TOUS LES JOURNAUX - '+IntToStr_Lgr(TotalNbPiece)+' pièces - '+IntToStr_Lgr(TotalNbEcriture)+' Ecritures : ;'+CurrToStr(TotalGPeriodeDebit) +';'+CurrToStr(TotalGPeriodeCredit)+';'+floatToStr(TotalGQtePeriode));

         ObjPrn.FTitreEdition := 'EDITION DES JOURNAUX - '+TitreCompte;
         ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
         ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;
         ListeValeur.Insert(0,' Date ;Réf. Pièce ; Compte ; Tiers ; Désignation ; Débit ; Crédit ; Qté ');
         ListeValeur.Insert(1,'0.6;0.8;0.8;0.8;2;0.8;0.8;0.8');
         ListeValeur.Insert(2,'texte;texte;texte;texte;texte;curr;curr;float');
      end;
     case TypeEdition of
       C_Exportation: ExportDonnees(ListeEdition,E.RepertoireExportDossier,'Journaux_'+E.NomDossier + E.NomExo + '.Txt')
     else
       ObjPrn.AffichageImp(ListeValeur);
     end;//fin du case TypeEdition
     //end;//fin du empty journal
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
     Initialise_TStringlist(ListeEdition);
     Initialise_TStringlist(ListeValeur);
//   ObjPrn.destroy;
end;
end;

Function EditionDesEcrituresL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:TStringList;DataSet:TDataSet;DateDeb:Tdate;DateFin:TDate):Boolean;
var
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeEdition:TStringList;
Reference,ReferenceTmp,DateTmp,Date,Journal:string;
ListeCpt:TResultStrList;
tiersCompte:string;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
reference:='';
ReferenceTmp:='';
DateTmp:='';
Date:='';
Journal:='';
  if DemandePeriode then
    begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
  else
    begin
     periode.Retour := true;
     if datefin<>0 then
       begin
         periode.DateDeb := DateDeb;
         periode.DateFin := DateFin;
       end
     else
       begin
         periode.DateDeb := E.DatExoDebut;
         periode.DateFin := E.DatExoFin;
       end;
     if e.PeriodeAutreImpression.Retour then
       begin
         periode.DateDeb := e.PeriodeAutreImpression.DateDeb;
         periode.DateFin := e.PeriodeAutreImpression.DateFin;
       end;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;
    if DMJournal=nil then DMJournal:=TDMJournal.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
    //on branche un filter record sur requete en passant une liste
    DMJournal.ListefilterRecordPieces.clear;
    if Pieces<>nil then      // Tous les Journaux
     begin
      DMJournal.ListefilterRecordPieces.Assign(Pieces);
      DMJournal.QuJournalPiece_Edition.OnFilterRecord:=DMJournal.QuJournalPiece_EditionFilterRecord;
     end
    else
    begin
      DMJournal.QuJournalPiece_Edition.OnFilterRecord:=nil;


          DMJournal.QuJournalPiece_Edition.Close;
          DMJournal.QuJournalPiece_Edition.SQL.Clear;
          DMJournal.QuJournalPiece_Edition.SQL.Add(' select distinct(P.reference),(P."Date")as DatePiece,');
          DMJournal.QuJournalPiece_Edition.SQL.Add(' P.libelle ,P.compte ,Substring(P.reference from 1 for 2)as Journal');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  from piece P');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  where P."date" between :DateDeb and  :DateFin');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  order by P.reference,P."date"');
          DMJournal.QuJournalPiece_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMJournal.QuJournalPiece_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          DMJournal.QuJournalPiece_Edition.Open;
          DMJournal.QuJournalPiece_Edition.First;

    ListeCpt.Liste:=TStringList.Create;
    ListeCpt.result:=true;
    ListeCpt.Liste.Duplicates:=dupIgnore;
    listecpt:=ChoixCompteAffich('Sélectionnez les pièces...',DMJournal.QuJournalPiece_Edition,['Reference','libelle','DatePiece','Journal'],true);
    if (ListeCpt.Liste<>nil)and(ListeCpt.Result) then
      DMJournal.ListefilterRecordPieces.Assign(ListeCpt.liste);
    end;
    
    if DMJournal.ListefilterRecordPieces<>nil then
      begin
          DMJournal.QuJournalPiece_Edition.Close;
          DMJournal.QuJournalPiece_Edition.SQL.Clear;
          DMJournal.QuJournalPiece_Edition.SQL.Add(' select E.id_piece,E.id_ligne,P.reference,P."Date",E.compte,E.Tiers,E.libelle as LibelleEcriture,');
          DMJournal.QuJournalPiece_Edition.SQL.Add(' E.DebitSaisie,E.creditSaisie,E.Qt1,P.libelle as LibellePiece,E.typeLigne,P.compte as ComptePiece  ');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  from piece P,ecriture E');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  where id_piece=piece.id ');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  and piece."date" between :DateDeb and  :DateFin   ');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  order by Piece.reference,piece."date",id_Piece,id_ligne  ');
          DMJournal.QuJournalPiece_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMJournal.QuJournalPiece_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          //DMJournal.QuJournalPiece_Edition.filtered:=true;
          DMJournal.QuJournalPiece_Edition.Open;
          DMJournal.QuJournalPiece_Edition.First;


          DMJournal.QuJournalPiece_Edition.filtered:=true;
          DMJournal.QuJournalPiece_Edition.OnFilterRecord:=DMJournal.QuJournalPiece_EditionFilterRecord;
//      end;


    if DMJournal.QuJournalPiece_Edition.recordcount<>0 then
      begin
          ListeEdition.Add('Journal;Référence;date;compte;tiers;libellé;débit;crédit;qté');
          //remplir la première ligne de présentation de la pièce
          referencetmp:=DMJournal.QuJournalPiece_Edition.findfield('Reference').AsString;
          journal:=copy(referencetmp,1,2);
          ListeValeur.Add('9; JOURNAL : '+GereLibelle(Infos_TInfosModel(dmrech.TaModelRech,'Journal',[journal]).Libelle_Model));
          ListeValeur.Add('11; '+referencetmp +' ; '+DMJournal.QuJournalPiece_Edition.findfield('Date').AsString+' ;;; '+DMJournal.QuJournalPiece_Edition.findfield('libellePiece').AsString+' ;;; ');
          DateTmp:=DMJournal.QuJournalPiece_Edition.FindField('DAte').AsString;
          reference:=referencetmp;
          date:=datetmp;

          while not DMJournal.QuJournalPiece_Edition.Eof do
            begin
            tiersCompte:=gereLibelle(DMJournal.QuJournalPiece_Edition.FindField('Tiers').AsString);
            tiersCompte:=str_remplacesouschaine_1ereOccurence_avecCasse(tiersCompte,'+','');
            tiersCompte:=DMJournal.QuJournalPiece_Edition.FindField('Compte').AsString+tiersCompte;
              //ensuite passer à un autre mois
                  ListeEdition.Add(Journal+
                                   ';'+
                                   referencetmp+
                                   ';'+
                                   datetmp+
                                   ';'+
                                   tiersCompte+
                                   ';'+
                                   GereLibelle(str_remplacesouschaine_1ereOccurence_avecCasse(DMJournal.QuJournalPiece_Edition.FindField('Tiers').AsString,'+',''))+
                                   ';'+
                                   GereLibelle(DMJournal.QuJournalPiece_Edition.FindField('LibelleEcriture').AsString)+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('DebitSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('CreditSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('Qt1').AsString
                                   );
                  ListeValeur.Add('0'+
                                   ';'+
                                   referencetmp+
                                   ';'+
                                   datetmp+
                                   ';'+
                                   tiersCompte+
                                   ';'+
                                   GereLibelle(str_remplacesouschaine_1ereOccurence_avecCasse(DMJournal.QuJournalPiece_Edition.FindField('Tiers').AsString,'+',''))+
                                   ';'+
                                   GereLibelle(DMJournal.QuJournalPiece_Edition.FindField('LibelleEcriture').AsString)+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('DebitSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('CreditSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('Qt1').AsString
                                   );
                   DMJournal.QuJournalPiece_Edition.Next;

                   reference:='';
                   date:='';
               if referencetmp<>DMJournal.QuJournalPiece_Edition.FindField('Reference').AsString then
                 begin
                    referencetmp:=DMJournal.QuJournalPiece_Edition.findfield('Reference').AsString;
                    if (journal)<>copy(DMJournal.QuJournalPiece_Edition.findfield('Reference').AsString,1,2)then
                      begin
                       journal:=copy(referencetmp,1,2);
                       ListeValeur.Add('9; JOURNAL :'+GereLibelle(Infos_TInfosModel(dmrech.TaModelRech,'Journal',[journal]).Libelle_Model));
                      end;
                    DateTmp:=DMJournal.QuJournalPiece_Edition.FindField('DAte').AsString;
                    reference:=referencetmp;
                    date:=datetmp;
                    ListeValeur.Add('11; '+referencetmp +' ; '+DMJournal.QuJournalPiece_Edition.findfield('Date').AsString+' ;;; '+DMJournal.QuJournalPiece_Edition.findfield('libellePiece').AsString+' ;;; ');
                 end;
            end;//fin du while not QuJournaux_Edition.eof
         ObjPrn.FTitreEdition := 'JOURNAL DES PIECES';
         ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;

         ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
         ListeValeur.Insert(0,' Réf. Pièce ; Date ; Compte ; Tiers ; Désignation ; Débit ; Crédit ; Qté ');
         ListeValeur.Insert(1,'0.8;0.8;0.8;0.8;2;0.8;0.8;0.6');
         ListeValeur.Insert(2,'texte;texte;texte;texte;texte;curr;curr;float');
      end;
      end;//si liste remplie
     case TypeEdition of
       C_Exportation: ExportDonnees(ListeEdition,E.RepertoireExportDossier,'ExportationDesEcritures_'+E.NomDossier + E.NomExo + '.Txt')
     else
       ObjPrn.AffichageImp(ListeValeur);
     end;//fin du case TypeEdition
     //end;//fin du empty journal
  end;//fin du periode.retour
finally
     Initialise_TStringlist(ListeEdition);
     Initialise_TStringlist(ListeValeur);
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;


Function EditionDesPiecesL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:TStringList;DataSet:TDataSet;DateDeb:Tdate;DateFin:TDate):Boolean;
var
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur,ListeEdition:TStringList;
Reference,ReferenceTmp,DateTmp,Date,Journal:string;
ListeCpt:TResultStrList;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
reference:='';
ReferenceTmp:='';
DateTmp:='';
Date:='';
Journal:='';
  if DemandePeriode then
    begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
  else
    begin
     periode.Retour := true;
     if datefin<>0 then
       begin
         periode.DateDeb := DateDeb;
         periode.DateFin := DateFin;
       end
     else
       begin
         periode.DateDeb := E.DatExoDebut;
         periode.DateFin := E.DatExoFin;
       end;
     if e.PeriodeAutreImpression.Retour then
       begin
         periode.DateDeb := e.PeriodeAutreImpression.DateDeb;
         periode.DateFin := e.PeriodeAutreImpression.DateFin;
       end;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    ListeEdition:=TStringList.Create;
    if DMJournal=nil then DMJournal:=TDMJournal.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
    //on branche un filter record sur requete en passant une liste
    DMJournal.ListefilterRecordPieces.clear;
    if Pieces<>nil then      // Tous les Journaux
     begin
      DMJournal.ListefilterRecordPieces.Assign(Pieces);
      DMJournal.QuJournalPiece_Edition.OnFilterRecord:=DMJournal.QuJournalPiece_EditionFilterRecord;
     end
    else
    begin
      DMJournal.QuJournalPiece_Edition.OnFilterRecord:=nil;


          DMJournal.QuJournalPiece_Edition.Close;
          DMJournal.QuJournalPiece_Edition.SQL.Clear;
          DMJournal.QuJournalPiece_Edition.SQL.Add(' select distinct(P.reference),(P."Date")as DatePiece,');
          DMJournal.QuJournalPiece_Edition.SQL.Add(' P.libelle ,P.compte ,Substring(P.reference from 1 for 2)as Journal');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  from piece P');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  where P."date" between :DateDeb and  :DateFin');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  order by P.reference,P."date"');
          DMJournal.QuJournalPiece_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMJournal.QuJournalPiece_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          DMJournal.QuJournalPiece_Edition.Open;
          DMJournal.QuJournalPiece_Edition.First;

    ListeCpt.Liste:=TStringList.Create;
    ListeCpt.result:=true;
    ListeCpt.Liste.Duplicates:=dupIgnore;
    listecpt:=ChoixCompteAffich('Sélectionnez les pièces...',DMJournal.QuJournalPiece_Edition,['Reference','libelle','DatePiece','Journal'],true);
    if (ListeCpt.Liste<>nil)and(ListeCpt.Result) then
      DMJournal.ListefilterRecordPieces.Assign(ListeCpt.liste);
    end;
    
    if DMJournal.ListefilterRecordPieces<>nil then
      begin
          DMJournal.QuJournalPiece_Edition.Close;
          DMJournal.QuJournalPiece_Edition.SQL.Clear;
          DMJournal.QuJournalPiece_Edition.SQL.Add(' select E.id_piece,E.id_ligne,P.reference,P."Date",E.compte,E.Tiers,E.libelle as LibelleEcriture,');
          DMJournal.QuJournalPiece_Edition.SQL.Add(' E.DebitSaisie,E.creditSaisie,E.Qt1,P.libelle as LibellePiece,E.typeLigne,P.compte as ComptePiece  ');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  from piece P,ecriture E');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  where id_piece=piece.id ');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  and piece."date" between :DateDeb and  :DateFin   ');
          DMJournal.QuJournalPiece_Edition.SQL.Add('  order by Piece.reference,piece."date",id_Piece,id_ligne  ');
          DMJournal.QuJournalPiece_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMJournal.QuJournalPiece_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          //DMJournal.QuJournalPiece_Edition.filtered:=true;
          DMJournal.QuJournalPiece_Edition.Open;
          DMJournal.QuJournalPiece_Edition.First;


          DMJournal.QuJournalPiece_Edition.filtered:=true;
          DMJournal.QuJournalPiece_Edition.OnFilterRecord:=DMJournal.QuJournalPiece_EditionFilterRecord;
//      end;


    if DMJournal.QuJournalPiece_Edition.recordcount<>0 then
      begin
          ListeEdition.Add('Journal;Référence;date;compte;tiers;libellé;débit;crédit;qté');
          //remplir la première ligne de présentation de la pièce
          referencetmp:=DMJournal.QuJournalPiece_Edition.findfield('Reference').AsString;
          journal:=copy(referencetmp,1,2);
          ListeValeur.Add('9; JOURNAL : '+GereLibelle(Infos_TInfosModel(dmrech.TaModelRech,'Journal',[journal]).Libelle_Model));
          ListeValeur.Add('11; '+referencetmp +' ; '+DMJournal.QuJournalPiece_Edition.findfield('Date').AsString+' ;;; '+DMJournal.QuJournalPiece_Edition.findfield('libellePiece').AsString+' ;;; ');
          DateTmp:=DMJournal.QuJournalPiece_Edition.FindField('DAte').AsString;
          reference:=referencetmp;
          date:=datetmp;
          while not DMJournal.QuJournalPiece_Edition.Eof do
            begin
              //ensuite passer à un autre mois
                  ListeEdition.Add(Journal+
                                   ';'+
                                   reference+
                                   ';'+
                                   Date+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('Compte').AsString+
                                   ';'+
                                   GereLibelle(DMJournal.QuJournalPiece_Edition.FindField('Tiers').AsString)+
                                   ';'+
                                   GereLibelle(DMJournal.QuJournalPiece_Edition.FindField('LibelleEcriture').AsString)+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('DebitSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('CreditSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('Qt1').AsString
                                   );
                  ListeValeur.Add('0'+
                                   ';'+
                                   reference+
                                   ';'+
                                   Date+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('Compte').AsString+
                                   ';'+
                                   GereLibelle(DMJournal.QuJournalPiece_Edition.FindField('Tiers').AsString)+
                                   ';'+
                                   GereLibelle(DMJournal.QuJournalPiece_Edition.FindField('LibelleEcriture').AsString)+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('DebitSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('CreditSaisie').AsString+
                                   ';'+
                                   DMJournal.QuJournalPiece_Edition.FindField('Qt1').AsString
                                   );
                   DMJournal.QuJournalPiece_Edition.Next;
                   reference:='';
                   date:='';
               if referencetmp<>DMJournal.QuJournalPiece_Edition.FindField('Reference').AsString then
                 begin
                    referencetmp:=DMJournal.QuJournalPiece_Edition.findfield('Reference').AsString;
                    if (journal)<>copy(DMJournal.QuJournalPiece_Edition.findfield('Reference').AsString,1,2)then
                      begin
                       journal:=copy(referencetmp,1,2);
                       ListeValeur.Add('9; JOURNAL :'+GereLibelle(Infos_TInfosModel(dmrech.TaModelRech,'Journal',[journal]).Libelle_Model));
                      end;
                    DateTmp:=DMJournal.QuJournalPiece_Edition.FindField('DAte').AsString;
                    reference:=referencetmp;
                    date:=datetmp;
                    ListeValeur.Add('11; '+referencetmp +' ; '+DMJournal.QuJournalPiece_Edition.findfield('Date').AsString+' ;;; '+DMJournal.QuJournalPiece_Edition.findfield('libellePiece').AsString+' ;;; ');
                 end;
            end;//fin du while not QuJournaux_Edition.eof
         ObjPrn.FTitreEdition := 'JOURNAL DES PIECES';
         ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;

         ObjPrn.FTitre2Edition :='Période du '+DateInfos(Periode.DateDeb).DateStr+' au '+DateInfos(Periode.DateFin).DateStr;
         ListeValeur.Insert(0,' Réf. Pièce ; Date ; Compte ; Tiers ; Désignation ; Débit ; Crédit ; Qté ');
         ListeValeur.Insert(1,'0.8;0.8;0.8;0.8;2;0.8;0.8;0.6');
         ListeValeur.Insert(2,'texte;texte;texte;texte;texte;curr;curr;float');
      end;
      end;//si liste remplie
     case TypeEdition of
       C_Exportation: ExportDonnees(ListeEdition,E.RepertoireExportDossier,'JournalDesPieces_'+E.NomDossier + E.NomExo + '.Txt')
     else
       ObjPrn.AffichageImp(ListeValeur);
     end;//fin du case TypeEdition
     //end;//fin du empty journal
  end;//fin du periode.retour
finally
     Initialise_TStringlist(ListeEdition);
     Initialise_TStringlist(ListeValeur);
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;

Function EditionDesJournauxL(TypeEdition : integer; DemandePeriode:Boolean; Journal:string;DataSet:TDataSet;Synthese : boolean = false):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (journal)then
     Maliste.Add(journal)
   else
     raise ExceptLGR.Create('Aucun journal n''est defini !',1000,true,mtError,Retour);
   EditionDesJournauxL(TypeEdition,DemandePeriode,Maliste,DataSet,Synthese);
  except
     abort;
  end;
end;

Function EditionDesPiecesL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:string;DataSet:TDataSet;DateDeb:Tdate;DateFin:TDate):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (Pieces)then
     Maliste.Add(Pieces)
   else
     raise ExceptLGR.Create('Aucune Piece n''est definie !',1000,true,mtError,Retour);
   EditionDesPiecesL(TypeEdition,DemandePeriode,Maliste,DataSet,dateDeb,DateFin);
  except
     abort;
  end;
end;

Function EditionDesEcrituresL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:string;DataSet:TDataSet;DateDeb:Tdate;DateFin:TDate):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (Pieces)then
     Maliste.Add(Pieces)
   else
     raise ExceptLGR.Create('Aucune Piece n''est definie !',1000,true,mtError,Retour);
   EditionDesEcrituresL(TypeEdition,DemandePeriode,Maliste,DataSet,dateDeb,DateFin);
  except
     abort;
  end;
end;

procedure TDMJournal.QuCode_EditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=ListeFilterRecordJournaux.IndexOf(DataSet.FindField('Journal').AsString) <> -1;
  end;
end;

procedure TDMJournal.QuJournalPiece_EditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=ListefilterRecordPieces.IndexOf(DataSet.FindField('Reference').AsString) <> -1;
  end;
end;



Function EditionDesRemisesL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:TStringList;DataSet:TDataSet):Boolean;
var
periode:TPeriode;
ParamAffichPeriode:TParamAffichPeriode;
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
Reference,ReferenceTmp,Libellecompte,Tiers,nomTiers:string;
Debit,Credit,Total:currency;
compteur:integer;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
compteur:=0;
reference:='';
ReferenceTmp:='';
Tiers:='';
Debit:=0;
Credit:=0;
  if DemandePeriode then
    begin
      Initialise_ParamAffichPeriode(ParamAffichPeriode);
      periode:=ChoixPeriodeAffich(e.DatExoDebut,e.DatExoFin,'',ParamAffichPeriode);
    end
  else
    begin
     periode.Retour := true;
     periode.DateDeb := E.DatExoDebut;
     periode.DateFin := E.DatExoFin;
     if e.PeriodeAutreImpression.Retour then
       begin
         periode.DateDeb := e.PeriodeAutreImpression.DateDeb;
         periode.DateFin := e.PeriodeAutreImpression.DateFin;
       end;
    end;
  if periode.Retour then
   begin

    ObjPrn.FontLigneSeule.Style := [fsBold];
    ListeValeur:=TStringList.Create;
    if DMJournal=nil then DMJournal:=TDMJournal.Create(Application.MainForm);
    if DMPlan=nil then DMPlan:=TDMPlan.Create(application.MainForm);
    if DMTiers=nil then DMTiers:=TDMTiers.Create(application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
    //on branche un filter record sur requete en passant une liste
    DMJournal.ListefilterRecordPieces.clear;
    if Pieces<>nil then      // Tous les Journaux
     begin
      DMJournal.ListefilterRecordPieces.Assign(Pieces);
      DMJournal.QuJournalPiece_Edition.OnFilterRecord:=DMJournal.QuJournalPiece_EditionFilterRecord;
     end
    else
      DMJournal.QuJournalPiece_Edition.OnFilterRecord:=nil;

          DMJournal.QuJournalPiece_Edition.Close;
          DMJournal.QuJournalPiece_Edition.ParamByName('DateDeb').AsDate := Periode.DateDeb;
          DMJournal.QuJournalPiece_Edition.ParamByName('DateFin').AsDate := Periode.DateFin;
          DMJournal.QuJournalPiece_Edition.filtered:=true;
          DMJournal.QuJournalPiece_Edition.Open;
          DMJournal.QuJournalPiece_Edition.First;

    if DMJournal.QuJournalPiece_Edition.recordcount<>0 then
      begin
          //remplir la première ligne de présentation de la pièce
          referencetmp:=DMJournal.QuJournalPiece_Edition.findfield('Reference').AsString;
          reference:=referencetmp;
          Libellecompte:=DMJournal.InfosJournal_Reference(reference).Libelle_Model;
          if empty(Libellecompte) then
            Libellecompte:=DMPlan.LibelleDuNumCptPCU(DMJournal.QuJournalPiece_Edition.findfield('ComptePiece').AsString);
          while not DMJournal.QuJournalPiece_Edition.Eof do
            begin //typeLigne
              if DMJournal.QuJournalPiece_Edition.findfield('typeLigne').AsString<>'X' then
                begin
                    Debit:=DMJournal.QuJournalPiece_Edition.FindField('DebitSaisie').Ascurrency;
                    Credit:=DMJournal.QuJournalPiece_Edition.FindField('CreditSaisie').Ascurrency;
                    Tiers:=DMJournal.QuJournalPiece_Edition.FindField('Tiers').AsString;
                    nomTiers:=dmtiers.LibelleDuTiers(Tiers);
                    if empty(tiers) then tiers:=DMJournal.QuJournalPiece_Edition.FindField('compte').AsString;
                    //ensuite passer à un autre mois
                        ListeValeur.Add('0'+
                                         ';'+
                                         GereLibelle(Tiers)+
                                         ';'+
                                         GereLibelle(nomTiers)+
                                         ';'+
                                         GereLibelle(DMJournal.QuJournalPiece_Edition.FindField('LibelleEcriture').AsString)+
                                         ';'+
                                         currtostr(Credit-Debit)
                                         );
               inc(compteur);
               Total:=Total+(Credit-Debit);
               end;
             DMJournal.QuJournalPiece_Edition.Next;
             reference:='';
               if referencetmp<>DMJournal.QuJournalPiece_Edition.FindField('Reference').AsString then
                 begin
                    referencetmp:=DMJournal.QuJournalPiece_Edition.findfield('Reference').AsString;
                    reference:=referencetmp;
                    Libellecompte:=DMJournal.InfosJournal_Reference(reference).Libelle_Model;
                    if empty(Libellecompte) then
                      Libellecompte:=DMPlan.LibelleDuNumCptPCU(DMJournal.QuJournalPiece_Edition.findfield('ComptePiece').AsString);
                 end;
            end;//fin du while not QuJournaux_Edition.eof
         ListeValeur.Add('1;;@Nombre de lignes (chèques) :   '+inttostr(compteur)+' ;Total de la Remise : ; '+currtostr(Total));
         ObjPrn.FTitreEdition := 'REMISES DE CHEQUES';
         ObjPrn.FSousTitreEdition:=StringVideCentsCaractere+'Du : '+DMJournal.QuJournalPiece_Edition.findfield('Date').AsString;
//         ObjPrn.FNomDossier :=E.NomDossier;
         ObjPrn.FNomDossier :='Raison sociale :   '+E.RaisonSociale;
         ObjPrn.FTitre2Edition :='Remise de chèque N° :   '+referencetmp+' - '+DMJournal.QuJournalPiece_Edition.findfield('LibellePiece').AsString; ;
         ObjPrn.FTitre3Edition :='Sur le compte :   '+Libellecompte;
         ListeValeur.Insert(0,' Tiers ; Nom du tiers ; Désignation de la ligne ; Montant ');
         ListeValeur.Insert(1,'0.8;2.0;3.8;1.0');
         ListeValeur.Insert(2,'texte;texte;texte;curr');
      end;
     ObjPrn.AffichageImp(ListeValeur);
     //end;//fin du empty journal
  end;//fin du periode.retour
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;  
end;
Function EditionDesRemisesL(TypeEdition : integer; DemandePeriode:Boolean; Pieces:string;DataSet:TDataSet):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (Pieces)then
     Maliste.Add(Pieces)
   else
     raise ExceptLGR.Create('Aucune Piece n''est definie !',1000,true,mtError,Retour);
   EditionDesRemisesL(TypeEdition,DemandePeriode,Maliste,DataSet);
  except
     abort;
  end;
end;


procedure TDMJournal.TaJournalAfterPost(DataSet: TDataSet);
begin
ReadOnlyChamps(dataset,false);
end;


Function EditionDesTrames(TypeEdition : integer; DemandePeriode:Boolean; Trame:TStringList;DataSet:TDataSet):Boolean;
var
i:integer;
ObjPrn:TObjetEdition;
ListeValeur:TStringList;
code,codetmp:string;
begin
try//finally
    ObjPrn:=TObjetEdition.Create(application.MainForm);
    ObjPrn.FontLigneSeule.Style := [fsBold];
    code:='';
    codetmp:='';
    ListeValeur:=TStringList.Create;
    if DMJournal=nil then DMJournal:=TDMJournal.Create(Application.MainForm);
    if dataset = nil then
      begin
        // Prevu pour passer le dataset concerné
      end;
    //on branche un filter record sur requete en passant une liste
    DMJournal.ListefilterRecordTrame.clear;
    if Trame<>nil then      // Tous les Journaux
     begin
      DMJournal.ListefilterRecordTrame.Assign(Trame);
      DMJournal.QuTrame_Edition.OnFilterRecord:=DMJournal.QuTrame_EditionFilterRecord;
     end
    else
      DMJournal.QuTrame_Edition.OnFilterRecord:=nil;

          DMJournal.QuTrame_Edition.Close;
          DMJournal.QuTrame_Edition.filtered:=true;
          DMJournal.QuTrame_Edition.Open;
          DMJournal.QuTrame_Edition.First;

    if DMJournal.QuTrame_Edition.recordcount<>0 then
      begin
      begin
          //remplir la première ligne de présentation de la pièce
          codetmp:=DMJournal.QuTrame_Edition.findfield('code').AsString;
          //ListeValeur.Add('9; Trame : '+codeTmp+' - '+DMJournal.QuTrame_Edition.findfield('Libelle_Trame').AsString);
          ListeValeur.Add('11; '+GereLibelle(codeTmp) +' ;; '+GereLibelle(DMJournal.QuTrame_Edition.findfield('Libelle_Trame').AsString)+' ;;;;; ');
          code:=codetmp;
          while not DMJournal.QuTrame_Edition.Eof do
            begin
                  ListeValeur.Add('0'+
                                   ';'+
                                   ''+
                                   ';'+
                                   DMJournal.QuTrame_Edition.FindField('Compte').AsString+
                                   ';'+
                                   GereLibelle(DMJournal.QuTrame_Edition.FindField('LibelleEcriture').AsString)+
                                   ';'+
                                   DMJournal.QuTrame_Edition.FindField('MontantDebit').AsString+
                                   ';'+
                                   DMJournal.QuTrame_Edition.FindField('MontantCredit').AsString+
                                   ';'+
                                   DMJournal.QuTrame_Edition.FindField('Qt1').AsString+
                                   ';'+
                                   DMJournal.QuTrame_Edition.FindField('TvaCode').AsString+
                                   ';'+
                                   DMJournal.QuTrame_Edition.FindField('TvaType').AsString
                                   );
                   DMJournal.QuTrame_Edition.Next;
                   code:='';
               if codetmp<>DMJournal.QuTrame_Edition.FindField('code').AsString then
                 begin
                    codetmp:=DMJournal.QuTrame_Edition.findfield('code').AsString;
                    code:=codetmp;
                    //ListeValeur.Add('9; Trame : '+codeTmp+' - '+DMJournal.QuTrame_Edition.findfield('Libelle_Trame').AsString);
                    ListeValeur.Add('11; '+GereLibelle(codeTmp) +' ;; '+GereLibelle(DMJournal.QuTrame_Edition.findfield('Libelle_Trame').AsString)+' ;;;;; ');
                 end;
            end;//fin du while not QuJournaux_Edition.eof
         ObjPrn.FTitreEdition := 'JOURNAL DES TRAMES';
         ObjPrn.FNomDossier :='Dossier : '+E.NomDossier +' - ' +e.RaisonSociale;

         ListeValeur.Insert(0,' Code trame; Compte ; Désignation ; Débit ; Crédit ; Qté ; Code tva; type tva');
         ListeValeur.Insert(1,'0.8;0.8;2;0.8;0.8;0.6;0.6;0.6');
         ListeValeur.Insert(2,'texte;texte;texte;curr;curr;float;texte;texte');
      end;
    end;
     ObjPrn.AffichageImp(ListeValeur);
finally
     LibereObjet(Tobject(ObjPrn));
//   ObjPrn.destroy;
end;
end;



Function EditionDesTrames(TypeEdition : integer; DemandePeriode:Boolean; Trame:String;DataSet:TDataSet):Boolean;
var
Maliste:Tstringlist;
Retour:TExceptLGR;
begin
  try
   Maliste:=TStringList.Create;
   if not empty (Trame)then
     Maliste.Add(Trame)
   else
     raise ExceptLGR.Create('Aucune Trame n''est definie !',1000,true,mtError,Retour);
   EditionDesTrames(TypeEdition,DemandePeriode,Maliste,DataSet);
  except
     abort;
  end;
end;


procedure TDMJournal.QuTrame_EditionFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
  begin
    accept:=ListefilterRecordTrame.IndexOf(DataSet.FindField('code').AsString) <> -1;
  end;
end;


function TDMJournal.LibelleDuJournal(journal:string):string;
begin
  result:='';
  DeFiltrageDataSet(DMRech.TaModelRech);
  result:=Infos_TInfosModel(dmrech.TaModelRech,'Journal',[journal]).Libelle_Model;
end;


function TDMJournal.CompteDuJournal(journal:string):string;
begin
  result:='';
  DeFiltrageDataSet(DMRech.TaModelRech);
  result:=Infos_TInfosModel(dmrech.TaModelRech,'Journal',[journal]).Compte;
end;

function TDMJournal.JournalDuCompte(compte:string):string;
begin
  result:='';
  DeFiltrageDataSet(DMRech.TaModelRech);
  result:=Infos_TInfosModel(dmrech.TaModelRech,'compte',[compte]).Journal;
end;

end.
