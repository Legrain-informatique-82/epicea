unit DMReglement;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Gr_Librairie;
  //GestCoLibSQL, GestCoLibDM ;

// sert à récupérer le code erreur suite à la vérification de la saisie
type
  TRetFunction = record
    CodeErreur:integer;
    Retour:boolean;
end;

type
  TDMReglements = class(TDataModule)
    DaReglement: TDataSource;
    TaReglement: TTable;
    QueryID: TQuery;
    TaConsultReglement: TTable;
    DaConsultReglement: TDataSource;
    Query1: TQuery;
    QueryIDMAXOFId: TIntegerField;
    procedure DMReglementsCreate(Sender: TObject);
    procedure DMReglementsDestroy(Sender: TObject);
//******************************************************************************
    procedure RechercheID;
    function VerifIfExist(TableCtrl:TTable;champ,Valeurchamp: string):boolean;
    procedure FiltrageTable(tableCtrl:TTable;chaineFiltre:string);
    function StrListe(TableCtrl:TTable;nomChamp:string):TStringList;
//******************************************************************************
    Function CtrlSaisie(CCourant:Tfield):TRetFunction;
//******************************************************************************
    procedure TaReglementBeforePost(DataSet: TDataSet);
    procedure TaReglementPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaReglementAfterPost(DataSet: TDataSet);
    procedure TaReglementBeforeDelete(DataSet: TDataSet);
    procedure TaReglementDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TaReglementAfterDelete(DataSet: TDataSet);
    procedure TaConsultReglementFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);


  private
    { Déclarations privées }
  public
    { Déclarations publiques }

  end;

var
  DMReglements: TDMReglements;

implementation
 uses E2_SaisieReglement;
{$R *.DFM}

//******************************************************************************
//                   vérifie l'existence de la valeur demandée
//******************************************************************************


procedure TDMReglements.DMReglementsCreate(Sender: TObject);
var I:integer;
begin
 try
   for i:=0 to DMReglements.ComponentCount -1 do
     if DMReglements.components[i].className = 'TTable' then
         (DMReglements.components[i]as TTable).open;
 except
//  DatabaseError :
   begin
     showmessage('Table '+DMReglements.Components[i].Name+' inconnue dans la fenêtre'+DMReglements.Name);
     DMReglements.Destroy;
   end;
 end;
 try
   for i:=0 to DMReglements.componentcount-1 do
     if DMReglements.components[i].className = 'TQuery' then
         (DMReglements.components[i]as TQuery).open;
 except
//  DatabaseError :
   begin
     showmessage('Query '+DMReglements.Components[i].Name+' inconnue dans la fenêtre'+DMReglements.Name);
     DMReglements.Destroy;
   end;
 end;
end;

procedure TDMReglements.DMReglementsDestroy(Sender: TObject);
var
  I:integer;
begin
 try
   for i:=0 to DMReglements.ComponentCount -1 do
     if DMReglements.components[i].className = 'TTable' then
         (DMReglements.components[i]as TTable).Close;
 except
//  DatabaseError :
   begin
     showmessage('Table inconnue dans la fenêtre'+DMReglements.Name);
     DMReglements.Destroy;
   end;
 end;
 try
   for i:=0 to DMReglements.componentcount-1 do
     if DMReglements.components[i].className = 'TQuery' then
         (DMReglements.components[i]as TQuery).close;
 except
//  DatabaseError :
   begin
     showmessage('Query inconnue dans la fenêtre'+DMReglements.Name);
     DMReglements.Destroy;
   end;
 end;
end;
{*******************************************************************************
                   recherches et vérifications d'existence...
*******************************************************************************}
function TDMReglements.VerifIfExist(TableCtrl:TTable;champ,Valeurchamp: string):boolean;
begin
  try
    begin
    TableCtrl.Locate(champ,valeurchamp,[loCaseInsensitive]);
    result := true;
    end;
  except
    result := false;
  end;
end;

procedure TDMReglements.RechercheID;
begin
 try
   begin
     if queryID.Active=true then  queryID.Active:=false;
     queryID.Active:=true;
{***************      traitements éventuels... *****************************}
   end;
 except
   begin
     showmessage('Problème dans la table ...');
     abort;
   end;
 end;
end;

{*******************     Filtrage de Table            **************************
           cette procedure sert à filter les enregistrements
      ( en fonction du remplissage d'un champ pas vide ...par exemple.)
*******************************************************************************}
procedure TDMReglements.FiltrageTable(tableCtrl:TTable;chaineFiltre:string);
begin
  tableCtrl.Filtered := False;
  tableCtrl.Filter := (chaineFiltre);//ex: ('Reference <> '''')
  tableCtrl.Filtered := True;
  tableCtrl.RecordCount;
end;

{La propriété Filter n'autorise pas les comparaisons de champs pour les tables
locales (Paradox, dBASE, Access, FoxPro) alors qu'un gestionnaire d'événements
'OnFilterRecord' le permet...}
procedure TDMReglements.TaConsultReglementFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=(dataset as Ttable).FieldByName('champ1').AsFloat < (dataset as Ttable).FieldByName('Champ2').AsFloat;
end;

{*******************     Creation de Liste             *************************
           cette procedure sert à créer une stringList...
*******************************************************************************}
function TDMReglements.StrListe(TableCtrl:TTable;nomChamp:string):TStringList;
begin
  FiltrageTable(TableCtrl,'champ1 = valeur1');// si besoin ...
  result:=TStringList.Create;
  result.Clear;
   While Not(TableCtrl.EOF) Do
   Begin
{******** traitements éventuels ******************}
     result.Add(TableCtrl.findfield(nomChamp).AsString);
     TableCtrl.Next;
   End;
end;
                                                            

{******************************************************************************
      contrôle de la saisie : retour du code erreur, traitements ailleurs...
******************************************************************************}
Function TDMReglements.CtrlSaisie(CCourant:Tfield):TRetFunction;
begin
{initialisation des variables de retour de fonction}
  CtrlSaisie.CodeErreur:=0;
  CtrlSaisie.Retour:=True;
{si table en état insertion ou modification}
  if TaReglement.State in [dsinsert,dsEdit] then
  begin
    case CCourant.Index of
      1: begin {si champ n° 1 pa exemple...}
{si vide}  If Empty(CCourant.AsString) then
           Begin
             CtrlSaisie.CodeErreur:=1100;
             CtrlSaisie.Retour:=False;
           end
{pas vide} else
           begin  {n'existe pas}
             if VerififExist(TaReglement,'champX',ccourant.AsString)=false then
             begin
               CtrlSaisie.CodeErreur:=1101;
               CtrlSaisie.Retour:=False;
             end
             else {existe}
             begin
                {traitement direct : initialisation de certains champs...
                                    exemple ds dmplan (RecupInfoApresVerif)
                 ou : }
               CtrlSaisie.CodeErreur:=1102;
               CtrlSaisie.Retour:=False;
             end;
           end;
         end; {fin champ n°1}
    2:;
    end;{fin du case.ccourant}
  end; {fin etat insertion ou modif}
end;


{*******************    Table1BeforePost            ****************************
       Cette procedure permet de faire une vérification des saisie.
   Commence la transaction: quand plusieurs choses doivent se faire en chaîne,
 si un problème se présente sur une des actions, toutes les actions entreprises
    seront annulées...
*******************************************************************************}

procedure TDMReglements.TaReglementBeforePost(DataSet: TDataSet);
var
  i:integer;
  RetourFonction:TRetFunction;
begin
  case TaReglement.State of
  dsInsert: begin
  {**************************************************************************
           voir si traitements à faire (recherches ou autre...)
           par ex : Table1DateSysteme.AsDateTime := Now;
  **************************************************************************}
            end;
  dsEdit: begin
  {**************************************************************************
           voir si traitements à faire (recherches ou autre...)
           par ex : Table1DateSysteme.AsDateTime := Now;
  **************************************************************************}
          end;
  end;//fin du case

// *******  début de la boucle de vérification des saisies *****************
  for i:=1 to 4 do //vérification des champs (ici, 1 à 4 par ex.)
     begin
       RetourFonction:=CtrlSaisie(TaReglement.Fields[i]);
       if  RetourFonction.Retour=false then
           case  RetourFonction.CodeErreur of
               1100,1101:  // par exemple : vide ou n'existe pas...
                 begin //  re-saisir
                   DataSet.Fields[i].FocusControl;
                   abort;
                 end;
           end; //fin case
     end; //fin boucle
{***************  on commence la transaction  ******************************}
  TaReglement.Database.StartTransaction;
  TaReglement.Database.TransIsolation:=tiDirtyRead;
   try
      if TaReglement.State=dsinsert then
      begin
{ici, plusieurs traitements à faire sur d'autres tables de la base de données}
      end;
      if TaReglement.State=dsedit then
{ici, plusieurs traitements à faire sur d'autres tables de la base de données}
   except
{*********  on annule la transaction (=ttes les actions) *******************}
     TaReglement.Database.Rollback;  //
     showmessage('Problèmes' + 'genre de problème...' + ' !!!');
     abort;
   end;//fin du try
end;

procedure TDMReglements.TaReglementPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
{*********  on annule la transaction (=ttes les actions) *******************}
  TaReglement.Database.Rollback;
end;

procedure TDMReglements.TaReglementAfterPost(DataSet: TDataSet);
begin
{ Valide la transaction (=ttes les actions se sont déroulées sans problèmes)}
  TaReglement.Database.Commit;
{ *************     + traitements éventuels ... ***************************** }
end;


{*******************************************************************************
                        idem pour le Delete...
*******************************************************************************}
procedure TDMReglements.TaReglementBeforeDelete(DataSet: TDataSet);
begin
{***************      traitements éventuels... *****************************}
{***************  on commence la transaction  ******************************}
  TaReglement.Database.StartTransaction;
  TaReglement.Database.TransIsolation:=tiDirtyRead;
  case self.Tag of    // par exemple ...
     1: begin
            try
{***************        traitements à faire     *****************************}
{ici, plusieurs traitements à faire sur d'autres tables de la base de données}
            except
               begin
{*********  on annule la transaction (=ttes les actions) *******************}
                 TaReglement.Database.Rollback;
                 showmessage('Problèmes !!!');
                 abort;
               end;
            end;
        end;
     2: begin
           try
{***************        traitements à faire     *****************************}
{ici, plusieurs traitements à faire sur d'autres tables de la base de données}
           except
              begin
{*********  on annule la transaction (=ttes les actions) *******************}
                TaReglement.Database.Rollback;
                showmessage('Problèmes !!!');
                abort;
              end;
           end;
        end;
    end;
end;


procedure TDMReglements.TaReglementDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
{*********  on annule la transaction (=ttes les actions) *******************}
  TaReglement.Database.Rollback;
end;

procedure TDMReglements.TaReglementAfterDelete(DataSet: TDataSet);
begin
{ Valide la transaction (=ttes les actions se sont déroulées sans problèmes)}
  TaReglement.Database.Commit;
{ *************     + traitements éventuels ... ***************************** }
end;



end.
