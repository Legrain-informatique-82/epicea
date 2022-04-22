
{***************************************************************************************************************************}
{                                                                                                                           }
{                                                  Liaison de données XML                                                   }
{                                                                                                                           }
{         Généré le : 23/10/2012 11:07:06                                                                                   }
{       Généré depuis : C:\Users\isabelle\workspace2.0.8\edition_supp_client\TableauDeBord-Epicea\TableauDeBord.xml         }
{   Paramètres stockés dans : C:\Users\isabelle\workspace2.0.8\edition_supp_client\TableauDeBord-Epicea\TableauDeBord.xdb   }
{                                                                                                                           }
{***************************************************************************************************************************}

unit ITableauDeBord;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Décl. Forward }

  IXMLTableauDeBordType = interface;
  IXMLDossierType = interface;
  IXMLPagesType = interface;
  IXMLPageType = interface;
  IXMLTresorerieType = interface;
  IXMLSoldecomptesType = interface;
  IXMLLigneType = interface;
  IXMLCourbesevolutiontresorerieType = interface;
  IXMLDettesetcreancesType = interface;
  IXMLDettesType = interface;
  IXMLCourbesdettesannuelleType = interface;
  IXMLCreancesType = interface;
  IXMLCourbesdettesmensuelleType = interface;
  IXMLChargesproduitsType = interface;
  IXMLCourbeschargesproduitsannuelleType = interface;
  IXMLCourbeschargesproduitsmensuelleType = interface;
  IXMLBilanType = interface;
  IXMLCompteResultatType = interface;
  IXMLRepartitionChargesType = interface;
  IXMLRepartitionProduitsType = interface;
  IXMLRepartitionDettesType = interface;
  IXMLRepartitionCreancesType = interface;

{ IXMLTableauDeBordType }

  IXMLTableauDeBordType = interface(IXMLNode)
    ['{503A9ABE-8B41-4598-A081-2A3F0BD95C04}']
    { Accesseurs de propriétés }
    function Get_Dossier: IXMLDossierType;
    function Get_Pages: IXMLPagesType;
    { Méthodes & propriétés }
    property Dossier: IXMLDossierType read Get_Dossier;
    property Pages: IXMLPagesType read Get_Pages;
  end;

{ IXMLDossierType }

  IXMLDossierType = interface(IXMLNode)
    ['{86F59B33-4104-485F-9E8C-C71638DAB03A}']
    { Accesseurs de propriétés }
    function Get_Codedossier: string;
    function Get_Codeexercice: string;
    function Get_Nom_Exercice: string;
    function Get_Raison_sociale: string;
    function Get_Debutn: tdateTime;
    function Get_Finn: tdateTime;
    function Get_Finn1: tdateTime;
    function Get_Finn2: tdateTime;
    function Get_Adresse1: string;
    function Get_Adresse2: string;
    function Get_Cp: string;
    function Get_Ville: string;
    function Get_Siret: string;
    function Get_Tvaintra: string;
    procedure Set_Codedossier(Value: string);
    procedure Set_Codeexercice(Value: string);
    procedure Set_Nom_Exercice(Value: string);
    procedure Set_Raison_sociale(Value: string);
    procedure Set_Debutn(Value: tdateTime);
    procedure Set_Finn(Value: tdateTime);
    procedure Set_Finn1(Value: tdateTime);
    procedure Set_Finn2(Value: tdateTime);
    procedure Set_Adresse1(Value: string);
    procedure Set_Adresse2(Value: string);
    procedure Set_Cp(Value: string);
    procedure Set_Ville(Value: string);
    procedure Set_Siret(Value: string);
    procedure Set_Tvaintra(Value: string);
    { Méthodes & propriétés }
    property Codedossier: string read Get_Codedossier write Set_Codedossier;
    property Codeexercice: string read Get_Codeexercice write Set_Codeexercice;
    property Nom_Exercice: string read Get_Nom_Exercice write Set_Nom_Exercice;
    property Raison_sociale: string read Get_Raison_sociale write Set_Raison_sociale;
    property Debutn: tdateTime read Get_Debutn write Set_Debutn;
    property Finn: tdateTime read Get_Finn write Set_Finn;
    property Finn1: tdateTime read Get_Finn1 write Set_Finn1;
    property Finn2: tdateTime read Get_Finn2 write Set_Finn2;
    property Adresse1: string read Get_Adresse1 write Set_Adresse1;
    property Adresse2: string read Get_Adresse2 write Set_Adresse2;
    property Cp: string read Get_Cp write Set_Cp;
    property Ville: string read Get_Ville write Set_Ville;
    property Siret: string read Get_Siret write Set_Siret;
    property Tvaintra: string read Get_Tvaintra write Set_Tvaintra;
  end;

{ IXMLPagesType }

  IXMLPagesType = interface(IXMLNodeCollection)
    ['{6C2DEE2B-116D-422F-A940-AA1321708BCC}']
    { Accesseurs de propriétés }
    function Get_Page(Index: Integer): IXMLPageType;
    { Méthodes & propriétés }
    function Add: IXMLPageType;
    function Insert(const Index: Integer): IXMLPageType;
    property Page[Index: Integer]: IXMLPageType read Get_Page; default;
  end;

{ IXMLPageType }

  IXMLPageType = interface(IXMLNode)
    ['{F7554D46-E816-4713-8D9B-06CA79DCB03A}']
    { Accesseurs de propriétés }
    function Get_Tresorerie: IXMLTresorerieType;
    function Get_Dettesetcreances: IXMLDettesetcreancesType;
    function Get_Chargesproduits: IXMLChargesproduitsType;
    function Get_Bilan: IXMLBilanType;
    function Get_CompteResultat: IXMLCompteResultatType;
    function Get_RepartitionCharges: IXMLRepartitionChargesType;
    function Get_RepartitionProduits: IXMLRepartitionProduitsType;
    function Get_RepartitionDettes: IXMLRepartitionDettesType;
    function Get_RepartitionCreances: IXMLRepartitionCreancesType;
    { Méthodes & propriétés }
    property Tresorerie: IXMLTresorerieType read Get_Tresorerie;
    property Dettesetcreances: IXMLDettesetcreancesType read Get_Dettesetcreances;
    property Chargesproduits: IXMLChargesproduitsType read Get_Chargesproduits;
    property Bilan: IXMLBilanType read Get_Bilan;
    property CompteResultat: IXMLCompteResultatType read Get_CompteResultat;
    property RepartitionCharges: IXMLRepartitionChargesType read Get_RepartitionCharges;
    property RepartitionProduits: IXMLRepartitionProduitsType read Get_RepartitionProduits;
    property RepartitionDettes: IXMLRepartitionDettesType read Get_RepartitionDettes;
    property RepartitionCreances: IXMLRepartitionCreancesType read Get_RepartitionCreances;
  end;

{ IXMLTresorerieType }

  IXMLTresorerieType = interface(IXMLNode)
    ['{E8B3F911-5E2B-48AE-A840-0B11FBEBE091}']
    { Accesseurs de propriétés }
    function Get_Soldecomptes: IXMLSoldecomptesType;
    function Get_Courbesevolutiontresorerie: IXMLCourbesevolutiontresorerieType;
    { Méthodes & propriétés }
    property Soldecomptes: IXMLSoldecomptesType read Get_Soldecomptes;
    property Courbesevolutiontresorerie: IXMLCourbesevolutiontresorerieType read Get_Courbesevolutiontresorerie;
  end;

{ IXMLSoldecomptesType }

  IXMLSoldecomptesType = interface(IXMLNodeCollection)
    ['{B208489B-A1A9-4FA7-BCCF-210F4F8A72D9}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLLigneType }

  IXMLLigneType = interface(IXMLNode)
    ['{B1602408-87C5-49AD-8A12-ECDF5E9258DA}']
    { Accesseurs de propriétés }
    function Get_Comptes: string;
    function Get_Libell: string;
    function Get_Rapprochement: currency;
    function Get_Balance: currency;
    function Get_compte: string;
    function Get_ExoN: currency;
    function Get_ExoN1: currency;
    function Get_Total: currency;
    function Get_Echance: currency;
    function Get_Exo: string;
    function Get_Dettes: currency;
    function Get_Crances: currency;
    function Get_Mois: string;
    function Get_Creances: currency;
    function Get_Charges: currency;
    function Get_Produits: currency;
    function Get_Resultat: currency;
    function Get_ExoN2: currency;
    procedure Set_Comptes(Value: string);
    procedure Set_Libell(Value: string);
    procedure Set_Rapprochement(Value: currency);
    procedure Set_Balance(Value: currency);
    procedure Set_compte(Value: string);
    procedure Set_ExoN(Value: currency);
    procedure Set_ExoN1(Value: currency);
    procedure Set_Total(Value: currency);
    procedure Set_Echance(Value: currency);
    procedure Set_Exo(Value: string);
    procedure Set_Dettes(Value: currency);
    procedure Set_Crances(Value: currency);
    procedure Set_Mois(Value: string);
    procedure Set_Creances(Value: currency);
    procedure Set_Charges(Value: currency);
    procedure Set_Produits(Value: currency);
    procedure Set_Resultat(Value: currency);
    procedure Set_ExoN2(Value: currency);
    { Méthodes & propriétés }
    property Comptes: string read Get_Comptes write Set_Comptes;
    property Libell: string read Get_Libell write Set_Libell;
    property Rapprochement: currency read Get_Rapprochement write Set_Rapprochement;
    property Balance: currency read Get_Balance write Set_Balance;
    property compte: string read Get_compte write Set_compte;
    property ExoN: currency read Get_ExoN write Set_ExoN;
    property ExoN1: currency read Get_ExoN1 write Set_ExoN1;
    property Total: currency read Get_Total write Set_Total;
    property Echance: currency read Get_Echance write Set_Echance;
    property Exo: string read Get_Exo write Set_Exo;
    property Dettes: currency read Get_Dettes write Set_Dettes;
    property Crances: currency read Get_Crances write Set_Crances;
    property Mois: string read Get_Mois write Set_Mois;
    property Creances: currency read Get_Creances write Set_Creances;
    property Charges: currency read Get_Charges write Set_Charges;
    property Produits: currency read Get_Produits write Set_Produits;
    property Resultat: currency read Get_Resultat write Set_Resultat;
    property ExoN2: currency read Get_ExoN2 write Set_ExoN2;
  end;

{ IXMLCourbesevolutiontresorerieType }

  IXMLCourbesevolutiontresorerieType = interface(IXMLNodeCollection)
    ['{432F4E1E-BA9E-477C-AF9F-F7BB6BE4771D}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLDettesetcreancesType }

  IXMLDettesetcreancesType = interface(IXMLNode)
    ['{26972DB8-F548-4AF4-9F57-8F636D509D87}']
    { Accesseurs de propriétés }
    function Get_Dettes: IXMLDettesType;
    function Get_Courbesdettesannuelle: IXMLCourbesdettesannuelleType;
    function Get_Creances: IXMLCreancesType;
    function Get_Courbesdettesmensuelle: IXMLCourbesdettesmensuelleType;
    { Méthodes & propriétés }
    property Dettes: IXMLDettesType read Get_Dettes;
    property Courbesdettesannuelle: IXMLCourbesdettesannuelleType read Get_Courbesdettesannuelle;
    property Creances: IXMLCreancesType read Get_Creances;
    property Courbesdettesmensuelle: IXMLCourbesdettesmensuelleType read Get_Courbesdettesmensuelle;
  end;

{ IXMLDettesType }

  IXMLDettesType = interface(IXMLNodeCollection)
    ['{56176F36-2D18-4FEE-838A-4620CBE23626}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLCourbesdettesannuelleType }

  IXMLCourbesdettesannuelleType = interface(IXMLNodeCollection)
    ['{A440C41F-C682-4B6F-A3B2-C87EA607DAE6}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLCreancesType }

  IXMLCreancesType = interface(IXMLNodeCollection)
    ['{A85159CA-F6A8-4ECB-8E59-2FDCF65CBC3D}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLCourbesdettesmensuelleType }

  IXMLCourbesdettesmensuelleType = interface(IXMLNodeCollection)
    ['{799EE31B-2A66-442C-BCCD-D70DAEC23121}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLChargesproduitsType }

  IXMLChargesproduitsType = interface(IXMLNode)
    ['{15FB8D54-2B7C-4D3A-A8BE-D9F0FAD1A4FF}']
    { Accesseurs de propriétés }
    function Get_Courbeschargesproduitsannuelle: IXMLCourbeschargesproduitsannuelleType;
    function Get_Courbeschargesproduitsmensuelle: IXMLCourbeschargesproduitsmensuelleType;
    { Méthodes & propriétés }
    property Courbeschargesproduitsannuelle: IXMLCourbeschargesproduitsannuelleType read Get_Courbeschargesproduitsannuelle;
    property Courbeschargesproduitsmensuelle: IXMLCourbeschargesproduitsmensuelleType read Get_Courbeschargesproduitsmensuelle;
  end;

{ IXMLCourbeschargesproduitsannuelleType }

  IXMLCourbeschargesproduitsannuelleType = interface(IXMLNodeCollection)
    ['{0C59A366-9435-4B5F-8F13-17B53C9A91E6}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLCourbeschargesproduitsmensuelleType }

  IXMLCourbeschargesproduitsmensuelleType = interface(IXMLNodeCollection)
    ['{A4EC9027-D96B-4F09-BAE8-290C5118D6F0}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLBilanType }

  IXMLBilanType = interface(IXMLNodeCollection)
    ['{3DEA95EE-CC11-4DF4-A3EA-37D0CEFE5131}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLCompteResultatType }

  IXMLCompteResultatType = interface(IXMLNodeCollection)
    ['{3D10DF31-6CF0-4567-A48D-B30D854F663F}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLRepartitionChargesType }

  IXMLRepartitionChargesType = interface(IXMLNodeCollection)
    ['{2174CE25-E0F3-491F-9DF9-5D60B8EBE39F}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLRepartitionProduitsType }

  IXMLRepartitionProduitsType = interface(IXMLNodeCollection)
    ['{8FD45839-D814-4497-83EE-225007E25C21}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLRepartitionDettesType }

  IXMLRepartitionDettesType = interface(IXMLNodeCollection)
    ['{192659A8-7DF0-4079-9705-0146ECAAAD43}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLRepartitionCreancesType }

  IXMLRepartitionCreancesType = interface(IXMLNodeCollection)
    ['{309C7B91-388E-4D58-A8A5-9D5640ED468E}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ Décl. Forward }

  TXMLTableauDeBordType = class;
  TXMLDossierType = class;
  TXMLPagesType = class;
  TXMLPageType = class;
  TXMLTresorerieType = class;
  TXMLSoldecomptesType = class;
  TXMLLigneType = class;
  TXMLCourbesevolutiontresorerieType = class;
  TXMLDettesetcreancesType = class;
  TXMLDettesType = class;
  TXMLCourbesdettesannuelleType = class;
  TXMLCreancesType = class;
  TXMLCourbesdettesmensuelleType = class;
  TXMLChargesproduitsType = class;
  TXMLCourbeschargesproduitsannuelleType = class;
  TXMLCourbeschargesproduitsmensuelleType = class;
  TXMLBilanType = class;
  TXMLCompteResultatType = class;
  TXMLRepartitionChargesType = class;
  TXMLRepartitionProduitsType = class;
  TXMLRepartitionDettesType = class;
  TXMLRepartitionCreancesType = class;

{ TXMLTableauDeBordType }

  TXMLTableauDeBordType = class(TXMLNode, IXMLTableauDeBordType)
  protected
    { IXMLTableauDeBordType }
    function Get_Dossier: IXMLDossierType;
    function Get_Pages: IXMLPagesType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDossierType }

  TXMLDossierType = class(TXMLNode, IXMLDossierType)
  protected
    { IXMLDossierType }
    function Get_Codedossier: string;
    function Get_Codeexercice: string;
    function Get_Nom_Exercice: string;
    function Get_Raison_sociale: string;
    function Get_Debutn: tdateTime;
    function Get_Finn: tdateTime;
    function Get_Finn1: tdateTime;
    function Get_Finn2: tdateTime;
    function Get_Adresse1: string;
    function Get_Adresse2: string;
    function Get_Cp: string;
    function Get_Ville: string;
    function Get_Siret: string;
    function Get_Tvaintra: string;
    procedure Set_Codedossier(Value: string);
    procedure Set_Codeexercice(Value: string);
    procedure Set_Nom_Exercice(Value: string);
    procedure Set_Raison_sociale(Value: string);
    procedure Set_Debutn(Value: tdateTime);
    procedure Set_Finn(Value: tdateTime);
    procedure Set_Finn1(Value: tdateTime);
    procedure Set_Finn2(Value: tdateTime);
    procedure Set_Adresse1(Value: string);
    procedure Set_Adresse2(Value: string);
    procedure Set_Cp(Value: string);
    procedure Set_Ville(Value: string);
    procedure Set_Siret(Value: string);
    procedure Set_Tvaintra(Value: string);
  end;

{ TXMLPagesType }

  TXMLPagesType = class(TXMLNodeCollection, IXMLPagesType)
  protected
    { IXMLPagesType }
    function Get_Page(Index: Integer): IXMLPageType;
    function Add: IXMLPageType;
    function Insert(const Index: Integer): IXMLPageType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPageType }

  TXMLPageType = class(TXMLNode, IXMLPageType)
  protected
    { IXMLPageType }
    function Get_Tresorerie: IXMLTresorerieType;
    function Get_Dettesetcreances: IXMLDettesetcreancesType;
    function Get_Chargesproduits: IXMLChargesproduitsType;
    function Get_Bilan: IXMLBilanType;
    function Get_CompteResultat: IXMLCompteResultatType;
    function Get_RepartitionCharges: IXMLRepartitionChargesType;
    function Get_RepartitionProduits: IXMLRepartitionProduitsType;
    function Get_RepartitionDettes: IXMLRepartitionDettesType;
    function Get_RepartitionCreances: IXMLRepartitionCreancesType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTresorerieType }

  TXMLTresorerieType = class(TXMLNode, IXMLTresorerieType)
  protected
    { IXMLTresorerieType }
    function Get_Soldecomptes: IXMLSoldecomptesType;
    function Get_Courbesevolutiontresorerie: IXMLCourbesevolutiontresorerieType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSoldecomptesType }

  TXMLSoldecomptesType = class(TXMLNodeCollection, IXMLSoldecomptesType)
  protected
    { IXMLSoldecomptesType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLigneType }

  TXMLLigneType = class(TXMLNode, IXMLLigneType)
  protected
    { IXMLLigneType }
    function Get_Comptes: string;
    function Get_Libell: string;
    function Get_Rapprochement: currency;
    function Get_Balance: currency;
    function Get_Compte: string;
    function Get_ExoN: currency;
    function Get_ExoN1: currency;
    function Get_Total: currency;
    function Get_Echance: currency;
    function Get_Exo: string;
    function Get_Dettes: currency;
    function Get_Crances: currency;
    function Get_Mois: string;
    function Get_Creances: currency;
    function Get_Charges: currency;
    function Get_Produits: currency;
    function Get_Resultat: currency;
    function Get_ExoN2: currency;
    procedure Set_Comptes(Value: string);
    procedure Set_Libell(Value: string);
    procedure Set_Rapprochement(Value: currency);
    procedure Set_Balance(Value: currency);
    procedure Set_Compte(Value: string);
    procedure Set_ExoN(Value: currency);
    procedure Set_ExoN1(Value: currency);
    procedure Set_Total(Value: currency);
    procedure Set_Echance(Value: currency);
    procedure Set_Exo(Value: string);
    procedure Set_Dettes(Value: currency);
    procedure Set_Crances(Value: currency);
    procedure Set_Mois(Value: string);
    procedure Set_Creances(Value: currency);
    procedure Set_Charges(Value: currency);
    procedure Set_Produits(Value: currency);
    procedure Set_Resultat(Value: currency);
    procedure Set_ExoN2(Value: currency);
  end;

{ TXMLCourbesevolutiontresorerieType }

  TXMLCourbesevolutiontresorerieType = class(TXMLNodeCollection, IXMLCourbesevolutiontresorerieType)
  protected
    { IXMLCourbesevolutiontresorerieType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDettesetcreancesType }

  TXMLDettesetcreancesType = class(TXMLNode, IXMLDettesetcreancesType)
  protected
    { IXMLDettesetcreancesType }
    function Get_Dettes: IXMLDettesType;
    function Get_Courbesdettesannuelle: IXMLCourbesdettesannuelleType;
    function Get_Creances: IXMLCreancesType;
    function Get_Courbesdettesmensuelle: IXMLCourbesdettesmensuelleType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDettesType }

  TXMLDettesType = class(TXMLNodeCollection, IXMLDettesType)
  protected
    { IXMLDettesType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCourbesdettesannuelleType }

  TXMLCourbesdettesannuelleType = class(TXMLNodeCollection, IXMLCourbesdettesannuelleType)
  protected
    { IXMLCourbesdettesannuelleType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCreancesType }

  TXMLCreancesType = class(TXMLNodeCollection, IXMLCreancesType)
  protected
    { IXMLCreancesType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCourbesdettesmensuelleType }

  TXMLCourbesdettesmensuelleType = class(TXMLNodeCollection, IXMLCourbesdettesmensuelleType)
  protected
    { IXMLCourbesdettesmensuelleType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLChargesproduitsType }

  TXMLChargesproduitsType = class(TXMLNode, IXMLChargesproduitsType)
  protected
    { IXMLChargesproduitsType }
    function Get_Courbeschargesproduitsannuelle: IXMLCourbeschargesproduitsannuelleType;
    function Get_Courbeschargesproduitsmensuelle: IXMLCourbeschargesproduitsmensuelleType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCourbeschargesproduitsannuelleType }

  TXMLCourbeschargesproduitsannuelleType = class(TXMLNodeCollection, IXMLCourbeschargesproduitsannuelleType)
  protected
    { IXMLCourbeschargesproduitsannuelleType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCourbeschargesproduitsmensuelleType }

  TXMLCourbeschargesproduitsmensuelleType = class(TXMLNodeCollection, IXMLCourbeschargesproduitsmensuelleType)
  protected
    { IXMLCourbeschargesproduitsmensuelleType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBilanType }

  TXMLBilanType = class(TXMLNodeCollection, IXMLBilanType)
  protected
    { IXMLBilanType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCompteResultatType }

  TXMLCompteResultatType = class(TXMLNodeCollection, IXMLCompteResultatType)
  protected
    { IXMLCompteResultatType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRepartitionChargesType }

  TXMLRepartitionChargesType = class(TXMLNodeCollection, IXMLRepartitionChargesType)
  protected
    { IXMLRepartitionChargesType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRepartitionProduitsType }

  TXMLRepartitionProduitsType = class(TXMLNodeCollection, IXMLRepartitionProduitsType)
  protected
    { IXMLRepartitionProduitsType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRepartitionDettesType }

  TXMLRepartitionDettesType = class(TXMLNodeCollection, IXMLRepartitionDettesType)
  protected
    { IXMLRepartitionDettesType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRepartitionCreancesType }

  TXMLRepartitionCreancesType = class(TXMLNodeCollection, IXMLRepartitionCreancesType)
  protected
    { IXMLRepartitionCreancesType }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
  public
    procedure AfterConstruction; override;
  end;

{ Fonctions globales }

function GettableauDeBord(Doc: IXMLDocument): IXMLTableauDeBordType;
function LoadtableauDeBord(const FileName: WideString): IXMLTableauDeBordType;
function NewtableauDeBord: IXMLTableauDeBordType;

const
  TargetNamespace = '';

implementation

{ Fonctions globales }

function GettableauDeBord(Doc: IXMLDocument): IXMLTableauDeBordType;
begin
  Result := Doc.GetDocBinding('tableauDeBord', TXMLTableauDeBordType, TargetNamespace) as IXMLTableauDeBordType;
end;

function LoadtableauDeBord(const FileName: WideString): IXMLTableauDeBordType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('tableauDeBord', TXMLTableauDeBordType, TargetNamespace) as IXMLTableauDeBordType;
end;

function NewtableauDeBord: IXMLTableauDeBordType;
begin
  Result := NewXMLDocument.GetDocBinding('tableauDeBord', TXMLTableauDeBordType, TargetNamespace) as IXMLTableauDeBordType;
end;

{ TXMLTableauDeBordType }

procedure TXMLTableauDeBordType.AfterConstruction;
begin
  RegisterChildNode('dossier', TXMLDossierType);
  RegisterChildNode('pages', TXMLPagesType);
  inherited;
end;

function TXMLTableauDeBordType.Get_Dossier: IXMLDossierType;
begin
  Result := ChildNodes['dossier'] as IXMLDossierType;
end;

function TXMLTableauDeBordType.Get_Pages: IXMLPagesType;
begin
  Result := ChildNodes['pages'] as IXMLPagesType;
end;

{ TXMLDossierType }

function TXMLDossierType.Get_Codedossier: string;
begin
  Result := ChildNodes['code-dossier'].Text;
end;

procedure TXMLDossierType.Set_Codedossier(Value: string);
begin
  ChildNodes['code-dossier'].NodeValue := Value;
end;

function TXMLDossierType.Get_Codeexercice: string;
begin
  Result := ChildNodes['code-exercice'].Text;
end;

procedure TXMLDossierType.Set_Codeexercice(Value: string);
begin
  ChildNodes['code-exercice'].NodeValue := Value;
end;

function TXMLDossierType.Get_Nom_Exercice: string;
begin
  Result := ChildNodes['Nom_Exercice'].Text;
end;

procedure TXMLDossierType.Set_Nom_Exercice(Value: string);
begin
  ChildNodes['Nom_Exercice'].NodeValue := Value;
end;

function TXMLDossierType.Get_Raison_sociale: string;
begin
  Result := ChildNodes['Raison_sociale'].Text;
end;

procedure TXMLDossierType.Set_Raison_sociale(Value: string);
begin
  ChildNodes['Raison_sociale'].NodeValue := Value;
end;

function TXMLDossierType.Get_Debutn: tdateTime;
begin
  Result := ChildNodes['debut-n'].NodeValue;
end;

procedure TXMLDossierType.Set_Debutn(Value: tdateTime);
begin
  ChildNodes['debut-n'].NodeValue := Value;
end;

function TXMLDossierType.Get_Finn: tdateTime;
begin
  Result := ChildNodes['fin-n'].NodeValue;
end;

procedure TXMLDossierType.Set_Finn(Value: tdateTime);
begin
  ChildNodes['fin-n'].NodeValue := Value;
end;

function TXMLDossierType.Get_Finn1: tdateTime;
begin
  Result := ChildNodes['fin-n1'].NodeValue;
end;

procedure TXMLDossierType.Set_Finn1(Value: tdateTime);
begin
  ChildNodes['fin-n1'].NodeValue := Value;
end;

function TXMLDossierType.Get_Finn2: tdateTime;
begin
  Result := ChildNodes['fin-n2'].NodeValue;
end;

procedure TXMLDossierType.Set_Finn2(Value: tdateTime);
begin
  ChildNodes['fin-n2'].NodeValue := Value;
end;

function TXMLDossierType.Get_Adresse1: string;
begin
  Result := ChildNodes['adresse1'].Text;
end;

procedure TXMLDossierType.Set_Adresse1(Value: string);
begin
  ChildNodes['adresse1'].NodeValue := Value;
end;

function TXMLDossierType.Get_Adresse2: string;
begin
  Result := ChildNodes['adresse2'].Text;
end;

procedure TXMLDossierType.Set_Adresse2(Value: string);
begin
  ChildNodes['adresse2'].NodeValue := Value;
end;

function TXMLDossierType.Get_Cp: string;
begin
  Result := ChildNodes['cp'].Text;
end;

procedure TXMLDossierType.Set_Cp(Value: string);
begin
  ChildNodes['cp'].NodeValue := Value;
end;

function TXMLDossierType.Get_Ville: string;
begin
  Result := ChildNodes['ville'].Text;
end;

procedure TXMLDossierType.Set_Ville(Value: string);
begin
  ChildNodes['ville'].NodeValue := Value;
end;

function TXMLDossierType.Get_Siret: string;
begin
  Result := ChildNodes['siret'].Text;
end;

procedure TXMLDossierType.Set_Siret(Value: string);
begin
  ChildNodes['siret'].NodeValue := Value;
end;

function TXMLDossierType.Get_Tvaintra: string;
begin
  Result := ChildNodes['tva-intra'].Text;
end;

procedure TXMLDossierType.Set_Tvaintra(Value: string);
begin
  ChildNodes['tva-intra'].NodeValue := Value;
end;

{ TXMLPagesType }

procedure TXMLPagesType.AfterConstruction;
begin
  RegisterChildNode('page', TXMLPageType);
  ItemTag := 'page';
  ItemInterface := IXMLPageType;
  inherited;
end;

function TXMLPagesType.Get_Page(Index: Integer): IXMLPageType;
begin
  Result := List[Index] as IXMLPageType;
end;

function TXMLPagesType.Add: IXMLPageType;
begin
  Result := AddItem(-1) as IXMLPageType;
end;

function TXMLPagesType.Insert(const Index: Integer): IXMLPageType;
begin
  Result := AddItem(Index) as IXMLPageType;
end;

{ TXMLPageType }

procedure TXMLPageType.AfterConstruction;
begin
  RegisterChildNode('tresorerie', TXMLTresorerieType);
  RegisterChildNode('Dettes-et-creances', TXMLDettesetcreancesType);
  RegisterChildNode('charges-produits', TXMLChargesproduitsType);
  RegisterChildNode('Bilan', TXMLBilanType);
  RegisterChildNode('CompteResultat', TXMLCompteResultatType);
  RegisterChildNode('RepartitionCharges', TXMLRepartitionChargesType);
  RegisterChildNode('RepartitionProduits', TXMLRepartitionProduitsType);
  RegisterChildNode('RepartitionDettes', TXMLRepartitionDettesType);
  RegisterChildNode('RepartitionCreances', TXMLRepartitionCreancesType);
  inherited;
end;

function TXMLPageType.Get_Tresorerie: IXMLTresorerieType;
begin
  Result := ChildNodes['tresorerie'] as IXMLTresorerieType;
end;

function TXMLPageType.Get_Dettesetcreances: IXMLDettesetcreancesType;
begin
  Result := ChildNodes['Dettes-et-creances'] as IXMLDettesetcreancesType;
end;

function TXMLPageType.Get_Chargesproduits: IXMLChargesproduitsType;
begin
  Result := ChildNodes['charges-produits'] as IXMLChargesproduitsType;
end;

function TXMLPageType.Get_Bilan: IXMLBilanType;
begin
  Result := ChildNodes['Bilan'] as IXMLBilanType;
end;

function TXMLPageType.Get_CompteResultat: IXMLCompteResultatType;
begin
  Result := ChildNodes['CompteResultat'] as IXMLCompteResultatType;
end;

function TXMLPageType.Get_RepartitionCharges: IXMLRepartitionChargesType;
begin
  Result := ChildNodes['RepartitionCharges'] as IXMLRepartitionChargesType;
end;

function TXMLPageType.Get_RepartitionProduits: IXMLRepartitionProduitsType;
begin
  Result := ChildNodes['RepartitionProduits'] as IXMLRepartitionProduitsType;
end;

function TXMLPageType.Get_RepartitionDettes: IXMLRepartitionDettesType;
begin
  Result := ChildNodes['RepartitionDettes'] as IXMLRepartitionDettesType;
end;

function TXMLPageType.Get_RepartitionCreances: IXMLRepartitionCreancesType;
begin
  Result := ChildNodes['RepartitionCreances'] as IXMLRepartitionCreancesType;
end;

{ TXMLTresorerieType }

procedure TXMLTresorerieType.AfterConstruction;
begin
  RegisterChildNode('solde-comptes', TXMLSoldecomptesType);
  RegisterChildNode('courbes-evolution-tresorerie', TXMLCourbesevolutiontresorerieType);
  inherited;
end;

function TXMLTresorerieType.Get_Soldecomptes: IXMLSoldecomptesType;
begin
  Result := ChildNodes['solde-comptes'] as IXMLSoldecomptesType;
end;

function TXMLTresorerieType.Get_Courbesevolutiontresorerie: IXMLCourbesevolutiontresorerieType;
begin
  Result := ChildNodes['courbes-evolution-tresorerie'] as IXMLCourbesevolutiontresorerieType;
end;

{ TXMLSoldecomptesType }

procedure TXMLSoldecomptesType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLSoldecomptesType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLSoldecomptesType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLSoldecomptesType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLLigneType }

function TXMLLigneType.Get_Comptes: string;
begin
  Result := ChildNodes['comptes'].Text;
end;

procedure TXMLLigneType.Set_Comptes(Value: string);
begin
  ChildNodes['comptes'].NodeValue := Value;
end;

function TXMLLigneType.Get_Libell: string;
begin
  Result := ChildNodes['libellé'].Text;
end;

procedure TXMLLigneType.Set_Libell(Value: string);
begin
  ChildNodes['libellé'].NodeValue := Value;
end;

function TXMLLigneType.Get_Rapprochement: currency;
begin
  Result := ChildNodes['Rapprochement'].NodeValue;
end;

procedure TXMLLigneType.Set_Rapprochement(Value: currency);
begin
  ChildNodes['Rapprochement'].NodeValue := Value;
end;

function TXMLLigneType.Get_Balance: currency;
begin
  Result := ChildNodes['balance'].NodeValue;
end;

procedure TXMLLigneType.Set_Balance(Value: currency);
begin
  ChildNodes['balance'].NodeValue := Value;
end;

function TXMLLigneType.Get_compte: string;
begin
  Result := ChildNodes['compte'].Text;
end;

procedure TXMLLigneType.Set_compte(Value: string);
begin
  ChildNodes['compte'].NodeValue := Value;
end;

function TXMLLigneType.Get_ExoN: currency;
begin
  Result := ChildNodes['ExoN'].NodeValue;
end;

procedure TXMLLigneType.Set_ExoN(Value: currency);
begin
  ChildNodes['ExoN'].NodeValue := Value;
end;

function TXMLLigneType.Get_ExoN1: currency;
begin
  Result := ChildNodes['ExoN-1'].NodeValue;
end;

procedure TXMLLigneType.Set_ExoN1(Value: currency);
begin
  ChildNodes['ExoN-1'].NodeValue := Value;
end;


function TXMLLigneType.Get_Total: currency;
begin
  Result := ChildNodes['Total'].NodeValue;
end;

procedure TXMLLigneType.Set_Total(Value: currency);
begin
  ChildNodes['Total'].NodeValue := Value;
end;

function TXMLLigneType.Get_Echance: currency;
begin
  Result := ChildNodes['Echéance'].NodeValue;
end;

procedure TXMLLigneType.Set_Echance(Value: currency);
begin
  ChildNodes['Echéance'].NodeValue := Value;
end;

function TXMLLigneType.Get_Exo: string;
begin
  Result := ChildNodes['Exo'].Text;
end;

procedure TXMLLigneType.Set_Exo(Value: string);
begin
  ChildNodes['Exo'].NodeValue := Value;
end;

function TXMLLigneType.Get_Dettes: currency;
begin
  Result := ChildNodes['Dettes'].NodeValue;
end;

procedure TXMLLigneType.Set_Dettes(Value: currency);
begin
  ChildNodes['Dettes'].NodeValue := Value;
end;

function TXMLLigneType.Get_Crances: currency;
begin
  Result := ChildNodes['Créances'].NodeValue;
end;

procedure TXMLLigneType.Set_Crances(Value: currency);
begin
  ChildNodes['Créances'].NodeValue := Value;
end;

function TXMLLigneType.Get_Mois: string;
begin
  Result := ChildNodes['mois'].Text;
end;

procedure TXMLLigneType.Set_Mois(Value: string);
begin
  ChildNodes['mois'].NodeValue := Value;
end;


function TXMLLigneType.Get_Creances: currency;
begin
  Result := ChildNodes['creances'].NodeValue;
end;

procedure TXMLLigneType.Set_Creances(Value: currency);
begin
  ChildNodes['creances'].NodeValue := Value;
end;

function TXMLLigneType.Get_Charges: currency;
begin
  Result := ChildNodes['Charges'].NodeValue;
end;

procedure TXMLLigneType.Set_Charges(Value: currency);
begin
  ChildNodes['Charges'].NodeValue := Value;
end;

function TXMLLigneType.Get_Produits: currency;
begin
  Result := ChildNodes['Produits'].NodeValue;
end;

procedure TXMLLigneType.Set_Produits(Value: currency);
begin
  ChildNodes['Produits'].NodeValue := Value;
end;

function TXMLLigneType.Get_Resultat: currency;
begin
  Result := ChildNodes['Resultat'].NodeValue;
end;

procedure TXMLLigneType.Set_Resultat(Value: currency);
begin
  ChildNodes['Resultat'].NodeValue := Value;
end;

function TXMLLigneType.Get_ExoN2: currency;
begin
  Result := ChildNodes['ExoN-2'].NodeValue;
end;

procedure TXMLLigneType.Set_ExoN2(Value: currency);
begin
  ChildNodes['ExoN-2'].NodeValue := Value;
end;

{ TXMLCourbesevolutiontresorerieType }

procedure TXMLCourbesevolutiontresorerieType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLCourbesevolutiontresorerieType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLCourbesevolutiontresorerieType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLCourbesevolutiontresorerieType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLDettesetcreancesType }

procedure TXMLDettesetcreancesType.AfterConstruction;
begin
  RegisterChildNode('Dettes', TXMLDettesType);
  RegisterChildNode('courbes-dettes-annuelle', TXMLCourbesdettesannuelleType);
  RegisterChildNode('Creances', TXMLCreancesType);
  RegisterChildNode('courbes-dettes-mensuelle', TXMLCourbesdettesmensuelleType);
  inherited;
end;

function TXMLDettesetcreancesType.Get_Dettes: IXMLDettesType;
begin
  Result := ChildNodes['Dettes'] as IXMLDettesType;
end;

function TXMLDettesetcreancesType.Get_Courbesdettesannuelle: IXMLCourbesdettesannuelleType;
begin
  Result := ChildNodes['courbes-dettes-annuelle'] as IXMLCourbesdettesannuelleType;
end;

function TXMLDettesetcreancesType.Get_Creances: IXMLCreancesType;
begin
  Result := ChildNodes['Creances'] as IXMLCreancesType;
end;

function TXMLDettesetcreancesType.Get_Courbesdettesmensuelle: IXMLCourbesdettesmensuelleType;
begin
  Result := ChildNodes['courbes-dettes-mensuelle'] as IXMLCourbesdettesmensuelleType;
end;

{ TXMLDettesType }

procedure TXMLDettesType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLDettesType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLDettesType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLDettesType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLCourbesdettesannuelleType }

procedure TXMLCourbesdettesannuelleType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLCourbesdettesannuelleType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLCourbesdettesannuelleType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLCourbesdettesannuelleType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLCreancesType }

procedure TXMLCreancesType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLCreancesType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLCreancesType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLCreancesType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLCourbesdettesmensuelleType }

procedure TXMLCourbesdettesmensuelleType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLCourbesdettesmensuelleType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLCourbesdettesmensuelleType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLCourbesdettesmensuelleType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLChargesproduitsType }

procedure TXMLChargesproduitsType.AfterConstruction;
begin
  RegisterChildNode('courbes-charges-produits-annuelle', TXMLCourbeschargesproduitsannuelleType);
  RegisterChildNode('courbes-charges-produits-mensuelle', TXMLCourbeschargesproduitsmensuelleType);
  inherited;
end;

function TXMLChargesproduitsType.Get_Courbeschargesproduitsannuelle: IXMLCourbeschargesproduitsannuelleType;
begin
  Result := ChildNodes['courbes-charges-produits-annuelle'] as IXMLCourbeschargesproduitsannuelleType;
end;

function TXMLChargesproduitsType.Get_Courbeschargesproduitsmensuelle: IXMLCourbeschargesproduitsmensuelleType;
begin
  Result := ChildNodes['courbes-charges-produits-mensuelle'] as IXMLCourbeschargesproduitsmensuelleType;
end;

{ TXMLCourbeschargesproduitsannuelleType }

procedure TXMLCourbeschargesproduitsannuelleType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLCourbeschargesproduitsannuelleType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLCourbeschargesproduitsannuelleType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLCourbeschargesproduitsannuelleType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLCourbeschargesproduitsmensuelleType }

procedure TXMLCourbeschargesproduitsmensuelleType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLCourbeschargesproduitsmensuelleType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLCourbeschargesproduitsmensuelleType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLCourbeschargesproduitsmensuelleType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLBilanType }

procedure TXMLBilanType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLBilanType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLBilanType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLBilanType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLCompteResultatType }

procedure TXMLCompteResultatType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLCompteResultatType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLCompteResultatType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLCompteResultatType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLRepartitionChargesType }

procedure TXMLRepartitionChargesType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLRepartitionChargesType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLRepartitionChargesType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLRepartitionChargesType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLRepartitionProduitsType }

procedure TXMLRepartitionProduitsType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLRepartitionProduitsType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLRepartitionProduitsType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLRepartitionProduitsType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLRepartitionDettesType }

procedure TXMLRepartitionDettesType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLRepartitionDettesType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLRepartitionDettesType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLRepartitionDettesType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLRepartitionCreancesType }

procedure TXMLRepartitionCreancesType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLRepartitionCreancesType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLRepartitionCreancesType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLRepartitionCreancesType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

end.