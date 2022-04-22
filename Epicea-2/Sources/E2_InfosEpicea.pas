unit E2_InfosEpicea;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  CommCtrl,
  DMInfosEpicea2,
  Lib_Chaine,
  LibDates,
  E2_Decl_Records,
  E2_Librairie_Obj,
  Dialogs, ComCtrls, RXCtrls, jpeg, ExtCtrls;

type
  TParamInfosEpicea = record
   ListeModule:TStringList;
  end;
  TInfosEpicea = class(TForm)
    Patitre: TPanel;
    ImEnTete: TImage;
    RxLabTitre: TRxLabel;
    TVModule: TTreeView;
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  InfosEpicea: TInfosEpicea;
  Function AfficheInfosEpicea(ParamInfosEpicea:TParamInfosEpicea):Boolean;


implementation

{$R *.dfm}

Function AfficheInfosEpicea(ParamInfosEpicea:TParamInfosEpicea):Boolean;
var
i:integer;
TreeNode:TTreeNode;
ParamDMInfosEpicea:TParamDMInfosEpicea;
InfosDMInfosEpicea:TInfosDMInfosEpicea;
Index:HTREEITEM;
IDossier,IMethode,IOuverture,IEcriture,IImmos,ICloture:HTREEITEM;
Begin
if InfosEpicea = nil then InfosEpicea:=TInfosEpicea.Create(Application.MainForm);
if ParamInfosEpicea.ListeModule = nil then abort;

ParamDMInfosEpicea.Stocks := False;
InfosEpicea.TVModule.Items.Clear;
for i:=0 to ParamInfosEpicea.ListeModule.Count-1 do
 begin
  if ParamInfosEpicea.ListeModule.Strings[i] = C_InfosStocks then
   begin
    ParamDMInfosEpicea.Stocks := true;
   end;
 end;

InfosDMInfosEpicea:=InitialiseDMInfosEpicea(ParamDMInfosEpicea);

IDossier:=InfosEpicea.TVModule.Items.Add(nil,'Dossier : '+ E.NomDossier).ItemId;
IMethode:=InfosEpicea.TVModule.Items.Add(nil,'Méthode').ItemId;
IOuverture:=InfosEpicea.TVModule.Items.Add(nil,'Ouverture').ItemId;
IEcriture:=InfosEpicea.TVModule.Items.Add(nil,'Ecriture').ItemId;
IImmos:=InfosEpicea.TVModule.Items.Add(nil,'Immobilisations').ItemId;
ICloture:=InfosEpicea.TVModule.Items.Add(nil,'Cloture').ItemId;
for i:=0 to ParamInfosEpicea.ListeModule.Count-1 do
 begin
  if ParamInfosEpicea.ListeModule.Strings[i] = C_InfosDossier then
   begin
    TreeNode:=InfosEpicea.TVModule.Items.GetNode(IDossier);

    TreeNode:=InfosEpicea.TVModule.Items.AddChild(TreeNode,'Exercice courant : '+InfosDMInfosEpicea.InfosEntreprise.NomExo);
    InfosEpicea.TVModule.Items.AddChild(TreeNode, 'Du '+
                                                  DateInfos(InfosDMInfosEpicea.InfosEntreprise.DatExoDebut).DateStrFormat +
                                                  ' au '+
                                                  DateInfos(InfosDMInfosEpicea.InfosEntreprise.DatExoFin).DateStrFormat);
    InfosEpicea.TVModule.Items.AddChild(TreeNode, 'Code : '+InfosDMInfosEpicea.InfosEntreprise.ExerciceSaisie);

    InfosEpicea.TVModule.Items.AddChild(TreeNode, 'Cloturé : '+str_bool2str_LGR(InfosDMInfosEpicea.InfosEntreprise.ExerciceCloture,'Oui','Non'));

    TreeNode:=InfosEpicea.TVModule.Items.GetNode(IDossier);

    TreeNode:=InfosEpicea.TVModule.Items.AddChild(TreeNode,'Répertoires utilisés');
    InfosEpicea.TVModule.Items.AddChild(TreeNode,'Répertoire exercice courant : '+InfosDMInfosEpicea.InfosEntreprise.RepertoireExercice);
    InfosEpicea.TVModule.Items.AddChild(TreeNode,'Répertoire du Dossier : '+InfosDMInfosEpicea.InfosEntreprise.RepertoireDossier);
    InfosEpicea.TVModule.Items.AddChild(TreeNode,'Répertoire du Programme : '+InfosDMInfosEpicea.InfosEntreprise.RepertoireProgram);
    InfosEpicea.TVModule.Items.AddChild(TreeNode,'Répertoire d''exportation de la balance : '+InfosDMInfosEpicea.InfosEntreprise.RepertoireExportBalance);
   end;

  if ParamInfosEpicea.ListeModule.Strings[i] = C_InfosStocks then
   begin
    TreeNode:=InfosEpicea.TVModule.Items.GetNode(IOuverture);

    TreeNode:=InfosEpicea.TVModule.Items.AddChild(TreeNode,'Stocks');
    InfosEpicea.TVModule.Items.AddChild(TreeNode,'Vous avez saisie' +
                                                  Str_SingulierToPluriel(InfosDMInfosEpicea.InfosDMStocks.NbStocksOuverture,'stock')+
                                                 'à l''ouverture.');
    if InfosDMInfosEpicea.InfosDMStocks.ResteStocksOuvertureAReprendre then
    InfosEpicea.TVModule.Items.AddChild(TreeNode,'Il reste' +
                                                 Str_SingulierToPluriel(InfosDMInfosEpicea.InfosDMStocks.NbStocksOuvertureAReprendre,'stock')+
                                                 'd''ouverture à reprendre.')


    else
    InfosEpicea.TVModule.Items.AddChild(TreeNode,'Aucun stock d''ouverture à reprendre.');

    TreeNode:=InfosEpicea.TVModule.Items.GetNode(ICloture);
    TreeNode:=InfosEpicea.TVModule.Items.AddChild(TreeNode,'Stocks');
    InfosEpicea.TVModule.Items.AddChild(TreeNode,'Vous avez saisie' +
                                                  Str_SingulierToPluriel(InfosDMInfosEpicea.InfosDMStocks.NbStocksCloture,'stock')+
                                                 'à la clôture.');
//    TreeNode:=InfosEpicea.TVModule.Items.AddChild(TreeNode,'Stocks de Cloture');
   end;

  if ParamInfosEpicea.ListeModule.Strings[i] = C_InfosEmprunts then
   begin
    TreeNode:=InfosEpicea.TVModule.Items.GetNode(IOuverture);
    TreeNode:=InfosEpicea.TVModule.Items.AddChild(TreeNode,'Emprunts');

    InfosEpicea.TVModule.Items.AddChild(TreeNode,'Vous avez saisie' +
                                                  Str_SingulierToPluriel(InfosDMInfosEpicea.InfosDMEmprunts.NbEmpruntsOuverture,'emprunt')+
                                                 'à l''ouverture.');
   end;

 end;

InfosEpicea.ShowModal;
InfosEpicea.TVModule.SaveToFile(E.RepertoireDossier+'InfosEpicea.txt');
End;


procedure TInfosEpicea.FormDestroy(Sender: TObject);
begin
InfosEpicea := nil;
end;

end.
