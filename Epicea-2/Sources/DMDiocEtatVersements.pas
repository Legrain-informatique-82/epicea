unit DMDiocEtatVersements;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,E2_Librairie_Obj,LibZoneSaisie,E2_Decl_Records,Gr_Librairie_Obj,LibSQL;

type
  TDMDiocEtatVersement = class(TDataModule)
    TaEcriture: TTable;
    DaEcriture: TDataSource;
    QuEcriture: TQuery;
    TaPlan: TTable;
    QuEcritureCompte: TStringField;
    QuEcritureDebit: TCurrencyField;
    QuEcritureCredit: TCurrencyField;
    QuEcritureSolde: TCurrencyField;
    QuEcritureLibelle: TStringField;
    QuEcritureSoldeCalc: TCurrencyField;
    QuEcritureTrimPrec: TQuery;
    DaEcritureTrimPrec: TDataSource;
    QuEtatDeVersement: TQuery;
    TaPiecesInfo: TTable;
    QuEcritureTrimPrecDebit: TCurrencyField;
    QuEcritureTrimPrecCredit: TCurrencyField;
    QuEcritureTrimPrecSolde: TCurrencyField;
    QuEcritureTrimPrecCompte: TStringField;
    procedure QuEcritureCalcFields(DataSet: TDataSet);
    procedure QuEcritureBeforeOpen(DataSet: TDataSet);
    procedure QuEcritureFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuEcritureTrimPrecFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure DMDiocEtatVersementCreate(Sender: TObject);
    procedure DMDiocEtatVersementDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DMDiocEtatVersement: TDMDiocEtatVersement;

Function EtatDeVersementExiste(CodeExo:string):TDernierEtatValide;
Function EtatDeVersementGenere_Num(RandEtat:integer):TInfosEtatVersement;

implementation

uses DMPlanCpt;

{$R *.DFM}

procedure TDMDiocEtatVersement.QuEcritureCalcFields(DataSet: TDataSet);
begin
QuEcritureSoldeCalc.AsCurrency:=Abs(QuEcritureSolde.AsCurrency);
end;

procedure TDMDiocEtatVersement.QuEcritureBeforeOpen(DataSet: TDataSet);
begin
QuEcritureCredit.DisplayFormat:=E.FormatMonnaie;
QuEcritureDebit.DisplayFormat:=E.FormatMonnaie;
//QuEcriture.FindField('Debit').DisplayFormat:=E.FormatMonnaie;
end;

procedure TDMDiocEtatVersement.QuEcritureFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
Begin//si
accept:=DMPlan.PossedeFils(QuEcritureCompte.AsString) = false;
accept:=((VerifFNumeric(QuEcritureCredit).VideOUZero = false) and (VerifFNumeric(QuEcritureDebit).VideOUZero = true)) or
         ((VerifFNumeric(QuEcritureCredit).VideOUZero = true) and (VerifFNumeric(QuEcritureDebit).VideOUZero = false)) ;
accept:=((QuEcritureCompte.AsString <> '7545232') and
        (QuEcritureCompte.AsString <> '65232') and
        (QuEcritureCompte.AsString <> '7545233') and
        (QuEcritureCompte.AsString <> '65233'));
end;
end;

Function EtatDeVersementExiste(CodeExo:string):TDernierEtatValide;
var
i,RangCourant:integer;

Begin
 if DMDiocEtatVersement = nil then DMDiocEtatVersement:=TDMDiocEtatVersement.Create(Application.MainForm);
 DMDiocEtatVersement.QuEtatDeVersement.Close;
 DMDiocEtatVersement.QuEtatDeVersement.ParamByName('CodeExo').AsString:=CodeExo;
 DMDiocEtatVersement.QuEtatDeVersement.ParamByName('Valeur_Champ_Gener').AsString:=E.ExerciceBase+'V';
 DMDiocEtatVersement.QuEtatDeVersement.open;
 result.Valide:=false;
 result.Nombre:=0;
 result.Nombre:=DMDiocEtatVersement.QuEtatDeVersement.RecordCount;
// result.Valide:=DMPieces.QuEtatDeVersement.RecordCount <> 0;  CreationSuivantPossible:
 case result.Nombre of
    0:begin
       result.Valide:=false;
       result.RangSuivantACreer:=result.Nombre+1;
       result.CreationSuivantPossible:=true;
      end;
    1:begin
       result.Valide:=not empty(DMDiocEtatVersement.QuEtatDeVersement.FindField('Val_Champ_Gen').AsString);
       if result.Valide then
          result.RangSuivantACreer:=result.Nombre+1
           // Si l'enregistrment est vide, bug des Query
           else result.RangSuivantACreer:=1;
       result.CreationSuivantPossible:=true;
      end;
    2..4:begin
           result.Valide:=true;
           result.RangSuivantACreer:=result.Nombre+1;
           if result.Nombre = 4 then
                   result.CreationSuivantPossible:=false;
         end;
 end;
// On recupère ici les valeur du dernier état de versement valide
if result.Valide then
 Begin
   i:=1;
   DMDiocEtatVersement.QuEtatDeVersement.First;
   RangCourant:=strtoint(copy(DMDiocEtatVersement.QuEtatDeVersement.FindField('Champ_Gen').AsString,4,1));
   result.RangSuivantACreer:=0;
   result.CreationSuivantPossible:=(RangCourant = i) ;
   while ((result.CreationSuivantPossible=true) and (not DMDiocEtatVersement.QuEtatDeVersement.EOF)) do
    Begin
     result.DatePiece:=DMDiocEtatVersement.QuEtatDeVersement.FindField('Date').AsDateTime;
     result.Rang:=i;
     result.Valeur_Champ_Gener:=DMDiocEtatVersement.QuEtatDeVersement.FindField('Val_Champ_Gen').AsString;
     inc(i);
     result.RangSuivantACreer:=i;
     RangCourant:=strtoint(copy(DMDiocEtatVersement.QuEtatDeVersement.FindField('Champ_Gen').AsString,4,1));
     DMDiocEtatVersement.QuEtatDeVersement.Next;
     if i < 4 then
     result.CreationSuivantPossible:=((RangCourant = (i-1)) and (i<=result.Nombre+1))
     else result.CreationSuivantPossible:=false;
    End;

 End;
if result.CreationSuivantPossible then
 if result.Valide then result.RangSuivantACreer:=i;
DMDiocEtatVersement.QuEtatDeVersement.Close;

End;

Function EtatDeVersementGenere_Num(RandEtat:integer):TInfosEtatVersement;
Begin
 if DMDiocEtatVersement = nil then DMDiocEtatVersement:=TDMDiocEtatVersement.Create(Application.MainForm);
 result.NumOD:='';
 result.Existe:=false;
 DMDiocEtatVersement.TaPiecesInfo.Open;
 result.NumOD:=RechercheInfo(DMDiocEtatVersement.TaPiecesInfo.Database,'Piece.db','Champ_gen',E.ExerciceSaisie+'V'+IntToStr(RandEtat),'Reference');
   result.Existe:=not empty(result.NumOD);
   if result.Existe then
    begin
      result.DatePiece:=StrToDate(RechercheInfo(DMDiocEtatVersement.TaPiecesInfo.Database,'Piece.db','Champ_gen',E.ExerciceSaisie+'V'+IntToStr(RandEtat),'Date'));
      result.LibelleOD:=RechercheInfo(DMDiocEtatVersement.TaPiecesInfo.Database,'Piece.db','Champ_gen',E.ExerciceSaisie+'V'+IntToStr(RandEtat),'Libelle');
      result.Rang:=RandEtat;
    end;
 DMDiocEtatVersement.TaPiecesInfo.Close;
End;


procedure TDMDiocEtatVersement.QuEcritureTrimPrecFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
if not((csDestroying)in dataset.ComponentState) then
Begin//si
accept:=DMPlan.PossedeFils(QuEcritureTrimPrecCompte.AsString) = false;
accept:=((VerifFNumeric(QuEcritureTrimPrecCredit).VideOUZero = false) and (VerifFNumeric(QuEcritureTrimPrecDebit).VideOUZero = true)) or
         ((VerifFNumeric(QuEcritureTrimPrecCredit).VideOUZero = true) and (VerifFNumeric(QuEcritureTrimPrecDebit).VideOUZero = false)) ;
accept:=((QuEcritureTrimPrecCompte.AsString <> '7545232') and
        (QuEcritureTrimPrecCompte.AsString <> '65232') and
        (QuEcritureTrimPrecCompte.AsString <> '7545233') and
        (QuEcritureTrimPrecCompte.AsString <> '65233'));
end;
end;

procedure TDMDiocEtatVersement.DMDiocEtatVersementCreate(Sender: TObject);
begin
OuvrirTouteTable('',TControl(self));
end;

procedure TDMDiocEtatVersement.DMDiocEtatVersementDestroy(Sender: TObject);
begin
FermerTouteTable('',TControl(self));
DMDiocEtatVersement:=nil;
end;

end.
