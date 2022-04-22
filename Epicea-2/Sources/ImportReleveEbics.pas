unit ImportReleveEbics;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RXCtrls, jpeg, ExtCtrls, StdCtrls, ToolEdit, Mask, xmldom,
  XMLIntf, oxmldom, XMLDoc, Grids, GrGrid,WinShellFolder, ComCtrls,
  E2_Decl_Records, Menus, ShellAPI;

type



  TypeAFB_Ecriture= record
     CodeEnregistrement:string[2];
     CodeBanque:string[5];
     CodeOperation:string[4];
     CodeGuichet:string[5];
     CodeDevises:string[3];
     NombreDecimales:string[1];
     IndiceSIT:string[1];
     Compte:string[11];
     CodeOperationInterbancaire:string[2];
     DateEcriture:string[6];
     CodeRejet:string[2];
     DateValeur:string[6];
     Libelle:string;
     ZoneReservee1:string[2];
     NumEcriture:string[7];
     CodeExoneration:string[1];
     ZoneReservee2:string[1];
     Montant:string[14];
     RefEcriture:string[16];                  
  end;

    TypeAFB_Complement= record
     CodeEnregistrement:string[2];
     CodeBanque:string[5];
     CodeOperation:string[4];
     CodeGuichet:string[5];
     ZoneReservee1:string[5];
     Compte:string[11];
     CodeOperationInterbancaire:string[2];
     DateEcriture:string[6];
     LibelleComplement:string;
     NumEcriture:string[7];
     ZoneReservee2:string[2];
     MontantDu04:string[14];
     ZoneReservee3:string[16];
  end;

  TImportationReleveEbics = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    Panel1: TPanel;
    PaBtn: TPanel;
    Panel2: TPanel;
    BtnCharger: TButton;
    Panel3: TPanel;
    PaEcritures: TPanel;
    PaCptIntit: TPanel;
    Panel5: TPanel;
    Panel11: TPanel;
    Panel9: TPanel;
    PaSoldeCompte: TPanel;
    GrSoldeCompte: TGrGrid;
    LVReleve: TListView;
    PaBtnRefus: TPanel;
    BtnTTDecocher: TButton;
    BtnTTCocher: TButton;
    BtnDoublon: TButton;
    PaBtnSupp: TPanel;
    Panel7: TPanel;
    PaMouvCompte: TPanel;
    GrMouvCompte: TGrGrid;
    Label4: TLabel;
    Panel4: TPanel;
    PaSoldeReleve: TPanel;
    GrSoldeReleve: TGrGrid;
    Panel12: TPanel;
    PaMouvReleve: TPanel;
    GrMouvReleve: TGrGrid;
    BtnGestionCompte: TButton;
    RxLabel1: TRxLabel;
    BtnEnregistrer: TButton;
    BtnAnnuler: TButton;
    EdDateDebutReleve: TDateEdit;
    Label9: TLabel;
    EdDateFinReleve: TDateEdit;
    Label1: TLabel;
    Label6: TLabel;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Modifier1: TMenuItem;
    Insrer1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    BtnCreerReglement: TButton;
    chDejaReleve: TCheckBox;
    MemoComplement: TMemo;
    cbCompteBancaire: TComboBox;
    cbDejaImporte: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnChargerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure initGrReleve;
    procedure PaEcrituresResize(Sender: TObject);
    procedure InitLisViewAvecListe(TabTitreColonne:array of string;ListeValeur:TStringList);
    procedure CocheDecocheListe(cocheDecoche:boolean;GestionDoublon:boolean=false);
    procedure DecocheDoublon;
    procedure Panel3Resize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure LVReleveSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure BtnTTCocherClick(Sender: TObject);
    procedure BtnTTDecocherClick(Sender: TObject);
    procedure BtnDoublonClick(Sender: TObject);
    procedure BtnGestionCompteClick(Sender: TObject);
    procedure FichierImportAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure initTotaux;
    procedure LVReleveChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure EdBanqueKeyPress(Sender: TObject; var Key: Char);
    procedure EdBanqueExit(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure EdBanqueChange(Sender: TObject);
    procedure changementEtatBoutons();
    procedure BtnCreerReglementClick(Sender: TObject);
    function verifSortie():boolean;
    procedure verifCompte(Sender: TObject);
    procedure essai_json;
    function RecupereToutesLesEcrituresServeur():boolean;
    procedure cbCompteBancaireChange(Sender: TObject);
    procedure LVReleveColumnClick(Sender: TObject; Column: TListColumn);
    procedure GestionDesColumnsRapprochement(Columns:TListColumns;Column:TListColumn);
    procedure cbCompteBancaireSelect(Sender: TObject);
    procedure LVReleveCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);


  private
    { Déclarations privées }
  public
    { Déclarations publiques }
       lignesReleves:TStringlist;
        TabStr,TabCurr,TabDate : set of Byte;
   end;
   // Déclaration statique de la DLL
   //function Execute(ebics:TClasseMere):TList; stdcall; external 'ebics.dll';
   procedure Execute(login,pwd,banque,guichet,compte:AnsiString); stdcall; external 'ebics.dll';
//procedure Execute(); stdcall; external 'ebics.dll';
   //procedure Execute(params:TStringList); stdcall; external 'ebics.dll';
var
  ImportationReleveEbics: TImportationReleveEbics;
  retourCompte:retourCompteBancaire;
  typeRapprochement:TtypeRapprochement;
  OrdreTriRapprochement,OrdreTriReleve:integer;
  procedure ChargeFichierOFX(FileName:string);
  procedure ChargeFichierAFB(FileName:string);
  function GestionCodeSensOperationAFB(Montant:string):string;
  function GestionDateOperationAFB(Date:string):string;
  procedure ChargeOperationDansInterval(DateDebut,DateFin:Tdate;banque,guichet,compte:string);
implementation

uses lib_chaine, DmImportReleves, Lib1, E2_Main, LibZoneSaisie,
  E2_Librairie_Obj, LibDates, E2_LibInfosTable, ComptesBancaires,
  Gr_Librairie_Obj, LibGestionParamXML, DMConstantes, LibFichRep, DB,
  LibSQL, DMJournaux, InputQueryFrm_F, CreationReglementReleve, 
  DateUtils, uLkJSON, E2_GestionSauvegarde, DMRecherche, rbeSoap;

{$R *.dfm}



procedure TImportationReleveEbics.FormCreate(Sender: TObject);
begin
if(DMImportReleve=nil)then DMImportReleve:=TDMImportReleve.Create(Application.MainForm);
   lignesReleves:=TStringlist.Create;
  try
    LibGestionParamXML.InitialiseForm(E.User,Self);
  except
    InitialiseFormPosDefaut(self);
  end;


end;

procedure TImportationReleveEbics.FormDestroy(Sender: TObject);
begin
   initialise_tstringlist(lignesReleves,self);
  if DMImportReleve <> nil then
    DMImportReleve.Destroy;
     LibGestionParamXML.DestroyForm(Self,E.USer);
   ImportationReleveEbics:=nil;
end;

//procedure TImportationReleveEbics.BtnChargerClick(Sender: TObject);
//var
//compte,guichet,banque:string;
////RbeSoap:RbeSoapPortType;
//username,pwd,codeBanque,codeGuichet,numCompte:string;
//datedeb,datefin:string;
//dejaReleve:boolean;
//reponse:ArrayOfEntete;
//entete1:Entete;
//mouvement1:Mouvement;
//complement1:Complement;
//i,j,k:integer;
////liste:TList;
//listeSave:Tstringlist;
//paramEbics:TClasseMere;
//id,idComplement:integer;
//chaine,idEnteteServeur,idMouvServeur,chemin:string;
//cheminFichier:string;
//begin
//try//finally
//cheminFichier:='C:\LGRDOSS\listeMouvement.csv';
////RbeSoap:=GetRbeSoapPortType();
//
//
////dejaReleve:=true;
////username:='prtf6xf9q34cg4oswos44os0oswk8sg';
////pwd:='5jpcn0mq4s8wwo4kog0k0skswsgwosg';
////codeBanque:='13306';
////codeGuichet:='00918';
////numCompte:='54300152368';
//
//datedeb:=DateToStr(EdDateDebutReleve.date);
//datefin:=DateToStr(EdDateFinReleve.date);
//datedeb:=Str_String_To_DateString(datedeb,4);
//datefin:=Str_String_To_DateString(datefin,4);
//dejaReleve:=true;
//
//
//username:=retourCompte.login;
//pwd:=retourCompte.password;
//codeBanque:=str_getstringelement(retourCompte.compte,1,'-');
//codeGuichet:=str_getstringelement(retourCompte.compte,2,'-');
//numCompte:=str_getstringelement(retourCompte.compte,3,'-');
//
//chaine:=username+' '+pwd+' '+codeBanque+' '+codeGuichet+' '+numCompte+' '+datedeb+' '+datefin+' '+'true';
//listeSave:=TStringList.Create();
//
////paramEbics:=TClasseMere.Create;
////paramEbics.login:=username;
////paramEbics.pwd:=pwd;
////paramEbics.banque:=codeBanque;
////paramEbics.guichet:=codeGuichet;
////paramEbics.compte:=numCompte;
////paramEbics.dateDeb:=datedeb;
////paramEbics.datefin:=datefin;
////paramEbics.dejaReleve:=true;
//
////liste:=TList.Create;
////liste:=Execute2();
////listeSave.Add(username);
////listeSave.Add(pwd);
////listeSave.Add(codeBanque);
////listeSave.Add(codeGuichet);
////listeSave.Add(numCompte);
////listeSave.Add(datedeb);
////listeSave.Add(datefin);
////listeSave.SaveToFile('C:\LGRDOSS\listeParams.csv');
////showmessage('save');
////chaine:=pchar(username+';;'+pwd+';;'+codeBanque+';;'+codeGuichet+';;'+numCompte+';;'+datedeb+';;'+datefin+';;'+'true');
////                    retourShell:=ShellExecuteAndWait(Application.Handle,'','envoi_ftp.exe',PChar('"'+e.ParamFTP.Fichier+'" ga'),
////                           PChar(ExcludeTrailingPathDelimiter(e.RepertoireProgram)),SW_SHOWNORMAL,INFINITE);
//
//if(ShellExecuteAndWait(handle,'','ws_ebics.exe',PChar(chaine),PChar(ExcludeTrailingPathDelimiter(e.RepertoireProgram)),SW_SHOW,INFINITE))= NO_ERROR then
//begin
//
//
////Execute(Pchar('prtf6xf9q34cg4oswos44os0oswk8sg'),PChar('5jpcn0mq4s8wwo4kog0k0skswsgwosg'),PChar('13306'),PChar('00918'),PChar('54300152368'));
////Execute();
////Execute(listeSave);
////liste:=Execute(paramEbics);
////showmessage('ok ');
//listeSave.Clear;
//listeSave.LoadFromFile(cheminFichier);
//
//
////essai_json;
////reponse:=RbeSoap.listRelevesBancaires(username,pwd,codeBanque,codeGuichet,numCompte,datedeb,datefin,dejaReleve);
////for i := Low(reponse) to High(reponse) do
////begin
////  entete1:=reponse[i];
////  inc(j);
////end;
//
//
//
////banque:=str_getstringelement(EdBanque.Text,1,'-');
////guichet:=str_getstringelement(EdBanque.Text,2,'-');
////compte:=str_getstringelement(EdBanque.Text,3,'-');
////// charger à partir du web service toutes les opérations depuis dernière connexion
//////ensuite remplir la table Ebics
//DMImportReleve.TaReleveEbics.close;
//DMImportReleve.TaReleveEbics.Open;
//DMImportReleve.TaComplementEbics.close;
//DMImportReleve.TaComplementEbics.Open;
//
////ShowMessage(IntToStr(liste.Count));
//
//for i:=0 to listeSave.Count-1 do
//begin
//   entete1:=entete.Create;
//   mouvement1:=Mouvement.Create;
//
//   chaine:=listeSave.Strings[i];
//   if(str_getstringelement(chaine,1,';')='4')then
//   begin
////          chaine:='code'; 1
////          chaine:=chaine+';idEnteteServeur'; 2
////          chaine:=chaine+';idMouvServeur'; 3
////          chaine:=chaine+';codeBanque'; 4
////          chaine:=chaine+';codeOperationInterne'; 5
////          chaine:=chaine+';codeGuichet'; 6
////          chaine:=chaine+';codeDevise'; 7
////          chaine:=chaine+';numeroCompte';  8
////          chaine:=chaine+';codeOperationInterbancaire'; 9
////          chaine:=chaine+';dateCompta';  10
////          chaine:=chaine+';dateValeur';   11
////          chaine:=chaine+';libelle';       12
////          chaine:=chaine+';numeroEcriture';  13
////          chaine:=chaine+';montantMouvement';    14
////          chaine:=chaine+';zoneReference';    15
////          listeSave.Add(chaine);
//          id:=MaxId_Query(DMImportReleve.TaReleveEbics_maxID,'Id');
//
//          TableGereInsert(DMImportReleve.TaReleveEbics);
//          DMImportReleve.TaReleveEbics.FindField('id').AsInteger:=id;
//          DMImportReleve.TaReleveEbics.FindField('idEnteteServeur').AsString:=str_getstringelement(chaine,2,';');
//           idEnteteServeur:=DMImportReleve.TaReleveEbics.FindField('idEnteteServeur').AsString;
//          DMImportReleve.TaReleveEbics.FindField('idMouvServeur').AsString:=str_getstringelement(chaine,3,';');
//           idMouvServeur:=DMImportReleve.TaReleveEbics.FindField('idMouvServeur').AsString;
//          DMImportReleve.TaReleveEbics.FindField('code_enreg').AsString:=str_getstringelement(chaine,1,';');
//          DMImportReleve.TaReleveEbics.FindField('code_banque').AsString:=str_getstringelement(chaine,4,';');
//          DMImportReleve.TaReleveEbics.FindField('code_op_interne').AsString:=str_getstringelement(chaine,5,';');
//          DMImportReleve.TaReleveEbics.FindField('code_guichet').AsString:=str_getstringelement(chaine,6,';');
//          DMImportReleve.TaReleveEbics.FindField('devise').AsString:=str_getstringelement(chaine,7,';');
//          DMImportReleve.TaReleveEbics.FindField('nb_decimal').AsInteger:=2;
//          DMImportReleve.TaReleveEbics.FindField('compte_banque').AsString:=str_getstringelement(chaine,8,';');
//          DMImportReleve.TaReleveEbics.FindField('code_op_bancaire').AsString:=str_getstringelement(chaine,9,';');
//          DMImportReleve.TaReleveEbics.FindField('date_compta').AsString:=Str_String_To_DateString(str_getstringelement(chaine,10,';'),3);
//          DMImportReleve.TaReleveEbics.FindField('date_valeur').AsString:=Str_String_To_DateString(str_getstringelement(chaine,11,';'),3);
//          DMImportReleve.TaReleveEbics.FindField('libelle').AsString:=str_getstringelement(chaine,12,';');
//          DMImportReleve.TaReleveEbics.FindField('num_Ecriture').AsString:=str_getstringelement(chaine,13,';');
//          DMImportReleve.TaReleveEbics.FindField('montant').AsCurrency:=StrToCurr_Lgr(str_getstringelement(chaine,14,';'));
//          DMImportReleve.TaReleveEbics.FindField('reference').AsString:=DMImportReleve.TaReleveEbics.FindField('idEnteteServeur').AsString+'-'+
//            DMImportReleve.TaReleveEbics.FindField('idMouvServeur').AsString+'-'+str_getstringelement(chaine,15,';');
//          DMImportReleve.TaReleveEbics.FindField('traite').AsBoolean:=false;
//          TableGerePost(DMImportReleve.TaReleveEbics);
//
//   end;
//    if(str_getstringelement(chaine,1,';')='5')then
//   begin
////          chaine:='code'; 1
////          chaine:=chaine+';idEnteteServeur'; 2
////          chaine:=chaine+';idMouvServeur'; 3
////          chaine:=chaine+';idComplServeur'; 4
////          chaine:=chaine+';codeBanque';   5
////          chaine:=chaine+';codeOperationInterne';  6
////          chaine:=chaine+';codeGuichet';  7
////          chaine:=chaine+';codeDevise';  8
////          chaine:=chaine+';numeroCompte'; 9
////          chaine:=chaine+';codeOperationInterbancaire'; 10
////          chaine:=chaine+';dateCompta'; 11
////          chaine:=chaine+';qualifiant';  12
////          chaine:=chaine+';infosComplement'; 13
//
//          idComplement:=MaxId_Query(DMImportReleve.TaComplementEbics_maxID,'Id');
//          TableGereInsert(DMImportReleve.TaComplementEbics);
//          DMImportReleve.TaComplementEbics.FindField('id').AsInteger:=idComplement;
//            DMImportReleve.TaComplementEbics.FindField('idEnteteServeur').AsString:=idEnteteServeur;
//            DMImportReleve.TaComplementEbics.FindField('idMouvServeur').AsString:=idMouvServeur;
//            DMImportReleve.TaComplementEbics.FindField('idComplServeur').AsString:=str_getstringelement(chaine,4,';');
//          DMImportReleve.TaComplementEbics.FindField('id_mouv').AsInteger:=id;
//          DMImportReleve.TaComplementEbics.FindField('code_enreg').AsString:='5';
//          DMImportReleve.TaComplementEbics.FindField('code_banque').AsString:=str_getstringelement(chaine,5,';');
//          DMImportReleve.TaComplementEbics.FindField('code_op_interne').AsString:=str_getstringelement(chaine,6,';');
//          DMImportReleve.TaComplementEbics.FindField('code_guichet').AsString:=str_getstringelement(chaine,7,';');
//          DMImportReleve.TaComplementEbics.FindField('devise').AsString:=str_getstringelement(chaine,8,';');
//          DMImportReleve.TaComplementEbics.FindField('nb_decimal').AsInteger:=2;
//          DMImportReleve.TaComplementEbics.FindField('compte_banque').AsString:=str_getstringelement(chaine,9,';');
//          DMImportReleve.TaComplementEbics.FindField('code_op_bancaire').AsString:=str_getstringelement(chaine,10,';');
//          DMImportReleve.TaComplementEbics.FindField('date_compta').AsString:=Str_String_To_DateString(str_getstringelement(chaine,11,';'),3);
//          DMImportReleve.TaComplementEbics.FindField('type_compl').AsString:=str_getstringelement(chaine,12,';');
//          DMImportReleve.TaComplementEbics.FindField('complement').AsString:=str_getstringelement(chaine,13,';');
//
//            TableGerePost(DMImportReleve.TaComplementEbics);
//   end;
//
//end;
//end;
////for i:=0 to liste.Count-1 do
////begin
////   //enregistrer dans la table tous les mouvements
////   //remplir la table Ebics
////   entete1:=liste.Items[i];
////   if(entete1.mouvements<>nil)and(High(entete1.mouvements)>0)then
////   begin
////   //if(i=0)then showmessage('mouvement1 : '+inttostr(High(entete1.mouvements)));
////   for j:=0 to High(entete1.mouvements)do
////   begin
////   mouvement1:=entete1.mouvements[j];
////
////          TableGereInsert(DMImportReleve.TaReleveEbics);
////          id:=MaxId_Query(DMImportReleve.TaReleveEbics_maxID,'Id');
////          DMImportReleve.TaReleveEbics.FindField('id').AsInteger:=id;
////            DMImportReleve.TaReleveEbics.FindField('idEnteteServeur').AsInteger:=entete1.id;
////            DMImportReleve.TaReleveEbics.FindField('idMouvServeur').AsInteger:=mouvement1.id;
////          DMImportReleve.TaReleveEbics.FindField('code_enreg').AsString:='4';
////          DMImportReleve.TaReleveEbics.FindField('code_banque').AsString:=entete1.codeBanque;
////          DMImportReleve.TaReleveEbics.FindField('code_op_interne').AsString:=mouvement1.codeOperationInterne;
////          DMImportReleve.TaReleveEbics.FindField('code_guichet').AsString:=entete1.codeGuichet;
////          DMImportReleve.TaReleveEbics.FindField('devise').AsString:=entete1.codeDevise;
////          DMImportReleve.TaReleveEbics.FindField('nb_decimal').AsInteger:=2;
////          DMImportReleve.TaReleveEbics.FindField('compte_banque').AsString:=entete1.numeroCompte;
////          DMImportReleve.TaReleveEbics.FindField('code_op_bancaire').AsString:=mouvement1.codeOperationInterbancaire;
////          DMImportReleve.TaReleveEbics.FindField('date_compta').AsDateTime:=StrToDate1(mouvement1.dateComptabilisationOperation);
////          DMImportReleve.TaReleveEbics.FindField('date_valeur').AsDateTime:=StrToDate1(mouvement1.dateValeur);
////          DMImportReleve.TaReleveEbics.FindField('libelle').AsString:=mouvement1.libelle;
////          DMImportReleve.TaReleveEbics.FindField('num_Ecriture').AsString:=IntToStr_Lgr(mouvement1.numeroEcriture);
////          DMImportReleve.TaReleveEbics.FindField('montant').AsCurrency:=mouvement1.montantMouvement;
////          DMImportReleve.TaReleveEbics.FindField('reference').AsString:=DMImportReleve.TaReleveEbics.FindField('idEnteteServeur').AsString+'-'+
////            DMImportReleve.TaReleveEbics.FindField('idMouvServeur').AsString+'-'+mouvement1.zoneReference;
////          DMImportReleve.TaReleveEbics.FindField('traite').AsBoolean:=false;
////
////         if(i=0)then showmessage(entete1.codeBanque);
////          TableGerePost(DMImportReleve.TaReleveEbics);
////   //if(j=0)then showmessage('complement1 : '+inttostr(high(mouvement1.complements)));
////
//////         for k:=0 to  high(mouvement1.complements)do
//////         begin
//////            complement1:= mouvement1.complements[k];
//////            TableGereInsert(DMImportReleve.TaComplementEbics);
//////            idComplement:=MaxId_Query(DMImportReleve.TaComplementEbics,'Id');
//////            DMImportReleve.TaComplementEbics.FindField('id').AsInteger:=idComplement;
//////            DMImportReleve.TaComplementEbics.FindField('id_mouv').AsInteger:=id;
//////          DMImportReleve.TaReleveEbics.FindField('code_enreg').AsString:='5';
//////          DMImportReleve.TaReleveEbics.FindField('code_banque').AsString:=entete1.codeBanque;
//////          DMImportReleve.TaReleveEbics.FindField('code_op_interne').AsString:=complement1.codeOperationInterbancaire;
//////          DMImportReleve.TaReleveEbics.FindField('code_guichet').AsString:=entete1.codeGuichet;
//////          DMImportReleve.TaReleveEbics.FindField('devise').AsString:=entete1.codeDevise;
//////          //DMImportReleve.TaReleveEbics.FindField('nb_decimal').AsInteger:=mouvement1.;
//////          DMImportReleve.TaReleveEbics.FindField('compte_banque').AsString:=entete1.numeroCompte;
//////          DMImportReleve.TaReleveEbics.FindField('code_op_bancaire').AsString:=complement1.codeOperationInterbancaire;
//////          DMImportReleve.TaReleveEbics.FindField('date_compta').AsString:=DateToStr(now);
//////          DMImportReleve.TaReleveEbics.FindField('type_compl').AsString:=complement1.qualifiant;
//////          DMImportReleve.TaReleveEbics.FindField('complement').AsString:=complement1.informationsComplementaires;
//////          DMImportReleve.TaReleveEbics.FindField('zoneReserve3').AsString:=complement1.informationsComplementaires;
//////            TableGerePost(DMImportReleve.TaComplementEbics);
//////         end;
////   end;
////   end;
////end;
//////ensuite à partir des dates saisies, remonter les opérations concernant cette période
//ChargeOperationDansInterval(EdDateDebutReleve.Date,EdDateFinReleve.Date,codeBanque,codeGuichet,numCompte);
//finally
//    if(FileExists(cheminFichier))then
//      DeleteFile(cheminFichier);
//end;
//end;


function TImportationReleveEbics.RecupereToutesLesEcrituresServeur():boolean;
var
compte,guichet,banque:string;

username,pwd,codeBanque,codeGuichet,numCompte:string;
datedeb,datefin:string;
dejaReleve:boolean;
reponse:ArrayOfEntete;
entete1:Entete;
mouvement1:Mouvement;
complement1:Complement;
i,j,k:integer;
listeSave:Tstringlist;
//paramEbics:TClasseMere;
id,idComplement:integer;
chaine,idEnteteServeur,idMouvServeur,chemin:string;
cheminFichier,urlWsdl:string;
montantStr:string;
montant:currency;
begin
try//finally
try//except
cheminFichier:=IncludeTrailingPathDelimiter(e.RepertoireDossier)+'listeMouvement.csv';
urlWsdl:=retourCompte.site;
if(DMRech=nil)then DMRech:=TDMRech.Create(Application.MainForm);
datedeb:=DateToStr(EdDateDebutReleve.date);
datefin:=DateToStr(EdDateFinReleve.date);
datedeb:=Str_String_To_DateString(datedeb,4);
datefin:=Str_String_To_DateString(datefin,4);
dejaReleve:=chDejaReleve.Checked;


username:=retourCompte.login;
pwd:=retourCompte.password;
codeBanque:=str_getstringelement(retourCompte.compte,1,'-');
codeGuichet:=str_getstringelement(retourCompte.compte,2,'-');
numCompte:=str_getstringelement(retourCompte.compte,3,'-');

chaine:=username+' '+pwd+' '+codeBanque+' '+codeGuichet+' '+numCompte+' '+datedeb+' '+datefin+' '+BoolToStrEnglish(dejaReleve)+' "'+Pchar(cheminFichier)+'"'+' "'+Pchar(urlWsdl)+'"';
listeSave:=TStringList.Create();


if(ShellExecuteAndWait(handle,'','ws_ebics.exe',PChar(chaine),PChar(ExcludeTrailingPathDelimiter(e.RepertoireProgram)),SW_SHOW,INFINITE))= NO_ERROR then
begin

//showmessage(cheminFichier);
listeSave.Clear;
listeSave.LoadFromFile(cheminFichier);

//// charger à partir du web service toutes les opérations depuis dernière connexion
////ensuite remplir la table Ebics
DMImportReleve.TaReleveEbics.close;
DMImportReleve.TaReleveEbics.Open;
DMImportReleve.TaComplementEbics.close;
DMImportReleve.TaComplementEbics.Open;

//ShowMessage(IntToStr(listeSave.Count));

for i:=0 to listeSave.Count-1 do
begin
   entete1:=entete.Create;
   mouvement1:=Mouvement.Create;

   chaine:=listeSave.Strings[i];

   if(str_getstringelement(chaine,1,';')='4')and ( not GrLocate(DMRech.TaReleveEbics,'idMouvServeur',[str_getstringelement(chaine,3,';')]))then
   begin
//          chaine:='code'; 1
//          chaine:=chaine+';idEnteteServeur'; 2
//          chaine:=chaine+';idMouvServeur'; 3
//          chaine:=chaine+';codeBanque'; 4
//          chaine:=chaine+';codeOperationInterne'; 5
//          chaine:=chaine+';codeGuichet'; 6
//          chaine:=chaine+';codeDevise'; 7
//          chaine:=chaine+';numeroCompte';  8
//          chaine:=chaine+';codeOperationInterbancaire'; 9
//          chaine:=chaine+';dateCompta';  10
//          chaine:=chaine+';dateValeur';   11
//          chaine:=chaine+';libelle';       12
//          chaine:=chaine+';numeroEcriture';  13
//          chaine:=chaine+';montantMouvement';    14
//          chaine:=chaine+';zoneReference';    15
//          listeSave.Add(chaine);
          id:=MaxId_Query(DMImportReleve.TaReleveEbics_maxID,'Id');

          TableGereInsert(DMImportReleve.TaReleveEbics);
          DMImportReleve.TaReleveEbics.FindField('id').AsInteger:=id;
          DMImportReleve.TaReleveEbics.FindField('idEnteteServeur').AsString:=str_getstringelement(chaine,2,';');
           idEnteteServeur:=DMImportReleve.TaReleveEbics.FindField('idEnteteServeur').AsString;
          DMImportReleve.TaReleveEbics.FindField('idMouvServeur').AsString:=str_getstringelement(chaine,3,';');
           idMouvServeur:=DMImportReleve.TaReleveEbics.FindField('idMouvServeur').AsString;
          DMImportReleve.TaReleveEbics.FindField('code_enreg').AsString:=str_getstringelement(chaine,1,';');
          DMImportReleve.TaReleveEbics.FindField('code_banque').AsString:=str_getstringelement(chaine,4,';');
          DMImportReleve.TaReleveEbics.FindField('code_op_interne').AsString:=str_getstringelement(chaine,5,';');
          DMImportReleve.TaReleveEbics.FindField('code_guichet').AsString:=str_getstringelement(chaine,6,';');
          DMImportReleve.TaReleveEbics.FindField('devise').AsString:=str_getstringelement(chaine,7,';');
          DMImportReleve.TaReleveEbics.FindField('nb_decimal').AsInteger:=2;
          DMImportReleve.TaReleveEbics.FindField('compte_banque').AsString:=str_getstringelement(chaine,8,';');
          DMImportReleve.TaReleveEbics.FindField('code_op_bancaire').AsString:=str_getstringelement(chaine,9,';');
          DMImportReleve.TaReleveEbics.FindField('date_compta').AsString:=Str_String_To_DateString(str_getstringelement(chaine,10,';'),3);
          DMImportReleve.TaReleveEbics.FindField('date_valeur').AsString:=Str_String_To_DateString(str_getstringelement(chaine,11,';'),3);
          DMImportReleve.TaReleveEbics.FindField('libelle').AsString:=str_getstringelement(chaine,12,';');
          DMImportReleve.TaReleveEbics.FindField('num_Ecriture').AsString:=str_getstringelement(chaine,13,';');
          montantStr:=str_getstringelement(chaine,14,';');
          if(montantStr<>'')then
          begin
            montantStr:=str_remplacesouschaine(montantStr,',','.');
            montant:= StrToCurr_Lgr(montantStr);
            montant:=Arrondi(montant,2);
          end;
          DMImportReleve.TaReleveEbics.FindField('montant').AsCurrency:=montant;
          DMImportReleve.TaReleveEbics.FindField('reference').AsString:=DMImportReleve.TaReleveEbics.FindField('idEnteteServeur').AsString+'-'+
            DMImportReleve.TaReleveEbics.FindField('idMouvServeur').AsString+'-'+str_getstringelement(chaine,15,';');
          DMImportReleve.TaReleveEbics.FindField('traite').AsBoolean:=false;
          TableGerePost(DMImportReleve.TaReleveEbics);

   end;
    if(str_getstringelement(chaine,1,';')='5')and ( not GrLocate(DMRech.TaComplementEbics,'idComplServeur',[str_getstringelement(chaine,4,';')]))then
   begin
//          chaine:='code'; 1
//          chaine:=chaine+';idEnteteServeur'; 2
//          chaine:=chaine+';idMouvServeur'; 3
//          chaine:=chaine+';idComplServeur'; 4
//          chaine:=chaine+';codeBanque';   5
//          chaine:=chaine+';codeOperationInterne';  6
//          chaine:=chaine+';codeGuichet';  7
//          chaine:=chaine+';codeDevise';  8
//          chaine:=chaine+';numeroCompte'; 9
//          chaine:=chaine+';codeOperationInterbancaire'; 10
//          chaine:=chaine+';dateCompta'; 11
//          chaine:=chaine+';qualifiant';  12
//          chaine:=chaine+';infosComplement'; 13

          idComplement:=MaxId_Query(DMImportReleve.TaComplementEbics_maxID,'Id');
          TableGereInsert(DMImportReleve.TaComplementEbics);
          DMImportReleve.TaComplementEbics.FindField('id').AsInteger:=idComplement;
            DMImportReleve.TaComplementEbics.FindField('idEnteteServeur').AsString:=idEnteteServeur;
            DMImportReleve.TaComplementEbics.FindField('idMouvServeur').AsString:=idMouvServeur;
            DMImportReleve.TaComplementEbics.FindField('idComplServeur').AsString:=str_getstringelement(chaine,4,';');
          DMImportReleve.TaComplementEbics.FindField('id_mouv').AsInteger:=id;
          DMImportReleve.TaComplementEbics.FindField('code_enreg').AsString:='5';
          DMImportReleve.TaComplementEbics.FindField('code_banque').AsString:=str_getstringelement(chaine,5,';');
          DMImportReleve.TaComplementEbics.FindField('code_op_interne').AsString:=str_getstringelement(chaine,6,';');
          DMImportReleve.TaComplementEbics.FindField('code_guichet').AsString:=str_getstringelement(chaine,7,';');
          DMImportReleve.TaComplementEbics.FindField('devise').AsString:=str_getstringelement(chaine,8,';');
          DMImportReleve.TaComplementEbics.FindField('nb_decimal').AsInteger:=2;
          DMImportReleve.TaComplementEbics.FindField('compte_banque').AsString:=str_getstringelement(chaine,9,';');
          DMImportReleve.TaComplementEbics.FindField('code_op_bancaire').AsString:=str_getstringelement(chaine,10,';');
          DMImportReleve.TaComplementEbics.FindField('date_compta').AsString:=Str_String_To_DateString(str_getstringelement(chaine,11,';'),3);
          DMImportReleve.TaComplementEbics.FindField('type_compl').AsString:=str_getstringelement(chaine,12,';');
          DMImportReleve.TaComplementEbics.FindField('complement').AsString:=str_getstringelement(chaine,13,';');

            TableGerePost(DMImportReleve.TaComplementEbics);
   end;

end;
end;
result:=true;
except
    result:=false;
end;
finally
    if(FileExists(cheminFichier))then
      DeleteFile(cheminFichier);
end;
end;


procedure TImportationReleveEbics.BtnChargerClick(Sender: TObject);
var
codeBanque,codeGuichet,numCompte:string;
begin
try//finally

codeBanque:=str_getstringelement(retourCompte.compte,1,'-');
codeGuichet:=str_getstringelement(retourCompte.compte,2,'-');
numCompte:=str_getstringelement(retourCompte.compte,3,'-');

if(not RecupereToutesLesEcrituresServeur)then abort;

////ensuite à partir des dates saisies, remonter les opérations concernant cette période
ChargeOperationDansInterval(EdDateDebutReleve.Date,EdDateFinReleve.Date,codeBanque,codeGuichet,numCompte);
finally

end;
end;

procedure ChargeOperationDansInterval(DateDebut,DateFin:Tdate;banque,guichet,compte:string);
var
   car:string;
   ligne:string;
   LigneAFB_Ecriture:TypeAFB_Ecriture;
   LigneAFB_Complement:TypeAFB_Complement;

//   i:integer;
montant:string;
   LigneReleve:TLigneImportReleve;
   MemoTemp:TStringlist;
   infosModel:TInfosmodel;
begin

   MemoTemp:=TStringlist.Create;

   ImportationReleveEbics.LVReleve.clear;
   ImportationReleveEbics.lignesReleves.Clear;

   DMImportReleve.QuReleveEbics.SQL.Clear;
   DMImportReleve.QuReleveEbics.SQL.Add('select * from Ta_releve_ebics r where r.code_banque like :banque and r.code_guichet like :guichet and r.compte_banque like :compte ');
   DMImportReleve.QuReleveEbics.SQL.Add(' and r.date_compta between cast(:dateDeb as date) and cast(:dateFin as date) ');
   if(ImportationReleveEbics.cbDejaImporte.Checked=false) then  DMImportReleve.QuReleveEbics.SQL.Add(' and traite=false or traite is null');
   DMImportReleve.QuReleveEbics.SQL.Add(' order by r.date_compta ');
   DMImportReleve.QuReleveEbics.ParamByName('banque').AsString:=banque;
   DMImportReleve.QuReleveEbics.ParamByName('guichet').AsString:=guichet;
   DMImportReleve.QuReleveEbics.ParamByName('compte').AsString:=compte;

   DMImportReleve.QuReleveEbics.ParamByName('dateDeb').AsDateTime:=DateDebut;
   DMImportReleve.QuReleveEbics.ParamByName('dateFin').AsDateTime:=DateFin;

   DMImportReleve.QuReleveEbics.Open;
   DMImportReleve.QuReleveEbics.first;

   DMImportReleve.QuLigneComplementEbics.SQL.Clear;
   DMImportReleve.QuLigneComplementEbics.SQL.Add('select * from ta_complement_ebics r where r.id_mouv =:id_releve ');
   DMImportReleve.QuLigneComplementEbics.SQL.Add(' order by r.id ');
   DMImportReleve.QuLigneComplementEbics.ParamByName('id_releve').AsInteger:=0;

   DMImportReleve.QuReleveEbics.Open;
   DMImportReleve.QuReleveEbics.first;
   try
      while (not DMImportReleve.QuReleveEbics.Eof)  do
        begin
              LigneAFB_complement.LibelleComplement:='';
//              LigneAFB_Ecriture.CodeEnregistrement:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring[2];
//                        LigneAFB_Ecriture.CodeBanque:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.CodeOperation:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.CodeGuichet:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.CodeDevises:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.NombreDecimales:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.IndiceSIT:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.Compte:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.CodeOperationInterbancaire:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.DateEcriture:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.CodeRejet:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.DateValeur:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.Libelle:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.ZoneReservee1:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.NumEcriture:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.CodeExoneration:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.ZoneReservee2:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.Montant:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;
//                        LigneAFB_Ecriture.RefEcriture:=DMImportReleve.QuReleveEbics.findfield('code_enreg')asstring;


                 LigneReleve:=TLigneImportReleve.Create(application.MainForm);
                 LigneReleve.IMPORT:=true;
                 LigneReleve.BANKID:=trim(DMImportReleve.QuReleveEbics.findfield('code_banque').asstring);
                 LigneReleve.BRANCHID:=trim(DMImportReleve.QuReleveEbics.findfield('code_guichet').asstring);
                 LigneReleve.ACCTID:=trim(DMImportReleve.QuReleveEbics.findfield('compte_banque').asstring);
                 infosModel:=DMImportReleve.verifComptesBancaire(LigneReleve.BANKID+'-'+LigneReleve.BRANCHID+'-'+LigneReleve.ACCTID,false,true);
                 LigneReleve.COMPTE:=infosModel.Compte;
                 LigneReleve.JOURNAL:=infosModel.Journal;
//                 LigneReleve.DTPOSTED:=GestionDateOperationAFB(DMImportReleve.QuReleveEbics.findfield('date_valeur').asstring);
                  LigneReleve.DTPOSTED:=DMImportReleve.QuReleveEbics.findfield('date_valeur').asstring;
//                 montant:=GestionCodeSensOperationAFB(LigneAFB_Ecriture.Montant);
                 montant:=DMImportReleve.QuReleveEbics.findfield('montant').asstring;
                 if(str_commence_par(montant,'-'))then
                   LigneReleve.CREDIT:=abs(montant)
                 else
                   LigneReleve.DEBIT:=abs(montant);
                 LigneReleve.FITID:=trim(DMImportReleve.QuReleveEbics.findfield('reference').asstring);
                 LigneReleve.NAME:=trim(DMImportReleve.QuReleveEbics.findfield('libelle').asstring);

                 if (LigneReleve.FITID='')then LigneReleve.FITID:=LigneReleve.DTPOSTED+QueDesChiffres(montant)+LigneReleve.NAME;
                 LigneReleve.DOUBLON:=DMImportReleve.VerifSiDoublon(LigneReleve.FITID,LigneReleve.COMPTE);
                 LigneReleve.IDLIGNE_ORIGINE:=DMImportReleve.QuReleveEbics.findfield('id').AsInteger;
                 ImportationReleveEbics.lignesReleves.AddObject(trim(LigneReleve.FITID),LigneReleve);

                 //s'occuper des lignes complémentaires contenant des infos complémentaires à la ligne en cours
                 DMImportReleve.QuLigneComplementEbics.close;
                 DMImportReleve.QuLigneComplementEbics.ParamByName('id_releve').AsInteger:=DMImportReleve.QuReleveEbics.findfield('id').asinteger;
                 DMImportReleve.QuLigneComplementEbics.open;
                 DMImportReleve.QuLigneComplementEbics.first;
                 while not(DMImportReleve.QuLigneComplementEbics.Eof)do
                 begin
                    LigneAFB_complement.LibelleComplement:=LigneAFB_complement.LibelleComplement+'-'+DMImportReleve.QuLigneComplementEbics.findfield('complement').AsString;
                    DMImportReleve.QuLigneComplementEbics.Next;
                 end;
                 //récupérer les infos complémentaires
                 LigneReleve.MEMO:=trim(LigneAFB_complement.LibelleComplement);

           DMImportReleve.QuReleveEbics.Next;
  end;
   finally
//     ImportationReleveEbics.lignesReleves.SaveToFile('C:\Documents and Settings\isabelle\Bureau\Releves\LigneReleve.csv');
     ImportationReleveEbics.initGrReleve;
     ImportationReleveEbics.CocheDecocheListe(true,true);

     Initialise_TStringlist(MemoTemp,ImportationReleveEbics);
   end;

end;

procedure ChargeFichierOFX(FileName:string);
var
   Fic:textfile;
   car:string;
   ligne:string;
   i:integer;
   Delimiteur,DelimiteurTemp:String;
   Rib1,Rib2,Rib3,date,montant,reference,libelle,memo:string;
   LigneReleve:TLigneImportReleve;
   MemoTemp:TStringlist;
   infosModel:TInfosmodel;
begin
   MemoTemp:=TStringlist.Create;
   ImportationReleveEbics.lignesReleves.Clear;
   ImportationReleveEbics.LVReleve.clear;
   AssignFile( Fic, FileName);
   reset(Fic);
   try
      while not eof(Fic) do
        begin //cette boucle répètera la lecture d'une ligne tant que nous n'aurons pas atteint la fin du document EOF
          readln(Fic,ligne);//à chaque fois que l'on utilisera readln on passera à la ligne suivante.
          //
          ImportationReleveEbics.lignesReleves.Clear;
          Delimiteur:='<';
          DelimiteurTemp:='';
          while Pos(Delimiteur, ligne)>0 do
          begin
                if Pos(Delimiteur, ligne)<>1 then
                   if trim(DelimiteurTemp+Copy(ligne,1,Pos(Delimiteur, ligne)-1))<>'' then
                     ImportationReleveEbics.lignesReleves.Add(trim(DelimiteurTemp+Copy(ligne,1,Pos(Delimiteur, ligne)-1)));
                ligne:=Copy(ligne,Pos(Delimiteur, ligne)+1,length(ligne));
              DelimiteurTemp:=Delimiteur;
          end;
          if ligne<>'' then
                 if( trim(DelimiteurTemp+ligne))<>'' then
                   ImportationReleveEbics.lignesReleves.Add(trim(DelimiteurTemp+ligne));
          //

          for i:=0 to ImportationReleveEbics.lignesReleves.Count-1 do
            MemoTemp.Add(ImportationReleveEbics.lignesReleves[i]); // ajoute notre ligne au memo
        end;
Rib1:='';
Rib2:='';
Rib3:='';
date:='';
montant:='';
reference:='';
libelle:='';
memo:='';
i:=0;
ImportationReleveEbics.lignesReleves.Clear;

while i<=MemoTemp.Count-1 do
  begin
    ligne:=MemoTemp.Strings[i];
    if str_commence_par(ligne,'<BANKID>')then
    begin
       rib1:=StringReplace(ligne,'<BANKID>','',[rfReplaceAll]);
       inc(i);
       ligne:=MemoTemp.Strings[i];
    end else
    if str_commence_par(ligne,'<BRANCHID>')then
    begin
       rib2:=StringReplace(ligne,'<BRANCHID>','',[rfReplaceAll]);
       inc(i);
       ligne:=MemoTemp.Strings[i];
    end else
    if str_commence_par(ligne,'<ACCTID>')then
    begin
       rib3:=StringReplace(ligne,'<ACCTID>','',[rfReplaceAll]);
       inc(i);
       ligne:=MemoTemp.Strings[i];
    end else
    if str_commence_par(ligne,'<DTPOSTED>')then
    begin
       date:=StringReplace(ligne,'<DTPOSTED>','',[rfReplaceAll]);
       inc(i);
       ligne:=MemoTemp.Strings[i];
    end else
    if str_commence_par(ligne,'<TRNAMT>')then
    begin
       montant:=StringReplace(ligne,'<TRNAMT>','',[rfReplaceAll]);
       inc(i);
       ligne:=MemoTemp.Strings[i];
    end else
    if str_commence_par(ligne,'<FITID>')then
    begin
       reference:=StringReplace(ligne,'<FITID>','',[rfReplaceAll]);
       inc(i);
       ligne:=MemoTemp.Strings[i];
    end else
    if str_commence_par(ligne,'<NAME>')then
    begin
       libelle:=StringReplace(ligne,'<NAME>','',[rfReplaceAll]);
       inc(i);
       ligne:=MemoTemp.Strings[i];
    end else
    if str_commence_par(ligne,'<MEMO>')then
    begin
       memo:=StringReplace(ligne,'<MEMO>','',[rfReplaceAll]);
       inc(i);
       ligne:=MemoTemp.Strings[i];
    end else
    if str_commence_par(ligne,'</STMTTRN>')then
      begin
         //nouvel objet
         LigneReleve:=TLigneImportReleve.Create(application.MainForm);
         LigneReleve.IMPORT:=true;
         LigneReleve.BANKID:=Rib1;
         LigneReleve.BRANCHID:=Rib2;
         LigneReleve.ACCTID:=Rib3;
         infosModel:=DMImportReleve.verifComptesBancaire(LigneReleve.BANKID+'-'+LigneReleve.BRANCHID+'-'+LigneReleve.ACCTID,false,true);
         LigneReleve.COMPTE:=infosModel.Compte;
         LigneReleve.JOURNAL:=infosModel.Journal;
         LigneReleve.DTPOSTED:=Str_String_To_DateString(date,2);
         if(str_commence_par(montant,'-'))then
           LigneReleve.CREDIT:=abs(montant)
         else
           LigneReleve.DEBIT:=abs(montant);
         LigneReleve.FITID:=reference;
         LigneReleve.NAME:=libelle;
         LigneReleve.MEMO:=memo;
         if (LigneReleve.FITID='')then LigneReleve.FITID:=LigneReleve.DTPOSTED+QueDesChiffres(montant)+LigneReleve.NAME;
         LigneReleve.DOUBLON:=DMImportReleve.VerifSiDoublon(LigneReleve.FITID,LigneReleve.COMPTE);
         ImportationReleveEbics.lignesReleves.AddObject(reference,LigneReleve);
//         lignesReleves.Add(rib1+';'+rib2+';'+rib3+';'+date+';'+montant+';'+reference+';'+libelle+';'+memo);
//         memo1.Lines.Add(rib1+';'+rib2+';'+rib3+';'+date+';'+montant+';'+reference+';'+libelle+';'+memo);
         date:='';
         montant:='';
         reference:='';
         libelle:='';
         memo:='';
         inc(i);
     end
      else inc(i);
  end;
   finally
     //lignesReleves.SaveToFile('C:\Documents and Settings\isabelle\Bureau\Releves\LigneReleve.csv');
     ImportationReleveEbics.initGrReleve;
     ImportationReleveEbics.CocheDecocheListe(true,true);
     closefile(Fic);

//     MemoTemp.free;
   end;

end;


procedure ChargeFichierAFB(FileName:string);
var
   FicTemp,FicFinal:textfile;
   car:string;
   ligne:string;
   LigneAFB_Ecriture:TypeAFB_Ecriture;
   LigneAFB_Complement:TypeAFB_Complement;
//   i:integer;
montant:string;
   LigneReleve:TLigneImportReleve;
   MemoTemp:TStringlist;
   infosModel:TInfosmodel;
begin
   MemoTemp:=TStringlist.Create;
   ImportationReleveEbics.lignesReleves.Clear;
   ImportationReleveEbics.LVReleve.clear;
   AssignFile( FicTemp, FileName);
   reset(FicTemp);
   AssignFile( FicFinal, FileName);
   reset(FicFinal);
   ImportationReleveEbics.lignesReleves.Clear;
   if (not eof(FicTemp)) then readln(fictemp,ligne);
   try
      while (not eof(FicTemp))and(not eof(FicFinal))  do
        begin //cette boucle répètera la lecture d'une ligne tant que nous n'aurons pas atteint la fin du document EOF
           if str_commence_par(ligne,'04') or str_commence_par(ligne,'05') then
          begin
             if str_commence_par(ligne,'04')then
              begin
              LigneAFB_complement.LibelleComplement:='';
              readln(FicFinal,LigneAFB_Ecriture.CodeEnregistrement,
                        LigneAFB_Ecriture.CodeBanque,
                        LigneAFB_Ecriture.CodeOperation,
                        LigneAFB_Ecriture.CodeGuichet,
                        LigneAFB_Ecriture.CodeDevises,
                        LigneAFB_Ecriture.NombreDecimales,
                        LigneAFB_Ecriture.IndiceSIT,
                        LigneAFB_Ecriture.Compte,
                        LigneAFB_Ecriture.CodeOperationInterbancaire,
                        LigneAFB_Ecriture.DateEcriture,
                        LigneAFB_Ecriture.CodeRejet,
                        LigneAFB_Ecriture.DateValeur,
                        LigneAFB_Ecriture.Libelle,
                        LigneAFB_Ecriture.ZoneReservee1,
                        LigneAFB_Ecriture.NumEcriture,
                        LigneAFB_Ecriture.CodeExoneration,
                        LigneAFB_Ecriture.ZoneReservee2,
                        LigneAFB_Ecriture.Montant,
                        LigneAFB_Ecriture.RefEcriture);
                        readln(FicTemp,ligne);

                      if str_commence_par(ligne,'05')then
                        begin
                             readln(FicFinal,LigneAFB_complement.CodeEnregistrement,
                              LigneAFB_complement.CodeBanque,
                              LigneAFB_complement.CodeOperation,
                              LigneAFB_complement.CodeGuichet,
                              LigneAFB_complement.ZoneReservee1,
                              LigneAFB_complement.Compte,
                              LigneAFB_complement.CodeOperationInterbancaire,
                              LigneAFB_complement.DateEcriture,
                              LigneAFB_complement.LibelleComplement,
                              LigneAFB_complement.NumEcriture,
                              LigneAFB_complement.ZoneReservee2,
                              LigneAFB_complement.MontantDu04,
                              LigneAFB_complement.ZoneReservee3);
                        end;
                 //nouvel objet
                 LigneReleve:=TLigneImportReleve.Create(application.MainForm);
                 LigneReleve.IMPORT:=true;
                 LigneReleve.BANKID:=trim(LigneAFB_Ecriture.CodeBanque);
                 LigneReleve.BRANCHID:=trim(LigneAFB_Ecriture.CodeGuichet);
                 LigneReleve.ACCTID:=trim(LigneAFB_Ecriture.Compte);
                 infosModel:=DMImportReleve.verifComptesBancaire(LigneReleve.BANKID+'-'+LigneReleve.BRANCHID+'-'+LigneReleve.ACCTID,false,true);
                 LigneReleve.COMPTE:=infosModel.Compte;
                 LigneReleve.JOURNAL:=infosModel.Journal;
                 LigneReleve.DTPOSTED:=GestionDateOperationAFB(LigneAFB_Ecriture.DateValeur);
                 montant:=GestionCodeSensOperationAFB(LigneAFB_Ecriture.Montant);
                 if(str_commence_par(montant,'-'))then
                   LigneReleve.CREDIT:=abs(montant)
                 else
                   LigneReleve.DEBIT:=abs(montant);
                 LigneReleve.FITID:=trim(LigneAFB_Ecriture.RefEcriture);
                 LigneReleve.NAME:=trim(LigneAFB_Ecriture.Libelle);
                 LigneReleve.MEMO:=trim(LigneAFB_complement.LibelleComplement);
                 if (LigneReleve.FITID='')then LigneReleve.FITID:=LigneReleve.DTPOSTED+QueDesChiffres(montant)+LigneReleve.NAME;
                 LigneReleve.DOUBLON:=DMImportReleve.VerifSiDoublon(LigneReleve.FITID,LigneReleve.COMPTE);
                 ImportationReleveEbics.lignesReleves.AddObject(trim(LigneReleve.FITID),LigneReleve);
//                 ImportationReleveEbics.lignesReleves.Add(LigneReleve.BANKID+';'+LigneReleve.BRANCHID+';'+LigneReleve.ACCTID+';'
//                 +LigneReleve.DTPOSTED+';'+LigneReleve.TRNAMT+';'+LigneReleve.FITID+';'+LigneReleve.NAME+';'+LigneReleve.MEMO);
                 if str_commence_par(ligne,'05') then readln(FicTemp,ligne);
              end;
         end
         else
            begin
              readln(FicFinal);
              readln(FicTemp,ligne);
            end;

//         memo1.Lines.Add(rib1+';'+rib2+';'+rib3+';'+date+';'+montant+';'+reference+';'+libelle+';'+memo);
//         inc(i);
//      else inc(i);
  end;
   finally
//     ImportationReleveEbics.lignesReleves.SaveToFile('C:\Documents and Settings\isabelle\Bureau\Releves\LigneReleve.csv');
     ImportationReleveEbics.initGrReleve;
     ImportationReleveEbics.CocheDecocheListe(true,true);
     closefile(FicTemp);
     closefile(FicFinal);
     Initialise_TStringlist(MemoTemp,ImportationReleveEbics);
   end;

end;

procedure TImportationReleveEbics.FormShow(Sender: TObject);
var
listeComptes:TStringList;
i:integer;
begin
try
listeComptes:=TStringList.Create;
ImportationReleveEbics.GrSoldeReleve.ParamColor:=true;
ImportationReleveEbics.GrSoldeReleve.Param:=ParamUtil.CouleurDBGrid;
ImportationReleveEbics.GrSoldeReleve.DessineContourLigne:=false;
ImportationReleveEbics.GrSoldeReleve.UpDateColor;

ImportationReleveEbics.GrSoldeCompte.ParamColor:=true;
ImportationReleveEbics.GrSoldeCompte.Param:=ParamUtil.CouleurDBGrid;
ImportationReleveEbics.GrSoldeCompte.DessineContourLigne:=false;
ImportationReleveEbics.GrSoldeCompte.UpDateColor;

ImportationReleveEbics.GrMouvReleve.ParamColor:=true;
ImportationReleveEbics.GrMouvReleve.Param:=ParamUtil.CouleurDBGrid;
ImportationReleveEbics.GrMouvReleve.DessineContourLigne:=false;
ImportationReleveEbics.GrMouvReleve.UpDateColor;

ImportationReleveEbics.GrMouvCompte.ParamColor:=true;
ImportationReleveEbics.GrMouvCompte.Param:=ParamUtil.CouleurDBGrid;
ImportationReleveEbics.GrMouvCompte.DessineContourLigne:=false;
ImportationReleveEbics.GrMouvCompte.UpDateColor;

EdDateDebutReleve.Date:=e.DatExoDebut;
EdDateFinReleve.Date:=now;
cbCompteBancaire.SetFocus;

OrdreTriRapprochement:=1;
TabStr:=[0,1,2,3,4,8,9];
TabCurr:=[6,7];
TabDate:=[5];

listeComptes:=DMImportReleve.listeCompteBancaire;
for i:=0 to listeComptes.Count-1 do
begin
   cbCompteBancaire.AddItem(listeComptes.Strings[i],listeComptes.Objects[i]);
end;
finally
  listeComptes.Free;
end;
end;

procedure TImportationReleveEbics.BtnEnregistrerClick(Sender: TObject);
var
i:integer;
begin
try
//lignesReleves.Clear;
for i:=0 to LVReleve.Items.Count-1 do
begin
  TLigneImportReleve(LVReleve.Items[i].SubItems.Objects[0]).IMPORT:=LVReleve.Items[i].Checked;
end;

if not DMImportReleve.ImportLignesReleve(lignesReleves,true) then abort;
showmessage('l''importation du relevé est terminée.');
//tout vider
lignesReleves.Clear;
LVReleve.clear;
ModalResult:=mryes;
except
    showmessage('l''importation du relevé ne s''est pas déroulée correctement.');
end;
end;

procedure TImportationReleveEbics.BtnFermerClick(Sender: TObject);
begin
close;
end;


procedure TImportationReleveEbics.initGrReleve;
var
i:integer;
ligneReleve:TLigneImportReleve;
ListeValeur:TStringlist;
doublon:char;
begin
try
ListeValeur:=Tstringlist.Create;
for i:=0 to lignesReleves.Count-1 do
begin
doublon:=#0;
if(TLigneImportReleve(lignesReleves.Objects[i]).DOUBLON)then       //
  doublon:='x';
 ListeValeur.AddObject(doublon +';'+
  TLigneImportReleve(lignesReleves.Objects[i]).BANKID+';'+
  TLigneImportReleve(lignesReleves.Objects[i]).BRANCHID+';'+
  TLigneImportReleve(lignesReleves.Objects[i]).ACCTID+';'+
  TLigneImportReleve(lignesReleves.Objects[i]).DTPOSTED+';'+
  TLigneImportReleve(lignesReleves.Objects[i]).DEBIT+';'+
  TLigneImportReleve(lignesReleves.Objects[i]).CREDIT+';'+
  TLigneImportReleve(lignesReleves.Objects[i]).NAME+';'+
  TLigneImportReleve(lignesReleves.Objects[i]).FITID+';',TLigneImportReleve(lignesReleves.Objects[i]));

end;                       // 'Accept',
      InitLisViewAvecListe(['D','Compte','Date','Montant','Désignation',
      'Référence'],ListeValeur);
OrdreTriRapprochement:=1;
TabStr:=[0,1,2,3,4,8,9];
TabCurr:=[6,7];
TabDate:=[5];

finally
PaEcrituresResize(PaEcritures);
Initialise_TStringlist(ListeValeur,self);
initTotaux;
end;
end;

procedure TImportationReleveEbics.PaEcrituresResize(Sender: TObject);
begin
WinShape(ActiveControl,main.Shape1,main.shape2,ParamUtil.ContourCouleur);

// Grilles d'en bas
PaSoldeCompte.Width:=RenvoiTailleColonneListView(LVReleve,[0,1,2,3,4,5])+5;
GrSoldeCompte.ColWidths[0]:=LVReleve.Column[6].Width;
GrSoldeCompte.ColWidths[1]:=LVReleve.Column[7].Width;

PaMouvReleve.Width:=RenvoiTailleColonneListView(LVReleve,[0,1,2,3,4,5])+5;
GrMouvReleve.ColWidths[0]:=LVReleve.Column[6].Width;
GrMouvReleve.ColWidths[1]:=LVReleve.Column[7].Width;

PaSoldeReleve.Width:=RenvoiTailleColonneListView(LVReleve,[0,1,2,3,4,5])+5;
GrSoldeReleve.ColWidths[0]:=LVReleve.Column[6].Width;
GrSoldeReleve.ColWidths[1]:=LVReleve.Column[7].Width;

PaMouvCompte.Width:=RenvoiTailleColonneListView(LVReleve,[0,1,2,3,4,5])+5;
GrMouvCompte.ColWidths[0]:=LVReleve.Column[6].Width;
GrMouvCompte.ColWidths[1]:=LVReleve.Column[7].Width;
end;


// On parcours d'abord le tableau de TStringlist
procedure TImportationReleveEbics.InitLisViewAvecListe(TabTitreColonne:array of string;ListeValeur:TStringList);
var
j,k, NbString:integer;
Begin

//   for i:=0 to high(TabList) do
//    begin
     for j:=0 to ListeValeur.Count-1 do
      begin
        LVReleve.Items.Add.Caption:=str_getstringelement((ListeValeur).Strings[j],1,';');
        NbString := Str_Count_Str(';',(ListeValeur).Strings[j]);
        for k:=1 to NbString do
         begin
         if k = 1 then
           begin
               LVReleve.Items[LVReleve.Items.Count-1].SubItems.AddObject(str_getstringelement((ListeValeur).Strings[j],k,';'),
                  ListeValeur.Objects[j]);
           end
          else
           LVReleve.Items[LVReleve.Items.Count-1].SubItems.Add(str_getstringelement((ListeValeur).Strings[j],k,';'));
         end;
      end;
CocheDecocheListe(true,true);
End;

procedure TImportationReleveEbics.CocheDecocheListe(cocheDecoche:boolean;GestionDoublon:boolean);
var
i:integer;
begin
for i:=0 to LVReleve.Items.Count-1 do
if(GestionDoublon)and(LVReleve.Items[i].SubItems.Strings[0]<>#0)then
  LVReleve.Items[i].Checked:=false
else
  LVReleve.Items[i].Checked:=cocheDecoche;
end;

procedure TImportationReleveEbics.DecocheDoublon;
var
i:integer;
begin
for i:=0 to LVReleve.Items.Count-1 do
  if LVReleve.Items[i].SubItems.Strings[0]<>#0 then
    LVReleve.Items[i].Checked:=false;
end;

procedure TImportationReleveEbics.Panel3Resize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([BtnDoublon,BtnTTCocher,BtnTTDecocher],PaBtnRefus,120,25,5);
FormateTailleBouttonAvecEspace([BtnAnnuler,BtnEnregistrer,BtnCreerReglement],PaBtnSupp,160,0,0);
end;

procedure TImportationReleveEbics.PaBtnResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([BtnEnregistrer,BtnAnnuler],PaBtn,90,0,0);

end;

procedure TImportationReleveEbics.LVReleveSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
MemoComplement.Clear;
if (Selected) then
  begin
      if(Item.SubItems.Objects[0]<>nil)then
        begin
        MemoComplement.text:=TLigneImportReleve(Item.SubItems.Objects[0]).MEMO;
        end;
  end;
end;

procedure TImportationReleveEbics.BtnTTCocherClick(Sender: TObject);
begin
CocheDecocheListe(true);
end;

procedure TImportationReleveEbics.BtnTTDecocherClick(Sender: TObject);
begin
CocheDecocheListe(false);
end;

procedure TImportationReleveEbics.BtnDoublonClick(Sender: TObject);
begin
DecocheDoublon();
end;

procedure TImportationReleveEbics.BtnGestionCompteClick(Sender: TObject);
begin
if E2_ComptesBancaires=nil then E2_ComptesBancaires:=TE2_ComptesBancaires.Create(self);
E2_ComptesBancaires.ShowModal;
if E2_ComptesBancaires.modification then
  if (BtnCharger.Enabled)then BtnCharger.Click;
end;

procedure TImportationReleveEbics.FichierImportAfterDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
//BtnCharger.Enabled:=FileExists(name);
if BtnCharger.Enabled then
  e.RepTelechargementReleve:=ExtractFileDir(name);
end;

procedure TImportationReleveEbics.FormActivate(Sender: TObject);
begin
//BtnCharger.Enabled:=AfficheCompteBanque(EdBanque);
MemoComplement.Clear;
end;


procedure TImportationReleveEbics.initTotaux;
var
sommeDebit,sommeCredit:currency;
i:integer;
begin
//Gestion de toutes les lignes
sommeDebit:=SommeColonneListView(LVReleve,5,0,LVReleve.Items.Count-1);
sommeCredit:=SommeColonneListView(LVReleve,6,0,LVReleve.Items.Count-1);
GrMouvReleve.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',sommeDebit );
GrMouvReleve.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',sommeCredit );
DetermineSolde(sommeDebit,sommeCredit);
GrSoldeReleve.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ',sommeDebit );
GrSoldeReleve.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ',sommeCredit );

sommeDebit:=0;
sommeCredit:=0;
//gestion des lignes à importer
for i:=0 to LVReleve.Items.Count-1 do
begin
  if LVReleve.Items[i].Checked then
    begin
      sommeDebit:=sommeDebit+StrToCurr_Lgr(LVReleve.Items[i].SubItems[5]);
      sommeCredit:=sommeCredit+StrToCurr_Lgr(LVReleve.Items[i].SubItems[6]);
    end;
end;
GrMouvCompte.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', sommeDebit);
GrMouvCompte.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', sommeCredit);

DetermineSolde(sommeDebit,sommeCredit);

GrSoldeCompte.Cells[0,0]:=FormatFloat(E.FormatMonnaie + ';; ', sommeDebit);
GrSoldeCompte.Cells[1,0]:=FormatFloat(E.FormatMonnaie + ';; ', sommeCredit);
end;


procedure TImportationReleveEbics.LVReleveChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
   initTotaux;
end;

function GestionDateOperationAFB(Date:string):string;
var
Jour,mois,annee:string[2];
begin
Jour:=str_souschaine(Date,0,2);
mois:=str_souschaine(Date,3,2);
annee:=str_souschaine(Date,5,2);
result:=jour+'/'+mois+'/'+annee;
end;

function GestionCodeSensOperationAFB(Montant:string):string;
var
deb:string ;
code,fin:string[1];
begin
fin:=(str_n_der_char(Montant,2)[1]);
code:=str_n_der_char(Montant,1);
deb:=str_n_prem_char(Montant,12)+'.';
result:=str_Suppr_N_Car_ADroite(Montant,1);

//0000000001660} = -166.00
//0000000000346P = -34.67
//0000000018300{ = +1830.00
if str_fini_par(uppercase(Montant),'{') then result:='+'+deb+fin+'0';
if str_fini_par(uppercase(Montant),'A') then result:='+'+deb+fin+'1';
if str_fini_par(uppercase(Montant),'B') then result:='+'+deb+fin+'2';
if str_fini_par(uppercase(Montant),'C') then result:='+'+deb+fin+'3';
if str_fini_par(uppercase(Montant),'D') then result:='+'+deb+fin+'4';
if str_fini_par(uppercase(Montant),'E') then result:='+'+deb+fin+'5';
if str_fini_par(uppercase(Montant),'F') then result:='+'+deb+fin+'6';
if str_fini_par(uppercase(Montant),'G') then result:='+'+deb+fin+'7';
if str_fini_par(uppercase(Montant),'H') then result:='+'+deb+fin+'8';
if str_fini_par(uppercase(Montant),'I') then result:='+'+deb+fin+'9';
if str_fini_par(uppercase(Montant),'}') then result:='-'+deb+fin+'0';
if str_fini_par(uppercase(Montant),'J') then result:='-'+deb+fin+'1';
if str_fini_par(uppercase(Montant),'K') then result:='-'+deb+fin+'2';
if str_fini_par(uppercase(Montant),'L') then result:='-'+deb+fin+'3';
if str_fini_par(uppercase(Montant),'M') then result:='-'+deb+fin+'4';
if str_fini_par(uppercase(Montant),'N') then result:='-'+deb+fin+'5';
if str_fini_par(uppercase(Montant),'O') then result:='-'+deb+fin+'6';
if str_fini_par(uppercase(Montant),'P') then result:='-'+deb+fin+'7';
if str_fini_par(uppercase(Montant),'Q') then result:='-'+deb+fin+'8';
if str_fini_par(uppercase(Montant),'R') then result:='-'+deb+fin+'9';
result:=e.FormatCurrSansDevise( StrToCurr(result));
end;
//codification des décimales en fonction du sens de l'operation
//	D	C
//{		0
//A		1
//b		2
//c		3
//d		4
//e		5
//f		6
//g		7
//h		8
//i		9
//}	0
//j	1
//k	2
//l	3
//m	4
//n	5
//o	6
//p	7
//q	8
//r	9

procedure TImportationReleveEbics.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[LVReleve]);
     If Key = VK_ESCAPE Then
     Begin
         if (LVReleve.Focused)then
            cbCompteBancaire.SetFocus
         else
            Self.Close;
     End;
end;

procedure TImportationReleveEbics.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if not(verifSortie)then
begin
   CanClose:=false;
end;
end;

procedure TImportationReleveEbics.BtnAnnulerClick(Sender: TObject);
begin
if verifSortie then
  begin
       ModalResult:=mrCancel;
       if(self.FormStyle=fsNormal)then close;
  end;
end;

function TImportationReleveEbics.verifSortie():boolean;
var retour:boolean;
begin
if (LVReleve.Items.Count=0)then retour:=true
else retour:=Application.MessageBox(Pchar('Voulez-vous annuler l''importation ?'),'Attention',
  MB_ICONEXCLAMATION +MB_YESNO+MB_DEFBUTTON2)=mryes;
if retour then
  begin
     //tout vider
     lignesReleves.Clear;
     LVReleve.clear;
  end;
end;
procedure TImportationReleveEbics.EdBanqueKeyPress(Sender: TObject;
  var Key: Char);
begin
if key = #13 then
 begin
  key := #9;
  //DBGridRappBanc.SetFocus;
 end;
end;

procedure TImportationReleveEbics.verifCompte(Sender: TObject);
//var
//derniereDate:TDate;
//retourCompteTMP:retourCompteBancaire;

begin
if(cbCompteBancaire.ItemIndex=-1)then cbCompteBancaire.SetFocus;
//derniereDate:=e.DatExoDebut;
//     retourCompteTMP:= AfficheCompteBanque(EdBanque,sender = nil);
//     if(retourCompteTMP.Arecupere)then retourCompte:=retourCompteTMP;
//     if not retourCompte.retour then
//     begin
//       EdBanque.SetFocus;
//       abort;
//     end
//     else
//     begin
//     if(retourCompte.Arecupere)then
//       begin
//           // remplir le journal de banque correspondant
//           EdJournal.Text:=retourCompte.journal;
////           derniereDate:=DMImportReleve.recupDerniereDateReleveCompte(EdBanque.Text);
////           EdDateDebutReleve.Date:=derniereDate;
//       end;
//     end;
//changementEtatBoutons;

end;
procedure TImportationReleveEbics.EdBanqueExit(Sender: TObject);
begin
if ((ActiveControl<>btnAnnuler) and (ActiveControl<>BtnCreerReglement))then
  begin
      verifCompte(sender);
  end;
end;

procedure TImportationReleveEbics.changementEtatBoutons();
begin
   BtnCharger.Enabled:=(retourCompte.site<>'')  and
   (retourCompte.login<>'') and (retourCompte.password<>'') and (retourCompte.compte<>'') and (retourCompte.journal<>'');
end;

procedure TImportationReleveEbics.Aide1Click(Sender: TObject);
begin
//if activeControl = EdBanque then
// begin
//     EdBanqueExit(nil);
// end;
end;

procedure TImportationReleveEbics.EdBanqueChange(Sender: TObject);
begin
   ImportationReleveEbics.LVReleve.clear;
   ImportationReleveEbics.lignesReleves.Clear;
   Initialise_retourCompteBancaire(retourCompte);
    changementEtatBoutons;
end;

procedure TImportationReleveEbics.BtnCreerReglementClick(Sender: TObject);
var
ParamAfficheReleve:TParamAfficheReleve;
result:integer;
datefin:Tdate;
legende:Tlabel;
begin
verifCompte(cbCompteBancaire);
  begin
      datefin:=EdDateFinReleve.Date;

//      if not MyInputQuery_Date(self,'Date de fin de relevé','Indiquer la date de fin du relevé.',
//          datefin,'',[#0]) then exit;


//      RxLabMArqueCourante.Text:=MarqueCourante;
//      DMRappBanc.MarqueCourante:=MarqueCourante;
      ParamAfficheReleve.Titre:='';
      ParamAfficheReleve.Direct:=false;
      ParamAfficheReleve.DateFinReleve:=datefin;
//      ParamAfficheReleve.Marque:=MarqueCourante;
      ParamAfficheReleve.journal:=DMJournal.CompteDuJournal(retourCompte.journal);

      ParamAfficheReleve.libelleJournal:=DMJournal.LibelleDuJournal(retourCompte.journal);
      result :=CreationReglementRelevesAffiche(ParamAfficheReleve);
      if result=mrok then
        begin
          cbCompteBancaire.SetFocus;
        end
  end;
end;

procedure TImportationReleveEbics.essai_json;
var
  js:TlkJSONobject;
  xs:TlkJSONbase;
  i,j,k,l: Integer;
  ws: String;
begin

end;

//procedure TImportationReleveEbics.essai_json;
//var
//  js:TlkJSONobject;
//  xs:TlkJSONbase;
//  i,j,k,l: Integer;
//  ws: String;
//begin
//{$ifdef USE_D2009}
//  ReportMemoryLeaksOnShutdown := True;
//{$endif}
//  Randomize;
//  js := TlkJSONobject.Create(true);
////  js.HashTable.HashOf := js.HashTable.SimpleHashOf;
//  k := GetTickCount;
//// syntax of adding changed to version 0.95+
//  for i := 0 to 50000 do
//    begin
//      l := random(9999999);
//      ws := 'param'+inttostr(l);
//      js.add(ws,ws);
//      ws := 'int'+inttostr(l);
//      js.add(ws,i);
//    end;
//  k := GetTickCount-k;
//  writeln('records inserted:',js.count);
//  writeln('time for insert:',k);
//  writeln('hash table counters:');
//  writeln(js.hashtable.counters);
//
//  k := GetTickCount;
//  ws := TlkJSON.GenerateText(js);
//  writeln('text length:',length(ws));
//  k := GetTickCount-k;
//// free the object
//  writeln('release memory...');
//  js.Free;
////  js.Free;
//
//  writeln('time for gentext:',k);
//
//  k := GetTickCount;
//  xs := TlkJSON.ParseText(ws);
//
//  k := GetTickCount-k;
//  writeln('time for parse:',k);
//  writeln('approx speed of parse (th.bytes/sec):',length(ws) div k);
//  writeln('press enter...');
//  readln;
//  writeln(ws);
//  writeln('press enter...');
//  readln;
//// works in 0.94+ only!
//  js := TlkJSONobject(xs);
//  for i := 1 to 10 do
//    begin
//      writeln('field ',i,' is ',js.NameOf[i]);
//      writeln('type of field ',i,' is ',js.FieldByIndex[i].SelfTypeName);
//      writeln('value of field ',i,' is ',js.FieldByIndex[i].Value);
//      writeln;
//    end;
//  writeln('release memory...');
//  if assigned(xs) then FreeAndNil(xs);
////  js.Free;
////}
//  writeln('press enter...');
//  ws := '';
//  readln;
//end;


procedure TImportationReleveEbics.cbCompteBancaireChange(Sender: TObject);
begin
   ImportationReleveEbics.LVReleve.clear;
   ImportationReleveEbics.lignesReleves.Clear;
   Initialise_retourCompteBancaire(retourCompte);
    changementEtatBoutons;
end;


function CustomSortDateProcAsc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
end;

function CustomSortDateProcDesc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) < StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=-1;
if StrToDate(TListItem(Item1).SubItems.Strings[ParamSort]) > StrToDate(TListItem(Item2).SubItems.Strings[ParamSort]) then
 result :=1;
result:=-result;
end;

function CustomSortCurrProcAsc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToCurr_Lgr(QueDesChiffres(TListItem(Item1).SubItems.Strings[ParamSort])) <
   StrToCurr_Lgr(QueDesChiffres(TListItem(Item2).SubItems.Strings[ParamSort])) then
 result :=-1;
if StrToCurr_Lgr(QueDesChiffres(TListItem(Item1).SubItems.Strings[ParamSort])) >
   StrToCurr_Lgr(QueDesChiffres(TListItem(Item2).SubItems.Strings[ParamSort])) then
 result :=1;
end;

function CustomSortCurrProcDesc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
result := 0;
if StrToCurr_Lgr(QueDesChiffres(TListItem(Item1).SubItems.Strings[ParamSort])) <
   StrToCurr_Lgr(QueDesChiffres(TListItem(Item2).SubItems.Strings[ParamSort])) then
 result :=-1;
if StrToCurr_Lgr(QueDesChiffres(TListItem(Item1).SubItems.Strings[ParamSort])) >
   StrToCurr_Lgr(QueDesChiffres(TListItem(Item2).SubItems.Strings[ParamSort])) then
 result :=1;
result:=-result;
end;
procedure TImportationReleveEbics.LVReleveColumnClick(Sender: TObject;
  Column: TListColumn);
begin
OrdreTriRapprochement:=-OrdreTriRapprochement;
if Sender<>nil then
  GestionDesColumnsRapprochement((Sender as TListView).Columns,Column);
  if Column.Index in TabDate  then
   begin
      if OrdreTriRapprochement > 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortDateProcAsc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortDateProcAsc, -1);
        end;
      if OrdreTriRapprochement < 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortDateProcDesc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortDateProcDesc, -1)
        end;
  end
else
  if (Column.Index in TabCurr)  then
   begin
      if OrdreTriRapprochement > 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortCurrProcAsc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortCurrProcAsc, -1);
        end;
      if OrdreTriRapprochement < 0 then
        begin
         if Column.Index > 0 then
            (sender as TListView).CustomSort(@CustomSortCurrProcDesc, Column.Index-1)
            else
            (sender as TListView).CustomSort(@CustomSortCurrProcDesc, -1)
        end;
  end
else
if (Column.Index in TabStr)  then
  begin
      if Column.Index > 0 then
      (sender as TListView).CustomSort(nil, Column.Index-1)
      else
      (sender as TListView).CustomSort(nil, -1)
  end;
end;
procedure TImportationReleveEbics.GestionDesColumnsRapprochement(Columns:TListColumns;Column:TListColumn);
var
i:integer;
begin
  for i := 0 to Columns.Count - 1 do
      Columns[i].ImageIndex := -1;

  if OrdreTriRapprochement>0 then
  Column.ImageIndex:=0
  else  Column.ImageIndex:=1
end;

procedure TImportationReleveEbics.cbCompteBancaireSelect(Sender: TObject);
var
objet:TObject;
begin
Initialise_retourCompteBancaire(retourCompte);
objet:=cbCompteBancaire.Items.Objects[cbCompteBancaire.ItemIndex] ;
if(objet<>nil)then
  begin
     retourCompte.retour:= true;
     retourCompte.compte:= (objet as TCompteBancaire).codeBancaire;
     retourCompte.site:= (objet as TCompteBancaire).site;
     retourCompte.journal:= (objet as TCompteBancaire).journal;
     retourCompte.login:= (objet as TCompteBancaire).login;
     retourCompte.password:= (objet as TCompteBancaire).password;
     retourCompte.Arecupere:= true; 
  end;
changementEtatBoutons;
end;



procedure TImportationReleveEbics.LVReleveCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTriRapprochement*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTriRapprochement*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
end;

end.
