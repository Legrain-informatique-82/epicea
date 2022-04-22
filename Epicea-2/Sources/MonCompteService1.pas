// ************************************************************************ //
// Les types déclaré dans ce fichier ont été générés à partir de données lues dans le fichier
// WSDL décrit ci-dessous :
// WSDL     : http://localhost:8888/fr.legrain.moncompte.ejb/MonCompteService?wsdl
// Codegen  : [wfDebug,wfUseSerializerClassForAttrs]
// Version  : 1.0
// (15/11/2016 12:32:04 - 1.33.2.5)
// ************************************************************************ //

unit MonCompteService1;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // Les types suivants mentionnés dans le document WSDL ne sont pas représentés
  // dans ce fichier. Ce sont soit des alias[@] de types représentés ou alors ils sont 
  // référencés mais jamais[!] déclarés dans ce document. Les types de la dernière catégorie
  // sont en principe mappés à des types Borland ou XML prédéfinis/connus. Toutefois, ils peuvent aussi
  // signaler des documents WSDL incorrects n'ayant pas réussi à déclarer ou importer un type de schéma.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"
  // !:taAdresse       - "http://www.w3.org/2001/XMLSchema"
  // !:taLicence       - "http://www.w3.org/2001/XMLSchema"
  // !:taUtilisateur   - "http://www.w3.org/2001/XMLSchema"
  // !:taClient        - "http://www.w3.org/2001/XMLSchema"
  // !:taAutorisation  - "http://www.w3.org/2001/XMLSchema"
  // !:taPrixPerso     - "http://www.w3.org/2001/XMLSchema"
  // !:taPrixParUtilisateurPerso - "http://www.w3.org/2001/XMLSchema"
  // !:taCategoriePro  - "http://www.w3.org/2001/XMLSchema"
  // !:taLignePanier   - "http://www.w3.org/2001/XMLSchema"
  // !:taCgv           - "http://www.w3.org/2001/XMLSchema"
  // !:taDossier       - "http://www.w3.org/2001/XMLSchema"

  taTNiveau            = class;                 { "http://service.moncompte.legrain.fr/" }
  taCgv                = class;                 { "http://service.moncompte.legrain.fr/" }
  taClient             = class;                 { "http://service.moncompte.legrain.fr/" }
  taDossier            = class;                 { "http://service.moncompte.legrain.fr/" }
  taLimitation         = class;                 { "http://service.moncompte.legrain.fr/" }
  taPanier             = class;                 { "http://service.moncompte.legrain.fr/" }
  chargeDernierSetup   = class;                 { "http://service.moncompte.legrain.fr/" }
  chargeDernierSetupResponse = class;           { "http://service.moncompte.legrain.fr/" }
  dossierExiste        = class;                 { "http://service.moncompte.legrain.fr/" }
  dossierExisteResponse = class;                { "http://service.moncompte.legrain.fr/" }
  findCgv              = class;                 { "http://service.moncompte.legrain.fr/" }
  findCgvCourant       = class;                 { "http://service.moncompte.legrain.fr/" }
  findCgvCourantResponse = class;               { "http://service.moncompte.legrain.fr/" }
  findCgvResponse      = class;                 { "http://service.moncompte.legrain.fr/" }
  findClientDossier    = class;                 { "http://service.moncompte.legrain.fr/" }
  findClientDossierResponse = class;            { "http://service.moncompte.legrain.fr/" }
  findDossier          = class;                 { "http://service.moncompte.legrain.fr/" }
  findDossierResponse  = class;                 { "http://service.moncompte.legrain.fr/" }
  findLimitationFacture = class;                { "http://service.moncompte.legrain.fr/" }
  findLimitationFactureResponse = class;        { "http://service.moncompte.legrain.fr/" }
  findPanier           = class;                 { "http://service.moncompte.legrain.fr/" }
  findPanierClient     = class;                 { "http://service.moncompte.legrain.fr/" }
  findPanierDossier    = class;                 { "http://service.moncompte.legrain.fr/" }
  findPanierResponse   = class;                 { "http://service.moncompte.legrain.fr/" }
  findPrixParUtilisateur = class;               { "http://service.moncompte.legrain.fr/" }
  mergeClient          = class;                 { "http://service.moncompte.legrain.fr/" }
  mergeClientResponse  = class;                 { "http://service.moncompte.legrain.fr/" }
  mergeDossier         = class;                 { "http://service.moncompte.legrain.fr/" }
  mergeDossierResponse = class;                 { "http://service.moncompte.legrain.fr/" }
  mergePanier          = class;                 { "http://service.moncompte.legrain.fr/" }
  mergePanierResponse  = class;                 { "http://service.moncompte.legrain.fr/" }
  selectAllCategoriePro = class;                { "http://service.moncompte.legrain.fr/" }
  selectAllProduit     = class;                 { "http://service.moncompte.legrain.fr/" }
  selectAllProduitCategoriePro = class;         { "http://service.moncompte.legrain.fr/" }
  selectAllTNiveau     = class;                 { "http://service.moncompte.legrain.fr/" }
  utilisateurExiste    = class;                 { "http://service.moncompte.legrain.fr/" }
  utilisateurExisteResponse = class;            { "http://service.moncompte.legrain.fr/" }
  selectAllTNiveauResponse = class;             { "http://service.moncompte.legrain.fr/"[A] }
  selectAllProduitResponse = class;             { "http://service.moncompte.legrain.fr/"[A] }
  selectAllProduitCategorieProResponse = class;   { "http://service.moncompte.legrain.fr/"[A] }
  selectAllCategorieProResponse = class;        { "http://service.moncompte.legrain.fr/"[A] }
  findPrixParUtilisateurResponse = class;       { "http://service.moncompte.legrain.fr/"[A] }
  findPanierDossierResponse = class;            { "http://service.moncompte.legrain.fr/"[A] }
  findPanierClientResponse = class;             { "http://service.moncompte.legrain.fr/"[A] }



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // ************************************************************************ //
  taTNiveau = class(TRemotable)
  private
    Fcode: WideString;
    FidTNiveau: Integer;
    FipAcces: WideString;
    Flibelle: WideString;
    FquandCree: TXSDateTime;
    FquandModif: TXSDateTime;
    FquiCree: WideString;
    FquiModif: WideString;
    FversionObj: Integer;
  public
    destructor Destroy; override;
  published
    property code: WideString read Fcode write Fcode;
    property idTNiveau: Integer read FidTNiveau write FidTNiveau;
    property ipAcces: WideString read FipAcces write FipAcces;
    property libelle: WideString read Flibelle write Flibelle;
    property quandCree: TXSDateTime read FquandCree write FquandCree;
    property quandModif: TXSDateTime read FquandModif write FquandModif;
    property quiCree: WideString read FquiCree write FquiCree;
    property quiModif: WideString read FquiModif write FquiModif;
    property versionObj: Integer read FversionObj write FversionObj;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // ************************************************************************ //
  taCgv = class(TRemotable)
  private
    Factif: Boolean;
    FblobFichier: TByteDynArray;
    Fcgv: WideString;
    FdateCgv: TXSDateTime;
    FidCgv: Integer;
    FipAcces: WideString;
    FquandCree: TXSDateTime;
    FquandModif: TXSDateTime;
    FquiCree: WideString;
    FquiModif: WideString;
    Furl: WideString;
    FversionObj: Integer;
  public
    destructor Destroy; override;
  published
    property actif: Boolean read Factif write Factif;
    property blobFichier: TByteDynArray read FblobFichier write FblobFichier;
    property cgv: WideString read Fcgv write Fcgv;
    property dateCgv: TXSDateTime read FdateCgv write FdateCgv;
    property idCgv: Integer read FidCgv write FidCgv;
    property ipAcces: WideString read FipAcces write FipAcces;
    property quandCree: TXSDateTime read FquandCree write FquandCree;
    property quandModif: TXSDateTime read FquandModif write FquandModif;
    property quiCree: WideString read FquiCree write FquiCree;
    property quiModif: WideString read FquiModif write FquiModif;
    property url: WideString read Furl write Furl;
    property versionObj: Integer read FversionObj write FversionObj;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // ************************************************************************ //
  taClient = class(TRemotable)
  private
    Factif: Boolean;
    Fadresse1: taAdresse;
    Fadresse2: taAdresse;
    Fadresse3: taAdresse;
    FancienCode: WideString;
    Fcode: WideString;
    Fid: Integer;
    FidentifiantFtp: WideString;
    FlisteLicence: taLicence;
    FmdpFtp: WideString;
    Fnom: WideString;
    Fprenom: WideString;
    FquandCree: TXSDateTime;
    FquandModif: TXSDateTime;
    FquiCree: WideString;
    FquiModif: WideString;
    FserveurFtp: WideString;
    FtaUtilisateur: taUtilisateur;
    FversionObj: Integer;
  public
    destructor Destroy; override;
  published
    property actif: Boolean read Factif write Factif;
    property adresse1: taAdresse read Fadresse1 write Fadresse1;
    property adresse2: taAdresse read Fadresse2 write Fadresse2;
    property adresse3: taAdresse read Fadresse3 write Fadresse3;
    property ancienCode: WideString read FancienCode write FancienCode;
    property code: WideString read Fcode write Fcode;
    property id: Integer read Fid write Fid;
    property identifiantFtp: WideString read FidentifiantFtp write FidentifiantFtp;
    property listeLicence: taLicence read FlisteLicence write FlisteLicence;
    property mdpFtp: WideString read FmdpFtp write FmdpFtp;
    property nom: WideString read Fnom write Fnom;
    property prenom: WideString read Fprenom write Fprenom;
    property quandCree: TXSDateTime read FquandCree write FquandCree;
    property quandModif: TXSDateTime read FquandModif write FquandModif;
    property quiCree: WideString read FquiCree write FquiCree;
    property quiModif: WideString read FquiModif write FquiModif;
    property serveurFtp: WideString read FserveurFtp write FserveurFtp;
    property taUtilisateur: taUtilisateur read FtaUtilisateur write FtaUtilisateur;
    property versionObj: Integer read FversionObj write FversionObj;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // ************************************************************************ //
  taDossier = class(TRemotable)
  private
    Fid: Integer;
    Fcode: WideString;
    Fdescription: WideString;
    Factif: Boolean;
    FmodeLocatif: Boolean;
    FnbUtilisateur: Integer;
    FnbPosteInstalle: Integer;
    FaccesWs: Boolean;
    FcodePartenaire: WideString;
    FtauxReduction: TXSDecimal;
    FtaClient: taClient;
    FlisteAutorisation: taAutorisation;
    FlistePrixPerso: taPrixPerso;
    FlistePrixParUtilisateurPerso: taPrixParUtilisateurPerso;
    FtaCategoriePro: taCategoriePro;
    FquandCree: TXSDateTime;
    FquandModif: TXSDateTime;
    FquiCree: WideString;
    FquiModif: WideString;
    FversionObj: Integer;
  public
    destructor Destroy; override;
  published
    property id: Integer read Fid write Fid;
    property code: WideString read Fcode write Fcode;
    property description: WideString read Fdescription write Fdescription;
    property actif: Boolean read Factif write Factif;
    property modeLocatif: Boolean read FmodeLocatif write FmodeLocatif;
    property nbUtilisateur: Integer read FnbUtilisateur write FnbUtilisateur;
    property nbPosteInstalle: Integer read FnbPosteInstalle write FnbPosteInstalle;
    property accesWs: Boolean read FaccesWs write FaccesWs;
    property codePartenaire: WideString read FcodePartenaire write FcodePartenaire;
    property tauxReduction: TXSDecimal read FtauxReduction write FtauxReduction;
    property taClient: taClient read FtaClient write FtaClient;
    property listeAutorisation: taAutorisation read FlisteAutorisation write FlisteAutorisation;
    property listePrixPerso: taPrixPerso read FlistePrixPerso write FlistePrixPerso;
    property listePrixParUtilisateurPerso: taPrixParUtilisateurPerso read FlistePrixParUtilisateurPerso write FlistePrixParUtilisateurPerso;
    property taCategoriePro: taCategoriePro read FtaCategoriePro write FtaCategoriePro;
    property quandCree: TXSDateTime read FquandCree write FquandCree;
    property quandModif: TXSDateTime read FquandModif write FquandModif;
    property quiCree: WideString read FquiCree write FquiCree;
    property quiModif: WideString read FquiModif write FquiModif;
    property versionObj: Integer read FversionObj write FversionObj;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // ************************************************************************ //
  taLimitation = class(TRemotable)
  private
    Fid: Integer;
    FipAcces: WideString;
    Flimite: TXSDecimal;
    FquandCree: TXSDateTime;
    FquandModif: TXSDateTime;
    FquiCree: WideString;
    FquiModif: WideString;
    FtypeLimite: WideString;
    FversionObj: Integer;
  public
    destructor Destroy; override;
  published
    property id: Integer read Fid write Fid;
    property ipAcces: WideString read FipAcces write FipAcces;
    property limite: TXSDecimal read Flimite write Flimite;
    property quandCree: TXSDateTime read FquandCree write FquandCree;
    property quandModif: TXSDateTime read FquandModif write FquandModif;
    property quiCree: WideString read FquiCree write FquiCree;
    property quiModif: WideString read FquiModif write FquiModif;
    property typeLimite: WideString read FtypeLimite write FtypeLimite;
    property versionObj: Integer read FversionObj write FversionObj;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // ************************************************************************ //
  taPanier = class(TRemotable)
  private
    FaccesWS: Boolean;
    FcodePromo: WideString;
    FcodeRevendeur: WideString;
    FdateCreation: TXSDateTime;
    FdatePaiement: TXSDateTime;
    FidPanier: Integer;
    FipAcces: WideString;
    Flibelle: WideString;
    Flignes: taLignePanier;
    FnbMois: Integer;
    FnbPosteInstalle: Integer;
    FnbUtilisateur: Integer;
    Fniveau: WideString;
    Fpaye: Boolean;
    FquandCree: TXSDateTime;
    FquandModif: TXSDateTime;
    FquiCree: WideString;
    FquiModif: WideString;
    FrefPaiement: WideString;
    FtaCategoriePro: taCategoriePro;
    FtaCgv: taCgv;
    FtaClient: taClient;
    FtaDossier: taDossier;
    FtauxReduction: TXSDecimal;
    FtotalHT: TXSDecimal;
    FtotalTTC: TXSDecimal;
    FtotalTVA: TXSDecimal;
    FtypePaiement: WideString;
    FversionObj: Integer;
  public
    destructor Destroy; override;
  published
    property accesWS: Boolean read FaccesWS write FaccesWS;
    property codePromo: WideString read FcodePromo write FcodePromo;
    property codeRevendeur: WideString read FcodeRevendeur write FcodeRevendeur;
    property dateCreation: TXSDateTime read FdateCreation write FdateCreation;
    property datePaiement: TXSDateTime read FdatePaiement write FdatePaiement;
    property idPanier: Integer read FidPanier write FidPanier;
    property ipAcces: WideString read FipAcces write FipAcces;
    property libelle: WideString read Flibelle write Flibelle;
    property lignes: taLignePanier read Flignes write Flignes;
    property nbMois: Integer read FnbMois write FnbMois;
    property nbPosteInstalle: Integer read FnbPosteInstalle write FnbPosteInstalle;
    property nbUtilisateur: Integer read FnbUtilisateur write FnbUtilisateur;
    property niveau: WideString read Fniveau write Fniveau;
    property paye: Boolean read Fpaye write Fpaye;
    property quandCree: TXSDateTime read FquandCree write FquandCree;
    property quandModif: TXSDateTime read FquandModif write FquandModif;
    property quiCree: WideString read FquiCree write FquiCree;
    property quiModif: WideString read FquiModif write FquiModif;
    property refPaiement: WideString read FrefPaiement write FrefPaiement;
    property taCategoriePro: taCategoriePro read FtaCategoriePro write FtaCategoriePro;
    property taCgv: taCgv read FtaCgv write FtaCgv;
    property taClient: taClient read FtaClient write FtaClient;
    property taDossier: taDossier read FtaDossier write FtaDossier;
    property tauxReduction: TXSDecimal read FtauxReduction write FtauxReduction;
    property totalHT: TXSDecimal read FtotalHT write FtotalHT;
    property totalTTC: TXSDecimal read FtotalTTC write FtotalTTC;
    property totalTVA: TXSDecimal read FtotalTVA write FtotalTVA;
    property typePaiement: WideString read FtypePaiement write FtypePaiement;
    property versionObj: Integer read FversionObj write FversionObj;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  chargeDernierSetup = class(TRemotable)
  private
    Farg0: WideString;
    Farg1: WideString;
    Farg2: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
    property arg1: WideString read Farg1 write Farg1;
    property arg2: WideString read Farg2 write Farg2;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  chargeDernierSetupResponse = class(TRemotable)
  private
    Freturn: WideString;
  public
    constructor Create; override;
  published
    property return: WideString read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  dossierExiste = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  dossierExisteResponse = class(TRemotable)
  private
    Freturn: Boolean;
  public
    constructor Create; override;
  published
    property return: Boolean read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findCgv = class(TRemotable)
  private
    Farg0: Integer;
  public
    constructor Create; override;
  published
    property arg0: Integer read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findCgvCourant = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findCgvCourantResponse = class(TRemotable)
  private
    Freturn: taCgv;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taCgv read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findCgvResponse = class(TRemotable)
  private
    Freturn: taCgv;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taCgv read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findClientDossier = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findClientDossierResponse = class(TRemotable)
  private
    Freturn: taClient;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taClient read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findDossier = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findDossierResponse = class(TRemotable)
  private
    Freturn: taDossier;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taDossier read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findLimitationFacture = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findLimitationFactureResponse = class(TRemotable)
  private
    Freturn: taLimitation;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taLimitation read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findPanier = class(TRemotable)
  private
    Farg0: Integer;
  public
    constructor Create; override;
  published
    property arg0: Integer read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findPanierClient = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findPanierDossier = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findPanierResponse = class(TRemotable)
  private
    Freturn: taPanier;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taPanier read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findPrixParUtilisateur = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergeClient = class(TRemotable)
  private
    Farg0: taClient;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taClient read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergeClientResponse = class(TRemotable)
  private
    Freturn: taClient;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taClient read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergeDossier = class(TRemotable)
  private
    Farg0: taDossier;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taDossier read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergeDossierResponse = class(TRemotable)
  private
    Freturn: taDossier;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taDossier read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergePanier = class(TRemotable)
  private
    Farg0: taPanier;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taPanier read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergePanierResponse = class(TRemotable)
  private
    Freturn: taPanier;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taPanier read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  selectAllCategoriePro = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  selectAllProduit = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  selectAllProduitCategoriePro = class(TRemotable)
  private
    Farg0: Integer;
  public
    constructor Create; override;
  published
    property arg0: Integer read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  selectAllTNiveau = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  utilisateurExiste = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  utilisateurExisteResponse = class(TRemotable)
  private
    Freturn: Boolean;
  public
    constructor Create; override;
  published
    property return: Boolean read Freturn write Freturn;
  end;

  return     = array of taTNiveau;              { "http://service.moncompte.legrain.fr/" }


  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  selectAllTNiveauResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaTNiveauArray(Index: Integer): taTNiveau;
    function   GettaTNiveauArrayLength: Integer;
    property   taTNiveauArray[Index: Integer]: taTNiveau read GettaTNiveauArray; default;
    property   Len: Integer read GettaTNiveauArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  selectAllProduitResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaTNiveauArray(Index: Integer): taTNiveau;
    function   GettaTNiveauArrayLength: Integer;
    property   taTNiveauArray[Index: Integer]: taTNiveau read GettaTNiveauArray; default;
    property   Len: Integer read GettaTNiveauArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  selectAllProduitCategorieProResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaTNiveauArray(Index: Integer): taTNiveau;
    function   GettaTNiveauArrayLength: Integer;
    property   taTNiveauArray[Index: Integer]: taTNiveau read GettaTNiveauArray; default;
    property   Len: Integer read GettaTNiveauArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  selectAllCategorieProResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaTNiveauArray(Index: Integer): taTNiveau;
    function   GettaTNiveauArrayLength: Integer;
    property   taTNiveauArray[Index: Integer]: taTNiveau read GettaTNiveauArray; default;
    property   Len: Integer read GettaTNiveauArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  findPrixParUtilisateurResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaTNiveauArray(Index: Integer): taTNiveau;
    function   GettaTNiveauArrayLength: Integer;
    property   taTNiveauArray[Index: Integer]: taTNiveau read GettaTNiveauArray; default;
    property   Len: Integer read GettaTNiveauArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  findPanierDossierResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaTNiveauArray(Index: Integer): taTNiveau;
    function   GettaTNiveauArrayLength: Integer;
    property   taTNiveauArray[Index: Integer]: taTNiveau read GettaTNiveauArray; default;
    property   Len: Integer read GettaTNiveauArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  findPanierClientResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaTNiveauArray(Index: Integer): taTNiveau;
    function   GettaTNiveauArrayLength: Integer;
    property   taTNiveauArray[Index: Integer]: taTNiveau read GettaTNiveauArray; default;
    property   Len: Integer read GettaTNiveauArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;


  // ************************************************************************ //
  // Espace de nommage : http://service.moncompte.legrain.fr/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // liaison   : MonCompteServiceServiceSoapBinding
  // service   : MonCompteServiceService
  // port      : MonCompteServicePort
  // URL       : http://localhost:8888/fr.legrain.moncompte.ejb/MonCompteService
  // ************************************************************************ //
  MonCompteService = interface(IInvokable)
  ['{A806ABC0-9309-1805-93EA-746185CACCC7}']
    function  findDossier(const parameters: findDossier): findDossierResponse; stdcall;
    function  findPanierClient(const parameters: findPanierClient): findPanierClientResponse; stdcall;
    function  findLimitationFacture(const parameters: findLimitationFacture): findLimitationFactureResponse; stdcall;
    function  findCgvCourant(const parameters: findCgvCourant): findCgvCourantResponse; stdcall;
    function  findPanier(const parameters: findPanier): findPanierResponse; stdcall;
    function  utilisateurExiste(const parameters: utilisateurExiste): utilisateurExisteResponse; stdcall;
    function  chargeDernierSetup(const parameters: chargeDernierSetup): chargeDernierSetupResponse; stdcall;
    function  findPanierDossier(const parameters: findPanierDossier): findPanierDossierResponse; stdcall;
    function  selectAllCategoriePro(const parameters: selectAllCategoriePro): selectAllCategorieProResponse; stdcall;
    function  dossierExiste(const parameters: dossierExiste): dossierExisteResponse; stdcall;
    function  mergeDossier(const parameters: mergeDossier): mergeDossierResponse; stdcall;
    function  mergePanier(const parameters: mergePanier): mergePanierResponse; stdcall;
    function  findCgv(const parameters: findCgv): findCgvResponse; stdcall;
    function  selectAllProduit(const parameters: selectAllProduit): selectAllProduitResponse; stdcall;
    function  findPrixParUtilisateur(const parameters: findPrixParUtilisateur): findPrixParUtilisateurResponse; stdcall;
    function  mergeClient(const parameters: mergeClient): mergeClientResponse; stdcall;
    function  findClientDossier(const parameters: findClientDossier): findClientDossierResponse; stdcall;
    function  selectAllTNiveau(const parameters: selectAllTNiveau): selectAllTNiveauResponse; stdcall;
    function  selectAllProduitCategoriePro(const parameters: selectAllProduitCategoriePro): selectAllProduitCategorieProResponse; stdcall;
  end;

function GetMonCompteService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MonCompteService;


implementation

function GetMonCompteService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MonCompteService;
const
  defWSDL = 'http://localhost:8888/fr.legrain.moncompte.ejb/MonCompteService?wsdl';
  defURL  = 'http://localhost:8888/fr.legrain.moncompte.ejb/MonCompteService';
  defSvc  = 'MonCompteServiceService';
  defPrt  = 'MonCompteServicePort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as MonCompteService);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor taTNiveau.Destroy;
begin
  if Assigned(FquandCree) then
    FquandCree.Free;
  if Assigned(FquandModif) then
    FquandModif.Free;
  inherited Destroy;
end;

destructor taCgv.Destroy;
begin
  if Assigned(FdateCgv) then
    FdateCgv.Free;
  if Assigned(FquandCree) then
    FquandCree.Free;
  if Assigned(FquandModif) then
    FquandModif.Free;
  inherited Destroy;
end;

destructor taClient.Destroy;
begin
  if Assigned(FquandCree) then
    FquandCree.Free;
  if Assigned(FquandModif) then
    FquandModif.Free;
  inherited Destroy;
end;

destructor taDossier.Destroy;
begin
  if Assigned(FtauxReduction) then
    FtauxReduction.Free;
  if Assigned(FquandCree) then
    FquandCree.Free;
  if Assigned(FquandModif) then
    FquandModif.Free;
  inherited Destroy;
end;

destructor taLimitation.Destroy;
begin
  if Assigned(Flimite) then
    Flimite.Free;
  if Assigned(FquandCree) then
    FquandCree.Free;
  if Assigned(FquandModif) then
    FquandModif.Free;
  inherited Destroy;
end;

destructor taPanier.Destroy;
begin
  if Assigned(FdateCreation) then
    FdateCreation.Free;
  if Assigned(FdatePaiement) then
    FdatePaiement.Free;
  if Assigned(FquandCree) then
    FquandCree.Free;
  if Assigned(FquandModif) then
    FquandModif.Free;
  if Assigned(FtauxReduction) then
    FtauxReduction.Free;
  if Assigned(FtotalHT) then
    FtotalHT.Free;
  if Assigned(FtotalTTC) then
    FtotalTTC.Free;
  if Assigned(FtotalTVA) then
    FtotalTVA.Free;
  inherited Destroy;
end;

constructor chargeDernierSetup.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor chargeDernierSetupResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor dossierExiste.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor dossierExisteResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findCgv.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findCgvCourant.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findCgvCourantResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor findCgvCourantResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor findCgvResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor findCgvResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor findClientDossier.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findClientDossierResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor findClientDossierResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor findDossier.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findDossierResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor findDossierResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor findLimitationFacture.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findLimitationFactureResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor findLimitationFactureResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor findPanier.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findPanierClient.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findPanierDossier.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findPanierResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor findPanierResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor findPrixParUtilisateur.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor mergeClient.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor mergeClient.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor mergeClientResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor mergeClientResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor mergeDossier.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor mergeDossier.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor mergeDossierResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor mergeDossierResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor mergePanier.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor mergePanier.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor mergePanierResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor mergePanierResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor selectAllCategoriePro.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor selectAllProduit.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor selectAllProduitCategoriePro.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor selectAllTNiveau.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor utilisateurExiste.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor utilisateurExisteResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor selectAllTNiveauResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor selectAllTNiveauResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function selectAllTNiveauResponse.GettaTNiveauArray(Index: Integer): taTNiveau;
begin
  Result := Freturn[Index];
end;

function selectAllTNiveauResponse.GettaTNiveauArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

constructor selectAllProduitResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor selectAllProduitResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function selectAllProduitResponse.GettaTNiveauArray(Index: Integer): taTNiveau;
begin
  Result := Freturn[Index];
end;

function selectAllProduitResponse.GettaTNiveauArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

constructor selectAllProduitCategorieProResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor selectAllProduitCategorieProResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function selectAllProduitCategorieProResponse.GettaTNiveauArray(Index: Integer): taTNiveau;
begin
  Result := Freturn[Index];
end;

function selectAllProduitCategorieProResponse.GettaTNiveauArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

constructor selectAllCategorieProResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor selectAllCategorieProResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function selectAllCategorieProResponse.GettaTNiveauArray(Index: Integer): taTNiveau;
begin
  Result := Freturn[Index];
end;

function selectAllCategorieProResponse.GettaTNiveauArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

constructor findPrixParUtilisateurResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor findPrixParUtilisateurResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function findPrixParUtilisateurResponse.GettaTNiveauArray(Index: Integer): taTNiveau;
begin
  Result := Freturn[Index];
end;

function findPrixParUtilisateurResponse.GettaTNiveauArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

constructor findPanierDossierResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor findPanierDossierResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function findPanierDossierResponse.GettaTNiveauArray(Index: Integer): taTNiveau;
begin
  Result := Freturn[Index];
end;

function findPanierDossierResponse.GettaTNiveauArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

constructor findPanierClientResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor findPanierClientResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function findPanierClientResponse.GettaTNiveauArray(Index: Integer): taTNiveau;
begin
  Result := Freturn[Index];
end;

function findPanierClientResponse.GettaTNiveauArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(MonCompteService), 'http://service.moncompte.legrain.fr/', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MonCompteService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(MonCompteService), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(MonCompteService), ioLiteral);
  RemClassRegistry.RegisterXSClass(taTNiveau, 'http://service.moncompte.legrain.fr/', 'taTNiveau');
  RemClassRegistry.RegisterXSClass(taCgv, 'http://service.moncompte.legrain.fr/', 'taCgv');
  RemClassRegistry.RegisterXSClass(taClient, 'http://service.moncompte.legrain.fr/', 'taClient');
  RemClassRegistry.RegisterXSClass(taDossier, 'http://service.moncompte.legrain.fr/', 'taDossier');
  RemClassRegistry.RegisterXSClass(taLimitation, 'http://service.moncompte.legrain.fr/', 'taLimitation');
  RemClassRegistry.RegisterXSClass(taPanier, 'http://service.moncompte.legrain.fr/', 'taPanier');
  RemClassRegistry.RegisterXSClass(chargeDernierSetup, 'http://service.moncompte.legrain.fr/', 'chargeDernierSetup');
  RemClassRegistry.RegisterSerializeOptions(chargeDernierSetup, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(chargeDernierSetupResponse, 'http://service.moncompte.legrain.fr/', 'chargeDernierSetupResponse');
  RemClassRegistry.RegisterSerializeOptions(chargeDernierSetupResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(dossierExiste, 'http://service.moncompte.legrain.fr/', 'dossierExiste');
  RemClassRegistry.RegisterSerializeOptions(dossierExiste, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(dossierExisteResponse, 'http://service.moncompte.legrain.fr/', 'dossierExisteResponse');
  RemClassRegistry.RegisterSerializeOptions(dossierExisteResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findCgv, 'http://service.moncompte.legrain.fr/', 'findCgv');
  RemClassRegistry.RegisterSerializeOptions(findCgv, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findCgvCourant, 'http://service.moncompte.legrain.fr/', 'findCgvCourant');
  RemClassRegistry.RegisterSerializeOptions(findCgvCourant, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findCgvCourantResponse, 'http://service.moncompte.legrain.fr/', 'findCgvCourantResponse');
  RemClassRegistry.RegisterSerializeOptions(findCgvCourantResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findCgvResponse, 'http://service.moncompte.legrain.fr/', 'findCgvResponse');
  RemClassRegistry.RegisterSerializeOptions(findCgvResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findClientDossier, 'http://service.moncompte.legrain.fr/', 'findClientDossier');
  RemClassRegistry.RegisterSerializeOptions(findClientDossier, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findClientDossierResponse, 'http://service.moncompte.legrain.fr/', 'findClientDossierResponse');
  RemClassRegistry.RegisterSerializeOptions(findClientDossierResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findDossier, 'http://service.moncompte.legrain.fr/', 'findDossier');
  RemClassRegistry.RegisterSerializeOptions(findDossier, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findDossierResponse, 'http://service.moncompte.legrain.fr/', 'findDossierResponse');
  RemClassRegistry.RegisterSerializeOptions(findDossierResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findLimitationFacture, 'http://service.moncompte.legrain.fr/', 'findLimitationFacture');
  RemClassRegistry.RegisterSerializeOptions(findLimitationFacture, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findLimitationFactureResponse, 'http://service.moncompte.legrain.fr/', 'findLimitationFactureResponse');
  RemClassRegistry.RegisterSerializeOptions(findLimitationFactureResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findPanier, 'http://service.moncompte.legrain.fr/', 'findPanier');
  RemClassRegistry.RegisterSerializeOptions(findPanier, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findPanierClient, 'http://service.moncompte.legrain.fr/', 'findPanierClient');
  RemClassRegistry.RegisterSerializeOptions(findPanierClient, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findPanierDossier, 'http://service.moncompte.legrain.fr/', 'findPanierDossier');
  RemClassRegistry.RegisterSerializeOptions(findPanierDossier, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findPanierResponse, 'http://service.moncompte.legrain.fr/', 'findPanierResponse');
  RemClassRegistry.RegisterSerializeOptions(findPanierResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findPrixParUtilisateur, 'http://service.moncompte.legrain.fr/', 'findPrixParUtilisateur');
  RemClassRegistry.RegisterSerializeOptions(findPrixParUtilisateur, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergeClient, 'http://service.moncompte.legrain.fr/', 'mergeClient');
  RemClassRegistry.RegisterSerializeOptions(mergeClient, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergeClientResponse, 'http://service.moncompte.legrain.fr/', 'mergeClientResponse');
  RemClassRegistry.RegisterSerializeOptions(mergeClientResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergeDossier, 'http://service.moncompte.legrain.fr/', 'mergeDossier');
  RemClassRegistry.RegisterSerializeOptions(mergeDossier, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergeDossierResponse, 'http://service.moncompte.legrain.fr/', 'mergeDossierResponse');
  RemClassRegistry.RegisterSerializeOptions(mergeDossierResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergePanier, 'http://service.moncompte.legrain.fr/', 'mergePanier');
  RemClassRegistry.RegisterSerializeOptions(mergePanier, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergePanierResponse, 'http://service.moncompte.legrain.fr/', 'mergePanierResponse');
  RemClassRegistry.RegisterSerializeOptions(mergePanierResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectAllCategoriePro, 'http://service.moncompte.legrain.fr/', 'selectAllCategoriePro');
  RemClassRegistry.RegisterSerializeOptions(selectAllCategoriePro, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectAllProduit, 'http://service.moncompte.legrain.fr/', 'selectAllProduit');
  RemClassRegistry.RegisterSerializeOptions(selectAllProduit, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectAllProduitCategoriePro, 'http://service.moncompte.legrain.fr/', 'selectAllProduitCategoriePro');
  RemClassRegistry.RegisterSerializeOptions(selectAllProduitCategoriePro, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectAllTNiveau, 'http://service.moncompte.legrain.fr/', 'selectAllTNiveau');
  RemClassRegistry.RegisterSerializeOptions(selectAllTNiveau, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(utilisateurExiste, 'http://service.moncompte.legrain.fr/', 'utilisateurExiste');
  RemClassRegistry.RegisterSerializeOptions(utilisateurExiste, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(utilisateurExisteResponse, 'http://service.moncompte.legrain.fr/', 'utilisateurExisteResponse');
  RemClassRegistry.RegisterSerializeOptions(utilisateurExisteResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(return), 'http://service.moncompte.legrain.fr/', 'return');
  RemClassRegistry.RegisterXSClass(selectAllTNiveauResponse, 'http://service.moncompte.legrain.fr/', 'selectAllTNiveauResponse');
  RemClassRegistry.RegisterSerializeOptions(selectAllTNiveauResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectAllProduitResponse, 'http://service.moncompte.legrain.fr/', 'selectAllProduitResponse');
  RemClassRegistry.RegisterSerializeOptions(selectAllProduitResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectAllProduitCategorieProResponse, 'http://service.moncompte.legrain.fr/', 'selectAllProduitCategorieProResponse');
  RemClassRegistry.RegisterSerializeOptions(selectAllProduitCategorieProResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectAllCategorieProResponse, 'http://service.moncompte.legrain.fr/', 'selectAllCategorieProResponse');
  RemClassRegistry.RegisterSerializeOptions(selectAllCategorieProResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findPrixParUtilisateurResponse, 'http://service.moncompte.legrain.fr/', 'findPrixParUtilisateurResponse');
  RemClassRegistry.RegisterSerializeOptions(findPrixParUtilisateurResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findPanierDossierResponse, 'http://service.moncompte.legrain.fr/', 'findPanierDossierResponse');
  RemClassRegistry.RegisterSerializeOptions(findPanierDossierResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findPanierClientResponse, 'http://service.moncompte.legrain.fr/', 'findPanierClientResponse');
  RemClassRegistry.RegisterSerializeOptions(findPanierClientResponse, [xoInlineArrays,xoLiteralParam]);

end. 