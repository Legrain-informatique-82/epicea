
{***********************************************************************************************************************************}
{                                                                                                                                   }
{                                                      Liaison de données XML                                                       }
{                                                                                                                                   }
{         Généré le : 06/12/2016 15:29:33                                                                                           }
{       Généré depuis : C:\Users\isabelle\workspaceBranche2.0.13\edition_supp_client\TableauDeBord-Epicea\TableauDeBord.xml         }
{   Paramètres stockés dans : C:\Users\isabelle\workspaceBranche2.0.13\edition_supp_client\TableauDeBord-Epicea\TableauDeBord.xdb   }
{                                                                                                                                   }
{***********************************************************************************************************************************}

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
  IXMLCourbesevolutiontresoreriemensuelleType = interface;
  IXMLLigneCompteType = interface;
  IXMLDettesetcreancesType = interface;
  IXMLDettesType = interface;
  IXMLCreancesType = interface;
  IXMLCourbesdettesmensuelleType = interface;
  IXMLCourbesdettesannuelleType = interface;
  IXMLRepartitionDettesType = interface;
  IXMLRepartitionCreancesType = interface;
  IXMLChargesproduitsType = interface;
  IXMLCourbeschargesproduitsannuelleType = interface;
  IXMLCourbeschargesproduitsmensuelleType = interface;
  IXMLRepartitionChargesType = interface;

{ IXMLTableauDeBordType }

  IXMLTableauDeBordType = interface(IXMLNode)
    ['{0A449F7C-6693-49A1-9128-FDA65C929258}']
    { Accesseurs de propriétés }
    function Get_Dossier: IXMLDossierType;
    function Get_Pages: IXMLPagesType;
    { Méthodes & propriétés }
    property Dossier: IXMLDossierType read Get_Dossier;
    property Pages: IXMLPagesType read Get_Pages;
  end;

{ IXMLDossierType }

  IXMLDossierType = interface(IXMLNode)
    ['{C3F43591-2CBD-4085-BF3E-0BBCF7CA6741}']
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
    ['{4C5DC309-7D9F-4673-BE9B-AC7E150583C0}']
    { Accesseurs de propriétés }
    function Get_Page(Index: Integer): IXMLPageType;
    { Méthodes & propriétés }
    function Add: IXMLPageType;
    function Insert(const Index: Integer): IXMLPageType;
    property Page[Index: Integer]: IXMLPageType read Get_Page; default;
  end;

{ IXMLPageType }

  IXMLPageType = interface(IXMLNode)
    ['{2E47A031-6B8C-4110-A902-C78E27444378}']
    { Accesseurs de propriétés }
    function Get_Tresorerie: IXMLTresorerieType;
    function Get_Dettesetcreances: IXMLDettesetcreancesType;
    function Get_RepartitionDettes: IXMLRepartitionDettesType;
    function Get_RepartitionCreances: IXMLRepartitionCreancesType;
    function Get_Chargesproduits: IXMLChargesproduitsType;
    function Get_RepartitionCharges: IXMLRepartitionChargesType;
    { Méthodes & propriétés }
    property Tresorerie: IXMLTresorerieType read Get_Tresorerie;
    property Dettesetcreances: IXMLDettesetcreancesType read Get_Dettesetcreances;
    property RepartitionDettes: IXMLRepartitionDettesType read Get_RepartitionDettes;
    property RepartitionCreances: IXMLRepartitionCreancesType read Get_RepartitionCreances;
    property Chargesproduits: IXMLChargesproduitsType read Get_Chargesproduits;
    property RepartitionCharges: IXMLRepartitionChargesType read Get_RepartitionCharges;
  end;

{ IXMLTresorerieType }

  IXMLTresorerieType = interface(IXMLNode)
    ['{53D3E7E1-D796-4A8B-A032-FA82933B547B}']
    { Accesseurs de propriétés }
    function Get_Soldecomptes: IXMLSoldecomptesType;
    function Get_Courbesevolutiontresorerie: IXMLCourbesevolutiontresorerieType;
    function Get_Courbesevolutiontresoreriemensuelle: IXMLCourbesevolutiontresoreriemensuelleType;
    { Méthodes & propriétés }
    property Soldecomptes: IXMLSoldecomptesType read Get_Soldecomptes;
    property Courbesevolutiontresorerie: IXMLCourbesevolutiontresorerieType read Get_Courbesevolutiontresorerie;
    property Courbesevolutiontresoreriemensuelle: IXMLCourbesevolutiontresoreriemensuelleType read Get_Courbesevolutiontresoreriemensuelle;
  end;

{ IXMLSoldecomptesType }

  IXMLSoldecomptesType = interface(IXMLNodeCollection)
    ['{FB7C25F1-7117-4E5B-911C-F23FD7DE2001}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLLigneType }

  IXMLLigneType = interface(IXMLNode)
    ['{D9EB6879-8FB2-41F0-B720-AFC3DBF9E99C}']
    { Accesseurs de propriétés }
    function Get_Comptes: Integer;
    function Get_Libell: WideString;
    function Get_Balance: Integer;
    function Get_Rapprochement: string;
    function Get_Compte: Integer;
    function Get_ExoN: Integer;
    function Get_ExoN1: Integer;
    function Get_ExoN2: Integer;
    function Get_Mois: Integer;
    function Get_Total: Integer;
    function Get_Echance: Integer;
    function Get_Dettes: Integer;
    function Get_Creances: string;
    function Get_Exo: WideString;
    function Get_Crances: string;
    function Get_Charges: string;
    function Get_Produits: Integer;
    function Get_Resultat: WideString;
    procedure Set_Comptes(Value: Integer);
    procedure Set_Libell(Value: WideString);
    procedure Set_Balance(Value: Integer);
    procedure Set_Rapprochement(Value: string);
    procedure Set_Compte(Value: Integer);
    procedure Set_ExoN(Value: Integer);
    procedure Set_ExoN1(Value: Integer);
    procedure Set_ExoN2(Value: Integer);
    procedure Set_Mois(Value: Integer);
    procedure Set_Total(Value: Integer);
    procedure Set_Echance(Value: Integer);
    procedure Set_Dettes(Value: Integer);
    procedure Set_Creances(Value: string);
    procedure Set_Exo(Value: WideString);
    procedure Set_Crances(Value: string);
    procedure Set_Charges(Value: string);
    procedure Set_Produits(Value: Integer);
    procedure Set_Resultat(Value: WideString);
    { Méthodes & propriétés }
    property Comptes: Integer read Get_Comptes write Set_Comptes;
    property Libell: WideString read Get_Libell write Set_Libell;
    property Balance: Integer read Get_Balance write Set_Balance;
    property Rapprochement: string read Get_Rapprochement write Set_Rapprochement;
    property Compte: Integer read Get_Compte write Set_Compte;
    property ExoN: Integer read Get_ExoN write Set_ExoN;
    property ExoN1: Integer read Get_ExoN1 write Set_ExoN1;
    property ExoN2: Integer read Get_ExoN2 write Set_ExoN2;
    property Mois: Integer read Get_Mois write Set_Mois;
    property Total: Integer read Get_Total write Set_Total;
    property Echance: Integer read Get_Echance write Set_Echance;
    property Dettes: Integer read Get_Dettes write Set_Dettes;
    property Creances: string read Get_Creances write Set_Creances;
    property Exo: WideString read Get_Exo write Set_Exo;
    property Crances: string read Get_Crances write Set_Crances;
    property Charges: string read Get_Charges write Set_Charges;
    property Produits: Integer read Get_Produits write Set_Produits;
    property Resultat: WideString read Get_Resultat write Set_Resultat;
  end;

{ IXMLCourbesevolutiontresorerieType }

  IXMLCourbesevolutiontresorerieType = interface(IXMLNodeCollection)
    ['{201675A7-556D-4787-8B5C-812444CD940C}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLCourbesevolutiontresoreriemensuelleType }

  IXMLCourbesevolutiontresoreriemensuelleType = interface(IXMLNodeCollection)
    ['{82096B2F-EE59-43AB-8040-35D07F1A5495}']
    { Accesseurs de propriétés }
    function Get_LigneCompte(Index: Integer): IXMLLigneCompteType;
    { Méthodes & propriétés }
    function Add: IXMLLigneCompteType;
    function Insert(const Index: Integer): IXMLLigneCompteType;
    property LigneCompte[Index: Integer]: IXMLLigneCompteType read Get_LigneCompte; default;
  end;

{ IXMLLigneCompteType }

  IXMLLigneCompteType = interface(IXMLNodeCollection)
    ['{EA897B8B-686E-456D-AEA9-E531F81FEA32}']
    { Accesseurs de propriétés }
    function Get_Compte: Integer;
    function Get_Rang: Integer;
    function Get_Ligne(Index: Integer): IXMLLigneType;
    procedure Set_Compte(Value: Integer);
    procedure Set_Rang(Value: Integer);
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Compte: Integer read Get_Compte write Set_Compte;
    property Rang: Integer read Get_Rang write Set_Rang;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLDettesetcreancesType }

  IXMLDettesetcreancesType = interface(IXMLNode)
    ['{139AFF54-1009-43B7-A662-B9887746A189}']
    { Accesseurs de propriétés }
    function Get_Dettes: IXMLDettesType;
    function Get_Creances: IXMLCreancesType;
    function Get_Courbesdettesmensuelle: IXMLCourbesdettesmensuelleType;
    function Get_Courbesdettesannuelle: IXMLCourbesdettesannuelleType;
    { Méthodes & propriétés }
    property Dettes: IXMLDettesType read Get_Dettes;
    property Creances: IXMLCreancesType read Get_Creances;
    property Courbesdettesmensuelle: IXMLCourbesdettesmensuelleType read Get_Courbesdettesmensuelle;
    property Courbesdettesannuelle: IXMLCourbesdettesannuelleType read Get_Courbesdettesannuelle;
  end;

{ IXMLDettesType }

  IXMLDettesType = interface(IXMLNodeCollection)
    ['{1FD67890-40DF-4C39-A322-088BC0BFA24F}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLCreancesType }

  IXMLCreancesType = interface(IXMLNodeCollection)
    ['{4EF72A25-05C9-4E00-882E-79640B63952E}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLCourbesdettesmensuelleType }

  IXMLCourbesdettesmensuelleType = interface(IXMLNodeCollection)
    ['{24BC26E2-8574-4CC8-A980-04EA9DB8A6DC}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLCourbesdettesannuelleType }

  IXMLCourbesdettesannuelleType = interface(IXMLNodeCollection)
    ['{31AF9E99-E096-4E3E-8CFC-A4BE550E8696}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLRepartitionDettesType }

  IXMLRepartitionDettesType = interface(IXMLNodeCollection)
    ['{EEF36667-0307-4E32-9F55-51977F3EF0F5}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLRepartitionCreancesType }

  IXMLRepartitionCreancesType = interface(IXMLNodeCollection)
    ['{6A5C82AE-AFCA-4450-82EA-329BE07EEEED}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLChargesproduitsType }

  IXMLChargesproduitsType = interface(IXMLNode)
    ['{012698D7-6E2C-4986-8086-A788D22D325E}']
    { Accesseurs de propriétés }
    function Get_Courbeschargesproduitsannuelle: IXMLCourbeschargesproduitsannuelleType;
    function Get_Courbeschargesproduitsmensuelle: IXMLCourbeschargesproduitsmensuelleType;
    { Méthodes & propriétés }
    property Courbeschargesproduitsannuelle: IXMLCourbeschargesproduitsannuelleType read Get_Courbeschargesproduitsannuelle;
    property Courbeschargesproduitsmensuelle: IXMLCourbeschargesproduitsmensuelleType read Get_Courbeschargesproduitsmensuelle;
  end;

{ IXMLCourbeschargesproduitsannuelleType }

  IXMLCourbeschargesproduitsannuelleType = interface(IXMLNodeCollection)
    ['{D6ED0EC3-606F-438E-95D6-B9A124C2BB71}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLCourbeschargesproduitsmensuelleType }

  IXMLCourbeschargesproduitsmensuelleType = interface(IXMLNodeCollection)
    ['{A69172E6-8CE2-4C5A-A23D-6FF68D7DDD9B}']
    { Accesseurs de propriétés }
    function Get_Ligne(Index: Integer): IXMLLigneType;
    { Méthodes & propriétés }
    function Add: IXMLLigneType;
    function Insert(const Index: Integer): IXMLLigneType;
    property Ligne[Index: Integer]: IXMLLigneType read Get_Ligne; default;
  end;

{ IXMLRepartitionChargesType }

  IXMLRepartitionChargesType = interface(IXMLNode)
    ['{66AE24AE-A832-4484-9DE5-757A5907A83A}']
    { Accesseurs de propriétés }
    function Get_Ligne: IXMLLigneType;
    { Méthodes & propriétés }
    property Ligne: IXMLLigneType read Get_Ligne;
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
  TXMLCourbesevolutiontresoreriemensuelleType = class;
  TXMLLigneCompteType = class;
  TXMLDettesetcreancesType = class;
  TXMLDettesType = class;
  TXMLCreancesType = class;
  TXMLCourbesdettesmensuelleType = class;
  TXMLCourbesdettesannuelleType = class;
  TXMLRepartitionDettesType = class;
  TXMLRepartitionCreancesType = class;
  TXMLChargesproduitsType = class;
  TXMLCourbeschargesproduitsannuelleType = class;
  TXMLCourbeschargesproduitsmensuelleType = class;
  TXMLRepartitionChargesType = class;

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
    function Get_RepartitionDettes: IXMLRepartitionDettesType;
    function Get_RepartitionCreances: IXMLRepartitionCreancesType;
    function Get_Chargesproduits: IXMLChargesproduitsType;
    function Get_RepartitionCharges: IXMLRepartitionChargesType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTresorerieType }

  TXMLTresorerieType = class(TXMLNode, IXMLTresorerieType)
  protected
    { IXMLTresorerieType }
    function Get_Soldecomptes: IXMLSoldecomptesType;
    function Get_Courbesevolutiontresorerie: IXMLCourbesevolutiontresorerieType;
    function Get_Courbesevolutiontresoreriemensuelle: IXMLCourbesevolutiontresoreriemensuelleType;
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
    function Get_Comptes: Integer;
    function Get_Libell: WideString;
    function Get_Balance: Integer;
    function Get_Rapprochement: string;
    function Get_Compte: Integer;
    function Get_ExoN: Integer;
    function Get_ExoN1: Integer;
    function Get_ExoN2: Integer;
    function Get_Mois: Integer;
    function Get_Total: Integer;
    function Get_Echance: Integer;
    function Get_Dettes: Integer;
    function Get_Creances: string;
    function Get_Exo: WideString;
    function Get_Crances: string;
    function Get_Charges: string;
    function Get_Produits: Integer;
    function Get_Resultat: WideString;
    procedure Set_Comptes(Value: Integer);
    procedure Set_Libell(Value: WideString);
    procedure Set_Balance(Value: Integer);
    procedure Set_Rapprochement(Value: string);
    procedure Set_Compte(Value: Integer);
    procedure Set_ExoN(Value: Integer);
    procedure Set_ExoN1(Value: Integer);
    procedure Set_ExoN2(Value: Integer);
    procedure Set_Mois(Value: Integer);
    procedure Set_Total(Value: Integer);
    procedure Set_Echance(Value: Integer);
    procedure Set_Dettes(Value: Integer);
    procedure Set_Creances(Value: string);
    procedure Set_Exo(Value: WideString);
    procedure Set_Crances(Value: string);
    procedure Set_Charges(Value: string);
    procedure Set_Produits(Value: Integer);
    procedure Set_Resultat(Value: WideString);
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

{ TXMLCourbesevolutiontresoreriemensuelleType }

  TXMLCourbesevolutiontresoreriemensuelleType = class(TXMLNodeCollection, IXMLCourbesevolutiontresoreriemensuelleType)
  protected
    { IXMLCourbesevolutiontresoreriemensuelleType }
    function Get_LigneCompte(Index: Integer): IXMLLigneCompteType;
    function Add: IXMLLigneCompteType;
    function Insert(const Index: Integer): IXMLLigneCompteType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLigneCompteType }

  TXMLLigneCompteType = class(TXMLNodeCollection, IXMLLigneCompteType)
  protected
    { IXMLLigneCompteType }
    function Get_Compte: Integer;
    function Get_Rang: Integer;
    function Get_Ligne(Index: Integer): IXMLLigneType;
    procedure Set_Compte(Value: Integer);
    procedure Set_Rang(Value: Integer);
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
    function Get_Creances: IXMLCreancesType;
    function Get_Courbesdettesmensuelle: IXMLCourbesdettesmensuelleType;
    function Get_Courbesdettesannuelle: IXMLCourbesdettesannuelleType;
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

{ TXMLRepartitionChargesType }

  TXMLRepartitionChargesType = class(TXMLNode, IXMLRepartitionChargesType)
  protected
    { IXMLRepartitionChargesType }
    function Get_Ligne: IXMLLigneType;
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
  Result := ChildNodes['code-dossier'].NodeValue;
end;

procedure TXMLDossierType.Set_Codedossier(Value: string);
begin
  ChildNodes['code-dossier'].NodeValue := Value;
end;

function TXMLDossierType.Get_Codeexercice: string;
begin
  Result := ChildNodes['code-exercice'].NodeValue;
end;

procedure TXMLDossierType.Set_Codeexercice(Value: string);
begin
  ChildNodes['code-exercice'].NodeValue := Value;
end;

function TXMLDossierType.Get_Nom_Exercice: string;
begin
  Result := ChildNodes['Nom_Exercice'].NodeValue;
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
  Result := ChildNodes['cp'].NodeValue;
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
  Result := ChildNodes['siret'].NodeValue;
end;

procedure TXMLDossierType.Set_Siret(Value: string);
begin
  ChildNodes['siret'].NodeValue := Value;
end;

function TXMLDossierType.Get_Tvaintra: string;
begin
  Result := ChildNodes['tva-intra'].NodeValue;
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
  RegisterChildNode('RepartitionDettes', TXMLRepartitionDettesType);
  RegisterChildNode('RepartitionCreances', TXMLRepartitionCreancesType);
  RegisterChildNode('charges-produits', TXMLChargesproduitsType);
  RegisterChildNode('RepartitionCharges', TXMLRepartitionChargesType);
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

function TXMLPageType.Get_RepartitionDettes: IXMLRepartitionDettesType;
begin
  Result := ChildNodes['RepartitionDettes'] as IXMLRepartitionDettesType;
end;

function TXMLPageType.Get_RepartitionCreances: IXMLRepartitionCreancesType;
begin
  Result := ChildNodes['RepartitionCreances'] as IXMLRepartitionCreancesType;
end;

function TXMLPageType.Get_Chargesproduits: IXMLChargesproduitsType;
begin
  Result := ChildNodes['charges-produits'] as IXMLChargesproduitsType;
end;

function TXMLPageType.Get_RepartitionCharges: IXMLRepartitionChargesType;
begin
  Result := ChildNodes['RepartitionCharges'] as IXMLRepartitionChargesType;
end;

{ TXMLTresorerieType }

procedure TXMLTresorerieType.AfterConstruction;
begin
  RegisterChildNode('solde-comptes', TXMLSoldecomptesType);
  RegisterChildNode('courbes-evolution-tresorerie', TXMLCourbesevolutiontresorerieType);
  RegisterChildNode('courbes-evolution-tresorerie-mensuelle', TXMLCourbesevolutiontresoreriemensuelleType);
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

function TXMLTresorerieType.Get_Courbesevolutiontresoreriemensuelle: IXMLCourbesevolutiontresoreriemensuelleType;
begin
  Result := ChildNodes['courbes-evolution-tresorerie-mensuelle'] as IXMLCourbesevolutiontresoreriemensuelleType;
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

function TXMLLigneType.Get_Comptes: Integer;
begin
  Result := ChildNodes['comptes'].NodeValue;
end;

procedure TXMLLigneType.Set_Comptes(Value: Integer);
begin
  ChildNodes['comptes'].NodeValue := Value;
end;

function TXMLLigneType.Get_Libell: WideString;
begin
  Result := ChildNodes['libellé'].Text;
end;

procedure TXMLLigneType.Set_Libell(Value: WideString);
begin
  ChildNodes['libellé'].NodeValue := Value;
end;

function TXMLLigneType.Get_Balance: Integer;
begin
  Result := ChildNodes['balance'].NodeValue;
end;

procedure TXMLLigneType.Set_Balance(Value: Integer);
begin
  ChildNodes['balance'].NodeValue := Value;
end;

function TXMLLigneType.Get_Rapprochement: string;
begin
  Result := ChildNodes['Rapprochement'].Text;
end;

procedure TXMLLigneType.Set_Rapprochement(Value: string);
begin
  ChildNodes['Rapprochement'].NodeValue := Value;
end;

function TXMLLigneType.Get_Compte: Integer;
begin
  Result := ChildNodes['compte'].NodeValue;
end;

procedure TXMLLigneType.Set_Compte(Value: Integer);
begin
  ChildNodes['compte'].NodeValue := Value;
end;

function TXMLLigneType.Get_ExoN: Integer;
begin
  Result := ChildNodes['ExoN'].NodeValue;
end;

procedure TXMLLigneType.Set_ExoN(Value: Integer);
begin
  ChildNodes['ExoN'].NodeValue := Value;
end;

function TXMLLigneType.Get_ExoN1: Integer;
begin
  Result := ChildNodes['ExoN-1'].NodeValue;
end;

procedure TXMLLigneType.Set_ExoN1(Value: Integer);
begin
  ChildNodes['ExoN-1'].NodeValue := Value;
end;

function TXMLLigneType.Get_ExoN2: Integer;
begin
  Result := ChildNodes['ExoN-2'].NodeValue;
end;

procedure TXMLLigneType.Set_ExoN2(Value: Integer);
begin
  ChildNodes['ExoN-2'].NodeValue := Value;
end;

function TXMLLigneType.Get_Mois: Integer;
begin
  Result := ChildNodes['mois'].NodeValue;
end;

procedure TXMLLigneType.Set_Mois(Value: Integer);
begin
  ChildNodes['mois'].NodeValue := Value;
end;

function TXMLLigneType.Get_Total: Integer;
begin
  Result := ChildNodes['Total'].NodeValue;
end;

procedure TXMLLigneType.Set_Total(Value: Integer);
begin
  ChildNodes['Total'].NodeValue := Value;
end;

function TXMLLigneType.Get_Echance: Integer;
begin
  Result := ChildNodes['Echéance'].NodeValue;
end;

procedure TXMLLigneType.Set_Echance(Value: Integer);
begin
  ChildNodes['Echéance'].NodeValue := Value;
end;

function TXMLLigneType.Get_Dettes: Integer;
begin
  Result := ChildNodes['Dettes'].NodeValue;
end;

procedure TXMLLigneType.Set_Dettes(Value: Integer);
begin
  ChildNodes['Dettes'].NodeValue := Value;
end;

function TXMLLigneType.Get_Creances: string;
begin
  Result := ChildNodes['creances'].Text;
end;

procedure TXMLLigneType.Set_Creances(Value: string);
begin
  ChildNodes['creances'].NodeValue := Value;
end;

function TXMLLigneType.Get_Exo: WideString;
begin
  Result := ChildNodes['Exo'].Text;
end;

procedure TXMLLigneType.Set_Exo(Value: WideString);
begin
  ChildNodes['Exo'].NodeValue := Value;
end;

function TXMLLigneType.Get_Crances: string;
begin
  Result := ChildNodes['Créances'].Text;
end;

procedure TXMLLigneType.Set_Crances(Value: string);
begin
  ChildNodes['Créances'].NodeValue := Value;
end;

function TXMLLigneType.Get_Charges: string;
begin
  Result := ChildNodes['Charges'].Text;
end;

procedure TXMLLigneType.Set_Charges(Value: string);
begin
  ChildNodes['Charges'].NodeValue := Value;
end;

function TXMLLigneType.Get_Produits: Integer;
begin
  Result := ChildNodes['Produits'].NodeValue;
end;

procedure TXMLLigneType.Set_Produits(Value: Integer);
begin
  ChildNodes['Produits'].NodeValue := Value;
end;

function TXMLLigneType.Get_Resultat: WideString;
begin
  Result := ChildNodes['Resultat'].Text;
end;

procedure TXMLLigneType.Set_Resultat(Value: WideString);
begin
  ChildNodes['Resultat'].NodeValue := Value;
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

{ TXMLCourbesevolutiontresoreriemensuelleType }

procedure TXMLCourbesevolutiontresoreriemensuelleType.AfterConstruction;
begin
  RegisterChildNode('ligneCompte', TXMLLigneCompteType);
  ItemTag := 'ligneCompte';
  ItemInterface := IXMLLigneCompteType;
  inherited;
end;

function TXMLCourbesevolutiontresoreriemensuelleType.Get_LigneCompte(Index: Integer): IXMLLigneCompteType;
begin
  Result := List[Index] as IXMLLigneCompteType;
end;

function TXMLCourbesevolutiontresoreriemensuelleType.Add: IXMLLigneCompteType;
begin
  Result := AddItem(-1) as IXMLLigneCompteType;
end;

function TXMLCourbesevolutiontresoreriemensuelleType.Insert(const Index: Integer): IXMLLigneCompteType;
begin
  Result := AddItem(Index) as IXMLLigneCompteType;
end;

{ TXMLLigneCompteType }

procedure TXMLLigneCompteType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  ItemTag := 'ligne';
  ItemInterface := IXMLLigneType;
  inherited;
end;

function TXMLLigneCompteType.Get_Compte: Integer;
begin
  Result := AttributeNodes['compte'].NodeValue;
end;

procedure TXMLLigneCompteType.Set_Compte(Value: Integer);
begin
  SetAttribute('compte', Value);
end;

function TXMLLigneCompteType.Get_Rang: Integer;
begin
  Result := AttributeNodes['rang'].NodeValue;
end;

procedure TXMLLigneCompteType.Set_Rang(Value: Integer);
begin
  SetAttribute('rang', Value);
end;

function TXMLLigneCompteType.Get_Ligne(Index: Integer): IXMLLigneType;
begin
  Result := List[Index] as IXMLLigneType;
end;

function TXMLLigneCompteType.Add: IXMLLigneType;
begin
  Result := AddItem(-1) as IXMLLigneType;
end;

function TXMLLigneCompteType.Insert(const Index: Integer): IXMLLigneType;
begin
  Result := AddItem(Index) as IXMLLigneType;
end;

{ TXMLDettesetcreancesType }

procedure TXMLDettesetcreancesType.AfterConstruction;
begin
  RegisterChildNode('Dettes', TXMLDettesType);
  RegisterChildNode('Creances', TXMLCreancesType);
  RegisterChildNode('courbes-dettes-mensuelle', TXMLCourbesdettesmensuelleType);
  RegisterChildNode('courbes-dettes-annuelle', TXMLCourbesdettesannuelleType);
  inherited;
end;

function TXMLDettesetcreancesType.Get_Dettes: IXMLDettesType;
begin
  Result := ChildNodes['Dettes'] as IXMLDettesType;
end;

function TXMLDettesetcreancesType.Get_Creances: IXMLCreancesType;
begin
  Result := ChildNodes['Creances'] as IXMLCreancesType;
end;

function TXMLDettesetcreancesType.Get_Courbesdettesmensuelle: IXMLCourbesdettesmensuelleType;
begin
  Result := ChildNodes['courbes-dettes-mensuelle'] as IXMLCourbesdettesmensuelleType;
end;

function TXMLDettesetcreancesType.Get_Courbesdettesannuelle: IXMLCourbesdettesannuelleType;
begin
  Result := ChildNodes['courbes-dettes-annuelle'] as IXMLCourbesdettesannuelleType;
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

{ TXMLRepartitionChargesType }

procedure TXMLRepartitionChargesType.AfterConstruction;
begin
  RegisterChildNode('ligne', TXMLLigneType);
  inherited;
end;

function TXMLRepartitionChargesType.Get_Ligne: IXMLLigneType;
begin
  Result := ChildNodes['ligne'] as IXMLLigneType;
end;

end.