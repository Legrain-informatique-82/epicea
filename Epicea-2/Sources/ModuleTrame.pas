unit ModuleTrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,
  Gr_Librairie_obj,
  E2_Librairie_obj,
  DMPlanCpt,
  DMPiece,
  Piece,
  Ecriture_Isa,
  E2_Decl_Records,
  LibSql,
  lib_chaine,
  DMBalances;

type
  TRetourFunction = record
  CodeErreur:integer;
  Retour:boolean;
  end;
  TTableau = array [0..5] of string;
  TDMTrame = class(TDataModule)
    DaTrame: TDataSource;
    TaTrame: TTable;
    TaTrameL: TTable;
    DaTrameL: TDataSource;
    TaTiers: TTable;
    DaTiers: TDataSource;
    TaTvaCode: TTable;
    DaTvaCode: TDataSource;
    Trame1: TTrame;
    TaTrame_Obj: TTable;
    TaTrameL_Obj: TTable;
    TaTrameLLigne: TSmallintField;
    TaTrameLCompte: TStringField;
    TaTrameLLibelle: TStringField;
    TaTrameLQt1: TFloatField;
    TaTrameLQt2: TFloatField;
    TaTrameLMontantDebit: TCurrencyField;
    TaTrameLMontantCredit: TCurrencyField;
    TaTrameLTvaCode: TStringField;
    TaTrameLTvaType: TStringField;
    TaTrameLTvaTaux: TFloatField;
    TaTrameLQui: TStringField;
    TaTrameLQuand: TDateTimeField;
    TaTrameLTypeLigne: TStringField;
    TaTrameCode: TStringField;
    TaTrameLibelle_Trame: TStringField;
    TaTrameLibelle: TStringField;
    TaTrameJournal: TStringField;
    TaTrameCompte: TStringField;
    TaTrameCompte_Reglement: TStringField;
    TaTrameMinimun: TBooleanField;
    TaTrameID_Devise: TIntegerField;
    TaTrameID_Journal: TIntegerField;
    TaTrameQui: TStringField;
    TaTrameQuand: TDateTimeField;
    TaTrameLID: TIntegerField;
    TaTrameLID_Trame: TIntegerField;
    TaTrameID: TIntegerField;

//******************************************************************************
    procedure DMTrameCreate(Sender: TObject);
//    function OuvreTable(NomFeuille:TDataModule ):boolean;
    procedure initTrame;
//    function FermeTable(Nomfeuille:TDataModule):boolean;
    procedure DMTrameDestroy(Sender: TObject);
//******************************************************************************
    procedure TaTrameBeforePost(DataSet: TDataSet);
    procedure TaTrameAfterPost(DataSet: TDataSet);
    procedure TaTrameBeforeDelete(DataSet: TDataSet);
    procedure TaTrameAfterScroll(DataSet: TDataSet);
//******************************************************************************
    procedure TaTrameLBeforeEdit(DataSet: TDataSet);
    procedure TaTrameLBeforePost(DataSet: TDataSet);
    procedure TaTrameLAfterPost(DataSet: TDataSet);
    procedure TaTrameLAfterScroll(DataSet: TDataSet);
    procedure TaTrameLBeforeInsert(DataSet: TDataSet);
    procedure TaTrameLBeforeDelete(DataSet: TDataSet);
    procedure TaTrameLAfterDelete(DataSet: TDataSet);
//******************************************************************************
    function RechercheInfoTrame(id_trame : integer):TTableau;
    function VerifierSiCodeExiste(NomBase,Table,code,ValeurCode: string):boolean;
    function RecupereLibelle(nomTable,nomChamp,texte,donnee: string):string;
    procedure chercherlibDefaut(codeTiers:string);
    procedure renseignerCompte(compte: string);
    function lignesVides: boolean;
//******************************************************************************
    function verifierBanque(compteReg : string):boolean;
    function verifierTiers(codeTiers: string):boolean;
    function verifierJournal(codeJournal: string):boolean;
    Function VerifLigne(Courant:Tfield):TRetourFunction;
    function VerifEnrgLigne(Dataset: Tfield):TRetourFunction;
    procedure TraitementVerifEnrgLigne;
    procedure TraitementVerifLigne;
//*****************              numeros de lignes           *******************
    function VerifierSiLigneExiste(ligne: integer):integer;
    function precedentLigneLibre:integer;
    function suivantLigneLibre:integer;
    function chercherTrouLigneAvant:integer;
    function chercherTrouLigneApres: integer;
    function chercherTrou(avant:boolean;place:integer):integer;
    function recupMaxLigne: integer;
    procedure incrementerTout(ligne: integer);
    procedure decrementerLigne(ligne: integer);
    procedure TaTrameLBeforeScroll(DataSet: TDataSet);
    procedure DaTrameStateChange(Sender: TObject);
    procedure DaTrameLStateChange(Sender: TObject);
    procedure TaTrameLBeforeCancel(DataSet: TDataSet);
    procedure TaTrameLAfterCancel(DataSet: TDataSet);
    procedure TaTrameLAfterEdit(DataSet: TDataSet);
//*************************** Rajout Isa *************************************
   function EnvoieTrame_TrameLigne_SurListe(Liste:Tlist;Ecriture:TEcriture_Isa):TExceptLGR_ImportPiece;
   function BatchMove_Liste_SurTaTrame(Source:TList;Ecriture:TEcriture_Isa):integer;
    procedure TaTrame_ObjPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaTrame_ObjDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaTrameL_ObjPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaTrameL_ObjDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    function VerifExistenceTrame(champRecherche,valeurRecherche:array of string):boolean;
    procedure TaTrameDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaTrameAfterDelete(DataSet: TDataSet);
//******************************************************************************
    procedure SupprLigneTrame(IdTrame:Integer);
    function CtrlInfosTrame_Obj(CCourant:TField):TExceptLGR_ImportPiece;
    procedure TaTrame_ObjBeforePost(DataSet: TDataSet);
    procedure TaTrame_ObjBeforeDelete(DataSet: TDataSet);
    procedure TaTrame_ObjAfterDelete(DataSet: TDataSet);


  private
    { Déclarations privées }

  public
    { Déclarations publiques }
   Tableau : TTableau;
   l,id_trame,ligne:integer;
   CompteL,LibelleCodeTrame,CodeTrame,journal,oper,tiers: string;
   automatique: boolean;
  end;

var
  DMTrame: TDMTrame;
  memoireCompte: string;
  existe,traite: boolean;
  memoireinsert,memoireL: integer;
implementation

uses E2_Tiers,
     //E2_Trame,
//     E2_Main,
DMEcriture, DMRecherche;

{$R *.DFM}

//****************************************************************************
//                         ouverture / fermeture
//****************************************************************************
procedure TDMTrame.DMTrameCreate(Sender: TObject);
begin
  TaTrame.AfterScroll := Nil;
  TaTrameL.AfterScroll := Nil;
  DaTrameL.onStateChange:= nil;
  DaTrame.onStateChange:= nil;

OuvrirTouteTable('',TControl(self));
//  if not OuvreTable(DMTrame) then showmessage('Erreur ouverture tables');
//  TaTrameL.IndexName:= '_num_ligne';  { isa  le  25/02/04 }
  initTrame;
end;

procedure TDMTrame.initTrame;
begin
  id_trame:= TaTrame.fieldbyname('ID').asinteger;
  tableau:= rechercheInfoTrame(id_trame);
end;

//function TDMTrame.OuvreTable(NomFeuille:TDataModule ):boolean;
//var I:integer;
//begin
// try
//   for i:=0 to Nomfeuille.ComponentCount -1 do
//     if Nomfeuille.components[i].className = 'TTable' then
//        begin
//       (Nomfeuille.components[i]as TTable).open;
//       result:=true;
//       end;
// except
// //  on E.DatabaseError then
//   begin
//   showmessage('Table '+Nomfeuille.Components[i].Name+' inconnue dans la fenêtre'+nomfeuille.Name);
//   nomfeuille.Destroy;
//   result:=false;
//   end;
// end;
// try
//   for i:=0 to Nomfeuille.componentcount-1 do
//     if Nomfeuille.components[i].className = 'TQuery' then
//       begin
//       (Nomfeuille.components[i]as TQuery).open;
//       result:=true;
//       end;
// except
// //  on E.DatabaseError then
//   begin
//   showmessage('Table '+Nomfeuille.Components[i].Name+' inconnue dans la fenêtre'+nomfeuille.Name);
//   nomfeuille.Destroy;
//   result:=false;
//   end;
// end;
//end;
//
//function TDMTrame.FermeTable(Nomfeuille:TDataModule):boolean;
//var I:integer;
//begin
// try
//   for i:=0 to Nomfeuille.ComponentCount -1 do
//     if Nomfeuille.components[i].className = 'TTable' then
//        begin
//       (Nomfeuille.components[i]as TTable).Close;
//       result:=true;
//       end;
// except
// //  on E.DatabaseError then
//   begin
//   showmessage('Table inconnue dans la fenêtre'+nomfeuille.Name);
//   nomfeuille.Destroy;
//   result:=false;
//   end;
// end;
// try
//   for i:=0 to Nomfeuille.componentcount-1 do
//     if Nomfeuille.components[i].className = 'TQuery' then
//       begin
//       (Nomfeuille.components[i]as TQuery).close;
//       result:=true;
//       end;
// except
// //  on E.DatabaseError then
//   begin
//   showmessage('Table inconnue dans la fenêtre'+nomfeuille.Name);
//   nomfeuille.Destroy;
//   result:=false;
//   end;
// end;
//end;

procedure TDMTrame.DMTrameDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
DMTrame:=nil;
//  if not FermeTable(DMTrame) then showmessage ('Erreur à la fermeture !');
end;

//*************************etat du datasource***********************************
procedure TDMTrame.DaTrameStateChange(Sender: TObject);
begin
//  Trame.gererboutons(1);
end;

procedure TDMTrame.DaTrameLStateChange(Sender: TObject);
begin
//  Trame.gererboutons(2);
end;

//******************************************************************************
//                            trame
//******************************************************************************
procedure TDMTrame.TaTrameBeforePost(DataSet: TDataSet);
begin
  if VerifierSiCodeExiste('Dossier','Trame.DB','ID',(TaTrame.FieldByName('ID').asString)) then
  begin
    if TaTrame.State  in [dsEdit] then
    begin
      TaTrame.Locate('ID', (TaTrame.FieldByName('ID').asInteger), [LoCaseInsensitive]);
      TaTrame.Edit;
      TaTrame.FieldByName('Journal').asString := journal;
//      TaTrame.FieldByName('Code').asString := Trame.Edit_PMCode.Text;
//      TaTrame.FieldByName('Libelle_Trame').asString := Trame.Edit_PMNom.Text;
      TaTrame.FieldByName('Compte').asString := Tiers;
//      TaTrame.FieldByName('Compte_Reglement').asString := Trame.Edit_PMBanque.text;
    end;
  end;
  if TaTrame.State  in [dsinsert] then
  begin
    TaTrame.FieldByName('Journal').asString := journal;
//    TaTrame.FieldByName('Code').asString := Trame.Edit_PMCode.Text;
//    TaTrame.FieldByName('Libelle_Trame').asString := Trame.Edit_PMNom.Text;
    TaTrame.FieldByName('Compte').asString := Tiers;
//    TaTrame.FieldByName('Compte_Reglement').asString := Trame.Edit_PMBanque.text;
  end ;
end;

procedure TDMTrame.TaTrameAfterPost(DataSet: TDataSet);
begin
  id_trame :=  TaTrame.FieldByName('ID').asInteger;
//  Trame.TrameEnrg := false;
  TaTrame.FlushBuffers;
end;

procedure TDMTrame.TaTrameBeforeDelete(DataSet: TDataSet);
begin
  try
    if MessageDlg('Êtes-Vous sûr de vouloir supprimer la trame '+TaTrame.FieldByName('Code').asstring+' ?',mtConfirmation,[mbYes,mbNo],0)=mrNo then
     abort
      else
     TableGereStartTransaction(DataSet);

    id_trame :=  TaTrame.FieldByName('ID').asInteger;
  except
    TableGereRollBack(DataSet);
    abort;
  end;
end;


procedure TDMTrame.TaTrameAfterScroll(DataSet: TDataSet);
begin
  initTrame;
//  Trame.initialisation;
end;



//******************************************************************************
//                             lignes
//******************************************************************************
procedure TDMTrame.TaTrameLBeforePost(DataSet: TDataSet);
var
  tab: array[0..4] of integer;
  i : integer;
begin
  tab[0] := 2;      tab[2] := 9;   tab[4] := 11;
  tab[1] := 3;      tab[3] := 10;
  for i:=0 to 4 do
  begin
    if  VerifEnrgLigne(TaTrameL.Fields[tab[i]]).retour = false then
      TraitementVerifEnrgLigne;
  end;
end;

procedure TDMTrame.TaTrameLAfterPost(DataSet: TDataSet);
begin
  ligne := TaTrameL.FieldByName('Ligne').AsInteger;
  if TaTrameL.fieldbyname('Compte').asstring <> memoireCompte then
    CompteL:= TaTrameL.FieldByName('Compte').AsString;
  TaTrameL.FlushBuffers;
//  memoireInsert :=0;
//  memoireL := 0;
end;

procedure TDMTrame.TaTrameLBeforeDelete(DataSet: TDataSet);
begin
  ligne :=  TaTrameL.FieldByName('Ligne').asInteger;
end;

procedure TDMTrame.TaTrameLAfterDelete(DataSet: TDataSet);
begin
  if automatique = true then
  begin
    decrementerLigne(ligne);
  end;
  ligne :=  TaTrameL.FieldByName('Ligne').asInteger;
//  if ligne = 0 then
//    Trame.BtnSupr.Caption:='supprimer Trame';
TaTrameL.FlushBuffers;
end;

procedure TDMTrame.TaTrameLBeforeEdit(DataSet: TDataSet);
begin
  memoireCompte:= TaTrameL.fieldbyname('Compte').asString;
  id_trame :=  TaTrameL.FieldByName('ID_Trame').asInteger;
  ligne :=  TaTrameL.FieldByName('Ligne').asInteger;
  memoireL :=  TaTrameL.FieldByName('Ligne').asInteger;
end;

procedure TDMTrame.TaTrameLBeforeInsert(DataSet: TDataSet);
begin
//  id_trame :=  TaTrameL.FieldByName('ID_Trame').asInteger;
//  ligne :=  TaTrameL.FieldByName('Ligne').asInteger;
//  memoireinsert :=ligne ;
//  if automatique = true then
//  begin
////    if Trame.ajout = false then
//    begin
//      if ligne <> 0 then
//      begin
//        if precedentLigneLibre = 0 then
//        begin
//          incrementerTout(ligne-1);
//        end
//        else
//          memoireinsert:=precedentLigneLibre;
//      end
//      else;
////        memoireinsert := recupMaxLigne;
//    end
//    else
//      memoireinsert := recupMaxLigne;
//    end;
end;

procedure TDMTrame.TaTrameLBeforeCancel(DataSet: TDataSet);
begin
  id_trame :=  TaTrame.FieldByName('ID').asInteger;
  memoireL :=  TaTrameL.FieldByName('Ligne').asInteger;
end;

procedure TDMTrame.TaTrameLAfterCancel(DataSet: TDataSet);
begin
//  if (automatique = true)and(Trame.ajout=false) then
  begin
  if memoireL <> recupmaxligne then
  begin
    if (memoireL <> ligne) then
    begin
      if memoireL = 0 then
      begin
        ligne := memoireinsert - 1;
        decrementerLigne(ligne);
      end
      else
        decrementerLigne(memoireL);
    end;
  end;
  end;
end;


procedure TDMTrame.TaTrameLBeforeScroll(DataSet: TDataSet);
begin
  Ligne:= TaTrameL.fieldbyname('Ligne').asInteger;
end;

procedure TDMTrame.TaTrameLAfterScroll(DataSet: TDataSet);
begin
  id_trame :=  TaTrameL.FieldByName('ID_Trame').asInteger;
end;

//******************************************************************************
//                             recherches/divers
//******************************************************************************
function  TDMTrame.RechercheInfoTrame(id_trame : integer): TTableau;
var
  QTable : TQuery;
  i : integer;
begin
  for i := 0 to 5 do
  Tableau[i] := '';
  QTable := TQuery.create(nil);
  try
  with  QTable do
  begin
    DataBaseName := 'Dossier' ;
    close;
    Sql.Clear;
    Sql.Add ('SELECT * FROM Trame.DB' );
    Sql.Add (' WHERE ID = ' + '''' + IntToStr(id_trame) + '''');
    Open;
    Tableau[0] := FieldByName('compte').asString;
    Tableau[1] := FieldByName('Code').asString;
    Tableau[2] := FieldByName('Libelle_Trame').asString;
    Tableau[3] := FieldByName('Journal').asString;
    Tableau[4] := FieldByName('Compte_Reglement').asString;
    if Tableau[3]= 'AC' then
    begin
      Tableau[3]:= 'A';
      Tableau[5]:= 'Achat';
    end;
    if Tableau[3]= 'VT' then
    begin
      Tableau[3]:= 'V';
      Tableau[5]:= 'Vente';
    end;
    if Tableau[3]= 'OD' then
    begin
      Tableau[3]:= 'O';
      Tableau[5]:= 'Opérations diverses';
    end;
    if Tableau[3]= 'B1' then
    begin
      Tableau[3]:= 'T';
      Tableau[5]:= 'Règlement';
    end;
    close;
  end;
  except
    QTable.free;
  end;
  result := Tableau;
end;

function TDMTrame.VerifierSiCodeExiste(NomBase,Table,code,ValeurCode: string):boolean;
var
  QTable : TQuery;
begin
  result := false;
  QTable := TQuery.create(nil);
  with  QTable do
  begin
    DataBaseName := NomBase ;
    close;
    Sql.Clear;
    Sql.Add ('SELECT * FROM ' + Table );
    Sql.Add ('WHERE ' + code + ' = ' + '''' +  ValeurCode + '''');
    Open;
    if recordCount <> 0 then
      result := true ;
    close;
    free;
  end;
end;

function TDMTrame.RecupereLibelle(nomTable,nomChamp,texte,donnee: string):string;
var
  QTable : TQuery;
  libelle : string;
begin
  libelle := '';
  QTable := TQuery.create(nil);
  try
  with  QTable do
  begin
    DataBaseName := 'Dossier' ;
    close;
    Sql.Clear;
    Sql.Add ('SELECT * FROM '+ nomTable );
    Sql.Add (' WHERE '+ nomChamp +'= ' + '''' +  texte + '''');
    Open;
    libelle := FieldByName(donnee).asString;
    close;
  end;
  finally
    QTable.free;
  end;
  result := libelle;
end;

procedure TDMTrame.chercherlibDefaut(codeTiers:string);
//le tiers existe: libellé et code trame par défaut
var
  i : integer;
begin
  LibelleCodeTrame := RecupereLibelle('Tiers.DB','Tiers',codeTiers,'Nom');
//  CodeTrame := 'T' + SortirCar(LibelleCodeTrame,'+');
  if VerifierSiCodeExiste('Dossier','Trame.DB','Code',CodeTrame) = true then
  begin  
    i := 2;
    CodeTrame := concat(copy(CodeTrame,1,7-length(inttostr(i))),inttostr(i));
    While VerifierSiCodeExiste('Dossier','Trame.DB','Code',CodeTrame) do
    begin
      i := i+ 1;
      CodeTrame := concat(copy(CodeTrame,1,7-length(inttostr(i))),inttostr(i));
    end;
  end;
  CodeTrame := (UpperCase(COPY(CodeTrame,1,7)));
//  LibelleCodeTrame := SortirCar(CodeTrame,'T');
end;  

procedure TDMTrame.renseignerCompte(compte: string);
begin
  if compte = '' then  compte := compteL;     
  if compte <> '' then
  begin                   
    TaTrameL.FieldByName('Compte').asString := compte;
    if VerifierSiCodeExiste('Dossier','PlanCpt.DB','Compte',compte) then
      if TaTrameL.FieldByName('Libelle').asString = '' then
        TaTrameL.FieldByName('Libelle').asString := DMPlan.LibelleDuNumCptPCU(compte);
  end;
end;

function TDMTrame.lignesVides: boolean;
begin
  result := false;
  if empty(TaTrameL.Fields[2].AsString)then
    if empty(TaTrameL.Fields[3].AsString)then
      if empty(TaTrameL.Fields[4].AsString)then
        if empty(TaTrameL.Fields[7].AsString)then
          if empty(TaTrameL.Fields[8].AsString)then
            if empty(TaTrameL.Fields[9].AsString)then
               if empty(TaTrameL.Fields[10].AsString)then
                 if empty(TaTrameL.Fields[11].AsString)then
                   result := true;
end;

//******************************************************************************
//                   vérifications et traitements
//******************************************************************************
function TDMTrame.verifierBanque(compteReg : string):boolean;
begin
  result:= true;
  if  compteReg <> '' then
  begin
    // le compte est renseigné:
    if  compteReg[1] <> '5' then
    begin
      // si <> compte de trésorerie:
      showmessage ( ' Le compte doit être de classe ''5'' ( F1 pour lister )');
      result := false;
    end
    else
    begin
    //sinon, on vérifie l'existence du compte:
      if not DMTrame.VerifierSiCodeExiste('Dossier','PlanCpt.DB','compte',compteReg)then
      begin
      //il n'existe pas, on propose de le créer:
      Application.Messagebox(Pchar('Voulez-vous le créer ?'),'compte banque inexistant !',MB_YesNo);
      result := false;
      end;  //fin création
    end;  //fin du traitement banque
  end;
end;

function TDMTrame.verifierTiers(codeTiers: string):boolean;
begin
  result := true;
  if codeTiers <>'' then
  begin
    if not VerifierSiCodeExiste('Dossier','Tiers.db','Tiers',codeTiers) then
    begin
     // tiers inexistant:
      Application.Messagebox(Pchar('Voulez-vous le créer ?'),'Tiers inexistant !',MB_YesNo);
      result := false;
    end ;  //fin du traitement inexistant
  end;
end;

function TDMTrame.verifierJournal(codeJournal: string): boolean;
begin
  result:=false;
  oper := '';
  journal := codeJournal;
  if codeJournal <> '' then
  begin
    if codeJournal = 'A' then
    begin
      journal := 'AC';
      oper := 'Achat';
      result := true;
    end;
    if codeJournal = 'V' then
    begin
      journal := 'VT';
      oper := 'Vente';
      result := true;
    end;                   
    if codeJournal = 'O' then
    begin                      
      journal := 'OD';
      oper := 'Opérations Diverses';
      result := true;
    end;
    if codeJournal = 'T' then
    begin
      journal := 'B1';
      oper := 'Règlement';
      result := true;
    end;
    //on vérifie s'il existe
    if not VerifierSiCodeExiste('Dossier','Trame.DB','journal',Journal)then
      Application.Messagebox(Pchar('Voulez-vous le créer ?'),'code journal inexistant !',MB_YesNo);
  end;
end;

Function TDMTrame.VerifLigne(Courant:Tfield):TRetourFunction;
var
  s:string;
begin
  s := '';
  if Courant.DataSet.State in [dsinsert,dsEdit] then
  begin  //on traite l'enregistrement courant:
    VerifLigne.CodeErreur:=0;        // initialisations
    VerifLigne.Retour:=true;
    case (Courant.index) of
       2:begin   //Numéro de ligne
          if empty(TaTrameL.Fields[2].AsString) then
           begin  //si vide
             VerifLigne.CodeErreur:=1000;
             VerifLigne.Retour:=false;
           end
           else
           begin // pas vide
             VerifLigne.CodeErreur:=1001;
             VerifLigne.Retour:=false;
           end;
         end;  // fin n° de ligne
      3:begin   //N° compte
           if empty(TaTrameL.Fields[3].AsString) then
           begin //si vide
            VerifLigne.CodeErreur:=2000;
            VerifLigne.Retour:=false;
           end
           else
           begin //si pas vide :on verifie s'il existe
             if not VerifierSiCodeExiste('Dossier','PlanCpt.db','Compte',TaTrameL.fieldbyname('Compte').asString) then
             begin // inexistant
               VerifLigne.CodeErreur:=2001;
               VerifLigne.Retour:=false;
             end
             else
             begin // il existe
               VerifLigne.CodeErreur:=2002;
               VerifLigne.Retour:=false;
             end;
           end; //fin de pas vide
         end; //fin n° compte
      9 :begin //vérif code tva
           if not empty(TaTrameL.Fields[9].AsString) then
           begin   // pas vide:
           s:= '';
           s := TaTrameL.fieldbyname('TvaCode').asString;
             if not VerifierSiCodeExiste('Program','TvaCode.DB','TvaCode',s) then
             begin   // il n'existe pas:
               VerifLigne.CodeErreur:=7001;
               VerifLigne.Retour:=false;
             end;
           end;  
         end; // fin vérif  code
      10 :begin    //verif type tva
           if not empty(TaTrameL.Fields[10].AsString) then
           begin    //pas vide:on verifie
           s := '';
           s := upCase(Courant.AsString[1]);
             if not ((s = 'D')or(s = 'E')) then
             begin
               VerifLigne.CodeErreur:=7002;
               VerifLigne.Retour:=false;
             end;
           end;//fin pas vide
         end;//fin verif type
      11:begin    //verif taux tva
            if not empty(TaTrameL.Fields[11].AsString) then   //pas vide :on vérifie
            begin
              if not((StrToCurr_Lgr(TaTrameL.Fields[11].AsString) = 20.6)or(StrToCurr_Lgr(TaTrameL.Fields[11].AsString) = 5.5)) then
              begin
                VerifLigne.CodeErreur:=7003;
                VerifLigne.Retour:=false;
              end // fin verif saisie
            end;//fin pas vide
          end;//fin verif taux
    end; //fin case
  end;  // fin du traitement de l'enregistrement
end;

function TDMTrame.VerifEnrgLigne(Dataset: TField):TRetourFunction;
var
  i : integer;
  s : string;
begin
  s := '';
  VerifEnrgLigne.CodeErreur:=0;        // initialisations
  VerifEnrgLigne.Retour:=true;
  if lignesVides then  //enregistrement vide
  begin   
    VerifEnrgLigne.CodeErreur:=1111;
    VerifEnrgLigne.Retour:=false;
    exit;
  end;
  case TaTrameL.Fields[i].Index of
    2: // ligne
    begin
      if empty(TaTrameL.fieldbyname('Ligne').asstring) then   //si vide
      begin
        VerifEnrgLigne.CodeErreur:=2000;
        VerifEnrgLigne.Retour:=false;
      end  // fin vide
      else
      begin //pas vide  verifier si ligne existe...
        VerifEnrgLigne.CodeErreur:=2001;
        VerifEnrgLigne.Retour:=false;
      end;// fin pas vide
    end;
    3: // compte
    begin
      if empty (TaTrameL.fieldbyname('Compte').asstring) then   //si vide
      begin
        VerifEnrgLigne.CodeErreur:=3000;
        VerifEnrgLigne.Retour:=false;
      end// fin vide
      else
      begin //si pas vide
//        if not VerifierSiCodeExiste('Dossier','PlanCpt.db','Compte',Trame.ExDBGTrameL.Fields[1].AsString) then
        begin // inexistant
          VerifEnrgLigne.CodeErreur:=3001;
          VerifEnrgLigne.Retour:=false;
        end ;  // fin inexistant
      end; //fin de pas vide
    end;
    9: //code tva
    begin
      if not empty(TaTrameL.fieldbyname('TvaCode').asstring) then   //si pas vide
      begin
      s := TaTrameL.fieldbyname('TvaCode').asstring;
        if not VerifierSiCodeExiste('Program','TvaCode.DB','TvaCode',s) then
        begin
          VerifEnrgLigne.CodeErreur:=9000;
          VerifEnrgLigne.Retour:=false;
        end;
      end;  // fin pas vide
    end;
    10: // type tva
    begin
      if not empty(TaTrameL.fieldbyname('TvaType').AsString) then
      begin
      s := '';
      s := upCase(TaTrameL.fieldbyname('TvaType').AsString[1]);
        if not ((s = 'D')or(s = 'E')) then
        begin
          VerifEnrgLigne.CodeErreur:=10000;
          VerifEnrgLigne.Retour:=false;
        end; // fin verif type
      end;//fin pas vide
    end;
    11: // taux tva
    begin
      if not empty(TaTrameL.fieldbyname('TvaTaux').AsString) then   //pas vide
      begin
        if not((StrToCurr_Lgr(TaTrameL.fieldbyname('TvaTaux').AsString) = 20.6)or
               (StrToCurr_Lgr(TaTrameL.fieldbyname('TvaTaux').AsString) = 5.5)) then
        begin
          VerifEnrgLigne.CodeErreur:=11000;
          VerifEnrgLigne.Retour:=false;
        end // fin verif saisie
      end;//fin pas vide
    end;//fin verif taux
  end;//fin cas
end;

procedure TDMTrame.TraitementVerifEnrgLigne;
var
  doublon : integer;
begin
//  TaTrameL.AfterScroll:= nil;
//  case VerifEnrgLigne(TaTrameL.Fields[i]).CodeErreur of
//    1111:// enregistrement vide
//    begin
//      abort;
//    end;
//    2000: //pas de n° de ligne
//    begin
//      ligne:=0;
//      if (recupmaxligne<>0) then
//      begin
//        if cherchertrouligneapres<>0 then
//          TaTrameL.Fields[2].AsInteger:= cherchertrouligneapres
//        else
//        begin
//          if memoireL<>0 then
//            TaTrameL.Fields[2].AsInteger:= memoireL
//          else
//            TaTrameL.Fields[2].AsInteger:= RecupMaxLigne;
//        end;
//      end
//      else
//       TaTrameL.Fields[2].AsInteger:=recupMaxLigne;
//    end;
//    2001: // vérifier si la ligne existe
//    begin
//      ligne:=TaTrameL.Fields[2].AsInteger;
//      doublon:=verifierSiLigneExiste(ligne);
//      if ligne <> memoireL then  // si ligne = memoire c'est ok !
//      begin
//        if (doublon <> 0) then
//        begin
//          if automatique = true then
//          begin
//            if precedentLigneLibre <> 0 then
//              TaTrameL.Fields[2].AsInteger:= precedentLigneLibre
//            else
//            begin
//              if (memoireL<>0)and (doublon<>memoireL) then
//                TaTrameL.Fields[2].AsInteger:= memoireL
//              else
//                TaTrameL.Fields[2].AsInteger:= RecupMaxLigne;
//            end;
//          end
//          else
//            TaTrameL.Fields[2].AsInteger:= RecupMaxLigne;
//        end;
//      end;
//      if (ligne=0)  then
//      begin
//        if automatique = true then
//        begin
//          if(recupmaxligne<>1) then
//          begin
//            if cherchertrouligneapres<>0 then
//              TaTrameL.Fields[2].AsInteger:= cherchertrouligneapres
//            else
//            begin
//              if memoireL<>0 then
//                TaTrameL.Fields[2].AsInteger:= memoireL
//              else
//                TaTrameL.Fields[2].AsInteger:= RecupMaxLigne;
//            end;
//          end
//          else
//            TaTrameL.Fields[2].AsInteger:= RecupMaxLigne;
//        end
//        else
//          TaTrameL.Fields[2].AsInteger:= RecupMaxLigne;
//      end;
//    end;
//    3000: //pas de compte
//    begin
//      Application.Messagebox(Pchar('Voulez-vous le créer ?'),'Le compte doit être renseigné !',MB_YesNo);
////      Trame.ExDBGTrameL.selectedindex:=1;
//      abort;
//    end;
//    3001: //compte inexistant
//    begin
//      showmessage ('compte inexistant ( F1 pour lister )');
////      Trame.ExDBGTrameL.selectedindex:=1;
//      abort;
//    end;
//    9000: //code tva inexistant
//    begin
//      showmessage(' erreur de code ');
////      Trame.ExDBGTrameL.selectedindex:=5;
//      Main.CodeTVA1Click(self);
//      abort;
//    end;
//    10000: //type tva
//    begin
//      showmessage(' erreur de Type ( (D)ébit ou (E)ncaissement ) ');
////      Trame.ExDBGTrameL.selectedindex:=6;
//      abort;
//    end;
//    11000: // taux tva
//    begin
//      showmessage(' erreur de Taux ( 20.6 ou 5.5 ) ');
////      Trame.ExDBGTrameL.selectedindex:=7;
//      abort;
//    end;
//  end; //fin cas
//  TaTrameL.AfterScroll:=TaTrameLAfterScroll;
end;

procedure TDMTrame.TraitementVerifLigne;
var
  doublon,memoireligne:integer;
begin
//  TaTrameL.AfterScroll:= nil;
//  case VerifLigne(Trame.ExDBGTrameL.SelectedField).CodeErreur of
//     1000 :  //numero de ligne vide
//     begin
//       if automatique = true then  //automatique
//       begin
//         if TaTrameL.state = dsinsert then
//         begin
//           if Trame.ajout = false then
//           begin
//             if ligne <> 0 then
//             begin
//               if precedentLigneLibre <> 0 then
//                 memoireinsert:=precedentLigneLibre;
//             end
//             else
//               memoireinsert := recupMaxLigne;
//           end
//           else
//             memoireinsert := recupMaxLigne;
////         Trame.ExDBGTrameL.Fields[0].AsInteger:=memoireinsert;
//         end;//fin etat insert
//       end; // fin automatique
//     end;
//    1001 :   //pas vide
//    begin
////      ligne:=TaTrameL.Fields[2].AsInteger;
////      if TaTrameL.state in [dsinsert] then
////        memoireligne := memoireinsert;
////      if TaTrameL.state in [dsedit] then
////        memoireligne := memoireL;
////         if (ligne=0)  then
////         begin
////           if automatique = true then
////           begin
////             if(recupmaxligne<>1) then
////             begin
////               if cherchertrouligneapres<>0 then
////                 Trame.ExDBGTrameL.Fields[0].AsInteger:= cherchertrouligneapres
////               else
////               begin
////                 if memoireligne<>0 then
////                   Trame.ExDBGTrameL.Fields[0].AsInteger:= memoireligne
////                 else
////                   Trame.ExDBGTrameL.Fields[0].AsInteger:= RecupMaxLigne;
////               end;
////             end
////             else
////               Trame.ExDBGTrameL.Fields[0].AsInteger:= RecupMaxLigne;
////           end
////           else
////             Trame.ExDBGTrameL.Fields[0].AsInteger:= RecupMaxLigne;
////         end;
////      doublon:=verifierSiLigneExiste(ligne);
////      if doublon <> 0 then
////      begin // oui, existe
////        if automatique = true then
////         begin
////           if precedentLigneLibre <> 0 then
////             Trame.ExDBGTrameL.Fields[0].AsInteger:= precedentLigneLibre
////           else
////           begin
////             if (memoireligne<>0)and (doublon<>memoireligne) then
////               Trame.ExDBGTrameL.Fields[0].AsInteger:= memoireligne
////             else
////               Trame.ExDBGTrameL.Fields[0].AsInteger:= RecupMaxLigne;
////           end;
////         end
////        else
////          TaTrameL.Fields[2].AsInteger:= RecupMaxLigne;
////      end; //fin existe
//    end;// fin pas vide
//     2000 :
//      begin   //compte vide : remplir par défaut avec dernière saisie
//        if TaTrameL.FieldByName('Ligne').asstring <> '' then
//          renseignerCompte(TaTrameL.Fieldbyname('Compte').asString);
//      end; //fin cas compte vide
//      2001 :
//      begin     // compte non trouvé
//        showmessage ('compte inexistant ( F1 pour lister )');
//        Trame.ExDBGTrameL.Fields[1].Clear;
//        Trame.ExDBGTrameL.Selectedindex:=1;
//        abort;
//      end;  //fin cas compte inexistant
//      2002 :
//      begin  //compte trouvé : prendre en mémoire et remplir le libellé...
//        compteL := TaTrameL.Fieldbyname('Compte').asString;
//        if empty(TaTrameL.Fieldbyname('Libelle').asString)then
//          renseignerCompte(TaTrameL.Fieldbyname('Compte').asString);
//      end;
//      7001 :
//      begin    //erreur saisie code
//        showmessage(' erreur de code ');
//        Main.CodeTVA1Click(self);
//        Trame.ExDBGTrameL.Fields[5].Clear;
//        Trame.ExDBGTrameL.selectedindex:=5;
//        abort;
//      end;   // fin erreur saisie code
//      7002 :
//      begin    //erreur saisie type
//        showmessage(' erreur de Type ( (D)ébit ou (E)ncaissement ) ');
//        Trame.ExDBGTrameL.Fields[6].Clear;
//        Trame.ExDBGTrameL.selectedindex:=6;
//        abort;
//      end;   // fin erreur type
//      7003 :
//      begin    //erreur saisie taux
//        showmessage(' erreur de Taux ( 20.6 ou 5.5 ) ');
//        Trame.ExDBGTrameL.Fields[7].Clear;
//        Trame.ExDBGTrameL.selectedindex:=7;
//        abort;
//      end;   // fin erreur taux
//    end;            // fin des cas
//  TaTrameL.AfterScroll:= TaTrameLAfterScroll;
end;

//******************************************************************************
//                         numéros de lignes
//******************************************************************************
function TDMTrame.VerifierSiLigneExiste(ligne: integer):integer;
var
  Qligne : TQuery;
begin
  result := 0;
  existe := false;
  Qligne := TQuery.create(self);
  try
  with  Qligne do
  begin
    DataBaseName := 'Dossier' ;
    close;
    Sql.Clear;
    Sql.Add ('SELECT * FROM TrameL.DB '  );
    Sql.Add ('WHERE ID_Trame = ' + '''' +  IntToStr(id_trame) + '''');
    Open;
    first;
    while not Qligne.eof do
    begin
      if Qligne.FieldByName('Ligne').asInteger <> ligne then
        next
      else
      begin
        result := Qligne.FieldByName('Ligne').asInteger;
        existe := true;
        Qligne.last;
      end;
    end;
  end;
  finally
  Qligne.close;
  Qligne.free;
  end;
end;

function TDMTrame.suivantLigneLibre:integer;
var
  QTable : TQuery;
begin
  QTable := TQuery.create(nil);
  try
  with  QTable do
  begin
    result := 0;
    DataBaseName := 'Dossier' ;
    close;
    Sql.Clear;
    Sql.Add ('SELECT * FROM TrameL.db' );
    Sql.Add ('WHERE ID_Trame = ' + '''' +  intToStr(id_trame) + '''');
    Sql.Add ('Order by Ligne');
    Open;
    if ligne <> 0 then
    begin
      Locate('Ligne', ligne, []);
      memoireL := FieldByName('Ligne').AsInteger;
      next;
      if FieldByName('Ligne').AsInteger <>  memoireL + 1 then
        result := memoireL + 1;
    end
    else
      result := 1;
  end;
  finally
    QTable.close;
    QTable.Free;
  end;
end;

function TDMTrame.precedentLigneLibre:integer;
var
  QTable : TQuery;
  memoire: integer;
begin
  QTable := TQuery.create(nil);
  try
  with  QTable do
  begin
    result := 0;
    DataBaseName := 'Dossier' ;
    close;
    Sql.Clear;
    Sql.Add ('SELECT * FROM TrameL.db' );
    Sql.Add ('WHERE ID_Trame = ' + '''' +  intToStr(id_trame) + '''');
    Sql.Add ('Order by Ligne');
    Open;
    if ligne <> 0 then
    begin
      Locate('Ligne', ligne, []);
      memoire := FieldByName('Ligne').AsInteger;
      prior;
      if FieldByName('Ligne').AsInteger <>  memoire - 1 then
        result := memoire - 1;
    end
    else
      result := 1;
  end;
  finally
    QTable.close;
    QTable.Free;
  end;
end;

procedure TDMTrame.decrementerLigne(ligne:integer);
var
  QTable : TQuery;
begin
  TaTrameL.BeforePost:= nil;
  TaTrameL.AfterScroll:= nil;
  QTable := TQuery.create(nil);
  try
  with  QTable do
  begin
    DataBaseName := 'Dossier' ;
    close;
    Sql.Clear;
    sql.add('select Ligne from TrameL.DB ');
    sql.add('where ID_Trame='+ ''''+inttostr(id_trame)+'''');
    sql.add('and Ligne>'+''''+inttostr(ligne)+'''');
    open;
    first;
    while not QTable.EOF do
    begin
    TaTrameL.locate('Ligne',FieldByName('Ligne').asinteger,[]);
    TaTrameL.edit;
    TaTrameL.FieldByName('Ligne').asinteger:=TaTrameL.FieldByName('Ligne').asinteger-1;
    TableGerePost(TaTrameL);
    QTable.next;
    end;
  end;
  finally    
    QTable.close;
    QTable.Free;
    TaTrameL.BeforePost:= TaTrameLBeforePost;
    TaTrameL.AfterScroll:= TaTrameLAfterScroll;
  end;
end;

procedure TDMTrame.incrementerTout(ligne: integer);
var
  QTable : TQuery;
begin
  TaTrameL.BeforePost:= nil;
  TaTrameL.beforeScroll:= nil;
  TaTrameL.AfterScroll:= nil;
  QTable := TQuery.create(nil);
  try
  with  QTable do
  begin
    DataBaseName := 'Dossier' ;
    close;
    Sql.Clear;
    sql.add('select Ligne from TrameL.DB ');
    sql.add('where ID_Trame='+ ''''+inttostr(id_trame)+'''');
    sql.add('and Ligne>'+''''+inttostr(ligne)+'''');
    open;
    first;
    while not QTable.EOF do
    begin
    TaTrameL.locate('Ligne',FieldByName('Ligne').asinteger,[]);
    TaTrameL.edit;
    TaTrameL.FieldByName('Ligne').asinteger:=TaTrameL.FieldByName('Ligne').asinteger+1;
    TableGerePost(TaTrameL);
    QTable.next;
    end;
  end;
  finally
    QTable.close;
    QTable.Free;
    TaTrameL.BeforePost:= TaTrameLBeforePost;
    TaTrameL.AfterScroll:= TaTrameLAfterScroll;
    TaTrameL.beforeScroll:= TaTrameLbeforeScroll;
  end;
end;

function TDMTrame.chercherTrouLigneAvant: integer;
var
  QTable : TQuery;
  indexligne: integer;
begin
  result := 0;
  indexligne := ligne;
  QTable := TQuery.create(nil);
  with  QTable do
  begin
    DataBaseName := 'Dossier' ;
    close;
    Sql.Clear;
    Sql.Add ('SELECT * FROM TrameL.db' );
    Sql.Add ('WHERE ID_Trame = ' + '''' +  intToStr(id_trame) + '''');
    Sql.Add ('Order by Ligne');
    Open;
    locate('Ligne',indexligne,[]);
     while ((FieldByName('Ligne').AsInteger = indexligne) and  (not QTable.BOF)) do
     begin
       FieldByName('Ligne').AsInteger := indexligne - 1;
       prior;
     end;
     if ((FieldByName('Ligne').AsInteger <> indexligne) and  (not QTable.BOF))then
       result:= indexligne;
    end;
    QTable.Close;
    QTable.free;
  end;


function TDMTrame.chercherTrou(avant:boolean;place:integer):integer;
begin
  result := 0;
  if avant = true then
    result := chercherTrouLigneAvant
  else
    result := chercherTrouLigneApres;
end;


function TDMTrame.chercherTrouLigneApres:integer;
var
  QTable : TQuery;
  indexligne: integer;
begin
  result := 0;
  indexligne := 1;
  QTable := TQuery.create(nil);
  with  QTable do
  begin
    DataBaseName := 'Dossier' ;
    close;
    Sql.Clear;
    Sql.Add ('SELECT * FROM TrameL.db' );
    Sql.Add ('WHERE ID_Trame = ' + '''' +  intToStr(id_trame) + '''');
    Sql.Add ('Order by Ligne');
    Open;
    first;
     while ((QTable.FieldByName('Ligne').AsInteger = indexligne) and  (not QTable.EOF)) do
     begin
       inc(indexligne);
       next;
     end;
     if ((FieldByName('Ligne').AsInteger <> indexligne) and  (not QTable.EOF))then
       result:= indexligne;
    end;
    QTable.Close;
    QTable.free;
  end;


function TDMTrame.recupMaxLigne: integer;
var
QLigne : TQuery;
begin
  QLigne:= TQuery.create(nil);
  result:=0;
  try
  with  QLigne do
  begin
    DataBaseName := 'Dossier' ;
    close;
    Sql.Clear;
    sql.add('select max(Ligne)as nadine from TrameL.db where ID_Trame = '+ ''''+intToStr(id_trame)+ '''');
    Open;
    result := FindField('nadine').asInteger+1;
    close;
  end;
  finally
    QLigne.free;
  end;
end;





procedure TDMTrame.TaTrameLAfterEdit(DataSet: TDataSet);
begin
//  TaTrameL.BeforeInsert:=TaTrameLBeforeInsert;
end;


function TDMTrame.EnvoieTrame_TrameLigne_SurListe(Liste:Tlist;Ecriture:TEcriture_Isa):TExceptLGR_ImportPiece;
begin
result.Erreur.retour:=true;
result.Erreur.numErreur:=0;
result.Mess:='';
      Try
      TableGereStartTransaction(TaTrame_Obj);        
      BatchMove_Liste_SurTaTrame(liste,ecriture);
      //crée la trame
//      TaTrame_Obj.AppendRecord([trame1.IDTrame,trame1.CodeTrame,trame1.LibelleTrame,
//      trame1.Libellepiece,dmpieces.Piece1.Journal,dmpieces.Piece1.compte,trame1.CptBanque,true,
//      e.Devise,dmpieces.Piece1.IDJournal,e.NomUtilisateur,now]);
      TaTrame_Obj.AppendRecord([trame1.IDTrame,trame1.CodeTrame,trame1.LibelleTrame,
      trame1.Libellepiece,Ecriture.piece.journal,Ecriture.piece.compte,trame1.CptBanque,true,
      e.Devise,Ecriture.piece.idjournal,e.NomUtilisateur,now]);
      TaTrame_Obj.FlushBuffers;
      except
      result:=trame1.ErreurTrame;
      //showmessage('Problème à l''enregistrement de la trame !!!');
      SupprLigneTrame(trame1.IDTrame);
      TableGereRollBack(TaTrame_Obj);
      abort;
      end;//fin du try
End;



function TDMTrame.BatchMove_Liste_SurTaTrame(Source:TList;Ecriture:TEcriture_Isa):integer;
var
i,IDEcriture,IMax,IMin:integer;
ListDelete:Tstringlist;
Debit,credit,MontantTva:currency;
Qte1,Qte2,Compte:string;
Begin
try
ListDelete:=TStringList.Create;
result:=0;
Debit:=0;
credit:=0;
Qte1:='';
Qte2:='';
MontantTva:=0;
  if (source<>nil) and (TaTrameL<>nil) then
   begin
   if TaTrameL_Obj.active then
     TaTrameL_Obj.close;
   TaTrameL_Obj.Open;
        try
        i:=0;
        while i<=source.Count-1 do
          Begin
          if ((PIdentifiant_obj(source.Items[i])^.Ligne.TypeLigne ='V')or((PIdentifiant_obj(source.Items[i])^.Ligne.Debit=0)and(PIdentifiant_obj(source.Items[i])^.Ligne.TypeLigne ='T')and(PIdentifiant_obj(source.Items[i])^.Ligne.Credit=0)))then
            begin
               PIdentifiant_obj(source.Items[i])^.Ligne.Enregistrer:=false;
            end
            else
               PIdentifiant_obj(source.Items[i])^.Ligne.Enregistrer:=true;
          inc(i);
          End;

         //Mise en ordre du corps de la pièce
         //avec les lignes T(TVA) toujours à la fin de la pièce
        IMin:=1;
        IMax:=source.count-1;
        while IMin<IMax do
          Begin
            if PIdentifiant_obj(source.Items[IMax])^.Ligne.TypeLigne='T'then
              dec(IMax)
            else
              Begin
                if PIdentifiant_obj(source.Items[IMin])^.Ligne.TypeLigne<>'T'then
                  inc(IMin)
                else
                  Begin
                    if PIdentifiant_obj(source.Items[IMin])^.Ligne.TypeLigne='T'then
                      Begin
                        source.Exchange(IMin,IMax);
                        dec(IMax);
                        inc(IMin);
                      End;
                  End;
              End;
          End;

        for i:=0 to source.Count-1 do
          Begin//for longueur du source
          //remplissage de la table trameLigne par rapport à la liste
          if PIdentifiant_obj(source.Items[i])^.Ligne.Enregistrer then
            begin//si c'est une ligne à enregister
                 Trame1.IDTrame_Ligne:=Trame1.NewID(taTrameL,'ID');
                 with PIdentifiant_obj(source.Items[i])^ do
                 begin
                 if trame1.ConserveMontant then
                   begin
                      Debit:=ligne.Debit;
                      credit:=ligne.Credit;
                      Qte1:=ligne.Qt1;
                      Qte2:=ligne.Qt2;
                      MontantTva:=Ligne.Complement.MontantTva;
                   end;
                 if not empty(ligne.Tiers) then
                   compte:=ligne.Tiers
                 else
                   compte:=ligne.Compte;
                 if Ecriture.Piece.IDJournal in [1,2] then //si achat ou vente on gére la tva
                   TaTrameL_Obj.AppendRecord([Trame1.IDTrame_Ligne,Trame1.IDTrame,i,Compte,
                   ligne.Libelle,Qte1,Qte2,Debit,Credit,ligne.Complement.CodeTvaCompl,
                   ligne.Complement.TvaType,ligne.Complement.TvaTaux,MontantTva,e.NomUtilisateur,now,Ligne.TypeLigne])
                 else  //si autres pièce, on ne gère pas la tva pour le moment
                   TaTrameL_Obj.AppendRecord([Trame1.IDTrame_Ligne,Trame1.IDTrame,i,Compte,
                   ligne.Libelle,Qte1,Qte2,Debit,Credit,'',
                   '',0,0,e.NomUtilisateur,now,Ligne.TypeLigne]);
                 TaTrameL_Obj.FlushBuffers;
                 end;
            end;//fin si c'est une ligne à enregister
          End;//fin for longueur du source
        except
        showmessage('Erreur d''Ecriture dans Table TrameLigne');
        for i:=0 to ListDelete.Count-1 do
        DMEcritures.Ecriture_Isa1.ListIdentifiantAdd_insert([0,0,0,'','','','','',0,0,false,'V',False,False,False,False,False,false,False,'',0,0,'','',False,'','','',0,0,false,'','','',0,0,false,true,'','',0],false,false,StrToInt_Lgr(ListDelete.Strings[i]));
        abort;
        end;//fin du try
   end;//fin si source <> nil
finally
ListDelete.free;
end;//fin du try finally
End;


procedure TDMTrame.TaTrame_ObjPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(TaTrame_Obj);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMTrame.TaTrame_ObjDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(TaTrame_Obj);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMTrame.TaTrameL_ObjPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(TaTramel_Obj);
TableGereRollBack(DMBalance.TaBalance);
end;

procedure TDMTrame.TaTrameL_ObjDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
TableGereRollBack(TaTramel_Obj);
TableGereRollBack(DMBalance.TaBalance);
end;


function TDMTrame.VerifExistenceTrame(champRecherche,valeurRecherche:array of string):boolean;
var
ListeChamp,ListeValeur:Tstringlist;
i:integer;
Exception:TExceptLGR;
begin
Initialise_ExceptLGR(Exception,GestMessageLGR);
//Exception.GestMessageLGR:=GestMessageLGR;
Exception.NomModule:='';
try
result:=false;

ListeChamp:=Tstringlist.create;
ListeChamp.clear;
ListeValeur:=Tstringlist.create;
ListeValeur.clear;

for i:=0 to high(champRecherche)do
  ListeChamp.Add(champRecherche[i]);

for i:=0 to high(valeurRecherche)do
  ListeValeur.Add(valeurRecherche[i]);

FiltrageDataSet(TaTrame,CreeFiltreET([ListeChamp],[ListeValeur]));
//FiltrageDataSet(TaTrame,CreeFiltreET(['Journal','Code'],[Journal,Code]));
result:=tatrame.RecordCount<>0;
deFiltrageDataSet(TaTrame);
except
  raise ExceptLGR.Create('Problème sur la vérification de l''existence d''un code trame',1000,true,mtError,Exception);
end;
End;


procedure TDMTrame.TaTrameDeleteError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
    TableGereRollBack(DataSet);
end;

procedure TDMTrame.TaTrameAfterDelete(DataSet: TDataSet);
begin
try
 SupprLigneTrame(Id_Trame);
 TableGereCommit(DataSet);
except
 TableGereRollBack(DataSet);
end;
end;

procedure TDMTrame.SupprLigneTrame(IdTrame:Integer);
begin
  try
    FiltrageDataSet(TaTrameL_Obj,'ID_trame='+IntToStr(IDTrame));
    DMTrame.TaTrameL_Obj.first;
    while TaTrameL_Obj.RecordCount > 0 do
    TableGereDelete(DMTrame.TaTrameL_Obj);
    DeFiltrageDataSet(TaTrameL_Obj);
  except
    abort;
  end;
end;



function TDMTrame.CtrlInfosTrame_Obj(CCourant:TField):TExceptLGR_ImportPiece;
begin
Try
Initialise_ExceptLGR(result.Erreur);
//Result.Erreur.NumErreur:=0;
//Result.Erreur.Retour:=True;
result.Mess:='';
Case CCourant.DataSet.State of
   dsInsert,
   dsedit:Begin
             case CCourant.Index of
                // traitement du code trame
                //*************************************************************************
                1:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Vous devez saisir le code de la Trame.',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result.Erreur);
                  if DMTrame.VerifExistenceTrame(['Journal','Code'],[CCourant.DataSet.findfield('Journal').AsString,CCourant.AsString])then
                      raise ExceptLGR.Create('Le code '+CCourant.AsString+' existe déjà dans une trame, vous devez en saisir un autre ?',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),true,mtError,result.Erreur);
                //vérifier si code trame n'est pas déjà employé dans les codes de journaux
                 FiltrageDataSet(DMRech.TaModelRech,'Code = '''+CCourant.AsString+'''');
                 if DMRech.TaModelRech.RecordCount > 0 then
                      raise ExceptLGR.Create('Le code '+CCourant.AsString+' existe déjà dans les journaux, vous devez en saisir un autre ?',StrToInt_Lgr(IntToStr(CCourant.Index)+'002'),true,mtError,result.Erreur);
//                  if result.Retour then
//                     DMTrame.Trame1.CodeTrame:=CCourant.AsString;
                  End;
                // traitement du Libelle trame
                //*************************************************************************
                2:Begin
                  if Empty(CCourant.AsString) then
                     raise ExceptLGR.Create('Vous devez saisir le Libelle de la Trame.',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result.Erreur);
                  if DMTrame.VerifExistenceTrame(['Journal','Libelle_Trame'],[CCourant.DataSet.findfield('Journal').AsString,CCourant.AsString])then
                    if application.MessageBox(Pchar('Ce Libellé existe déjà dans une trame, voulez-vous le conserver ?'),'Erreur de saisie',0)=mrno then
                      raise ExceptLGR.Create('',StrToInt_Lgr(IntToStr(CCourant.Index)+'001'),false,mtError,result.Erreur);
//                  if result.Retour then
//                     DMTrame.Trame1.LibelleTrame:=CCourant.AsString;
                  End;
                // traitement du Libelle Piece
                //*************************************************************************
                3:Begin
                  if Empty(CCourant.AsString) then
                      CCourant.AsString:=CCourant.DataSet.findfield('libelle_Trame').AsString;
                     //raise ExceptLGR.Create('Vous devez saisir le Libelle de la Pièce.',StrToInt_Lgr(IntToStr(CCourant.Index)+'000'),true,mtError,result);
//                  if result.Retour then
//                     DMTrame.Trame1.LibellePiece:=CCourant.AsString;
                  End;
             end;//fin case index
          end;//fin si edit ou insert   
end;//fin du case state
except
  case Result.Erreur.NumErreur of
    1000:result.Mess:='Vous devez saisir le code de la Trame.';
    1001:result.Mess:='Le code '+CCourant.AsString+' existe déjà dans une trame, vous devez en saisir un autre ?';
    1002:result.Mess:='Le code '+CCourant.AsString+' existe déjà dans les journaux, vous devez en saisir un autre ?';
    2000:result.Mess:='Vous devez saisir le Libelle de la Trame.';
  end;//fin du case
  abort;
end;
end;

procedure TDMTrame.TaTrame_ObjBeforePost(DataSet: TDataSet);
var
i:integer;
ErreurListe:TExceptLGR_ImportPiece;
begin
      Case DataSet.State of
         dsInsert,
         dsedit  :Begin
                  For I:=0 to DataSet.FieldCount-1 do
                    begin
                     try
                      ErreurListe:=CtrlInfosTrame_Obj(DataSet.Fields[i]);
                     except
                      Trame1.ErreurTrame:=ErreurListe;
                      case ErreurListe.Erreur.NumErreur of
                      // Traitement de tous
                      //*************************************************************************
                      1000,
                      1001,
                      1002:Begin
                              DataSet.Fields[i].FocusControl;
                              abort;
                           End;
                      // Traitement libelle trame
                      //*************************************************************************
                      2000,
                      2001,
                      2002:Begin
                              //Application.Messagebox(Pchar('L"id activite est vide'),'Erreur de saisie',0);
                              DataSet.Fields[i].FocusControl;
                              abort;
                           End;
                      // Traitement libelle Piece
                      //*************************************************************************
                      3000,
                      3001,
                      3002:Begin
                              //Application.Messagebox(Pchar('L"id activite est vide'),'Erreur de saisie',0);
                              DataSet.Fields[i].FocusControl;
                              abort;
                           End;
                End; // Fin du case
               End; // Fin du try
              End; // Fin du begin de boucle For
            End; // Fin Begin du dsEdit
      end;//fin du case state

end;

procedure TDMTrame.TaTrame_ObjBeforeDelete(DataSet: TDataSet);
begin
  try
     TableGereStartTransaction(DataSet);

    id_trame :=  TaTrame_Obj.FieldByName('ID').asInteger;
  except
    TableGereRollBack(DataSet);
    abort;
  end;

end;

procedure TDMTrame.TaTrame_ObjAfterDelete(DataSet: TDataSet);
begin
try
 SupprLigneTrame(Id_Trame);
 TableGereCommit(DataSet);
except
 TableGereRollBack(DataSet);
end;

end;

end.



