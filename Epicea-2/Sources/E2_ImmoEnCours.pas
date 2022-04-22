unit E2_ImmoEnCours;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gr_Librairie_obj, E2_Librairie_obj, Grids, DBGrids, Db,
  DBTables, E2_AideCompte, LibSql, Menus, Buttons,Gr_MiseAJourBalance,
  RXDBCtrl, ExRxDBGrid,DMBalances,DMPiece,{DMProvision,}registry, RXCtrls,
  GrDBGrid,LibZoneSaisie,E2_AssistantClotureDef,E2_Decl_Records,AideMontant2,
  DMTVA,E2_Cloture_Def,LibGestionParamXML, DMConstantes;

type
   TImmoEnCours = class(TForm)
    Patitre: TPanel;
    RxSpeedButton1: TRxSpeedButton;
    RxSpeedButton2: TRxSpeedButton;
    PaBtn: TPanel;
    BtnEnregistrer: TButton;
    BtnInserer: TButton;
    BtnModifier: TButton;
    BtnSupprimer: TButton;
    BtnFermer: TButton;
    PaBas: TPanel;
    PaLabel: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    NumCpt: TEdit;
    PaGrille: TPanel;
    DBImmo: TGrDBGrid;
    BtnAnnuler: TButton;
    BtnImprimer: TButton;
    PopupMenu1: TPopupMenu;
    pmMenu1: TMenuItem;
    Aideenligne1: TMenuItem;
    Aide1: TMenuItem;
    Visualisation1: TMenuItem;
    Imprimer1: TMenuItem;
    Calculatrice1: TMenuItem;
    N1: TMenuItem;
    Enregister1: TMenuItem;
    Insrer1: TMenuItem;
    Modifier1: TMenuItem;
    Supprimer1: TMenuItem;
    Annuler1: TMenuItem;
    Fermer1: TMenuItem;
    N2: TMenuItem;
    Precdant1: TMenuItem;
    Suivant1: TMenuItem;
    Slectioncharges1: TMenuItem;
    procedure AideEnLigne(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Procedure InitialiseTable_A_Nil;
    procedure FormDestroy(Sender: TObject);
    procedure BtnInsererClick(Sender: TObject);
    procedure BtnFermerClick(Sender: TObject);
    procedure BtnSupprimerClick(Sender: TObject);
    procedure DBImmoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnModifierClick(Sender: TObject);
    procedure BtnEnregistrerClick(Sender: TObject);
    procedure DBImmoColExit(Sender: TObject);
    procedure DBImmoEnter(Sender: TObject);
    procedure ChangementEtatBoutons(Sender: TObject);
    procedure ChangementEtatCaption(Sender: TObject);
    procedure ChangementEtatGrille(Sender: TObject);
    procedure Enregistrement;
    procedure NumCptExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure NumCptKeyPress(Sender: TObject; var Key: Char);
    procedure RxSpeedButton2Click(Sender: TObject);
    procedure RxSpeedButton1Click(Sender: TObject);
    procedure PatitreResize(Sender: TObject);
    procedure PaGrilleResize(Sender: TObject);
    procedure PaBtnResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Aide1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure BtnImprimerClick(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Aideenligne1Click(Sender: TObject);
    procedure BtnAnnulerEnter(Sender: TObject);
    procedure BtnAnnulerExit(Sender: TObject);
    procedure NumCptEnter(Sender: TObject);
    procedure Slectioncharges1Click(Sender: TObject);
    procedure TraitementAideTVA;
    procedure InitialisatonApresInsert(DataSet: TDataSet);
    procedure Calculatrice1Click(Sender: TObject);

  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }

  end;

var
  ImmoEnCours: TImmoEnCours;
  Mark: TBookMark;
  LastSize:integer;
  DernierCptValide,DernierLibValide:string;
//  DerniereDateValide:Tdatetime;
  MessDerSub:boolean;
  NumCpt1,NumCpt2,NumCpt3:string;
  CaptionNCpt1,CaptionNCpt2,CaptionNCpt3:string;
implementation

uses DMPlanCpt, E2_Main,E2_Recherche,
//UQReport,
E2_AideAssist, DMAide,
DMImmo_Clot,E2_SelectionLigne;

{$R *.DFM}



procedure TImmoEnCours.AideEnLigne(Sender: TObject);
var
   aa,result:boolean;
begin
try
//WinShape(ActiveControl,Shape1,shape2,Main.ContourCouleur);
if ((AideAssist <> nil) and (AideAssist.Visible)) then
Result:=DMAides.taAssist.FindKey([self.Name+inttostr(self.tag),ActiveControl.Name]);
     if not Result then
        DMAides.taAssist.FindKey(['Vide','Vide']);
except;
end;
end;

procedure TImmoEnCours.Enregistrement;
begin
  try
  TableGerePost(DMImmo_Clo.TaImmo_Clo);
  except
  abort;
  end;
end;

//****************************************************************************//
// Gestion du Show de la fen�tre.                                             //
//****************************************************************************//
procedure TImmoEnCours.FormShow(Sender: TObject);
var
   Colonne: TColumn;
   I: Integer;
begin
DMImmo_Clo.DaImmo_Clo.OnStateChange:=ChangementEtatBoutons;
DMImmo_Clo.TaImmo_Clo.afterInsert:=InitialisatonApresInsert;
DMImmo_Clo.Tag:=self.Tag;
for i:=0 to DBImmo.ColCount-3 do
dbimmo.Columns[0].Free;
//on construit la grille
dbimmo.Columns[0].FieldName := 'Reference_OP';
dbimmo.Columns[0].Title.Caption := 'R�f�rence';
Colonne := DBImmo.Columns.Add;
Colonne.FieldName := 'COMPTE';
Colonne.Title.Caption := 'Compte';
Colonne := DBImmo.Columns.Add;
Colonne.FieldName := 'Designation';
Colonne.Title.Caption := 'D�signation';
Colonne := DBImmo.Columns.Add;
Colonne.FieldName := 'Quantite';
Colonne.Title.Caption := 'Qt�';
Colonne := DBImmo.Columns.Add;
Colonne.FieldName := 'Montant';
Colonne.Title.Caption := 'Montant HT';

     Case Self.Tag Of
           1: Begin // Si fen�tre d'immobilisation en cours ou Termin�es
                  Colonne := DBImmo.Columns.Add;
                  Colonne.FieldName := 'Date';
                  Colonne.Title.Caption := 'Date';           
                  Patitre.Caption:='Immobilisation en Cours';
                  Patitre.Color:=$00E8FFFF;
                  Label5.Caption := DateToStr(E.DatExoFin);
                  Self.Caption :='Cl�ture - Immobilisation en Cours';
//                  RxSpeedButton1.Visible:=True;
             End; // Fin fen�tre d'ouverture
          2: Begin // Si fen�tre d'immobilisation en cours ou Termin�es
                  Colonne := DBImmo.Columns.Add;
                  Colonne.FieldName := 'Date';
                  Colonne.Title.Caption := 'Date';
                  Patitre.Caption:='Immobilisation termin�es';
                  Patitre.Color:=$00E8FFFF;
                  Label5.Caption := DateToStr(E.DatExoFin);
                  Self.Caption :='Cl�ture - Immobilisation termin�es';
//                  RxSpeedButton1.Visible:=True;
             End; // Fin fen�tre d'ouverture
          3: Begin // Si fen�tre de Productions immobilis�es
                  Colonne := DBImmo.Columns.Add;
                  Colonne.FieldName := 'TVA';
                  Colonne.Title.Caption := 'Montant TVA';
                  Colonne := DBImmo.Columns.Add;
                  Colonne.FieldName := 'Date';
                  Colonne.Title.Caption := 'Date';
                  Label5.Caption := DateToStr(E.DatExoFin);
                  Patitre.Caption:='Cl�ture : Productions immobilis�es';
                  Patitre.Color:=$00A4A4FF;
//               RxSpeedButton1.Visible:=false;
             End; // Fin fen�tre de cl�ture
     End; // Fin de Self.Tag
     PaGrilleResize(pagrille);
//For I:= 0 To 5 Do DBImmo.Columns[I].ReadOnly := False;
end;
//****************************************************************************//


//****************************************************************************//
// Initialisation � la cr�ation de la fen�tre.                                //
//****************************************************************************//
procedure TImmoEnCours.FormCreate(Sender: TObject);
Var
Registre :TRegistry;
numDefaut,LibDefaut:string;
Begin
 if DMImmo_Clo=nil then
 DMImmo_Clo:=TDMImmo_Clo.Create(self);

// if DataModuleImmos=nil then
// DataModuleImmos:=TDataModuleImmos.Create(self);

 if AideCompte=nil then
 AideCompte:=TAideCompte.Create(self);
 Registre:= TRegistry.Create;
 NumCpt1:='';
 NumCpt2:='';
 NumCpt3:='';
CaptionNCpt1:='';
CaptionNCpt2:='';
CaptionNCpt3:='';
 case self.tag of
 1,2:Begin
      numDefaut:='231';
      LibDefaut:='Immobilisation en cours';
     End;
 3:  Begin
       numDefaut:='721';
       LibDefaut:='Production immobilis�e';
     End;
 end;//fin du case
   try
     with Registre do
     begin
        RootKey := HKEY_LOCAL_MACHINE;
        OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, false);
      try
             NumCpt1:=ReadString('NumCpt1');
             CaptionNCpt1:=ReadString('CaptionNCpt1');
             NumCpt2:=ReadString('NumCpt2');
             CaptionNCpt2:=ReadString('CaptionNCpt2');
             NumCpt3:=ReadString('NumCpt3');
             CaptionNCpt3:=ReadString('CaptionNCpt3');
      except
        NumCpt.Text:=numDefaut;
        label3.Caption:=LibDefaut;
      end;//fin du try except
   end;//fin du with registre
   finally
    Registre.Free;
   end;
   if empty(numcpt.text) then
      Begin
        NumCpt.Text:=numDefaut;
        label3.Caption:=LibDefaut;
      End;
case self.tag of
 1:Begin
     NumCpt.Text:=NumCpt1;
     label3.Caption:=CaptionNCpt1;
   End;
 2:Begin
     NumCpt.Text:=NumCpt2;
     label3.Caption:=CaptionNCpt2;
   End;
 3:Begin
     NumCpt.Text:=NumCpt3;
     label3.Caption:=CaptionNCpt3;
   End;
end;//fin du case tag
DMImmo_Clo.Contrepartie:=NumCpt.Text;
DernierCptValide:=NumCpt.Text;
DernierLibValide:=label3.Caption;

  try
      LibGestionParamXML.InitialiseForm(E.User,Self);
  except
      Position:=poScreenCenter;
      InitialiseFormPosDefaut(self);
  end;

 LastSize:=0;
 MessDerSub:=true;
 DBImmo.DateDef:=e.DatExoFin;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion de la fermeture de la fen�tre.                                     //
//****************************************************************************//
procedure TImmoEnCours.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//     EffaceBookmark;
end;
//****************************************************************************//

Procedure TImmoEnCours.InitialiseTable_A_Nil;
Begin
  //   DMImmo_Clo.DaImmo_Clo.OnStateChange:=nil;
  if DMImmo_Clo<>nil then
  InitDatasetEvent_A_Nil_Sur_Form([DMImmo_Clo.DaImmo_Clo]);
End;

//****************************************************************************//
// Lib�ration de la m�moire.                                                  //
//****************************************************************************//
procedure TImmoEnCours.FormDestroy(Sender: TObject);
Var
	Registre :TRegistry;
Begin
      Registre:= TRegistry.Create;
      try
         InitialiseTable_A_Nil;
         with Registre do begin
            RootKey := HKEY_LOCAL_MACHINE;

            OpenKey('\SOFTWARE\LGR\Epicea2\' + e.User+ '\' + self.Name, True);
             WriteString('NumCpt1',NumCpt1);
             WriteString('CaptionNCpt1',CaptionNCpt1);
             WriteString('NumCpt2',NumCpt2);
             WriteString('CaptionNCpt2',CaptionNCpt2);
             WriteString('NumCpt3',NumCpt3);
             WriteString('CaptionNCpt3',CaptionNCpt3);
            CloseKey;
         end;
      finally
         Registre.Free;
      end;

     LibGestionParamXML.DestroyForm(Self,E.User);
//     if DataModuleImmos<>nil then  DataModuleImmos.Free;
     if DMImmo_Clo<>nil then DMImmo_Clo.Free;
     ImmoEnCours:=Nil;
end;
//****************************************************************************//

//******************* ChangementEtatBoutons *************************
procedure TImmoEnCours.ChangementEtatBoutons(Sender: TObject);
begin
   case DMImmo_Clo.TaImmo_Clo.State of
   dsBrowse	: begin
            NumCpt.Enabled:=true;
            BtnEnregistrer.Enabled:=false;
            BtnInserer.Enabled:=true;
            BtnModifier.Enabled:=(Not(DMImmo_Clo.TaImmo_Clo.RecordCount = 0));
            BtnSupprimer.Enabled:=(Not(DMImmo_Clo.TaImmo_Clo.RecordCount = 0));
            BtnImprimer.Enabled:=true;
            DBImmo.OnColExit:=nil;
           end;

   dsedit:   begin
            NumCpt.Enabled:=False;
            BtnEnregistrer.Enabled:=true;
            BtnInserer.Enabled:=false;
            BtnModifier.Enabled:=false;
            BtnSupprimer.Enabled:=false;
            BtnImprimer.Enabled:=false;
            DBImmo.OnColExit:=DBImmoColExit;
           end;

   dsinsert: begin
            NumCpt.Enabled:=False;
            BtnEnregistrer.Enabled:=false;
            BtnInserer.Enabled:=false;
            BtnModifier.Enabled:=false;
            BtnSupprimer.Enabled:=false;
            BtnImprimer.Enabled:=false;
            DBImmo.OnColExit:=DBImmoColExit;
           end;
   end; //fin du case
   //Pop-up Menu
   Fermer1.Enabled:=BtnFermer.Enabled;
   Insrer1.Enabled:=BtnInserer.Enabled;
   Enregister1.Enabled:=BtnEnregistrer.Enabled;
   Modifier1.Enabled:=BtnModifier.Enabled;
   Supprimer1.Enabled:=BtnSupprimer.Enabled;
   imprimer1.Enabled:=btnimprimer.Enabled;
   if self.tag in [1,2] then
     Slectioncharges1.Enabled:=true
   else
     Slectioncharges1.Enabled:=false;
   ChangementEtatCaption(self);//appel d'une proc�dure de changement
   //des captions en fonction de l'�tat de la table
   ChangementEtatGrille(self); //appel d'une proc�dure de changement
   //d'�tat de la grille en fonction de l'�tat de la table
end;




//******************* ChangementEtatCaption *************************
procedure TImmoEnCours.ChangementEtatCaption(Sender: TObject);
var
   messagetmp: String;
begin
     Case Self.Tag Of
          1: Messagetmp := 'Cl�ture - Immobilisation en cours';
          2: Messagetmp := 'Cl�ture - Immobilisation Termin�es';
          3: Messagetmp := 'Cl�ture - Productions immobilis�es';
     End; // Fin du Case.Tag

     Case DMImmo_Clo.TaImmo_Clo.State Of

          dsBrowse:  Self.Caption := messagetmp+'Consultation';

          dsEdit:    Self.Caption := messagetmp+'Modification';

          dsInsert:  Self.Caption := messagetmp+'Insertion';

     End;// fin du case

end;


//******************* ChangementEtatGrille *************************

procedure TImmoEnCours.ChangementEtatGrille(Sender: TObject);
var I:integer;
begin
DBImmo.OnColExit:=nil;
  case DBImmo.DataSource.State of
    dsinsert : begin //si table en insertion
                 DBImmo.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
                 DBImmo.Columns[0].ReadOnly := True;
                 DBImmo.Columns[1].ReadOnly := False;
                 DBImmo.Columns[2].ReadOnly := False;
                 DBImmo.Columns[3].ReadOnly := false;
                 DBImmo.Columns[4].ReadOnly := False;
                 Case Self.Tag Of
                 3: Begin //si cl�ture
                    DBImmo.Columns[5].ReadOnly := False;
                    End;
                 End; // Fin du Case.tag
                 DBImmo.TitreColor(true);
                 DBImmo.SetFocus;
               end;// fin insertion
    dsbrowse : begin //si table en consultation
                 DBImmo.Options := [dgediting,dgtitles,dgindicator,dgrowlines,dgcollines,dgtabs];
                 if DBImmo.InplaceEditor <> nil then
                    DBImmo.EditorMode:=false;
                 DBImmo.TitreColor(true);
               end;//fin de consultation
    dsEdit : begin //si table en modification
               DBImmo.TitreColor(true);
               DBImmo.Options := [dgediting,dgalwaysshoweditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
               DBImmo.SetFocus;
               DBImmo.Columns[0].ReadOnly := true;
               DBImmo.Columns[1].ReadOnly := False;
               DBImmo.Columns[2].ReadOnly := False;
               DBImmo.Columns[3].ReadOnly := false;
               DBImmo.Columns[4].ReadOnly := False;
               If Self.Tag = 2 Then//si cl�ture
                 DBImmo.Columns[5].ReadOnly := False;
             End;//fin modification
  end;//fin du case.state
  DBImmo.OnColExit:=DBImmoColExit;
end;


//****************************************************************************//
// Permet d'ins�rer une charge � r�partir.                                    //
//****************************************************************************//
procedure TImmoEnCours.BtnInsererClick(Sender: TObject);
begin
 TableAjoute(DMImmo_Clo.TaImmo_Clo);
end;
//****************************************************************************//


//****************************************************************************//
// Permet de fermer la fen�tre.                                               //
//****************************************************************************//
procedure TImmoEnCours.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;
//****************************************************************************//


//****************************************************************************//
// Permet de supprimer la charge s�lectionn�e par l'utilisateur.              //
//****************************************************************************//
procedure TImmoEnCours.BtnSupprimerClick(Sender: TObject);
begin
   try
   TableGereDelete(DMImmo_Clo.TaImmo_Clo);
   except
   abort;
   end;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches dans la grille.                                        //
//****************************************************************************//
procedure TImmoEnCours.DBImmoKeyPress(Sender: TObject; var Key: Char);
begin
       If Key = #13 Then //si on tape sur entree
     Begin
          Case Self.Tag Of
          1: Begin //si ouverture
                  If DBImmo.SelectedIndex < 2 Then
                  //si on n'est pas sur la derni�re colonne
                     DBImmo.SelectedIndex := DBImmo.SelectedIndex + 1
                  Else
                  Begin//si on est sur la derni�re colonne
                       If DMImmo_Clo.TaImmo_Clo.State in [dsInsert,dsedit] Then
                       //si on est en insertion ou edition
                          begin
                          Enregistrement;
                          DBImmo.SetFocus;
                          end
                       Else
                       Begin//si browse
                       //showmessage('je ne fais rien');
                             DMImmo_Clo.TaImmo_Clo.Next;//ligne suivante
                             DBImmo.SelectedIndex := 1;
                             DBImmo.SetFocus;
                       End;//fin si browse
                  End;
             End;
          End;
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion des touches alphanum�riques.                                       //
//****************************************************************************//
procedure TImmoEnCours.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     If Key = VK_ESCAPE Then
     Begin

          If DMImmo_Clo.TaImmo_Clo.State = dsBrowse Then
          Begin
            if DBImmo.Focused then Self.Close;
            if NumCpt.Focused then DBImmo.SetFocus;
          End;

       // Si l'utilisateur est en mode Insertion
          If DMImmo_Clo.TaImmo_Clo.State = dsInsert Then
          Begin
          if Messagedlg('Voulez-vous annuler la cr�ation cette immobilisation ?',
            MtConfirmation,[mbyes,mbno],0) = mryes Then
            begin
             DMImmo_Clo.TaImmo_Clo.Cancel;
             abort;
            end
            else
            begin
             Abort;
            end;
          End;


          If DMImmo_Clo.TaImmo_Clo.State = dsEdit Then
          Begin
               If Messagedlg('Annuler les modifications de cette immobilisation ?',
               MtConfirmation,[mbyes,mbno],0) = mryes Then
               Begin
                 DMImmo_Clo.TaImmo_Clo.Cancel;
//                    DBImmo.SelectedIndex := 1;
                 abort;
               End
               Else
               Begin
                    Abort;
               End;
          End;
     End;
end;
//****************************************************************************//


//****************************************************************************//
// Gestion du click sur le bouton Modifier.                                   //
//****************************************************************************//
procedure TImmoEnCours.BtnModifierClick(Sender: TObject);
begin
  DMImmo_Clo.TaImmo_Clo.Edit;
end;
//****************************************************************************//



//****************************************************************************//
// Gestion du click sur le bouton Enregistrer.                                //
//****************************************************************************//
procedure TImmoEnCours.BtnEnregistrerClick(Sender: TObject);
begin
  if DMImmo_Clo.TaImmo_Clo.State in  [dsinsert,dsedit] then
     begin
     DMImmo_Clo.BoutonEnregistrer:=true;
     Enregistrement;
     DBImmo.SelectedIndex:=1;
     DBImmo.SetFocus;
     end;
end;
//****************************************************************************//

//****************************************************************************//
// Permet de contr�ler la saisie de l'utilisateur dans la grille.             //
//****************************************************************************//
procedure TImmoEnCours.DBImmoColExit(Sender: TObject);
var retourFonction:TErreurSaisie;
key:word;
begin
if DBImmo.DataSource.DataSet.State in [dsinsert,dsEdit] then
   begin
   // appel de la fonction de contr�le de saisie
   retourFonction:=DMImmo_Clo.CtrlSaisieImmos_Clo(DBImmo.SelectedField);
    if  retourFonction.Retour=false then
     begin
       case self.tag of
       1,2,3:begin//si tous les ecrans
           case retourFonction.CodeErreur of
             3100,7100:abort;//
             9101,9102:Begin
                         key:=VK_F1;
                         dbimmo.KeyDown(key,[]);
                       End;
           end;//fin du case codeerreur
         end;//fin tous les ecrans
       end;//fin case.tag
       DBImmo.SetFocus
     end;
   end;
end;


procedure TImmoEnCours.DBImmoEnter(Sender: TObject);
begin
  if empty(numcpt.Text) then
  begin
  numcpt.SetFocus;
  abort;
  end;
end;

procedure TImmoEnCours.NumCptExit(Sender: TObject);
var
Enregistrement:TEnregistrementComplet;
begin
try
//if (DMImmo_Clo.TaImmo_Clo.State in [dsBrowse]) then
//   begin
//    DMImmo_Clo.FiltrageAffichageGrille(self.tag,);
//
// end;

DMImmo_Clo.GestionFiltrageAideCompte('1');
DMImmo_Clo.DaImmo_Clo.OnStateChange(DMImmo_Clo.TaImmo_Clo);
//if not empty(numcpt.Text)then
//  begin
    if AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],false,MessDerSub,true,true,false,true,0)=true then
       begin
       DMImmo_Clo.FiltrageAffichageGrille(self.Tag,numcpt.text);
       Enregistrement:=DmPlanRecupEnregistrementComplet(numcpt.text);
       if enregistrement.CodeRetour then
       Label3.Caption:=enregistrement.Libelle;
       if self.Tag=3 then
         begin
         if empty(enregistrement.TvaCode) then
           DMImmo_Clo.TaImmo_CloTVA.ReadOnly:=true;
         end;
       DMImmo_Clo.TaImmo_Clo.BeforePost:=nil;
       DMImmo_Clo.TaImmo_Clo.AfterPost:=nil;
       DMImmo_Clo.Contrepartie:= numcpt.text;
       DMImmo_Clo.DaImmo_Clo.OnStateChange(DMImmo_Clo.TaImmo_Clo);
       end
       else
       begin
       numcpt.SetFocus;
       abort;
       end;
MessDerSub:=true;
DernierCptValide:=NumCpt.Text;
DernierLibValide:=label3.Caption;
case self.tag of
 1:Begin
     NumCpt1:=NumCpt.Text;
     CaptionNCpt1:=label3.Caption;
   End;
 2:Begin
     NumCpt2:=NumCpt.Text;
     CaptionNCpt2:=label3.Caption;
   End;
 3:Begin
     NumCpt3:=NumCpt.Text;
     CaptionNCpt3:=label3.Caption;
   End;
end;//fin du case tag
finally
  DMImmo_Clo.TaImmo_Clo.BeforePost:=DMImmo_Clo.TaImmo_CloBeforePost;
  DMImmo_Clo.TaImmo_Clo.AfterPost:=DMImmo_Clo.TaImmo_CloAfterPost;
end;//fin du try finally
end;

procedure TImmoEnCours.FormActivate(Sender: TObject);
begin
//filtrer aidecompte en fonction du contexte
Initialiser_ShortCut_Main(true);
DMImmo_Clo.GestionFiltrageAideCompte('1');
MessDerSub:=false;
case self.tag of
 1:Begin
     NumCpt.Text:=NumCpt1;
     label3.Caption:=CaptionNCpt1;
   End;
 2:Begin
    NumCpt.Text:= NumCpt2;
    label3.Caption:=CaptionNCpt2;
   End;
 3:Begin
     NumCpt.Text:=NumCpt3;
     label3.Caption:=CaptionNCpt3;
   End;
end;//fin du case tag
if AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],false,MessDerSub,false,true,false,true,0)=false then
  begin
  NumCpt.Text:='';
  label3.Caption:='';
  numcpt.SetFocus;
  end
else
  DBImmo.SetFocus;
DMImmo_Clo.Contrepartie:=NumCpt.text;
MessDerSub:=true;
DMImmo_Clo.FiltrageAffichageGrille(self.tag,numcpt.text);
DMImmo_Clo.Tag:=self.Tag;
if (DMImmo_Clo.TaImmo_Clo.State in [dsBrowse]) then
    DMImmo_Clo.DaImmo_Clo.OnStateChange(DMImmo_Clo.TaImmo_Clo);
DBImmo.ParamColor:=true;
DBImmo.Param:=ParamUtil.CouleurDBGrid;
DBImmo.UpDateColor;

end;

procedure TImmoEnCours.NumCptKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in [#48..#57,#13,#8,#9]) then
key:=#0;
if key=#13 then
 begin
   DBImmo.SetFocus;
 end;
end;

procedure TImmoEnCours.RxSpeedButton2Click(Sender: TObject);
begin
case self.tag of
   1:Main.Cetprecevoir1Click(Main.Cetprecevoir1);
   2:Main.Dpensedelentreprise1Click(Main.Dpensedelentreprise1);
end;


end;

procedure TImmoEnCours.RxSpeedButton1Click(Sender: TObject);
begin
Main.Balance1Click(Main.Bilandouverture1);
end;

procedure TImmoEnCours.PatitreResize(Sender: TObject);
begin
RxSpeedButton1.top:=12;
RxSpeedButton1.Left:=Patitre.Width-102;
RxSpeedButton1.Height:=Patitre.Height-24;
end;

procedure TImmoEnCours.PaGrilleResize(Sender: TObject);
begin
case self.tag of
   1,2:Begin
       DBImmo.ColWidths[1]:=(DBImmo.Width) div 7;
       DBImmo.ColWidths[2]:=(DBImmo.Width) div 8;
       DBImmo.ColWidths[3]:=(DBImmo.Width) div 3;
       DBImmo.ColWidths[4]:=(DBImmo.Width) div 21;
       DBImmo.ColWidths[5]:=(DBImmo.Width) div 7;
       //DBImmo.ColWidths[5]:=(DBImmo.Width) div 7;
     End;

   3:Begin
       DBImmo.ColWidths[1]:=(DBImmo.Width) div 7;
       DBImmo.ColWidths[2]:=(DBImmo.Width) div 8;
       DBImmo.ColWidths[3]:=(DBImmo.Width) div 3;
       DBImmo.ColWidths[4]:=(DBImmo.Width) div 21;
       DBImmo.ColWidths[5]:=(DBImmo.Width) div 7;
       DBImmo.ColWidths[6]:=(DBImmo.Width) div 7;
     End;
end;
WinShape(ActiveControl,Main.Shape1,Main.shape2,ParamUtil.ContourCouleur);
end;

procedure TImmoEnCours.PaBtnResize(Sender: TObject);
begin
FormateTailleBoutton([BtnAnnuler,BtnEnregistrer,BtnModifier,BtnInserer,BtnSupprimer,BtnFermer,BtnImprimer],PaBtn,90,0);
//BtnAnnuler.Left:=(PaBtn.Width-630) div 2;
//BtnEnregistrer.Left:=BtnAnnuler.Left +89;
//BtnInserer.Left:=BtnAnnuler.Left+178;
//BtnModifier.Left:=BtnAnnuler.Left+267;
//BtnSupprimer.Left:=BtnAnnuler.Left+356;
//BtnFermer.Left:=BtnAnnuler.Left+445;
//BtnImprimer.left:=BtnAnnuler.Left+534;
end;

procedure TImmoEnCours.FormResize(Sender: TObject);
begin
if self.Width < 450 then
     if LastSize > self.Width
       then
           begin
          LastSize:=self.Width;
           abort;
           end;
LastSize:=self.Width;
end;

procedure TImmoEnCours.Aide1Click(Sender: TObject);
begin
 If activecontrol = DBImmo Then
  begin //si focus grille
   case DBImmo.DataSource.State of
   dsbrowse:case DBImmo.SelectedIndex of
              0:Rechercher(DBImmo,DMImmo_Clo.TaImmo_Clo,['Reference_OP','Designation','ID','Date','Compte'],['R�ference','D�signation','','',''],'',0);
              1:Rechercher(DBImmo,DMImmo_Clo.TaImmo_Clo,['Designation','Reference_OP','Date','ID','Compte'],['D�signation','R�ference','','',''],'',0);
            end;
   dsinsert,
   dsedit  :case self.tag of
              1,2:Begin//si ecran immo en cours ou termin�es
                   case DBImmo.SelectedIndex of
                    1:begin
                       DMImmo_Clo.GestionFiltrageAideCompte('2');
                       MessDerSub:=false;
                       AideCompteDansContexte(DBImmo.Columns[1].Field.AsString,DBImmo,['Rac1'],true,MessDerSub,false,true,false,true,0);
                       MessDerSub:=true;
                      end;
                   end;//fin du case selectedIndex
                 End;//fin si ecran immo en cours ou termin�es
               3:Begin//si ecran immo en cours ou termin�es
                   case DBImmo.SelectedIndex of
                    1:begin
                       DMImmo_Clo.GestionFiltrageAideCompte('2');
                       MessDerSub:=false;
                       AideCompteDansContexte(DBImmo.Columns[1].Field.AsString,DBImmo,['Rac1'],true,MessDerSub,false,true,false,true,0);
                       MessDerSub:=true;
                      end;
                    4,5:Begin
                        try
                          if DBImmo.Columns[5].Field.ReadOnly=false then
                            TraitementAideTVA
                          else
                            showmessage('Ce Compte n''attends pas de TVA');
                        except
                            showmessage('Ce Compte n''attends pas de TVA');
                        end;//fin du try except
                      End;
                   end;//fin du case selectedIndex
                 End;//fin si ecran immo en cours ou termin�es
            end;//fin du case self.tag
   end;//fin du case etat table
  end;//fin si focus grille
 If activecontrol = NumCpt Then
  begin //si focus numcpt
   case DBImmo.DataSource.State of
   dsbrowse:begin
             DMImmo_Clo.GestionFiltrageAideCompte('1');
             MessDerSub:=false;
             AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],true,MessDerSub,false,true,false,true,0);
             MessDerSub:=true;
            end;
   end;//fin du case etat table
  end;//fin si focus numcpt
end;

procedure TImmoEnCours.FormDeactivate(Sender: TObject);
begin
//If DMImmo_Clo.TaImmo_Clo.State = dsInsert Then
//     Begin
//          If BtnEnregistrer.Enabled Then //s'il y a une saisie
//          Begin
//               If Messagedlg('Voulez-vous enregistrer cette provision ?',
//               MtConfirmation,[mbyes,mbno],0) = mryes Then
//                  Enregistrement
//               else //si on ne veut pas enregistrer
//                 DMImmo_Clo.TaImmo_Clo.Cancel;
//          End
//          Else //s'il n'y a rien de saisi
//          Begin
//                  DMImmo_Clo.TaImmo_Clo.Cancel;
//          End;
//     End;
//     If DMImmo_Clo.TaImmo_Clo.State = dsEdit Then
//     Begin
//          If Messagedlg('Voulez-vous enregistrer les modifications de cette provision ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
//             Enregistrement
//          else //si on ne veut pas enregistrer
//             DMImmo_Clo.TaImmo_Clo.Cancel;
//     End;
//
//          EffaceBookmark;
//
//     Case Self.Tag Of
//          2: Begin //si cloture
//             if DMImmo_Clo.FiltragePourOuvertureReprise=true then
//                 begin//si on a trouv� des charges � repartir
//                     try
////                     DMImmo_Clo.CreationODChargeOuverture;
////                     DMImmo_Clo.CreationODChargeCloture;
//
//                    except
//                       begin
//                       showmessage('Probl�me � la cr�ation des OD ');
//                //       DMPieces.TaPiece.Database.Rollback;
//                       abort;
//                       end;
//                    end;
//                 DMImmo_Clo.DemandeAffichageReprise;
//                 end;//fin si on a trouv� des charges � repartir
//             end;//fin si cloture
//     End; // Fin du Self.Tag
//if aidecompte<>nil then
//aidecompte.DefiltrageAideCompte;
//if empty(NumCpt.Text) then
//NumCpt.Text:=CompteParDefaut;
end;

procedure TImmoEnCours.BtnImprimerClick(Sender: TObject);
begin
//if (FPrint = nil) then FPrint:=TFPrint.Create(self);
//FPrint.SelectionEtat := 10;
//FPrint.show;

end;

procedure TImmoEnCours.BtnAnnulerClick(Sender: TObject);
var
ch:word;
begin
ch:=VK_ESCAPE;
self.KeyDown(ch,[]);
end;

procedure TImmoEnCours.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
messagetmp:string;
begin
try
canclose:=true;
// immoblisation
case self.tag of
  1:messagetmp:='immobilisation en cours';
  2:messagetmp:='immobilisation termin�e';
  3:messagetmp:='production immobilis�e';
end;//fin du case tag
If DMImmo_Clo <> nil then
If DMImmo_Clo.TaImmo_Clo.State = dsInsert Then
     Begin
          self.WindowState:=wsNormal;
          self.BringToFront;
          If BtnEnregistrer.Enabled Then //s'il y a une saisie
          Begin
               If Messagedlg('Voulez-vous enregistrer cette '+messagetmp+' ?',
               MtConfirmation,[mbyes,mbno],0) = mryes Then
                begin
                  Enregistrement;
                end
               else //si on ne veut pas enregistrer
                begin
                 DMImmo_Clo.TaImmo_Clo.Cancel;
                end;
          End
          Else //s'il n'y a rien de saisi
          Begin
               If Messagedlg('Voulez-vous annuler la cr�ation cette '+messagetmp+' ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
                begin
                  DMImmo_Clo.TaImmo_Clo.Cancel;
                end
               Else
                begin
                  canclose:=false;
                end;
          End;
     End;// Fin utilisateur est en mode Insertion

     // Si l'utilisateur est en mode Modification
     If DMImmo_Clo.TaImmo_Clo.State = dsEdit Then
     Begin
          self.WindowState:=wsNormal;
          self.BringToFront;
          If Messagedlg('Voulez-vous enregistrer les modifications de cette '+messagetmp+' ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
             Enregistrement
          else //si on ne veut pas enregistrer
             DMImmo_Clo.TaImmo_Clo.Cancel;
     End; // Fin utilisateur est en mode Modification

    if DMImmo_Clo.FiltragePourCreationOD(DMImmo_Clo.TaImmo_Clo,self.Tag)=true then
        begin//si on a trouv� des OD � cr�er
            try
            DMImmo_Clo.CreationOD_Immos(self.tag);
            except
              begin
              showmessage('Probl�me � la cr�ation des OD ');
       //       DMPieces.TaPiece.Database.Rollback;
              abort;
              end;
            end;//fin du try except
        end;//fin si on a trouv� des OD � cr�er
        if DMImmo_Clo.FiltrageReference(self.tag) then
           DMImmo_Clo.DemandeAffichageReprise(messagetmp);
    self.tag:=0; // initialisation du tag sinon plusieurs passage
//if aidecompte<>nil then
//aidecompte.DefiltrageAideCompte;
if not empty(NumCpt.Text) then
 begin
  DMImmo_Clo.GestionFiltrageAideCompte('1');
  MessDerSub:=false;
  if AideCompteDansContexte(NumCpt.text,NumCpt,['Rac1'],false,MessDerSub,false,true,false,true,0)= false then
   begin
   NumCpt.Text:=DernierCptValide;
   Label3.Caption:=DernierLibValide;
   end;
  end
  else
   begin
   NumCpt.Text:=DernierCptValide;
   Label3.Caption:=DernierLibValide;
   end;

except
   canclose:=false;
end;
if CanClose then InitialiseTable_A_Nil { isa  le  29/01/04 }
 else
 begin
   if AideCompte=nil then
   AideCompte:=TAideCompte.Create(self);

 end;

 
AssistantClotRafraichit(7);
  try
    if ((Cloture_Def<>nil)and(ActivationForm(Cloture_Def))) then // PB
      begin
        if ((Cloture_Def.EtapeSuivante>=7)or(Cloture_Def.EtapeSuivante>=8)) then  { isa  le  09/09/03 }
          Cloture_Def.EtapeSuivante:=Cloture_Def.EtapeSuivante-1;
      end;
  except
    //
  end;
end;

procedure TImmoEnCours.Aideenligne1Click(Sender: TObject);
begin
if AideAssist = Nil then AideAssist:= TAideAssist.Create(Self);
if AideAssist.Visible then
     begin
      AideAssist.close;
      self.show;
     end
     else begin
      AideAssist.Show;
      self.show;
     end;
end;

procedure TImmoEnCours.BtnAnnulerEnter(Sender: TObject);
begin
BouttonDiminue(sender as TButton);
end;

procedure TImmoEnCours.BtnAnnulerExit(Sender: TObject);
begin
BouttonAgrandit(sender as TButton);
end;

procedure TImmoEnCours.NumCptEnter(Sender: TObject);
begin
  EnableWinControl([BtnAnnuler,BtnFermer],True);
  EnableWinControl([BtnEnregistrer,BtnInserer,BtnModifier,BtnSupprimer,BtnImprimer],False);
  //Pop menu
  EnableItemMenu([Annuler1,Fermer1],true);
  EnableItemMenu([Enregister1,Insrer1,Modifier1,Supprimer1,Imprimer1],False);

end;



procedure TImmoEnCours.Slectioncharges1Click(Sender: TObject);
var
cpt:string;
begin
case self.Tag of
  1:cpt:='6%';
  2:cpt:='23%';
end;//fin du case tag
 AideSelectionImmoEnCours(DMImmo_Clo.TaImmo_Clo,Cpt,E.DatExoDebut,e.DatExoFin);
end;


procedure TImmoEnCours.TraitementAideTVA;
var
resultat:TAideMontantTTC2RetFunction;
Enregistrement:TEnregistrementComplet;
RetourTva:TRecupMiniMaxTva;
begin
  try
  RetourTva.Taux_Inf:=0;
  RetourTva.Taux_Supp:=0;
  RetourTva.CodeRetour:=0;
   Enregistrement:=DmPlanRecupEnregistrementComplet(DBImmo.Columns[1].Field.AsString);
         if Enregistrement.CodeRetour then
           begin//si le compte a �t� trouv�
              if not(empty(Enregistrement.TvaCode))then
              RetourTva:=FTvaRecupMiniMaxTva(Enregistrement.TvaCode)
              else
              abort;
           end;
   if DBImmo.InplaceEditor=nil then  DBImmo.InplaceEditor.Create(DBImmo);
  // if true then
  // begin //si editeur deja cr�e
      DBImmo.EditorMode:=true;
      if DBImmo.EditorMode then
      begin //si editeur mode =true
         if DBImmo.SelectedIndex = 4 then
         begin
         if (empty(DBImmo.InplaceEditor.Text))  then
         DBImmo.InplaceEditor.Text:='0';
         if strtofloat(DBImmo.InplaceEditor.text)=0 then
         DBImmo.InplaceEditor.Text:='0';
         if empty(DBImmo.Columns[5].Field.Asstring)then
         DBImmo.Columns[5].Field.Asinteger:=0;
         resultat.HT:=DBImmo.Columns[4].Field.Asinteger;
         resultat.TVA:=DBImmo.Columns[5].Field.Asinteger;
              case retourtva.CodeRetour of
                0:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,strtofloat(DBImmo.InplaceEditor.Text),DBImmo.Columns[5].Field.asfloat],3,True,[DBImmo.InplaceEditor],[3],E.DeviseSigle[1]);
                1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,strtofloat(DBImmo.InplaceEditor.Text),DBImmo.Columns[5].Field.asfloat],3,True,[DBImmo.InplaceEditor],[3],E.DeviseSigle[1]);
                2:resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,strtofloat(DBImmo.InplaceEditor.Text),DBImmo.Columns[5].Field.asfloat],3,True,[DBImmo.InplaceEditor],[3],E.DeviseSigle[1]);
               12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,strtofloat(DBImmo.InplaceEditor.Text),DBImmo.Columns[5].Field.asfloat,retourtva.Taux_Supp,0,strtofloat(DBImmo.InplaceEditor.Text),DBImmo.Columns[5].Field.asfloat],3,True,[DBImmo.InplaceEditor],[3],E.DeviseSigle[1]);
              end;//fin du case retourTva
         end;
         if DBImmo.SelectedIndex = 5 then
         begin
         if empty(DBImmo.Columns[4].Field.Asstring)then
         DBImmo.Columns[4].Field.Ascurrency:=0;
          if (empty(DBImmo.InplaceEditor.Text))  then
         DBImmo.InplaceEditor.Text:='0';
         if strtofloat(DBImmo.InplaceEditor.text)=0 then
         DBImmo.InplaceEditor.Text:='0';
         resultat.HT:=DBImmo.Columns[4].Field.Asinteger;
         resultat.TVA:=DBImmo.Columns[5].Field.Asinteger;
           case retourtva.CodeRetour of
              0:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBImmo.Columns[4].Field.asfloat,strtofloat(DBImmo.InplaceEditor.Text)],4,True,[DBImmo.InplaceEditor],[4],E.DeviseSigle[1]);
              1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBImmo.Columns[4].Field.asfloat,strtofloat(DBImmo.InplaceEditor.Text)],4,True,[DBImmo.InplaceEditor],[4],E.DeviseSigle[1]);
              2:resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,DBImmo.Columns[4].Field.asfloat,strtofloat(DBImmo.InplaceEditor.Text)],4,True,[DBImmo.InplaceEditor],[4],E.DeviseSigle[1]);
             12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBImmo.Columns[4].Field.asfloat,strtofloat(DBImmo.InplaceEditor.Text),retourtva.Taux_Supp,0,DBImmo.Columns[4].Field.asfloat,strtofloat(DBImmo.InplaceEditor.Text)],4,True,[DBImmo.InplaceEditor],[4],E.DeviseSigle[1]);
           end;//fin du case retourTva
         end;
      end;
  //    else //si editeur mode =false
  //    begin
  //    if currtostr(DBGridChAPayer.Columns[4].Field.Ascurrency)='' then
  //    DBGridChAPayer.Columns[4].Field.Ascurrency:=0;
  //    if inttostr(DBGridChAPayer.Columns[5].Field.asinteger)='' then
  //    DBGridChAPayer.Columns[5].Field.asinteger:=0;
  ////        case retourtva.CodeRetour of
  ////            1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
  ////            2:resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
  ////           12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,retourtva.Taux_Supp,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
  ////         end;//fin du case retourTva
  //    end;
  // end // fin si editeur deja cr�e
  // else
  // begin //si editeur pas cr�e
  // if currtostr(DBGridChAPayer.Columns[4].Field.Ascurrency)='' then
  // DBGridChAPayer.Columns[4].Field.Ascurrency:=0;
  // if inttostr(DBGridChAPayer.Columns[5].Field.asinteger)='' then
  // DBGridChAPayer.Columns[5].Field.asinteger:=0;
  ////         case retourtva.CodeRetour of
  ////            1:resultat:=AideMontantAffiche([retourtva.Taux_Inf,0,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
  ////            2:resultat:=AideMontantAffiche([retourtva.Taux_Supp,0,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
  ////           12:resultat:=AideMontantAffiche([retourtva.Taux_Inf,retourtva.Taux_Supp,DBGridChAPayer.Columns[4].Field,DBGridChAPayer.Columns[5].Field]);
  ////         end;//fin du case retourTva
  // end;

  if resultat.Retour then
  begin
  DBImmo.Columns[4].Field.AsCurrency:=resultat.HT;
  DBImmo.Columns[5].Field.AsCurrency:=resultat.TVA;
  end;
  except
   abort;
  end;//fin du try except
end;


procedure TImmoEnCours.InitialisatonApresInsert(DataSet: TDataSet);
begin
  dataset.Fields[9].AsDateTime:=e.DatExoFin;
end;

procedure TImmoEnCours.Calculatrice1Click(Sender: TObject);
begin
if DBImmo.Col in [3,4,5] then
  AfficheCalculatrice(DBImmo)
else
  AfficheCalculatrice(nil);
end;

end.