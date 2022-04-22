unit DMReglement;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Gr_Librairie;
  //GestCoLibSQL, GestCoLibDM ;

// sert � r�cup�rer le code erreur suite � la v�rification de la saisie
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
    { D�clarations priv�es }
  public
    { D�clarations publiques }

  end;

var
  DMReglements: TDMReglements;

implementation
 uses E2_SaisieReglement;
{$R *.DFM}

//******************************************************************************
//                   v�rifie l'existence de la valeur demand�e
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
     showmessage('Table '+DMReglements.Components[i].Name+' inconnue dans la fen�tre'+DMReglements.Name);
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
     showmessage('Query '+DMReglements.Components[i].Name+' inconnue dans la fen�tre'+DMReglements.Name);
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
     showmessage('Table inconnue dans la fen�tre'+DMReglements.Name);
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
     showmessage('Query inconnue dans la fen�tre'+DMReglements.Name);
     DMReglements.Destroy;
   end;
 end;
end;
{*******************************************************************************
                   recherches et v�rifications d'existence...
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
{***************      traitements �ventuels... *****************************}
   end;
 except
   begin
     showmessage('Probl�me dans la table ...');
     abort;
   end;
 end;
end;

{*******************     Filtrage de Table            **************************
           cette procedure sert � filter les enregistrements
      ( en fonction du remplissage d'un champ pas vide ...par exemple.)
*******************************************************************************}
procedure TDMReglements.FiltrageTable(tableCtrl:TTable;chaineFiltre:string);
begin
  tableCtrl.Filtered := False;
  tableCtrl.Filter := (chaineFiltre);//ex: ('Reference <> '''')
  tableCtrl.Filtered := True;
  tableCtrl.RecordCount;
end;

{La propri�t� Filter n'autorise pas les comparaisons de champs pour les tables
locales (Paradox, dBASE, Access, FoxPro) alors qu'un gestionnaire d'�v�nements
'OnFilterRecord' le permet...}
procedure TDMReglements.TaConsultReglementFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=(dataset as Ttable).FieldByName('champ1').AsFloat < (dataset as Ttable).FieldByName('Champ2').AsFloat;
end;

{*******************     Creation de Liste             *************************
           cette procedure sert � cr�er une stringList...
*******************************************************************************}
function TDMReglements.StrListe(TableCtrl:TTable;nomChamp:string):TStringList;
begin
  FiltrageTable(TableCtrl,'champ1 = valeur1');// si besoin ...
  result:=TStringList.Create;
  result.Clear;
   While Not(TableCtrl.EOF) Do
   Begin
{******** traitements �ventuels ******************}
     result.Add(TableCtrl.findfield(nomChamp).AsString);
     TableCtrl.Next;
   End;
end;
                                                            

{******************************************************************************
      contr�le de la saisie : retour du code erreur, traitements ailleurs...
******************************************************************************}
Function TDMReglements.CtrlSaisie(CCourant:Tfield):TRetFunction;
begin
{initialisation des variables de retour de fonction}
  CtrlSaisie.CodeErreur:=0;
  CtrlSaisie.Retour:=True;
{si table en �tat insertion ou modification}
  if TaReglement.State in [dsinsert,dsEdit] then
  begin
    case CCourant.Index of
      1: begin {si champ n� 1 pa exemple...}
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
         end; {fin champ n�1}
    2:;
    end;{fin du case.ccourant}
  end; {fin etat insertion ou modif}
end;


{*******************    Table1BeforePost            ****************************
       Cette procedure permet de faire une v�rification des saisie.
   Commence la transaction: quand plusieurs choses doivent se faire en cha�ne,
 si un probl�me se pr�sente sur une des actions, toutes les actions entreprises
    seront annul�es...
*******************************************************************************}

procedure TDMReglements.TaReglementBeforePost(DataSet: TDataSet);
var
  i:integer;
  RetourFonction:TRetFunction;
begin
  case TaReglement.State of
  dsInsert: begin
  {**************************************************************************
           voir si traitements � faire (recherches ou autre...)
           par ex : Table1DateSysteme.AsDateTime := Now;
  **************************************************************************}
            end;
  dsEdit: begin
  {**************************************************************************
           voir si traitements � faire (recherches ou autre...)
           par ex : Table1DateSysteme.AsDateTime := Now;
  **************************************************************************}
          end;
  end;//fin du case

// *******  d�but de la boucle de v�rification des saisies *****************
  for i:=1 to 4 do //v�rification des champs (ici, 1 � 4 par ex.)
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
{ici, plusieurs traitements � faire sur d'autres tables de la base de donn�es}
      end;
      if TaReglement.State=dsedit then
{ici, plusieurs traitements � faire sur d'autres tables de la base de donn�es}
   except
{*********  on annule la transaction (=ttes les actions) *******************}
     TaReglement.Database.Rollback;  //
     showmessage('Probl�mes' + 'genre de probl�me...' + ' !!!');
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
{ Valide la transaction (=ttes les actions se sont d�roul�es sans probl�mes)}
  TaReglement.Database.Commit;
{ *************     + traitements �ventuels ... ***************************** }
end;


{*******************************************************************************
                        idem pour le Delete...
*******************************************************************************}
procedure TDMReglements.TaReglementBeforeDelete(DataSet: TDataSet);
begin
{***************      traitements �ventuels... *****************************}
{***************  on commence la transaction  ******************************}
  TaReglement.Database.StartTransaction;
  TaReglement.Database.TransIsolation:=tiDirtyRead;
  case self.Tag of    // par exemple ...
     1: begin
            try
{***************        traitements � faire     *****************************}
{ici, plusieurs traitements � faire sur d'autres tables de la base de donn�es}
            except
               begin
{*********  on annule la transaction (=ttes les actions) *******************}
                 TaReglement.Database.Rollback;
                 showmessage('Probl�mes !!!');
                 abort;
               end;
            end;
        end;
     2: begin
           try
{***************        traitements � faire     *****************************}
{ici, plusieurs traitements � faire sur d'autres tables de la base de donn�es}
           except
              begin
{*********  on annule la transaction (=ttes les actions) *******************}
                TaReglement.Database.Rollback;
                showmessage('Probl�mes !!!');
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
{ Valide la transaction (=ttes les actions se sont d�roul�es sans probl�mes)}
  TaReglement.Database.Commit;
{ *************     + traitements �ventuels ... ***************************** }
end;



end.
