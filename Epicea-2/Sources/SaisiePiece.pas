unit SaisiePiece;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Grids, Menus, StdCtrls, DBGrids, Mask,
  DB, DBTables, calculatrice, E2_ctrl, ComCtrls, Librairie, ObjetPiece,
  DBCtrls, EpiceaControl, AideCompte, AideDate;

type
  TfrmSaisiePiece = class(TForm)
    PaFond: TPanel;
    paEntete: TPanel;
    PopupMenu1: TPopupMenu;
    pmAideenLigne: TMenuItem;
    pmAideF1: TMenuItem;
    N1: TMenuItem;
    pmEnregistrer: TMenuItem;
    Annulation1: TMenuItem;
    N2: TMenuItem;
    InsertionLigne1: TMenuItem;
    SuppressionLigne1: TMenuItem;
    SuppressionPiece1: TMenuItem;
    N3: TMenuItem;
    Echeancier1: TMenuItem;
    SaisieRglement1: TMenuItem;
    Ventillation1: TMenuItem;
    ComplmentLigne1: TMenuItem;
    TableauTVA1: TMenuItem;
    Fermer1: TMenuItem;
    pmVisu: TMenuItem;
    pmCalculatrice: TMenuItem;
    hcCompte: THeaderControl;
    hcAide: THeaderControl;
    edTrame: TText;
    Label1: TLabel;
    Label2: TLabel;
    edReference: TText;
    laCompte: TLabel;
    edCompte: TText;
    pmDevise: TMenuItem;
    grEcriture: TGrid;
    Label3: TLabel;
    edLibelle: TText;
    Label4: TLabel;
    edDate: TDate;
    laLibCompte: TLabel;
    Table1: TTable;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Fermer1Click(Sender: TObject);
    procedure pmCalculatriceClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmAideF1Click(Sender: TObject);
    procedure edTrameValidation(Sender: TObject; var Valide: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edCompteValidation(Sender: TObject; var Valide: Boolean);
    procedure grEcritureDrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure grEcritureSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure grEcritureValidation(Sender: TObject; var Valide: Boolean);
    procedure InsertionLigne1Click(Sender: TObject);
    procedure SuppressionLigne1Click(Sender: TObject);
    procedure EnterZone(Sender: TObject);
    procedure pmEnregistrerClick(Sender: TObject);
    procedure Annulation1Click(Sender: TObject);
    procedure edReferenceValidation(Sender: TObject; var Valide: Boolean);
    procedure edDateValidation(Sender: TObject; var Valide: Boolean);
    procedure edLibelleValidation(Sender: TObject; var Valide: Boolean);
  private
    { Déclarations private }
    Piece :TSaisiePiece;
    FDernierLigne :LongInt;

    FPos :Integer;
	procedure InsertionLigne(Ajoute :Boolean);
   procedure AfficheLibelleCompte(Row :LongInt);
   procedure ChargePiece(Creation :Boolean);
  public
    { Déclarations public }
  end;

var
  frmSaisiePiece: TfrmSaisiePiece;

implementation

{$R *.DFM}

procedure TfrmSaisiePiece.ChargePiece(Creation :Boolean);
Var
	id :LongInt;
   i :Integer;
Begin
	with Piece do begin
   	ID:= taPiece.FindField('Journal').AsInteger;

      edTrame.Text:= frmAideTrame.GetCode_Journal(Id);
      edReference.Text:= GetDonneePiece('Reference');
      edCompte.Text:= GetDonneePiece('Compte');
   	laLibCompte.Caption:= GetLibelleCompte(ExisteCompte(edCompte.Text, Nil));

      edDate.Text:= GetDonneePiece('Date');
      edLibelle.Text:= GetDonneePiece('Libelle');

      edTrame.Enabled:= (taPiece.State = dsInsert);
      edReference.Enabled:= (taPiece.State = dsInsert);

      grEcriture.RowCount:= 3;
		for i:= 0 to 5 do grEcriture.Cells[i, 2]:= '';
	   FDernierLigne:= 2;

      if Not (Creation) then Begin
	      if Not (taPiece.State = dsInsert) then edCompte.SetFocus
   	   Else edTrame.SetFocus;
      End;
   end;
End;

procedure TfrmSaisiePiece.InsertionLigne(Ajoute :Boolean);
Var
	l, c, Fin :LongInt;
begin
	{Insertion Ligne dans la grille,
   	Ajoute = True ajout sur dernierligne
      			False, insertion }

	with grEcriture do begin
   	RowCount:= RowCount +1;
      FDernierLigne:= FDernierLigne +1;

      if (Ajoute) then Fin:= FDernierLigne
      Else Begin
	   	if (Row >= FDernierLigne) then Row:= FDernierLigne -1;
         Fin:= Row;
      End;

		for l:= RowCount -1 Downto Fin do begin
      	For c:= 0 to 5 do
         if (l = Row) Or (l = FDernierLigne) then
         		Cells[c, l]:= ''
         Else 	Cells[c, l]:= Cells[c, l -1];
      end;

      Piece.InsertLigne(Row);
   end;

end;

procedure TfrmSaisiePiece.AfficheLibelleCompte(Row :LongInt);
Var TypePlan :TTypePlan;
begin
	if (Activecontrol = grEcriture) then
   Begin
   	TypePlan:= ExisteCompte(grEcriture.Cells[0, Row], Nil);
      if (TypePlan = tpComptable) then Begin
	   	grEcriture.Cells[2, 1]:= FrmAideCompte.taCompte.FindField('Un1').AsString;
         grEcriture.Cells[3, 1]:= FrmAideCompte.taCompte.FindField('Un2').AsString;
      End
      Else Begin
         grEcriture.Cells[2, 1]:= ''; grEcriture.Cells[3, 1]:= '';
      End;
   End
   Else TypePlan:= ExisteCompte(edCompte.Text, Nil);

  	hcCompte.Sections[0].Text:= 'Compte : ' + GetLibelleCompte(TypePlan);
end;

procedure TfrmSaisiePiece.FormCreate(Sender: TObject);
begin
	InitialiseForm(Self);

   Piece:= TSaisiePiece.Create(Self);

   if(frmAideCompte = Nil) then
   	frmAideCompte:= TfrmAideCompte.Create(Application.MainForm);

   with grEcriture do begin
      ColWidths[0]:= 61; ColWidths[1]:= 218;
      ColWidths[2]:= 71; ColWidths[3]:= 71;
      ColWidths[4]:= 90; ColWidths[5]:= 90;

	   Cells[0, 0]:= 'Compte'; Cells[1, 0]:= 'Libelle';
   	Cells[2, 0]:= 'Qté 1'; Cells[3, 0]:= 'Qté 2';
	   Cells[4, 0]:= 'Débit'; Cells[5, 0]:= 'Crédit';

   	Cells[2, 1]:= ''; Cells[3, 1]:= '';
	   Cells[4, 1]:= 'Charges'; Cells[5, 1]:= 'Produits';
   end;

   Piece.NouvellePiece;
	ChargePiece(True);
end;

procedure TfrmSaisiePiece.FormDestroy(Sender: TObject);
begin
	Piece.Destroy;

	DestroyForm(Self);
   frmSaisiePiece:= Nil;
end;

procedure TfrmSaisiePiece.FormResize(Sender: TObject);
begin
	if (Height >= 373) then
   Begin
   	if (Width < 636) Then 	paFond.height:= Height - 45
		Else 							paFond.height:= Height - 27;
   End
   Else paFond.height:= 346;

   VertScrollBar.Visible:= (Height < 373);
   HorzScrollBar.Visible:= (Width < 636);
end;

procedure TfrmSaisiePiece.Fermer1Click(Sender: TObject);
begin
   Self.Close;
end;

procedure TfrmSaisiePiece.pmCalculatriceClick(Sender: TObject);
begin
	frmCalculatrice.Affichage(ActiveControl);
end;

procedure TfrmSaisiePiece.pmAideF1Click(Sender: TObject);
begin
	if ActiveControl = edTrame then frmAideTrame.Affiche(edTrame)
   Else if ActiveControl = edCompte then AfficheAideCompte(edCompte)
   Else if ActiveControl = grEcriture then Begin
   	case grEcriture.Col of
        0: AfficheAideCompte(grEcriture);
        2, 3, 4, 5: frmCalculatrice.Affichage(grEcriture);
      end;

   End
end;

procedure TfrmSaisiePiece.edTrameValidation(Sender: TObject;
  var Valide: Boolean);
begin
	Valide:= frmAideTrame.ExisteCode(edTrame, True);

   if Valide then Begin
		Piece.Modif_Piece('Journal', frmAideTrame.GetId_Journal);

   	edReference.Text:= Piece.NouvelleReference(frmAideTrame.CodeJournal);
		Piece.Modif_Piece('Reference', edReference.Text);

      if (frmAideTrame.AchatVente) then Begin
      	laCompte.Caption:= '&Tiers';
		   grEcriture.Cells[4, 1]:= 'Charges'; grEcriture.Cells[5, 1]:= 'Produits';
      End
      Else if (frmAideTrame.OD) then Begin
      	laCompte.Caption:= '&Compte';
		   grEcriture.Cells[4, 1]:= ''; grEcriture.Cells[5, 1]:= '';
      End
      Else Begin
      	laCompte.Caption:= '&Banque';
		   grEcriture.Cells[4, 1]:= 'Décaissement'; grEcriture.Cells[5, 1]:= 'Encaissement';
      End;
   End;
end;

procedure TfrmSaisiePiece.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	Action:= caFree;
end;

procedure TfrmSaisiePiece.edCompteValidation(Sender: TObject;
  var Valide: Boolean);
Var
	TypePlan :TTypePlan;
begin
	TypePlan:= ExisteCompte(edCompte.Text, edCompte);
	Valide:= (TypePlan <> tpNone);

   if (Valide) then Begin
   	laLibCompte.Caption:= GetLibelleCompte(TypePlan);
		Piece.Modif_Piece('Compte', edCompte.Text);
   End;
end;

procedure TfrmSaisiePiece.grEcritureDrawCell(Sender: TObject; Col,
  Row: Integer; Rect: TRect; State: TGridDrawState);
Var
	s :String;
   dLeft :Integer;
   mt :Double;
begin
	{Draw de la grille}
	if Not (grEcriture.Focused) or Not (gdFocused in State) then
   with grEcriture.Canvas do begin
     	s:= grEcriture.Cells[Col, Row];

      if (Col > 1) then Begin
      	if (Row > 1) then Begin
         	{Mise en forme Montant}
   	      Mt:= StrToFloat1(grEcriture.Cells[Col, Row]);

            if (Mt = 0) then s:= ''
            Else s:= FormatFloat('# ##0.00', Mt);
         End;

      	dLeft:= Rect.Right - TextWidth(s) - 2
      End
      Else dLeft:= Rect.Left + 2;

      if (Row > 1) And Not ((Row Div 2) = (Row /2)) then
      	{Couleur des ligne impaire}
      	Brush.Color:= clAqua;

      TextRect(Rect, dLeft, Rect.Top +2, s);
   end;
end;

procedure TfrmSaisiePiece.grEcritureSelectCell(Sender: TObject; Col,
  Row: Integer; var CanSelect: Boolean);
begin
	{Control Validiter donnees}
  	case grEcriture.Col of
	   0: if (grEcriture.Row < FDernierLigne)
      	or Not Empty(grEcriture.Cell) then Begin
      	CanSelect:= (ExisteCompte(grEcriture.Cell, grEcriture) <> tpNone);
         if (grEcriture.Row = FDernierLigne) then InsertionLigne(True);
      End;
   end;

	if (CanSelect) then Begin
   	AfficheLibelleCompte(Row);
      Piece.Modif_Ecriture(grEcriture);

   	if (Row = FDernierLigne) And (Col <> 0) then Begin
      	{Position 1 colonne si dernier Ligne}
      	CanSelect:= False;
        	grEcriture.Col:= 0;
			grEcriture.Row:= FDernierLigne;
      End
     	Else if (Col = 4) And (StrToFloat1(grEcriture.Cells[5, Row]) <> 0) then Begin
      	{Interdire la col Debit si montant dans Col credit}
      	CanSelect:= False;
         if (grEcriture.Col <= Col) then
         		grEcriture.Col:= 5
         Else 	grEcriture.Col:= 3;
      End
      Else if (Col = 5) And (StrToFloat1(grEcriture.Cells[4, Row]) <> 0) then Begin
      	{Interdire la col Credit si montant dans Col Debit}
      	CanSelect:= False;
			if (grEcriture.Col <> 4) then	grEcriture.Col:= 4
         Else Begin
         	grEcriture.Col:= 0;
            if (grEcriture.Row < grEcriture.RowCount -1) then
            	grEcriture.Row:= grEcriture.Row +1;
         End;
      End;
   End;
end;

procedure TfrmSaisiePiece.grEcritureValidation(Sender: TObject;
  var Valide: Boolean);
begin
	grEcritureSelectCell(grEcriture, grEcriture.Col, grEcriture.Row, Valide);
end;

procedure TfrmSaisiePiece.InsertionLigne1Click(Sender: TObject);
Begin
	InsertionLigne(False);
   grEcriture.Col:= 0;
End;

procedure TfrmSaisiePiece.SuppressionLigne1Click(Sender: TObject);
Var
	l, c :LongInt;
begin
	with grEcriture do
   if (Row < FDernierLigne) then begin
   	for l:= Row to (RowCount - 2) do
     	For c:= 0 to 5 do Cells[c, l]:= Cells[c, l +1];

   	RowCount:= RowCount -1;
      FDernierLigne:= FDernierLigne -1;
      if (Row = FDernierLigne) then Col:= 0;
   end;

end;

procedure TfrmSaisiePiece.EnterZone(Sender: TObject);
begin
	hcAide.Sections[0].Text:= TWinControl(Sender).Hint;
end;

procedure TfrmSaisiePiece.pmEnregistrerClick(Sender: TObject);
begin
	Piece.Enregistrer;
   Piece.NouvellePiece;
  	ChargePiece(False);
end;

procedure TfrmSaisiePiece.Annulation1Click(Sender: TObject);
begin
	Piece.Annuler;
   Piece.NouvellePiece;
  	ChargePiece(False);
end;

procedure TfrmSaisiePiece.edReferenceValidation(Sender: TObject;
  var Valide: Boolean);
begin
	Piece.Modif_Piece('Reference', edReference.Text);
end;

procedure TfrmSaisiePiece.edDateValidation(Sender: TObject;
  var Valide: Boolean);
begin
	Valide:= DateValide(edDate.Date, edDate);
	if (Valide) then
   	Piece.Modif_Piece('Date', edDate.Date);
end;

procedure TfrmSaisiePiece.edLibelleValidation(Sender: TObject;
  var Valide: Boolean);
begin
	if (Valide) then Piece.Modif_Piece('Libelle', edLibelle.text);
end;

end.
