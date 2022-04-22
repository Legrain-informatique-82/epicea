unit BalancesComparatives;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RXCtrls, jpeg, ExtCtrls, Mask, ComCtrls, ToolEdit,DBTables,DMProgramme;

type


  TParamAfficheBalanceComparative = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   TitreForm:String;
   SousTitreForm:String;
   end;




  TBalanceComparative = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    PaTitrePetit: TPanel;
    PaBas: TPanel;
    PaDateDeb: TPanel;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnAnnuler: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupSelect1: TGroupBox;
    Combo1: TComboBox;
    GroupSelect3: TGroupBox;
    Combo3: TComboBox;
    Panel3: TPanel;
    MemoInfDof1: TRichEdit;
    MemoInfDof3: TRichEdit;
    Label1: TLabel;
    EditDebutPer1: TDateEdit;
    Label2: TLabel;
    EditFinPer1: TDateEdit;
    Label3: TLabel;
    EditDebutPer3: TDateEdit;
    Label4: TLabel;
    EditFinPer3: TDateEdit;
    GroupSelect2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Combo2: TComboBox;
    MemoInfDof2: TRichEdit;
    EditDebutPer2: TDateEdit;
    EditFinPer2: TDateEdit;
    groupeReport: TRadioGroup;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    cb1a5: TRadioGroup;
    GroupBox1: TGroupBox;
    GroupVariation: TCheckBox;

    procedure Combo2Select(Sender: TObject);
    procedure SelectionCombo(combo: TComboBox;memo:TrichEdit;DateDeb,DateFin:TdateEdit);
    procedure Combo1Select(Sender: TObject);
    procedure Combo3Select(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure EditDebutPer1AcceptDate(Sender: TObject;
      var ADate: TDateTime; var Action: Boolean);
    procedure EditFinPer1AcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure EditDebutPer2AcceptDate(Sender: TObject;
      var ADate: TDateTime; var Action: Boolean);
    procedure EditDebutPer3AcceptDate(Sender: TObject;
      var ADate: TDateTime; var Action: Boolean);
    procedure EditFinPer2AcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure EditFinPer3AcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
//    function SelectionDateDeb(ADate:TDate;combo:TComboBox;memo:TRichEdit;DateDeb,DateFin:Tdate):boolean;
//    function SelectionDateFin(ADate:TDate;combo:TComboBox;memo:TRichEdit;DateDeb,DateFin:Tdate):boolean;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure rempliMemo(ListeExercices:Tstringlist;combo: TComboBox;memo:TrichEdit;DateDeb,DateFin:TDate);
    procedure EditDebutPer1Exit(Sender: TObject);
    procedure EditFinPer1Exit(Sender: TObject);
    procedure EditDebutPer2Exit(Sender: TObject);
    procedure EditDebutPer3Exit(Sender: TObject);
    procedure EditFinPer2Exit(Sender: TObject);
    procedure EditFinPer3Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Combo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function SelectionDate(ADate:TDate;combo:TComboBox;memo:TRichEdit;DateDeb,DateFin:Tdate):boolean;
    function listeExerciceSurPeriode(combo:TcomboBox;DateDeb,DateFin:Tdate):TStringList;
    procedure PaBtnResize(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }

       Affiche:Boolean;
   AffichageModal:Boolean;
   TitreForm:String;
   SousTitreForm:String;
  end;

var
   BalanceComparative: TBalanceComparative;

   Function BalanceComparativeAffiche(ParamAffiche:TParamAfficheBalanceComparative):Boolean;
//   function listeExercice(idDossier:integer):TStringList;

implementation

uses  DMCorrection, E2_Librairie_Obj, lib_chaine, DB,
  DMConstantes, Gr_Librairie_Obj, LibDates, E2_Decl_Records,
  LibChoixCompte, DMDiocEtatBalance, LibGestionParamXML, LibZoneSaisie;

{$R *.dfm}

procedure TBalanceComparative.SelectionCombo(combo: TComboBox;memo:TrichEdit;DateDeb,DateFin:TdateEdit);
var
//Debut,longueur:integer;
//Texte:String;
Exercice:TExercice;
listeExercice:Tstringlist;
begin
Exercice:=nil;
listeExercice:=TStringList.Create;
DateDeb.Text:='';
DateFin.Text:='';
  if(combo.ItemIndex<>-1)then
    Exercice:=TExercice(combo.Items.Objects[combo.ItemIndex]);
    if(Exercice<>nil)then
    begin
      listeExercice.AddObject(Exercice.nom_exo,Exercice);
      rempliMemo(listeExercice,combo,memo,Exercice.Date_Deb_Exo,Exercice.Date_Fin_Exo);
      DateDeb.Date:=Exercice.Date_Deb_Exo;
      DateFin.Date:=Exercice.Date_Fin_Exo;
    end
    else
        rempliMemo(listeExercice,combo,memo,DateDeb.Date,DateFin.Date);
end;


procedure TBalanceComparative.rempliMemo(ListeExercices:Tstringlist;combo: TComboBox;memo:TrichEdit;DateDeb,DateFin:TDate);
var
Debut,longueur,i:integer;
Texte:String;
trouveExo:boolean;
begin
  memo.Clear;
  memo.SelStart:=0;
  texte:='';
  memo.SelLength:=length(texte);
  memo.SelAttributes.Color:=clWindowText;
  memo.SelAttributes.Style:=[];

  //if(Exercice<>nil)then
  //begin
      Debut:=0;
      longueur:=17;
      if(DateDeb=0) and (DateFin=0)then
        Texte:=''
      else
        Texte:='Dates d''exercice :'+ #13#10 +'Début : ' + DateToStr_Lgr(DateDeb) + #13#10 + 'Fin : ' + DateToStr_Lgr(DateFin);
      memo.Lines.Add(texte);
      Debut:=length(texte)+1;
      memo.SelStart:=debut;
      memo.SelLength:=length(texte);
      texte:='';
      if(ListeExercices<>nil)and(ListeExercices.Count=1)and (TExercice(ListeExercices.Objects[0])<>nil)and(FileExists(TExercice(ListeExercices.Objects[0]).dir_exo+'\Epure.txt'))then
      begin
        texte:='Attention !!! Exercice Epuré.';
      end
      else
      begin
         if(ListeExercices<>nil)and(ListeExercices.Count>1)then
         begin
            i:=1;
            texte:='';
            while (empty(texte))and(i< ListeExercices.Count-1) do
              begin
                  if(FileExists(TExercice(ListeExercices.Objects[i]).dir_exo+'\Epure.txt'))then
                    texte:='Attention !!! Période Epurée.';
                  inc(i);
              end;
         end;
      end;
      if(not empty(texte))then
        begin
            memo.SelAttributes.Color:=clRed;
            memo.SelAttributes.Style:=[fsbold,fsunderline];
            memo.Lines.Add(texte);
            debut:=debut+length(texte)+1;
        end;

      //permet de rajouter du texte formatée normalement
      memo.SelStart:=debut;
      texte:='';
      memo.SelLength:=length(texte);
      memo.SelAttributes.Color:=clWindowText;
      memo.SelAttributes.Style:=[];
      memo.Lines.Add(texte);
  //end;
end;
procedure TBalanceComparative.Combo2Select(Sender: TObject);
begin
  SelectionCombo(TComboBox(sender),MemoInfDof2,EditDebutPer2,EditFinPer2);
end;

Function BalanceComparativeAffiche(ParamAffiche:TParamAfficheBalanceComparative):Boolean;
var
listeExo:Tstringlist;
i,depart:integer;
Begin
  if (BalanceComparative = nil) then BalanceComparative:=TBalanceComparative.Create(Application.MainForm);
  depart:=0;
  BalanceComparative.TitreForm := 'Balances Comparatives';
  BalanceComparative.SousTitreForm := 'Sélectionnez les exercices à comparer...';
  BalanceComparative.RxLabTitre.Caption:=BalanceComparative.SousTitreForm;

  //récupérer la liste des exercices existants
  listeExo:=listeExercice(E.ID_Dos)  ;
  if(listeExo=nil)then exit;
  BalanceComparative.Combo1.Clear;
  BalanceComparative.Combo2.Clear;
  BalanceComparative.Combo3.Clear;

  for i:=0 to listeExo.count-1 do
  begin
     BalanceComparative.Combo1.AddItem(listeExo.Strings[i],listeExo.Objects[i]);
     BalanceComparative.Combo2.AddItem(listeExo.Strings[i],listeExo.Objects[i]);
     BalanceComparative.Combo3.AddItem(listeExo.Strings[i],listeExo.Objects[i]);
  end;

  i:=1;
  while (depart=0)and(i<BalanceComparative.Combo1.Items.Count) do
  begin
    if(ChercheInfos_ExoN(e.NomDossier).Nom_Exo=BalanceComparative.Combo1.Items[BalanceComparative.Combo1.Items.Count-i])
      then depart:= i;
    inc(i);
  end;

  if(BalanceComparative.Combo1.Items.Count>abs(depart))then
    begin
      BalanceComparative.Combo1.ItemIndex:=BalanceComparative.Combo1.Items.Count-depart;
      inc(depart);
    end;
  if(BalanceComparative.Combo1.Items.Count>abs(depart))then
    BalanceComparative.Combo2.ItemIndex:=BalanceComparative.Combo2.Items.Count-depart;

  BalanceComparative.Combo3.ItemIndex:=-1;
  BalanceComparative.Combo1Select(BalanceComparative.Combo1);
  BalanceComparative.Combo2Select(BalanceComparative.Combo2);
  BalanceComparative.Combo3Select(BalanceComparative.Combo3);

  BalanceComparative.Combo1.DropDownCount:=BalanceComparative.Combo1.Items.Count;
  BalanceComparative.Combo2.DropDownCount:=BalanceComparative.Combo2.Items.Count;
  BalanceComparative.Combo3.DropDownCount:=BalanceComparative.Combo3.Items.Count;

  BalanceComparative.groupeReport.Items.Clear;
  BalanceComparative.groupeReport.Items.Add('Sans les reports');
  BalanceComparative.groupeReport.Items.Add('Avec les reports');
  BalanceComparative.groupeReport.ItemIndex:=1;

  BalanceComparative.cb1a5.Items.Clear;
  BalanceComparative.cb1a5.Items.Add('comptes de 1 à 5');
  BalanceComparative.cb1a5.Items.Add('comptes 6 et 7');
  BalanceComparative.cb1a5.Items.Add('Tous');
  BalanceComparative.cb1a5.ItemIndex:=2;

  BalanceComparative.GroupVariation.Checked:=false;

  Result:=BalanceComparative.ShowModal=MrOk;
End;

function TBalanceComparative.listeExerciceSurPeriode(combo:TcomboBox;DateDeb,DateFin:Tdate):TStringList;
var
i:integer;
DateexoDeb,DateexoFin:Tdate;
begin
result:=TStringList.Create;
DateexoDeb:=0;
DateexoFin:=0;
i:=1;
  while(DateexoDeb=0)and(i<=combo.Items.Count-1)do
  begin
     if(DateDsIntervale(TExercice(combo.Items.Objects[i]).Date_Deb_Exo,DateDeb,TExercice(combo.Items.Objects[i]).Date_Fin_Exo)) then
       DateexoDeb:=TExercice(combo.Items.Objects[i]).Date_Deb_Exo;
     inc(i);
  end;
i:=1;
  while (DateexoDeb<>0)and(DateexoFin=0)and(i<=combo.Items.Count-1)do
  begin
     if(DateexoDeb<>0) and (DateexoDeb<=TExercice(combo.Items.Objects[i]).Date_Deb_Exo)then
       result.AddObject(TExercice(combo.Items.Objects[i]).nom_exo,TExercice(combo.Items.Objects[i]));
     if(DateDsIntervale(TExercice(combo.Items.Objects[i]).Date_Deb_Exo,DateFin,TExercice(combo.Items.Objects[i]).Date_Fin_Exo)) then
     DateexoFin:=TExercice(combo.Items.Objects[i]).Date_Fin_Exo;
     inc(i);
  end;

end;

//function listeExercice(idDossier:integer):TStringList;
//var
//Requete:TQuery;
//Exercice:TExercice;
//begin
//try//finally
// result:=TStringList.Create;
// Requete:=TQuery.Create(BalanceComparative);
// Requete.DatabaseName:=DM_C_NomAliasProgram;
//      try//except
//        if idDossier=0 then abort;
//        Requete.sql.Add('select nom_dossier,dir_dossier,nom_Exo,Dir_Exo,Date_Deb_Exo,Date_Fin_Exo,cloture,Designation_dossier from GestDossier');
//        Requete.sql.Add('where id_dossier=:Dossier');
//        Requete.sql.Add('Order by Date_Deb_Exo,Date_Fin_Exo');
//        Requete.ParamByName('Dossier').asinteger:=idDossier;
//        Requete.Open;
//        Requete.first;
//                    Exercice:=TExercice.Create;
//                    Exercice.nom_Dossier:=Requete.findfield('nom_Dossier').AsString;
//                    Exercice.id_Dossier:=idDossier;
//                    Exercice.dir_dossier:=Requete.findfield('dir_dossier').AsString;
//                    Exercice.dir_exo:='-';
//                    Exercice.nom_exo:='-';
//                    Exercice.cloture:=false;
//                    Exercice.Date_Deb_Exo:=0;
//                    Exercice.Date_Fin_Exo:=0;
//                    Exercice.Designation_dossier:='non déterminé';
//                    result.AddObject(Exercice.nom_exo,Exercice);
//
//                while not(Requete.eof) do
//                  begin
//                    Exercice:=TExercice.Create;
//                    Exercice.nom_Dossier:=Requete.findfield('nom_Dossier').AsString;
//                    Exercice.id_Dossier:=idDossier;
//                    Exercice.dir_dossier:=Requete.findfield('dir_dossier').AsString;
//                    Exercice.dir_exo:=Requete.findfield('dir_exo').AsString;
//                    Exercice.nom_exo:=Requete.findfield('nom_Exo').AsString;
//                    Exercice.cloture:=Requete.findfield('cloture').AsBoolean;
//                    Exercice.Date_Deb_Exo:=Requete.findfield('Date_Deb_Exo').AsDateTime;
//                    Exercice.Date_Fin_Exo:=Requete.findfield('Date_Fin_Exo').AsDateTime;
//                    Exercice.Designation_dossier:=Requete.findfield('Designation_dossier').AsString;
//
//                    result.AddObject(Exercice.nom_exo,Exercice);
//                    Requete.next;
//                  end;
//
//
//
//      except
//         result:=nil;
//      end;
//  finally
//    Requete.close;
//    LibereObjet(TObject(Requete));
//  end;
//end;
procedure TBalanceComparative.Combo1Select(Sender: TObject);
begin
  SelectionCombo(TComboBox(sender),MemoInfDof1,EditDebutPer1,EditFinPer1);
end;

procedure TBalanceComparative.Combo3Select(Sender: TObject);
begin
  SelectionCombo(TComboBox(sender),MemoInfDof3,EditDebutPer3,EditFinPer3);
end;

procedure TBalanceComparative.BtnEnregistrerClick(Sender: TObject);
var
ListeCpt:TResultStrList;
i:integer;
requete : TQuery;
ParamAffichCompte:TParamAffichCompte;
Exercice1,Exercice2,Exercice3:PPeriode;
listePeriode:Tstringlist;
close:string;
motCle:string;
typeVariation:integer;
begin
//afficher la selection des comptes
 ListeCpt.Liste:=TStringList.Create;
 listePeriode:=TStringList.create;
 Exercice1:=PPeriode.Create;
 Exercice2:=PPeriode.Create;
 Exercice3:=PPeriode.Create;
 Exercice1.DateDeb:=EditDebutPer1.Date ;
 Exercice1.DateFin:=EditFinPer1.Date ;
 Exercice2.DateDeb:=EditDebutPer2.Date ;
 Exercice2.DateFin:=EditFinPer2.Date ;
 Exercice3.DateDeb:=EditDebutPer3.Date ;
 Exercice3.DateFin:=EditFinPer3.Date ;
 Exercice1.Retour:=(Exercice1.DateDeb<>0) and (Exercice1.DateFin<>0);
 Exercice2.Retour:=(Exercice2.DateDeb<>0) and (Exercice2.DateFin<>0);
 Exercice3.Retour:=(Exercice3.DateDeb<>0) and (Exercice3.DateFin<>0);

 for i:=0 to combo1.Items.Count-1 do
 begin
    if(Exercice1.Retour)and (DateDsIntervale(TExercice(Combo1.Items.Objects[i]).Date_Deb_Exo,Exercice1.DateDeb,TExercice(Combo1.Items.Objects[i]).Date_Fin_Exo))then
      begin
        Exercice1.DateDebExo:=TExercice(Combo1.Items.Objects[i]).Date_Deb_Exo;
        Exercice1.DirExoBalance:=TExercice(Combo1.Items.Objects[i]).dir_exo;
      end;
    if(Exercice2.Retour)and(DateDsIntervale(TExercice(Combo2.Items.Objects[i]).Date_Deb_Exo,Exercice2.DateDeb,TExercice(Combo2.Items.Objects[i]).Date_Fin_Exo))then
      begin
        Exercice2.DateDebExo:=TExercice(Combo2.Items.Objects[i]).Date_Deb_Exo;
        Exercice2.DirExoBalance:=TExercice(Combo2.Items.Objects[i]).dir_exo;
      end;
   if(Exercice3.Retour)and(DateDsIntervale(TExercice(Combo3.Items.Objects[i]).Date_Deb_Exo,Exercice3.DateDeb,TExercice(Combo3.Items.Objects[i]).Date_Fin_Exo))then
      begin
        Exercice3.DateDebExo:=TExercice(Combo3.Items.Objects[i]).Date_Deb_Exo;
        Exercice3.DirExoBalance:=TExercice(Combo3.Items.Objects[i]).dir_exo;
      end;
 end;
    Exercice1.retour:=(not empty(Exercice1.DirExoBalance));
    Exercice2.retour:=(not empty(Exercice2.DirExoBalance));
    Exercice3.retour:=(not empty(Exercice3.DirExoBalance));

    if(Exercice1.Retour)then
      begin
        listePeriode.AddObject('',Exercice1);
      end;
    if(Exercice2.Retour)then
      begin
       listePeriode.AddObject('',Exercice2);
      end;
   if(Exercice3.Retour)then
      begin
        listePeriode.AddObject('',Exercice3);
      end;
      
 Screen.Cursor := crSQLWait;
       begin
        try
        ListeCpt.Liste:=TStringList.Create;
        ListeCpt.result:=true;
        requete := TQuery.Create(self);

        requete.DatabaseName :=DM_C_NomAliasDossier;
        motCle:=' where (';
        requete.SQL.Add(' select distinct(P.compte),P.libelle,P.collectif,P.pointable from plancpt P ');
        if(Exercice1.retour)then
          begin
            requete.SQL.Add(motCle+' exists(select * from "'+IncludeTrailingPathDelimiter(Exercice1.DirExoBalance)+'balance" b1 where b1.compte=P.compte) ');
            motCle:=' or';
          end;
        if(Exercice2.retour)then
          begin
            requete.SQL.Add(motCle+' exists(select * from "'+IncludeTrailingPathDelimiter(Exercice2.DirExoBalance)+'balance" b2 where b2.compte=P.compte)');
            motCle:=' or';
          end;
        if(Exercice3.retour)then
          begin
            requete.SQL.Add(motCle+' exists(select * from "'+IncludeTrailingPathDelimiter(Exercice3.DirExoBalance)+'balance" b3 where b3.compte=P.compte)');
            motCle:=' or';
          end;
        requete.SQL.Add(')');
        if(str_position('where',lowercase(requete.Text))<>-1) then motCle:=' and ' else motCle:=' where ';
        if(cb1a5.ItemIndex=0)then requete.SQL.Add(motCle+' (not p.compte like ''6%'' and not p.compte like ''7%'')');
        if(str_position('where',lowercase(requete.Text))<>-1 )then motCle:=' and ' else motCle:=' where ';
        if(cb1a5.ItemIndex=1)then requete.SQL.Add(motCle+' (p.compte like ''6%'' or p.compte like ''7%'' )');
        requete.Open;

        InitialiseParamAffichCompte(ParamAffichCompte);
        ParamAffichCompte.Regrouper:=8;
        ParamAffichCompte.Tiers:=false;
        ParamAffichCompte.Dataset:=requete;
        ParamAffichCompte.Titre:='Sélectionnez les comptes...';
        ParamAffichCompte.ListeChamps.Add('compte');
        ParamAffichCompte.ListeChamps.Add('libelle');
        ParamAffichCompte.ListeChamps.Add('Collectif');
        ParamAffichCompte.ListeChamps.Add('Pointable');

        listecpt:=ChoixCompteAffich(ParamAffichCompte);

        if (ListeCpt.Liste<>nil) then
          begin
            //puis imprimer la balance comparative
            if(GroupVariation.Checked)then typeVariation:=1 else typeVariation:=0;
            EditionBalanceComparative(ListeCpt.Liste,listePeriode,nil,ParamAffichCompte.Regrouper,groupeReport.ItemIndex=1,typeVariation);
          end;

        finally
          Screen.Cursor := crDefault;
          requete.close;
          requete.free;
        end;
       end;


end;

//function TBalanceComparative.SelectionDateDeb(ADate:TDate;combo:TComboBox;memo:TRichEdit;DateDeb,DateFin:Tdate):boolean;
//var
//trouveExo:boolean;
//i:integer;
//begin
//result:=true;
//trouveExo:=true;
//i:=combo.ItemIndex;
//// if(combo.ItemIndex=-1)or (not DateDsIntervale(TExercice(combo.Items.Objects[combo.ItemIndex]).Date_Deb_Exo,Adate,
////   TExercice(combo.Items.Objects[combo.ItemIndex]).Date_fin_Exo))then
// begin
//    i:=1;
//    result:=false;
//    trouveExo:=false;
//    while (not trouveExo) and (i< combo.Items.Count-1) do
//    begin
//       if(not result)then
//         result:=DateDsIntervale(TExercice(combo.Items.Objects[i]).Date_Deb_Exo,Adate,DateFin) ;
//       if(result)then
//         begin
//           trouveExo:=Adate<=TExercice(combo.Items.Objects[i]).Date_Fin_Exo;
//           DateDeb:=TExercice(combo.Items.Objects[i]).Date_Deb_Exo;
//           //trouveExo:=DateDsIntervale(TExercice(combo.Items.Objects[i]).Date_Deb_Exo,DateDeb,TExercice(combo.Items.Objects[i]).Date_Fin_Exo) and
//            //DateDsIntervale(TExercice(combo.Items.Objects[i]).Date_Deb_Exo,DateFin,TExercice(combo.Items.Objects[i]).Date_Fin_Exo);
//         end;
//       inc(i);
//    end;
//    if(trouveExo)then dec(i);
// end;
//  if(trouveExo)then combo.ItemIndex:=i else combo.ItemIndex:=0;
// if(result)then rempliMemo(TExercice(combo.Items.Objects[combo.ItemIndex]),combo,memo,DateDeb,DateFin);
// if(not result)then showmessage('Date hors contexte');
//
//end;


function TBalanceComparative.SelectionDate(ADate:TDate;combo:TComboBox;memo:TRichEdit;DateDeb,DateFin:Tdate):boolean;
var
trouveExo:boolean;
i:integer;
listeExercices:Tstringlist;
begin
listeExercices:=listeExerciceSurPeriode(combo,DateDeb,DateFin);
if(listeExercices.Count>1) then combo.ItemIndex:=0 else if listeExercices.Count=1 then combo.ItemIndex:=combo.Items.IndexOfObject(listeExercices.Objects[0])
else combo.ItemIndex:=-1;
rempliMemo(listeExercices,combo,memo,DateDeb,DateFin);
if(combo.ItemIndex=-1)then result:=false;
if not result then showmessage('Date hors contexte');
end;



//function TBalanceComparative.SelectionDateFin(ADate:TDate;combo:TComboBox;memo:TRichEdit;DateDeb,DateFin:Tdate):boolean;
//var
//trouveExo:boolean;
//i:integer;
//begin
//result:=true;
//trouveExo:=true;
//i:=combo.ItemIndex;
// if(combo.ItemIndex=-1)or ((not DateDsIntervale(TExercice(combo.Items.Objects[combo.ItemIndex]).Date_Deb_Exo,Adate,
//    TExercice(combo.Items.Objects[combo.ItemIndex]).Date_fin_Exo))and (not DateDsIntervale(TExercice(combo.Items.Objects[combo.ItemIndex]).Date_Deb_Exo,DateDeb,
//    TExercice(combo.Items.Objects[combo.ItemIndex]).Date_fin_Exo)))then
// begin
//    i:=1;
//    result:=false;
//    trouveExo:=false;
//    while (not trouveExo) and (i< combo.Items.Count-1) do
//    begin
////       if(not result)then
////         result:=DateDsIntervale(TExercice(combo.Items.Objects[i]).Date_Deb_Exo,Adate,TExercice(combo.Items.Objects[combo.Items.count-2]).Date_Fin_Exo) ;
//       if(not result)then
//         result:=DateDsIntervale(TExercice(combo.Items.Objects[i]).Date_Deb_Exo,DateDeb,TExercice(combo.Items.Objects[combo.Items.count-2]).Date_Fin_Exo) ;
//       if(result)then
//         begin
//           trouveExo:=Adate<=TExercice(combo.Items.Objects[i]).Date_fin_Exo;
//           DateFin:=TExercice(combo.Items.Objects[i]).Date_fin_Exo;
////           trouveExo:=DateDsIntervale(TExercice(combo.Items.Objects[i]).Date_Deb_Exo,DateDeb,TExercice(combo.Items.Objects[i]).Date_Fin_Exo) and
////            DateDsIntervale(TExercice(combo.Items.Objects[i]).Date_Deb_Exo,DateFin,TExercice(combo.Items.Objects[i]).Date_Fin_Exo);
//         end;
//       inc(i);
//    end;
//     if(trouveExo)then dec(i);
// end;
// if(trouveExo)then combo.ItemIndex:=i else combo.ItemIndex:=0;
// if(result)then
// begin
//   rempliMemo(TExercice(combo.Items.Objects[combo.ItemIndex]),combo,memo,DateDeb,DateFin);
// end;
// if(not result)then showmessage('Date hors contexte');
//end;


procedure TBalanceComparative.EditDebutPer1AcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
Action:=SelectionDate(ADate,Combo1,MemoInfDof1,EditDebutPer1.Date,EditFinPer1.Date) ;
end;


procedure TBalanceComparative.EditFinPer1AcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
Action:=SelectionDate(ADate,Combo1,MemoInfDof1,EditDebutPer1.Date,EditFinPer1.Date) ;
end;

procedure TBalanceComparative.EditDebutPer2AcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
Action:=SelectionDate(ADate,Combo2,MemoInfDof2,EditDebutPer2.Date,EditFinPer2.Date) ;
end;

procedure TBalanceComparative.EditDebutPer3AcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
Action:=SelectionDate(ADate,Combo3,MemoInfDof3,EditDebutPer3.Date,EditFinPer3.Date) ;
end;

procedure TBalanceComparative.EditFinPer2AcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
Action:=SelectionDate(ADate,Combo2,MemoInfDof2,EditDebutPer2.Date,EditFinPer2.Date) ;
end;

procedure TBalanceComparative.EditFinPer3AcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
Action:=SelectionDate(ADate,Combo3,MemoInfDof3,EditDebutPer3.Date,EditFinPer3.Date) ;
end;



procedure TBalanceComparative.FormCreate(Sender: TObject);
begin
  try
      if DMDiocEtatBal = nil then DMDiocEtatBal := TDMDiocEtatBal.Create(Application.MainForm);
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;
end;

procedure TBalanceComparative.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,E.User);
BalanceComparative:=nil;
end;

procedure TBalanceComparative.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[] then  WinSuivPrec(Handle,key,[]);
  if Key = VK_ESCAPE then
   begin
    Key:= 0;
    Self.Close;
   end
 else
  if Key = VK_F3 then
   begin
    BtnEnregistrer.Click;
   end;

end;

procedure TBalanceComparative.BtnAnnulerClick(Sender: TObject);
begin
  self.close;
end;

procedure TBalanceComparative.EditDebutPer1Exit(Sender: TObject);
var
accept:boolean;
date:TDateTime;
begin
  accept:=true;
  date:=EditDebutPer1.date;
  EditDebutPer1AcceptDate(Sender,date,accept);
  if not accept then begin
  EditDebutPer1.SetFocus;
  abort;
  end;
end;

procedure TBalanceComparative.EditFinPer1Exit(Sender: TObject);
var
accept:boolean;
date:TDateTime;
begin
  accept:=true;
  date:=EditFinPer1.date;
  EditFinPer1AcceptDate(Sender,date,accept);
  if not accept then abort;
end;

procedure TBalanceComparative.EditDebutPer2Exit(Sender: TObject);
var
accept:boolean;
date:TDateTime;
begin
  accept:=true;
  date:=EditDebutPer2.date;
  EditDebutPer2AcceptDate(Sender,date,accept);
  if not accept then abort;
end;

procedure TBalanceComparative.EditDebutPer3Exit(Sender: TObject);
var
accept:boolean;
date:TDateTime;
begin
  accept:=true;
  date:=EditDebutPer3.date;
  EditDebutPer3AcceptDate(Sender,date,accept);
  if not accept then abort;
end;

procedure TBalanceComparative.EditFinPer2Exit(Sender: TObject);
var
accept:boolean;
date:TDateTime;
begin
  accept:=true;
  date:=EditFinPer2.date;
  EditFinPer2AcceptDate(Sender,date,accept);
  if not accept then abort;
end;

procedure TBalanceComparative.EditFinPer3Exit(Sender: TObject);
var
accept:boolean;
date:TDateTime;
begin
  accept:=true;
  date:=EditFinPer3.date;
  EditFinPer3AcceptDate(Sender,date,accept);
  if not accept then abort;
end;

procedure TBalanceComparative.FormShow(Sender: TObject);
begin
  BalanceComparative.Combo1.SetFocus;
  PaBtnResize(PaBtn);
end;

procedure TBalanceComparative.Combo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if(not (Sender as TComboBox).DroppedDown)then key:=0;
end;

procedure TBalanceComparative.PaBtnResize(Sender: TObject);
begin
FormateTailleBouttonAvecEspace([BtnAnnuler,BtnEnregistrer],PaBtn,90,0,30);
end;

end.
