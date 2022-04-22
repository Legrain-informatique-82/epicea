unit E2_MenuBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus;

type
  TMenuBar = class(TForm)
    MenuMain: TMainMenu;
    mnDossiers: TMenuItem;
    mnOuvrir: TMenuItem;
    mnDemo: TMenuItem;
    mnFermer: TMenuItem;
    N1: TMenuItem;
    mnQuitter: TMenuItem;
    mnMethodes: TMenuItem;
    mnEntreprise: TMenuItem;
    PlanComptable1: TMenuItem;
    PlanAuxiliaire1: TMenuItem;
    CodeTVA1: TMenuItem;
    TramesdeSaisie1: TMenuItem;
    PlanComptabledebase1: TMenuItem;
    mnOuverture: TMenuItem;
    Emprunts1: TMenuItem;
    Stoks1: TMenuItem;
    DettetCreances: TMenuItem;
    SaisieAnneeAnterieur: TMenuItem;
    BalancedesTiers1: TMenuItem;
    Autressituationdedbut1: TMenuItem;
    Chargesrpartir1: TMenuItem;
    Chargesetproduitsconstatsdavance1: TMenuItem;
    Chargespayeretproduitsrecevoir1: TMenuItem;
    Provisions1: TMenuItem;
    Bilandouverture1: TMenuItem;
    ChargesetProduitsAnneAntrieure1: TMenuItem;
    ValidationBalancedouverture1: TMenuItem;
    mnEcritures: TMenuItem;
    mnSaisiePiece: TMenuItem;
    mnReglementSurListe: TMenuItem;
    Transfertdefond1: TMenuItem;
    RepriseStoks1: TMenuItem;
    Stocks1: TMenuItem;
    Chargesetproduitsconstatsdavances1: TMenuItem;
    Chargespayeretproduitsrecevoir2: TMenuItem;
    Visualisation1: TMenuItem;
    Pices1: TMenuItem;
    mnGestion: TMenuItem;
    Balance2: TMenuItem;
    mnCloture: TMenuItem;
    StoksdeFin1: TMenuItem;
    Autrescrituresdinventaire1: TMenuItem;
    Chargesetproduitsconstatsdavance2: TMenuItem;
    Chargespayeretproduitsrecevoir3: TMenuItem;
    Chargesrpartir2: TMenuItem;
    Dpensedelentreprise1: TMenuItem;
    Provisions2: TMenuItem;
    mnImmobilisations: TMenuItem;
    mnVoirLesImmos: TMenuItem;
    mnImmoToutes: TMenuItem;
    mnImmoParCompte: TMenuItem;
    mnSyntheseParCompte: TMenuItem;
    mnSyntheseImmo: TMenuItem;
    mnSyntheseSubv: TMenuItem;
    mnPlusMoinsValues: TMenuItem;
    mnAmortisSur5Ans: TMenuItem;
    mnAmortisImmo5ans: TMenuItem;
    mnAmortisSubv3ans: TMenuItem;
    N2: TMenuItem;
    mnMouvements: TMenuItem;
    mnCrationFichesAcquis: TMenuItem;
    mnAcquisExercice: TMenuItem;
    mnCessionsSimples: TMenuItem;
    mnCessionsGroupees: TMenuItem;
    mnCessionsExercice: TMenuItem;
    mnMiseAuRebut: TMenuItem;
    mnDivisionImmo: TMenuItem;
    N3: TMenuItem;
    mnOuvertureImmo: TMenuItem;
    mnPriodeAmortissement: TMenuItem;
    mnPlanComptes: TMenuItem;
    mnDescriptionOuverture: TMenuItem;
    mnDescriptionPassageReel: TMenuItem;
    N4: TMenuItem;
    mnFinExerciceImmo: TMenuItem;
    mnChoixAmortis: TMenuItem;
    mnEditionsImmos: TMenuItem;
    mnChangeExercice: TMenuItem;
    mnOutils: TMenuItem;
    mnMessage: TMenuItem;
    mnAfficheEspion: TMenuItem;
    mnLectureTable: TMenuItem;
    mnRequeteSql: TMenuItem;
    mnOptionsMenu: TMenuItem;
    OptionsLicence1: TMenuItem;
    Proprits1: TMenuItem;
    mnAffichage: TMenuItem;
    mnFenetre: TMenuItem;
    mnAide: TMenuItem;
    mnApropos: TMenuItem;
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  MenuBar: TMenuBar;

implementation

uses E2_Main;

{$R *.DFM}

procedure TMenuBar.FormActivate(Sender: TObject);
begin
self.top:=main.top;
end;

end.
