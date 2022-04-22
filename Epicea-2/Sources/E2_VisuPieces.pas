unit E2_VisuPieces;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Gr_Librairie, E2_Librairie_obj, DBGrids, Db,
  DBTables,E2_AideCompte, Gr_GestPlanCpt,Buttons, DBCtrls,
  ComCtrls,ToolWin, EpiceaControl,E2_main, Grids, EditAlign, Edit_PM;
type
  TVisuPieces = class(TForm)
    DataSource1: TDataSource;
    TaPiece: TTable;
    TaPieceID: TIntegerField;
    TaPieceJournal: TIntegerField;
    TaPieceReference: TStringField;
    TaPieceDate: TDateField;
    TaPieceLibelle: TStringField;
    TaPieceTypePiece: TSmallintField;
    TaPieceCompte: TStringField;
    TaPieceID_Devise: TIntegerField;
    TaPieceValidation: TDateField;
    TaPieceQui: TStringField;
    TaPieceQuand: TDateTimeField;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Label2: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    Label3: TLabel;
    DBText3: TDBText;
    Label4: TLabel;
    Label5: TLabel;
    DBGrid2: TDBGrid;
    TaEcriture: TTable;
    DataSource2: TDataSource;
    TaEcritureID: TIntegerField;
    TaEcritureID_Piece: TIntegerField;
    TaEcritureTypeLigne: TStringField;
    TaEcritureID_Ligne: TSmallintField;
    TaEcritureDate: TDateField;
    TaEcritureCompte: TStringField;
    TaEcritureTiers: TStringField;
    TaEcritureLibelle: TStringField;
    TaEcritureQt1: TFloatField;
    TaEcritureQt2: TFloatField;
    TaEcritureDebitSaisie: TFloatField;
    TaEcritureCreditSaisie: TFloatField;
    TaEcritureID_Devise: TIntegerField;
    TaEcritureDebit: TFloatField;
    TaEcritureCredit: TFloatField;
    TaEcritureTvaCode: TStringField;
    TaEcritureTvaType: TStringField;
    TaEcritureTvaTaux: TFloatField;
    TaEcritureTvaDate: TDateField;
    TaEcritureRapprochement: TStringField;
    TaEcritureValidation: TDateField;
    TaEcritureQui: TStringField;
    TaEcritureQuand: TDateTimeField;
    Panel1: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Label6: TLabel;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label7: TLabel;
    Panel4: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Panel5: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Panel6: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    SpeedButton6: TSpeedButton;
    SpeedButton5: TSpeedButton;
    EditDate1: TEditDate;
    EditDate2: TEditDate;
    EditReference1: TEditReference;
    EditReference2: TEditReference;
    EditCompte1: TEditCompte;
    EditCompte2: TEditCompte;
    BtnFermer: TButton;
    Query1: TQuery;
    Query1Reference: TStringField;
    Query1ID: TIntegerField;
    Query1Date: TDateField;
    Query1Compte: TStringField;
    Query1Libelle: TStringField;
    Query1Debit: TFloatField;
    Query1Credit: TFloatField;
    Panel7: TPanel;
    Label15: TLabel;
    Label14: TLabel;
    Button1: TButton;
    dbNameExo2: TDatabase;
    TAexercice: TTable;
    DataSource3: TDataSource;
    DBComboBox1: TComboBox;
    Edit7: TEdit_PM;
    Edit8: TEdit_PM;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure InitialiseVarFiltre;
    procedure FiltreTaPiece;
    procedure FiltreQuery1;
    procedure EditDate1Enter(Sender: TObject);
    procedure EditDate1Exit(Sender: TObject);
    procedure EditDate1Change(Sender: TObject);
    procedure EditReference1Enter(Sender: TObject);
    procedure EditReference1Exit(Sender: TObject);
    procedure EditCompte1Enter(Sender: TObject);
    procedure EditCompte1Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1Enter(Sender: TObject);
    procedure DBGrid1Exit(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid2ColEnter(Sender: TObject);
    procedure TaEcritureBeforeInsert(DataSet: TDataSet);
    procedure DBGrid2Exit(Sender: TObject);
    procedure TaEcritureBeforePost(DataSet: TDataSet);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnFermerClick(Sender: TObject);
    procedure TaEcritureBeforeScroll(DataSet: TDataSet);
    procedure DataSource2StateChange(Sender: TObject);
    procedure Edit8Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit7Exit(Sender: TObject);
    procedure DBComboBox1Click(Sender: TObject);
    procedure Edit7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit7Enter(Sender: TObject);
    procedure Edit8Enter(Sender: TObject);
    procedure DBComboBox1Enter(Sender: TObject);
    procedure DBComboBox1Exit(Sender: TObject);




  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;
var
  VisuPieces: TVisuPieces;
  Date1,Date2,Ref1,Ref2,Tiers1,Tiers2,Cpt1,Cpt2: String;
  Indice: Boolean;

implementation

uses DMBaseDonnee;

{$R *.DFM}
//****************************************************************************//
// Initialiser les valeurs du filtre de TaPiece.                              //
//****************************************************************************//
procedure TVisuPieces.InitialiseVarFiltre;
begin
     // Initialisation des variables avec des valeurs par défaut
     If SpeedButton1.Down Then
     Begin
          If EditDate1.Font.Style = [fsStrikeOut] Then Date1 := '01/01/1980' Else
          Begin
               If EditDate1.Text = '' Then Date1 := '01/01/1980' Else Date1 := EditDate1.Text;
          End;
          If EditDate2.Font.Style = [fsStrikeOut] Then Date2 := '31/12/2099' Else
          Begin
               If EditDate2.Text = '' Then Date2 := '31/12/2099' Else Date2 := EditDate2.Text;
          End;
     End
     Else
     Begin
          Date1 := '01/01/1980';
          Date2 := '31/12/2099';
     End;
     If SpeedButton2.Down Then
     Begin
          If EditReference1.Text = '' Then Ref1 := '!' Else Ref1 := EditReference1.Text;
          If EditReference2.Text = '' Then Ref2 := 'ÿÿ9999999' Else Ref2 := EditReference2.Text;
     End
     Else
     Begin
          Ref1 := '!';
          Ref2 := 'ÿÿ9999999'
     End;
     If SpeedButton3.Down Then
     Begin
          If EditCompte1.Text = '' Then Tiers1 := '+' Else Tiers1 := EditCompte1.Text;
          If EditCompte2.Text = '' Then Tiers2 := '0' Else Tiers2 := EditCompte2.Text;
     End;
     If SpeedButton4.Down Then
     Begin
          If EditCompte1.Text = '' Then Cpt1 := '1' Else Cpt1 := EditCompte1.Text;
          If EditCompte2.Text = '' Then Cpt2 := '9' Else Cpt2 := EditCompte2.Text;
     End;
end;
//****************************************************************************//

//****************************************************************************//
// Filtre la table des Pieces en fonction des critères de l'utilisateur.      //
//****************************************************************************//
procedure TVisuPieces.FiltreTaPiece;
begin
     InitialiseVarFiltre;
     TaPiece.Filtered := False;
     If ((Not(SpeedButton3.Down)) And (Not(SpeedButton4.Down))) Then
        TaPiece.Filter := CreeFiltreETPlage(['Date','Reference'],[Date1,Date2,Ref1,Ref2]);
     If SpeedButton3.Down Then
        TaPiece.Filter := CreeFiltreETPlage(['Date','Reference','Compte'],[Date1,Date2,Ref1,Ref2,Tiers1,Tiers2]);
     If SpeedButton4.Down Then
        TaPiece.Filter := CreeFiltreETPlage(['Date','Reference','Compte'],[Date1,Date2,Ref1,Ref2,Cpt1,Cpt2]);
        TaPiece.Filtered := True;
        Label15.Caption :=IntToStr(TaPiece.RecordCount);
end;
//****************************************************************************//

//****************************************************************************//
// Filtre la table des Pieces en fonction des critères de l'utilisateur.      //
//****************************************************************************//
procedure TVisuPieces.FiltreQuery1;
begin
     InitialiseVarFiltre;
     Query1.Filtered := False;
     If ((Not(SpeedButton3.Down)) And (Not(SpeedButton4.Down))) Then
        Query1.Filter := CreeFiltreETPlage(['Date','Reference'],[Date1,Date2,Ref1,Ref2]);
     If SpeedButton3.Down Then
        Query1.Filter := CreeFiltreETPlage(['Date','Reference','Compte'],[Date1,Date2,Ref1,Ref2,Tiers1,Tiers2]);
     If SpeedButton4.Down Then
        Query1.Filter := CreeFiltreETPlage(['Date','Reference','Compte'],[Date1,Date2,Ref1,Ref2,Cpt1,Cpt2]);
        Query1.Filtered := True;
        Label15.Caption :=  IntToStr(TaPiece.RecordCount);
end;
//****************************************************************************//
//****************************************************************************//
// Gestion du Destroy de la fenêtre.                                          //
//****************************************************************************//
procedure TVisuPieces.FormDestroy(Sender: TObject);
begin
     DestroyForm(Self);
     VisuPieces := Nil;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion du Create de la fenêtre.                                           //
//****************************************************************************//
procedure TVisuPieces.FormCreate(Sender: TObject);
begin
        InitialiseForm(Self);
        TaEcriture.DatabaseName:=dbNameExo2.DatabaseName;
        TaPiece.DatabaseName:=dbNameExo2.DatabaseName;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion du Show de la fenêtre.                                             //
//****************************************************************************//
procedure TVisuPieces.FormShow(Sender: TObject);
Var
   I: Integer;
begin
     dbNameExo2.close;
     dbNameExo2.Params:=DMBD.dbNameExo.Params;
     TAexercice.open ;
     TAexercice.Close ;

     //ON FILTRE SUR LE DOSSIER EN COURS
     TAexercice.Filter:='ID_Dossier='''+main.IDDos+'''';
     TAexercice.Filtered:=true;
     TAexercice.Open ;
     dbNameExo2.Open;
     TaPiece.Open;
     TaEcriture.Open;
     Query1.Open;
     dbcombobox1.Clear;
     //ON REMPLI LE COMBO AVEC LES EXERCICES DU DOSSIER
     for i:=0 to  TAexercice.RecordCount -1 do
         begin
            dbcombobox1.Items.Add(UpperCase(TAexercice.Fields[4].AsString));
            TAexercice.Next;
         end;
     if TAexercice.Locate('DIR_EXO',copy(dbNameExo2.Params[0],6,length(dbNameExo2.Params[0])),[loCaseInsensitive]) then
        editdate2.Text:=DateTimeToStr(TAexercice.FindField('DATE_FIN_EXO').AsDateTime);

     //RECHERCHE L4EXERCICE COURANT DANS LE COMBO
     dbcombobox1.ItemIndex:=dbcombobox1.Items.IndexOf(copy(dbNameExo2.Params[0],LastDelimiter('\',DMBD.dbNameExo.Params[0])+1,length(dbNameExo2.Params[0])));;
     visupieces.Caption:= 'Visualisation des pièces pour l''exercice '+ dbcombobox1.Text;
     dbNameExo2.Open;
     TaPiece.Open;
     TaEcriture.Open;
     Query1.Open;
     Indice := True;
    if (TAexercice.FindField('Cloture').AsBoolean)=True then
      begin
      DBGrid2.Options := [dgtitles,dgindicator,dgcollines,dgrowlines];
      end
   else
     begin
     DBGrid2.Options := [dgediting,dgalwaysshowEditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
     end;


     For I := 1 To 5 Do
     Begin
          (FindComponent('SpeedButton'+IntToStr(I)) as TSpeedButton).Down := False;
          (FindComponent('SpeedButton'+IntToStr(I)) as TSpeedButton).Font.Color := clWindowText;
     End;
     For I := 1 To 6 Do
     begin
          (FindComponent('SpeedButton'+IntToStr(I)) as TSpeedButton).Enabled := True;
     end ;
     For I := 3 To 6 Do
     Begin
          (FindComponent('Panel'+IntToStr(I)) as TPanel).Enabled := True;
          (FindComponent('Panel'+IntToStr(I)) as TPanel).Visible := False;
     End;
     SpeedButton6.Down := False;
     SpeedButton6Click(SpeedButton6);
     DBGrid1.SetFocus;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion du Close de la fenêtre.                                            //
//****************************************************************************//
procedure TVisuPieces.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     If TaEcriture.State = dsEdit Then
     Begin
          If Messagedlg('Voulez-vous enregistrer les modifications du libellé ?',MtConfirmation,[mbyes,mbno],0) = mryes Then
          Begin
               TaEcriture.Post;
          End;
     End;
     Query1.close;
     TaPiece.Close;
     TaEcriture.Close;
     TAexercice.close;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion du click sur le SpeedBouton Date.                                  //
//****************************************************************************//
procedure TVisuPieces.SpeedButton1Click(Sender: TObject);
var
   I: Integer;
begin
     If Not(SpeedButton6.Down) Then SpeedButton6.Down := True;
     // Si le Speed Bouton Date est activé
     If SpeedButton1.Down Then
       Begin
          SpeedButton1.Font.Color := clRed;
          // Redessinage de Panel1
          SpeedButton6Click(SpeedButton6);
          Panel3.Top := Panel1.Height - 41;
          Panel3.Visible := True;
          EditDate1.setfocus;
          //editdate2.Text:= DateTimeToStr(date);
         // Si la date actuelle n'est pas dans l'exercise courant on met la date de fin d'exercise
//         If ((StrToDate(editdate2.Text)<(TAexercice.FindField('DATE_DEB_EXO').AsDateTime)) or ((StrToDate(editdate2.Text)) > (TAexercice.FindField('DATE_FIN_EXO').AsDateTime))) then
 //         If ((StrToDate(editdate2.Text) < E.DatExoDebut) Or (StrToDate(editdate2.Text) > E.DatExoFin)) Then
 //               begin
 //               Editdate2.Text:=DateTimeToStr(TAexercice.FindField('DATE_FIN_EXO').AsDateTime);
 //               end
 //          else
 //               begin
  //              editdate2.Text:= DateTimeToStr(date);
  //              EditDate1.SetFocus;
   //             end
       End
     Else
     Begin
          SpeedButton1.Font.Color := clWindowText;
          If ((EditDate1.Focused) Or (EditDate2.Focused)) Then Panel3.SetFocus
          Else
          Begin
               EditDate1.Text := '';
               EditDate2.Text := '';
               FiltreTaPiece;
               FiltreQuery1;
          End;
          Panel3.Visible := False;
          SpeedButton6Click(SpeedButton6);
          For I := 3 To 6 Do
          Begin
               If (((FindComponent('Panel'+IntToStr(I)) as TPanel).Visible) And ((FindComponent('Panel'+IntToStr(I)) as TPanel).Top > Panel3.Top))  Then
                   (FindComponent('Panel'+IntToStr(I)) as TPanel).Top := (FindComponent('Panel'+IntToStr(I)) as TPanel).Top - 41;


           End;
     end;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion du click sur le Speed Bouton Reference.                            //
//****************************************************************************//
procedure TVisuPieces.SpeedButton2Click(Sender: TObject);
var
   I: Integer;
begin
     If Not(SpeedButton6.Down) Then SpeedButton6.Down := True;
     If SpeedButton2.Down Then
     Begin
          SpeedButton2.Font.Color := clRed;
          SpeedButton6Click(SpeedButton6);
          Panel4.Top := Panel1.Height - 41;
          Panel4.Visible := True;
          Panel4.SetFocus;
          EditReference1.SetFocus;
     End
     Else
     Begin
          SpeedButton2.Font.Color := clWindowText;
          If ((EditReference1.Focused) Or (EditReference2.Focused)) Then Panel4.SetFocus
          Else
          Begin
               EditReference1.Text := '';
               EditReference2.Text := '';
               FiltreTaPiece;
               FiltreQuery1;
          End;

          Panel4.Visible := False;
          SpeedButton6Click(SpeedButton6);
          For I := 3 To 6 Do
          Begin
               If (((FindComponent('Panel'+IntToStr(I)) as TPanel).Visible) And ((FindComponent('Panel'+IntToStr(I)) as TPanel).Top > Panel4.Top))  Then
                  (FindComponent('Panel'+IntToStr(I)) as TPanel).Top := (FindComponent('Panel'+IntToStr(I)) as TPanel).Top - 41;
          End;
     end;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion du click sur le SpeedBouton Tiers.                                 //
//****************************************************************************//
procedure TVisuPieces.SpeedButton3Click(Sender: TObject);
var
   I: Integer;
begin
     If Not(SpeedButton6.Down) Then SpeedButton6.Down := True;

     If SpeedButton3.Down Then
     Begin
          SpeedButton3.Font.Color := clRed;
          If Panel5.Visible Then
          Begin
               SpeedButton4.Font.Color := clWindowText;
               Label10.Caption := 'Tiers';
               EditCompte1.Text := '';
               EditCompte2.Text := '';
               FiltreTaPiece;
               FiltreQuery1;
               EditCompte1.SetFocus;
          End
          Else
          Begin
               SpeedButton6Click(SpeedButton6);
               Panel5.Top := Panel1.Height - 41;
               Label10.Caption := 'Tiers';
               Panel5.Visible := True;
               EditCompte1.SetFocus;
               EditCompte1.Text := '';
               EditCompte2.Text := '';
               FiltreTaPiece;
               FiltreQuery1;
         End;
     End
     Else
     Begin
          SpeedButton3.Font.Color := clWindowText;
          If ((EditCompte1.Focused) Or (EditCompte2.Focused)) Then Panel5.SetFocus
          Else
          Begin
               EditCompte1.Text := '';
               EditCompte2.Text := '';
               FiltreTaPiece;
               FiltreQuery1;
         End;
          If SpeedButton4.Down Then Label10.Caption := 'Compte'
          Else
          Begin
               Panel5.Visible := False;
               SpeedButton6Click(SpeedButton6);
               For I := 3 To 6 Do
               Begin
                    If (((FindComponent('Panel'+IntToStr(I)) as TPanel).Visible) And ((FindComponent('Panel'+IntToStr(I)) as TPanel).Top > Panel5.Top))  Then
                       (FindComponent('Panel'+IntToStr(I)) as TPanel).Top := (FindComponent('Panel'+IntToStr(I)) as TPanel).Top - 41;
               End;
          End;
     end;
end;
//****************************************************************************//

procedure TVisuPieces.SpeedButton4Click(Sender: TObject);
var
   I: Integer;
begin
     If Not(SpeedButton6.Down) Then SpeedButton6.Down := True;
     If SpeedButton4.Down Then
     Begin

          SpeedButton4.Font.Color := clRed;
          If Panel5.Visible Then
             Begin
               SpeedButton3.Font.Color := clWindowText;
               Label10.Caption := 'Compte';
               EditCompte1.Text := '';
               EditCompte2.Text := '';
               FiltreTaPiece;
               FiltreQuery1;
               EditCompte1.SetFocus;
            End
          Else
             Begin
               SpeedButton6Click(SpeedButton6);
               Panel5.Top := Panel1.Height - 41;
               Label10.Caption := 'Compte';
               Panel5.Visible := True;
               EditCompte1.SetFocus;
               EditCompte1.Text := '';
               EditCompte2.Text := '';
               FiltreTaPiece;
               FiltreQuery1;
            End;
     End
     Else
     Begin
          SpeedButton4.Font.Color := clWindowText;
          If ((EditCompte1.Focused) Or (EditCompte2.Focused)) Then Panel5.SetFocus
          Else
          Begin
               EditCompte1.Text := '';
               EditCompte2.Text := '';
               FiltreTaPiece;
               FiltreQuery1;
         End;
          If SpeedButton3.Down Then Label10.Caption := 'Tiers'
          Else
          Begin
               Panel5.Visible := False;
               SpeedButton6Click(SpeedButton6);
               For I := 3 To 6 Do
               Begin
                    If (((FindComponent('Panel'+IntToStr(I)) as TPanel).Visible) And ((FindComponent('Panel'+IntToStr(I)) as TPanel).Top > Panel5.Top))  Then
                       (FindComponent('Panel'+IntToStr(I)) as TPanel).Top := (FindComponent('Panel'+IntToStr(I)) as TPanel).Top - 41;
               End;
          End;
    end;
end;
//**************************************************************************************

procedure TVisuPieces.SpeedButton6Click(Sender: TObject);
var
   I: integer;
begin
     // Si le Speed Bouton est activé
     If SpeedButton6.Down Then
     Begin
          Panel1.Height := (SpeedButton1.Top + SpeedButton1.Height) ; //+8;
          For I := 1 To 5 Do
             Begin
             If (FindComponent('SpeedButton'+IntToStr(I)) as TSpeedButton).Down Then
                    Panel1.Height := Panel1.Height + 41;
             End;
          DBGrid1.Top := Panel1.Height + Panel1.Top  + 8;
          Panel2.Top := DBGrid1.Height + DBgrid1.Top  + 8;
          BtnFermer.Top := Panel2.Height + Panel2.Top  + 8;
          panel7.top:= DBGrid1.Top;
     End // Fin Speed Bouton activé

     Else
     // Si le Speed Bouton n'est pas activé
     Begin
          Panel1.Height := (SpeedButton1.Top + SpeedButton1.Height);
          DBGrid1.Top := Panel1.Height + Panel1.Top + 8;
          Panel2.Top := DBGrid1.Height + DBgrid1.Top + 8;
          BtnFermer.Top := Panel2.Height + Panel2.Top + 8;
          panel7.top:= DBGrid1.Top;
     End; // Fin Speed Bouton n'est pas activé
end;
//*******************************************************************
procedure TVisuPieces.SpeedButton5Click(Sender: TObject);
var
   I: Integer;
begin
     If Not(SpeedButton6.Down) Then SpeedButton6.Down := True;
     If SpeedButton5.Down Then
     Begin
          SpeedButton5.Font.Color := clRed;
          SpeedButton6Click(SpeedButton6);
          Panel6.Top := Panel1.Height - 41;
          Panel6.Visible := True;
          edit7.SetFocus;
     End
     Else
     Begin
          SpeedButton5.Font.Color := clWindowText;
          Panel6.Visible := False;
          SpeedButton6Click(SpeedButton6);
          For I := 3 To 6 Do
          Begin
               If (((FindComponent('Panel'+IntToStr(I)) as TPanel).Visible) And ((FindComponent('Panel'+IntToStr(I)) as TPanel).Top > Panel6.Top))  Then
                    (FindComponent('Panel'+IntToStr(I)) as TPanel).Top := (FindComponent('Panel'+IntToStr(I)) as TPanel).Top - 41;
          End;
     end;
end;
//****************************************************************************//
// Gestion de l'entrée dans les TEditDate.                                    //
//****************************************************************************//
procedure TVisuPieces.EditDate1Enter(Sender: TObject);
begin
     With (Sender as TEditDate) Do Color := clAqua;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion de la sortie des TEditDate.                                        //
//****************************************************************************//
procedure TVisuPieces.EditDate1Exit(Sender: TObject);
begin
    With (Sender As TEditDate) Do
     Begin
          Color := clWindow;
          If Text <> '' Then
             Begin
               If((StrToDate(Text) < E.DatExoDebut) Or (StrToDate(Text) > E.DatExoFin)) Then
                 Font.Style := [fsStrikeOut]
               Else
                 Font.Style := [];
             End;
     End;
         If ActiveControl.Name = 'Panel3' Then
            Begin
                 EditDate1.Text := '';
                 EditDate2.Text := '';
            End;
     FiltreTaPiece;
     FiltreQuery1;
 end;
//****************************************************************************//

//****************************************************************************//
// Gestion du Change des EditDate.                                            //
//****************************************************************************//
procedure TVisuPieces.EditDate1Change(Sender: TObject);
begin
     With (Sender As TEditDate) Do
     Begin
          If Text = '' Then Font.Style := [];
     End;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion de l'entrée dans les EditReference.                                //
//****************************************************************************//
procedure TVisuPieces.EditReference1Enter(Sender: TObject);
begin
     With (Sender as TEditReference) Do Color := clAqua;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion de la sortie des EditReference.                                    //
//****************************************************************************//
procedure TVisuPieces.EditReference1Exit(Sender: TObject);
begin
     If EditReference1.Text = EditReference2.Text Then EditReference2.Text := '';
     With (Sender As TEditReference) Do Color := clWindow;
     If ActiveControl.Name = 'Panel4' Then
     Begin
          EditReference1.Text := '';
          EditReference2.Text := '';
     End;
    FiltreTaPiece;
    FiltreQuery1;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion de l'entrée dans les EditComptes.                                  //
//****************************************************************************//
procedure TVisuPieces.EditCompte1Enter(Sender: TObject);
begin
     With (Sender As TEditCompte) Do Color := clAqua;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion de la sortie des EditCompte.                                       //
//****************************************************************************//
procedure TVisuPieces.EditCompte1Exit(Sender: TObject);
var
Texte1:string;
Texte2:string;
begin
     texte1:=EditCompte1.Text;
     texte2:= EditCompte2.Text;
     With (Sender As TEditCompte) Do Color := clWindow;
     If ActiveControl.Name = 'Panel5' Then
        Begin
          EditCompte1.Text := '';
          EditCompte2.Text := '';
        End;
        if  Label10.Caption= 'Tiers' then
            If ((copy(editcompte1.Text,1,1)) <> chr(43)) and not(Empty(copy(editcompte1.Text,1,1))) then      // chr(43)=+
               begin
               insert(chr(43),Texte1,1);
               EditCompte1.Text:=texte1;
               end
            else If ((copy(editcompte2.Text,1,1)) <> chr(43)) and not(Empty(copy(editcompte1.Text,1,1))) then      // chr(43)=+
               begin
               insert(chr(43),Texte2,1);
               EditCompte2.Text:=texte2;
               end;
    FiltreTaPiece;
    FiltreQuery1;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion des touches dans la fenêtre.                                       //
//****************************************************************************//
procedure TVisuPieces.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     If ((Key = 68) And (Shift = [ssAlt])) Then          
        SpeedButton1.Down := Not(SpeedButton1.Down);
     If ((Key = 82) And (Shift = [ssAlt])) Then
        SpeedButton2.Down := Not(SpeedButton2.Down);
     If ((Key = 84) And (Shift = [ssAlt])) Then
        SpeedButton3.Down := Not(SpeedButton3.Down);
     If ((Key = 67) And (Shift = [ssAlt])) Then
        SpeedButton4.Down := Not(SpeedButton4.Down);
     If ((Key = 77) And (Shift = [ssAlt])) Then
        SpeedButton5.Down := Not(SpeedButton5.Down);
     If Key = VK_ESCAPE Then
     Begin
          If Not(TaEcriture.State = dsEdit) Then
             Self.Close                                     
          Else
             TaEcriture.Cancel;
     End;
end;
//****************************************************************************//

//****************************************************************************//
// Gestion de la DBGRID1.                                                     //
//****************************************************************************//
procedure TVisuPieces.DBGrid1Enter(Sender: TObject);
begin

     (Sender as TDBGrid).Color := clAqua;
     If DBGrid2.Focused Then
     Begin
          DBGrid2.SelectedIndex := 1;
          Indice := True;
     End;
 
end;
//****************************************************************************//
procedure TVisuPieces.DBGrid1Exit(Sender: TObject);
begin
     DBGrid1.Color := clWindow;
   dbgrid2.setfocus;  
end;

procedure TVisuPieces.DBGrid1DblClick(Sender: TObject);
begin
     DBGrid2.SelectedIndex := 1;
   // DBGrid2.SetFocus;
end;
//****************************************************************************//

procedure TVisuPieces.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     If ((Key = VK_RETURN) Or (Key = VK_TAB)) Then DBGrid1DblClick(Sender);
end;
//****************************************************************************//

procedure TVisuPieces.DBGrid2ColEnter(Sender: TObject);
begin
     DBGrid2.SelectedIndex := 1;
end;
//*************************************************************************
procedure TVisuPieces.DBGrid2Exit(Sender: TObject);
begin
// if (TAexercice.FindField('Cloture').Value)=false then
     begin
     If ((ActiveControl.Name = 'DBGrid1') Or (ActiveControl.Name = 'BtnFermer')) Then
     Begin
          Indice := False;
          If TaEcritureLibelle.AsString = '' Then
          Begin
               Messagedlg('Le Libelle doit être obligatoirement renseigné !!!',MtWarning,[mbok],0);
               DBGrid2.SetFocus;
               Abort;
          End
          Else
              DBGrid2.Color := clWindow;
     End
     Else
         DBGrid2.Color := clWindow;
 end;
end;
//****************************************************************************//

procedure TVisuPieces.DBGrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
 begin
//  if (TAexercice.FindField('Cloture').AsBoolean)=false then
     begin
     If ((Key = VK_TAB) And (Shift = [ssShift])) Then
     Begin
          TaEcriture.Edit;
          TaEcriture.Post;
          DBGrid1.SetFocus;
     End;
     If ((Key = VK_TAB) Or (Key = VK_RETURN) Or (Key = VK_UP) Or (Key = VK_DOWN)) Then
     Begin
          TaEcriture.Edit;
          TaEcriture.Post;
     End;
     If ((Key = VK_RETURN) And (Shift = [ssShift])) Then
     Begin
          TaEcriture.Edit;
          TaEcritureLibelle.AsString := TaPieceLibelle.AsString;
     End;
  end;
end;

//****************************************************************************//
procedure TVisuPieces.TaEcritureBeforeInsert(DataSet: TDataSet);
begin
     Abort;
end;

//*******************************************************************
procedure TVisuPieces.TaEcritureBeforePost(DataSet: TDataSet);
begin
     If Indice Then
     Begin
          If TaEcritureLibelle.AsString = '' Then
          Begin
               Messagedlg('Le Libellé doit être obligatoirement renseigné !!!',MtWarning,[mbok],0);
               Abort;
          End;
     End;
end;
//****************************************************************************//
procedure TVisuPieces.BtnFermerClick(Sender: TObject);
begin
     Self.Close;
end;

//*******************************************************************
procedure TVisuPieces.TaEcritureBeforeScroll(DataSet: TDataSet);
begin
     Indice := True;
     If DBGrid2.Focused Then
     Begin
          TaEcriture.Edit;
          TaEcriture.Post;
     End;
end;
//************************************************************************
procedure TVisuPieces.DataSource2StateChange(Sender: TObject);
var
i:integer;
begin
     Case TaEcriture.State Of
          dsBrowse: Begin
                     for i:=1 to 6 do
                         begin
                         (FindComponent('speedbutton'+inttostr(i)) as TSpeedButton).enabled:=True;
                         end ;
                      for i:=3 to 6 do
                          begin
                         (FindComponent('Panel'+IntToStr(I)) as TPanel).Enabled := True;
                          end;
                    End;
          dsEdit: Begin
                     for i:=1 to 6 do
                         begin
                         (FindComponent('speedbutton'+inttostr(i)) as TSpeedButton).enabled:=false;
                         end ;
                     for i:=3 to 6 do
                         begin
                         (FindComponent('Panel'+IntToStr(I)) as TPanel).Enabled := True;
                         end;
                  End;
     End;
end;
//*********************************************************************
// Filtre la table avec query1 en fonction du montant
//*********************************************************************
procedure TVisuPieces.Edit8Exit(Sender: TObject);
begin
//     With (Sender As TEdit) Do Color := clWindow;
     edit8.text:=QueDesChiffres(edit8.text);
     IF empty(Edit7.text) then Edit7.text:='0' ;
     IF empty(Edit8.text) then Edit8.text:='0' ;
     query1.close;
     query1.ParamByName('Montant1').Value:=strtofloat(edit7.text);
     query1.ParamByName('Montant2').Value:=strtofloat(edit8.text);
     query1.Open;
     DataSource1.DataSet:=Query1;
     FiltreQuery1;
     Label15.Caption := IntToStr(query1.RecordCount);
 end;
 //********************************************************************
procedure TVisuPieces.Button1Click(Sender: TObject);
var
I:integer;
begin
          Panel1.Height := (SpeedButton1.Top + SpeedButton1.Height);
          DBGrid1.Top := Panel1.Height + Panel1.Top + 8;
          Panel2.Top := DBGrid1.Height + DBgrid1.Top + 8;
          BtnFermer.Top := Panel2.Height + Panel2.Top + 8;
          panel7.top:= DBGrid1.Top;
          EditDate1.Text := '';
          EditReference1.Text := '';
          EditReference2.Text := '';
          FiltreTaPiece;
    For I := 1 To 6 Do
     Begin
          (FindComponent('SpeedButton'+IntToStr(I)) as TSpeedButton).Down := False;
          (FindComponent('SpeedButton'+IntToStr(I)) as TSpeedButton).Font.Color := clWindowText;
          (FindComponent('SpeedButton'+IntToStr(I)) as TSpeedButton).Enabled := True;
     End;

     For I := 3 To 6 Do
     Begin
          (FindComponent('Panel'+IntToStr(I)) as TPanel).Enabled := True;
          (FindComponent('Panel'+IntToStr(I)) as TPanel).Visible := False;
     End;
    TaPiece.Filtered := False;
    TaPiece.Filter := '';
    TaPiece.Filtered := False;
    DataSource1.DataSet:=tapiece;
    Label15.Caption :=  IntToStr(TaPiece.RecordCount);
end;
//*******************************************************************
procedure TVisuPieces.Edit7Exit(Sender: TObject);
begin
//  With (Sender As TEdit) Do Color := clwindow;
  edit7.text:=QueDesChiffres(edit7.text);
end;
//*******************************************************************
procedure TVisuPieces.DBComboBox1Click(Sender: TObject);
var
toto:string;
begin
     dbNameExo2.Close;
     //Modify le nom de l'execice dans dbNameExo2.Params ligne 0 ony met la selection du combo
     dbNameExo2.Params[0]:=copy(dbNameExo2.Params[0],1,LastDelimiter('\',dbNameExo2.Params[0]))+ DBComboBox1.Text;
     visupieces.Caption:= 'Visualisation des pièces pour l''exercice '+ dbcombobox1.Text;

     dbNameExo2.Open;
     TaPiece.Open;
     TaEcriture.Open;
     Query1.Open;
     TAexercice.Open;
//   TAexercice.Locate('DIR_EXO',(copy(dbNameExo2.Params[0],6,length(dbNameExo2.Params[0]))),[loCaseInsensitive]);
     toto:=copy(dbNameExo2.Params[0],6,length(dbNameExo2.Params[0]));
    if TAexercice.Locate('DIR_EXO',toto,[loCaseInsensitive]) then
    editdate2.Text:=DateTimeToStr(TAexercice.FindField('DATE_FIN_EXO').AsDateTime) ;
    EditDate1.Text := '';
    EditReference1.Text := '';
    EditReference2.Text := '';
    editdate2.Font.Style := [];
   if (TAexercice.FindField('Cloture').AsBoolean)=True then
      begin
      //TaEcriture.Close;
     //TaEcriture.ReadOnly:=true;
      //DBGrid2.Columns[0].ReadOnly:=true;
      // DBGrid2.Columns[1].ReadOnly:=true;
      //DBGrid2.Columns[2].ReadOnly:=true;
     //DBGrid2.Columns[3].ReadOnly:=true;
      DBGrid2.Options := [dgtitles,dgindicator,dgcollines,dgrowlines];
     //  TaEcriture.open;
     end
   else
     begin
     //  TaEcriture.Close;
     // TaEcriture.ReadOnly:=false;
     DBGrid2.Options := [dgediting,dgalwaysshowEditor,dgtitles,dgindicator,dgcollines,dgrowlines,dgtabs];
     //DBGrid2.Columns[2].ReadOnly:=false;
     //TaEcriture.open;
     end;
end;

procedure TVisuPieces.Edit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=VK_return then edit8.SetFocus;
end;

procedure TVisuPieces.Edit7Enter(Sender: TObject);
begin
    With (Sender As TEdit) Do Color := claqua;
end;

procedure TVisuPieces.Edit8Enter(Sender: TObject);
begin
  With (Sender As TEdit) Do Color := claqua;
end;

procedure TVisuPieces.DBComboBox1Enter(Sender: TObject);
begin
   With (Sender as TComboBox) Do Color := clAqua;
end;

procedure TVisuPieces.DBComboBox1Exit(Sender: TObject);
begin
 With (Sender as TComboBox) Do Color := clwindow;
end;


end.
