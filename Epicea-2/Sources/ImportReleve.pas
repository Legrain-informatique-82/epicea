unit ImportReleve;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RXCtrls, jpeg, ExtCtrls, StdCtrls, ToolEdit, Mask, xmldom,
  XMLIntf, oxmldom, XMLDoc, Grids, GrGrid,WinShellFolder, ComCtrls;

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
     Libelle:string[31];
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
     LibelleComplement:string[41];
     NumEcriture:string[7];
     ZoneReservee2:string[2];
     MontantDu04:string[14];
     ZoneReservee3:string[16];
  end;

  TImportationReleve = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTools: TPanel;
    RxSBInfoVersion: TRxSpeedButton;
    Panel1: TPanel;
    PaBtn: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    FichierImport: TFilenameEdit;
    BtnCharger: TButton;
    Panel3: TPanel;
    PaEcritures: TPanel;
    PaCptIntit: TPanel;
    Panel5: TPanel;
    Panel11: TPanel;
    Panel9: TPanel;
    PaSoldeCompte: TPanel;
    GrSoldeCompte: TGrGrid;
    Label3: TLabel;
    EdJournal: TEdit;
    LVReleve: TListView;
    PaBtnRefus: TPanel;
    BtnTTDecocher: TButton;
    BtnTTCocher: TButton;
    BtnDoublon: TButton;
    PaBtnSupp: TPanel;
    Label2: TLabel;
    EdCompteBancaire: TEdit;
    Panel7: TPanel;
    PaMouvCompte: TPanel;
    GrMouvCompte: TGrGrid;
    Label4: TLabel;
    Edit1: TEdit;
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
    procedure LVReleveColumnClick(Sender: TObject; Column: TListColumn);
    procedure GestionDesColumnsRapprochement(Columns:TListColumns;Column:TListColumn);
    procedure LVReleveCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
       lignesReleves:TStringlist;
      TabStr,TabCurr,TabDate : set of Byte;
  end;

var
  ImportationReleve: TImportationReleve;
  OrdreTriRapprochement:integer;

  procedure ChargeFichierOFX(FileName:string);
  procedure ChargeFichierAFB(FileName:string);
  function GestionCodeSensOperationAFB(Montant:string):string;
  function GestionDateOperationAFB(Date:string):string;
  
implementation

uses lib_chaine, DmImportReleves, Lib1, E2_Main, LibZoneSaisie,
  E2_Librairie_Obj, LibDates, E2_LibInfosTable, ComptesBancaires,
  Gr_Librairie_Obj, LibGestionParamXML, DMConstantes, LibFichRep, LibSQL;

{$R *.dfm}



procedure TImportationReleve.FormCreate(Sender: TObject);
begin
   lignesReleves:=TStringlist.Create;
  try
    LibGestionParamXML.InitialiseForm(E.User,Self);
  except
    InitialiseFormPosDefaut(self);
  end;


end;

procedure TImportationReleve.FormDestroy(Sender: TObject);
begin
   initialise_tstringlist(lignesReleves,self);
  if DMImportReleve <> nil then
    DMImportReleve.Destroy;   
     LibGestionParamXML.DestroyForm(Self,E.USer);
   ImportationReleve:=nil;
end;

procedure TImportationReleve.BtnChargerClick(Sender: TObject);
begin
  //on traite selon le type de fichier

  if UpperCase(ExtractFileExt(FichierImport.FileName))='.OFX' then
     ChargeFichierOFX(FichierImport.FileName)
  else
    if UpperCase(ExtractFileExt(FichierImport.FileName))='.AFB' then
     ChargeFichierAFB(FichierImport.FileName)
     else
       showmessage('Le type de fichier : '+ExtractFileExt(FichierImport.FileName)+' n''est pas pris en compte dans cette version.');
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
   ImportationReleve.lignesReleves.Clear;
   ImportationReleve.LVReleve.clear;
   AssignFile( Fic, FileName);
   reset(Fic);
   try
      while not eof(Fic) do
        begin //cette boucle répètera la lecture d'une ligne tant que nous n'aurons pas atteint la fin du document EOF
          readln(Fic,ligne);//à chaque fois que l'on utilisera readln on passera à la ligne suivante.
          //
          ImportationReleve.lignesReleves.Clear;
          Delimiteur:='<';
          DelimiteurTemp:='';
          while Pos(Delimiteur, ligne)>0 do
          begin
                if Pos(Delimiteur, ligne)<>1 then
                   if trim(DelimiteurTemp+Copy(ligne,1,Pos(Delimiteur, ligne)-1))<>'' then
                     ImportationReleve.lignesReleves.Add(trim(DelimiteurTemp+Copy(ligne,1,Pos(Delimiteur, ligne)-1)));
                ligne:=Copy(ligne,Pos(Delimiteur, ligne)+1,length(ligne));
              DelimiteurTemp:=Delimiteur;
          end;
          if ligne<>'' then
                 if( trim(DelimiteurTemp+ligne))<>'' then
                   ImportationReleve.lignesReleves.Add(trim(DelimiteurTemp+ligne));
          //

          for i:=0 to ImportationReleve.lignesReleves.Count-1 do
            MemoTemp.Add(ImportationReleve.lignesReleves[i]); // ajoute notre ligne au memo
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
ImportationReleve.lignesReleves.Clear;
TableGereOpen(DMImportReleve.TaReleveEbics);
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
         ImportationReleve.lignesReleves.AddObject(reference,LigneReleve);
         
          //remplir la table Ebics
          TableGereInsert(DMImportReleve.TaReleveEbics);
          DMImportReleve.TaReleveEbics.FindField('id').AsInteger:=MaxId_Query(DMImportReleve.TaReleveEbics_maxID,'Id');;
          DMImportReleve.TaReleveEbics.FindField('idEnteteServeur').AsInteger:=-1;
          DMImportReleve.TaReleveEbics.FindField('idMouvServeur').AsInteger:=-1;
          DMImportReleve.TaReleveEbics.FindField('code_enreg').AsString:='4';
          DMImportReleve.TaReleveEbics.FindField('code_banque').AsString:=LigneReleve.BANKID;
          DMImportReleve.TaReleveEbics.FindField('code_guichet').AsString:=LigneReleve.BRANCHID;
          DMImportReleve.TaReleveEbics.FindField('devise').AsString:='eur';
          DMImportReleve.TaReleveEbics.FindField('nb_decimal').AsInteger:=2;
          DMImportReleve.TaReleveEbics.FindField('compte_banque').AsString:=trim(LigneReleve.ACCTID);
          DMImportReleve.TaReleveEbics.FindField('code_op_bancaire').AsString:='';
          DMImportReleve.TaReleveEbics.FindField('date_compta').AsString:=Str_String_To_DateString(date,2);
          DMImportReleve.TaReleveEbics.FindField('libelle').AsString:=LigneReleve.NAME;
          DMImportReleve.TaReleveEbics.FindField('date_valeur').AsString:=Str_String_To_DateString(date,2);
          DMImportReleve.TaReleveEbics.FindField('montant').AsString:=montant;
          DMImportReleve.TaReleveEbics.FindField('reference').AsString:=LigneReleve.FITID;
          DMImportReleve.TaReleveEbics.FindField('traite').AsBoolean:=false;
          TableGerePost(DMImportReleve.TaReleveEbics);

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
     ImportationReleve.initGrReleve;
     ImportationReleve.CocheDecocheListe(true,true);
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
   ImportationReleve.lignesReleves.Clear;
   ImportationReleve.LVReleve.clear;
   AssignFile( FicTemp, FileName);
   reset(FicTemp);
   AssignFile( FicFinal, FileName);
   reset(FicFinal);
   ImportationReleve.lignesReleves.Clear;
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
                 ImportationReleve.lignesReleves.AddObject(trim(LigneReleve.FITID),LigneReleve);
//                 ImportationReleve.lignesReleves.Add(LigneReleve.BANKID+';'+LigneReleve.BRANCHID+';'+LigneReleve.ACCTID+';'
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
//     ImportationReleve.lignesReleves.SaveToFile('C:\Documents and Settings\isabelle\Bureau\Releves\LigneReleve.csv');
     ImportationReleve.initGrReleve;
     ImportationReleve.CocheDecocheListe(true,true);
     closefile(FicTemp);
     closefile(FicFinal);
     Initialise_TStringlist(MemoTemp,ImportationReleve);
   end;

end;

procedure TImportationReleve.FormShow(Sender: TObject);
begin
ImportationReleve.GrSoldeReleve.ParamColor:=true;
ImportationReleve.GrSoldeReleve.Param:=ParamUtil.CouleurDBGrid;
ImportationReleve.GrSoldeReleve.DessineContourLigne:=false;
ImportationReleve.GrSoldeReleve.UpDateColor;

ImportationReleve.GrSoldeCompte.ParamColor:=true;
ImportationReleve.GrSoldeCompte.Param:=ParamUtil.CouleurDBGrid;
ImportationReleve.GrSoldeCompte.DessineContourLigne:=false;
ImportationReleve.GrSoldeCompte.UpDateColor;

ImportationReleve.GrMouvReleve.ParamColor:=true;
ImportationReleve.GrMouvReleve.Param:=ParamUtil.CouleurDBGrid;
ImportationReleve.GrMouvReleve.DessineContourLigne:=false;
ImportationReleve.GrMouvReleve.UpDateColor;

ImportationReleve.GrMouvCompte.ParamColor:=true;
ImportationReleve.GrMouvCompte.Param:=ParamUtil.CouleurDBGrid;
ImportationReleve.GrMouvCompte.DessineContourLigne:=false;
ImportationReleve.GrMouvCompte.UpDateColor;
FichierImport.SetFocus;

end;

procedure TImportationReleve.BtnEnregistrerClick(Sender: TObject);
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

procedure TImportationReleve.BtnFermerClick(Sender: TObject);
begin
close;
end;


procedure TImportationReleve.initGrReleve;
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

procedure TImportationReleve.PaEcrituresResize(Sender: TObject);
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
procedure TImportationReleve.InitLisViewAvecListe(TabTitreColonne:array of string;ListeValeur:TStringList);
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

procedure TImportationReleve.CocheDecocheListe(cocheDecoche:boolean;GestionDoublon:boolean);
var
i:integer;
begin
for i:=0 to LVReleve.Items.Count-1 do
if(GestionDoublon)and(LVReleve.Items[i].SubItems.Strings[0]<>#0)then
  LVReleve.Items[i].Checked:=false
else
  LVReleve.Items[i].Checked:=cocheDecoche;
end;

procedure TImportationReleve.DecocheDoublon;
var
i:integer;
begin
for i:=0 to LVReleve.Items.Count-1 do
  if LVReleve.Items[i].SubItems.Strings[0]<>#0 then
    LVReleve.Items[i].Checked:=false;
end;

procedure TImportationReleve.Panel3Resize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([BtnDoublon,BtnTTCocher,BtnTTDecocher],PaBtnRefus,120,25,5);
FormateTailleBouttonAvecEspace([BtnAnnuler,BtnEnregistrer],PaBtnSupp,90,0,0);
end;

procedure TImportationReleve.PaBtnResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([BtnEnregistrer,BtnAnnuler],PaBtn,90,0,0);

end;

procedure TImportationReleve.LVReleveSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
if (Selected) then
  begin
      if(Item.SubItems.Objects[0]<>nil)then
        begin
        EdCompteBancaire.Text:=TLigneImportReleve(Item.SubItems.Objects[0]).COMPTE;
        EdJournal.Text:=TLigneImportReleve(Item.SubItems.Objects[0]).JOURNAL;
        Edit1.text:=TLigneImportReleve(Item.SubItems.Objects[0]).MEMO;
        end;
  end;
end;

procedure TImportationReleve.BtnTTCocherClick(Sender: TObject);
begin
CocheDecocheListe(true);
end;

procedure TImportationReleve.BtnTTDecocherClick(Sender: TObject);
begin
CocheDecocheListe(false);
end;

procedure TImportationReleve.BtnDoublonClick(Sender: TObject);
begin
DecocheDoublon();
end;

procedure TImportationReleve.BtnGestionCompteClick(Sender: TObject);
begin
if E2_ComptesBancaires=nil then E2_ComptesBancaires:=TE2_ComptesBancaires.Create(self);
E2_ComptesBancaires.ShowModal;
if E2_ComptesBancaires.modification then
  if (BtnCharger.Enabled)then BtnCharger.Click;
end;

procedure TImportationReleve.FichierImportAfterDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
BtnCharger.Enabled:=FileExists(name);
if BtnCharger.Enabled then
  e.RepTelechargementReleve:=ExtractFileDir(name);
end;

procedure TImportationReleve.FormActivate(Sender: TObject);
begin
BtnCharger.Enabled:=FileExists(FichierImport.FileName);
FichierImport.InitialDir:=e.RepTelechargementReleve;
if FichierImport.InitialDir='' then    FichierImport.InitialDir:=TypeRepertoirePath(CSIDL_PERSONAL);
end;


procedure TImportationReleve.initTotaux;
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


procedure TImportationReleve.LVReleveChange(Sender: TObject;
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

procedure TImportationReleve.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
WinSuivPrec(Handle,key,[LVReleve]);
     If Key = VK_ESCAPE Then
     Begin
         if (LVReleve.Focused)then
            FichierImport.SetFocus
         else
            Self.Close;
     End;
end;

procedure TImportationReleve.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
BtnAnnuler.Click;
end;

procedure TImportationReleve.BtnAnnulerClick(Sender: TObject);
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
     ModalResult:=mrno;
  end;
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
procedure TImportationReleve.LVReleveColumnClick(Sender: TObject;
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
procedure TImportationReleve.GestionDesColumnsRapprochement(Columns:TListColumns;Column:TListColumn);
var
i:integer;
begin
  for i := 0 to Columns.Count - 1 do
      Columns[i].ImageIndex := -1;

  if OrdreTriRapprochement>0 then
  Column.ImageIndex:=0
  else  Column.ImageIndex:=1
end;


procedure TImportationReleve.LVReleveCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
if DAta >= 0 then
compare:=OrdreTriRapprochement*StrComp(PChar(Item1.SubItems.Strings[Data]),PChar(Item2.SubItems.Strings[Data]))
else
compare:=OrdreTriRapprochement*StrComp(PChar(TListItem(Item1).Caption),PChar(TListItem(Item2).Caption));
end;

end.
