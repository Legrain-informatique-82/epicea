// ************************************************************************ //
// Les types déclaré dans ce fichier ont été générés à partir de données lues dans le fichier
// WSDL décrit ci-dessous :
// WSDL     : http://localhost:8888/fr.legrain.autorisations.ejb/TaAutorisationsService?wsdl
// Codegen  : [wfDebug,wfMapStringsToWideStrings,wfUseSerializerClassForAttrs]
// Version  : 1.0
// (31/03/2015 15:06:41 - 1.33.2.5)
// ************************************************************************ //

unit TaAutorisationsService3;

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

  errorResponse        = class;                 { "http://service.autorisations.legrain.fr/" }
  mergeDTOResponse     = class;                 { "http://service.autorisations.legrain.fr/" }
  mergeDTOValidationContextResponse = class;    { "http://service.autorisations.legrain.fr/" }
  persistDTOResponse   = class;                 { "http://service.autorisations.legrain.fr/" }
  persistDTOValidationContextResponse = class;   { "http://service.autorisations.legrain.fr/" }
  persistResponse      = class;                 { "http://service.autorisations.legrain.fr/" }
  persistValidationContextResponse = class;     { "http://service.autorisations.legrain.fr/" }
  removeDTOResponse    = class;                 { "http://service.autorisations.legrain.fr/" }
  removeResponse       = class;                 { "http://service.autorisations.legrain.fr/" }
  selectAll            = class;                 { "http://service.autorisations.legrain.fr/" }
  selectAllDTO         = class;                 { "http://service.autorisations.legrain.fr/" }
  selectCount          = class;                 { "http://service.autorisations.legrain.fr/" }
  validateDTOPropertyResponse = class;          { "http://service.autorisations.legrain.fr/" }
  validateDTOPropertyValidationContextResponse = class;   { "http://service.autorisations.legrain.fr/" }
  validateDTOResponse  = class;                 { "http://service.autorisations.legrain.fr/" }
  validateDTOValidationContextResponse = class;   { "http://service.autorisations.legrain.fr/" }
  validateEntityPropertyResponse = class;       { "http://service.autorisations.legrain.fr/" }
  validateEntityPropertyValidationContextResponse = class;   { "http://service.autorisations.legrain.fr/" }
  validateEntityResponse = class;               { "http://service.autorisations.legrain.fr/" }
  validateEntityValidationContextResponse = class;   { "http://service.autorisations.legrain.fr/" }
  module               = class;                 { "http://service.autorisations.legrain.fr/" }
  listeModules         = class;                 { "http://service.autorisations.legrain.fr/" }
  findByTiersTypeProduitResponse = class;       { "http://service.autorisations.legrain.fr/" }
  CreateException      = class;                 { "http://service.autorisations.legrain.fr/"[F] }
  EJBException         = class;                 { "http://service.autorisations.legrain.fr/"[F] }
  FinderException      = class;                 { "http://service.autorisations.legrain.fr/"[F] }
  RemoveException      = class;                 { "http://service.autorisations.legrain.fr/"[F] }
  findWithNamedQueryDTO = class;                { "http://service.autorisations.legrain.fr/" }
  findWithJPQLQueryDTO = class;                 { "http://service.autorisations.legrain.fr/" }
  findByCodeDTO        = class;                 { "http://service.autorisations.legrain.fr/" }
  findByCode           = class;                 { "http://service.autorisations.legrain.fr/" }
  selectCountResponse  = class;                 { "http://service.autorisations.legrain.fr/" }
  findByTiersTypeProduit = class;               { "http://service.autorisations.legrain.fr/" }
  findByIdDTO          = class;                 { "http://service.autorisations.legrain.fr/" }
  findById             = class;                 { "http://service.autorisations.legrain.fr/" }
  taTypeProduit        = class;                 { "http://service.autorisations.legrain.fr/" }
  taAutorisations      = class;                 { "http://service.autorisations.legrain.fr/" }
  entityToDTO          = class;                 { "http://service.autorisations.legrain.fr/" }
  findByCodeResponse   = class;                 { "http://service.autorisations.legrain.fr/" }
  findByIdResponse     = class;                 { "http://service.autorisations.legrain.fr/" }
  merge                = class;                 { "http://service.autorisations.legrain.fr/" }
  mergeResponse        = class;                 { "http://service.autorisations.legrain.fr/" }
  mergeValidationContext = class;               { "http://service.autorisations.legrain.fr/" }
  mergeValidationContextResponse = class;       { "http://service.autorisations.legrain.fr/" }
  persist              = class;                 { "http://service.autorisations.legrain.fr/" }
  persistValidationContext = class;             { "http://service.autorisations.legrain.fr/" }
  remove               = class;                 { "http://service.autorisations.legrain.fr/" }
  validateEntity       = class;                 { "http://service.autorisations.legrain.fr/" }
  validateEntityProperty = class;               { "http://service.autorisations.legrain.fr/" }
  validateEntityPropertyValidationContext = class;   { "http://service.autorisations.legrain.fr/" }
  validateEntityValidationContext = class;      { "http://service.autorisations.legrain.fr/" }
  modelObject          = class;                 { "http://service.autorisations.legrain.fr/" }
  taAutorisationsDTO   = class;                 { "http://service.autorisations.legrain.fr/" }
  entityToDTOResponse  = class;                 { "http://service.autorisations.legrain.fr/" }
  error                = class;                 { "http://service.autorisations.legrain.fr/" }
  findByCodeDTOResponse = class;                { "http://service.autorisations.legrain.fr/" }
  findByIdDTOResponse  = class;                 { "http://service.autorisations.legrain.fr/" }
  mergeDTO             = class;                 { "http://service.autorisations.legrain.fr/" }
  mergeDTOValidationContext = class;            { "http://service.autorisations.legrain.fr/" }
  persistDTO           = class;                 { "http://service.autorisations.legrain.fr/" }
  persistDTOValidationContext = class;          { "http://service.autorisations.legrain.fr/" }
  removeDTO            = class;                 { "http://service.autorisations.legrain.fr/" }
  validateDTO          = class;                 { "http://service.autorisations.legrain.fr/" }
  validateDTOProperty  = class;                 { "http://service.autorisations.legrain.fr/" }
  validateDTOPropertyValidationContext = class;   { "http://service.autorisations.legrain.fr/" }
  validateDTOValidationContext = class;         { "http://service.autorisations.legrain.fr/" }
  selectAllResponse    = class;                 { "http://service.autorisations.legrain.fr/"[A] }
  selectAllDTOResponse = class;                 { "http://service.autorisations.legrain.fr/"[A] }
  listEntityToListDTOResponse = class;          { "http://service.autorisations.legrain.fr/"[A] }
  findWithNamedQueryDTOResponse = class;        { "http://service.autorisations.legrain.fr/"[A] }
  findWithJPQLQueryDTOResponse = class;         { "http://service.autorisations.legrain.fr/"[A] }
  listEntityToListDTO  = class;                 { "http://service.autorisations.legrain.fr/"[A] }



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  errorResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergeDTOResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergeDTOValidationContextResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  persistDTOResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  persistDTOValidationContextResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  persistResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  persistValidationContextResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  removeDTOResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  removeResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  selectAll = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  selectAllDTO = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  selectCount = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateDTOPropertyResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateDTOPropertyValidationContextResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateDTOResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateDTOValidationContextResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateEntityPropertyResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateEntityPropertyValidationContextResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateEntityResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateEntityValidationContextResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // ************************************************************************ //
  module = class(TRemotable)
  private
    Fnom_module: WideString;
  published
    property nom_module: WideString read Fnom_module write Fnom_module stored AS_ATTRIBUTE;
  end;

  modules    = array of module;                 { "http://service.autorisations.legrain.fr/" }


  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // ************************************************************************ //
  listeModules = class(TRemotable)
  private
    Fmodules: modules;
  public
    destructor Destroy; override;
  published
    property modules: modules read Fmodules write Fmodules;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findByTiersTypeProduitResponse = class(TRemotable)
  private
    Freturn: listeModules;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: listeModules read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // ************************************************************************ //
  CreateException = class(ERemotableException)
  private
    Fmessage: WideString;
  published
    property message: WideString read Fmessage write Fmessage;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // ************************************************************************ //
  EJBException = class(ERemotableException)
  private
    Fmessage: WideString;
  published
    property message: WideString read Fmessage write Fmessage;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // ************************************************************************ //
  FinderException = class(ERemotableException)
  private
    Fmessage: WideString;
  published
    property message: WideString read Fmessage write Fmessage;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // ************************************************************************ //
  RemoveException = class(ERemotableException)
  private
    Fmessage: WideString;
  published
    property message: WideString read Fmessage write Fmessage;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findWithNamedQueryDTO = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findWithJPQLQueryDTO = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findByCodeDTO = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findByCode = class(TRemotable)
  private
    Farg0: WideString;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  selectCountResponse = class(TRemotable)
  private
    Freturn: Integer;
  public
    constructor Create; override;
  published
    property return: Integer read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findByTiersTypeProduit = class(TRemotable)
  private
    Farg0: WideString;
    Farg1: Integer;
  public
    constructor Create; override;
  published
    property arg0: WideString read Farg0 write Farg0;
    property arg1: Integer read Farg1 write Farg1;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findByIdDTO = class(TRemotable)
  private
    Farg0: Integer;
  public
    constructor Create; override;
  published
    property arg0: Integer read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findById = class(TRemotable)
  private
    Farg0: Integer;
  public
    constructor Create; override;
  published
    property arg0: Integer read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // ************************************************************************ //
  taTypeProduit = class(TRemotable)
  private
    Fcode: WideString;
    FidType: Integer;
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
    property idType: Integer read FidType write FidType;
    property libelle: WideString read Flibelle write Flibelle;
    property quandCree: TXSDateTime read FquandCree write FquandCree;
    property quandModif: TXSDateTime read FquandModif write FquandModif;
    property quiCree: WideString read FquiCree write FquiCree;
    property quiModif: WideString read FquiModif write FquiModif;
    property versionObj: Integer read FversionObj write FversionObj;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // ************************************************************************ //
  taAutorisations = class(TRemotable)
  private
    FcheminFichierXlm: WideString;
    FcodeTiers: WideString;
    FidAutorisation: Integer;
    Fmodules: WideString;
    FquandCree: TXSDateTime;
    FquandModif: TXSDateTime;
    FquiCree: WideString;
    FquiModif: WideString;
    FtaTypeProduit: taTypeProduit;
    Fvalide: Boolean;
    FversionObj: Integer;
  public
    destructor Destroy; override;
  published
    property cheminFichierXlm: WideString read FcheminFichierXlm write FcheminFichierXlm;
    property codeTiers: WideString read FcodeTiers write FcodeTiers;
    property idAutorisation: Integer read FidAutorisation write FidAutorisation;
    property modules: WideString read Fmodules write Fmodules;
    property quandCree: TXSDateTime read FquandCree write FquandCree;
    property quandModif: TXSDateTime read FquandModif write FquandModif;
    property quiCree: WideString read FquiCree write FquiCree;
    property quiModif: WideString read FquiModif write FquiModif;
    property taTypeProduit: taTypeProduit read FtaTypeProduit write FtaTypeProduit;
    property valide: Boolean read Fvalide write Fvalide;
    property versionObj: Integer read FversionObj write FversionObj;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  entityToDTO = class(TRemotable)
  private
    Farg0: taAutorisations;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisations read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findByCodeResponse = class(TRemotable)
  private
    Freturn: taAutorisations;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taAutorisations read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findByIdResponse = class(TRemotable)
  private
    Freturn: taAutorisations;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taAutorisations read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  merge = class(TRemotable)
  private
    Farg0: taAutorisations;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisations read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergeResponse = class(TRemotable)
  private
    Freturn: taAutorisations;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taAutorisations read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergeValidationContext = class(TRemotable)
  private
    Farg0: taAutorisations;
    Farg1: WideString;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisations read Farg0 write Farg0;
    property arg1: WideString read Farg1 write Farg1;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergeValidationContextResponse = class(TRemotable)
  private
    Freturn: taAutorisations;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taAutorisations read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  persist = class(TRemotable)
  private
    Farg0: taAutorisations;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisations read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  persistValidationContext = class(TRemotable)
  private
    Farg0: taAutorisations;
    Farg1: WideString;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisations read Farg0 write Farg0;
    property arg1: WideString read Farg1 write Farg1;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  remove = class(TRemotable)
  private
    Farg0: taAutorisations;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisations read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateEntity = class(TRemotable)
  private
    Farg0: taAutorisations;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisations read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateEntityProperty = class(TRemotable)
  private
    Farg0: taAutorisations;
    Farg1: WideString;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisations read Farg0 write Farg0;
    property arg1: WideString read Farg1 write Farg1;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateEntityPropertyValidationContext = class(TRemotable)
  private
    Farg0: taAutorisations;
    Farg1: WideString;
    Farg2: WideString;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisations read Farg0 write Farg0;
    property arg1: WideString read Farg1 write Farg1;
    property arg2: WideString read Farg2 write Farg2;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateEntityValidationContext = class(TRemotable)
  private
    Farg0: taAutorisations;
    Farg1: WideString;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisations read Farg0 write Farg0;
    property arg1: WideString read Farg1 write Farg1;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // ************************************************************************ //
  modelObject = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // ************************************************************************ //
  taAutorisationsDTO = class(modelObject)
  private
    FcodeTiers: WideString;
    FcodeType: WideString;
    Fid: Integer;
    FidType: Integer;
    Fmodules: WideString;
    Fvalide: Boolean;
    FversionObj: Integer;
  published
    property codeTiers: WideString read FcodeTiers write FcodeTiers;
    property codeType: WideString read FcodeType write FcodeType;
    property id: Integer read Fid write Fid;
    property idType: Integer read FidType write FidType;
    property modules: WideString read Fmodules write Fmodules;
    property valide: Boolean read Fvalide write Fvalide;
    property versionObj: Integer read FversionObj write FversionObj;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  entityToDTOResponse = class(TRemotable)
  private
    Freturn: taAutorisationsDTO;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taAutorisationsDTO read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  error = class(TRemotable)
  private
    Farg0: taAutorisationsDTO;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisationsDTO read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findByCodeDTOResponse = class(TRemotable)
  private
    Freturn: taAutorisationsDTO;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taAutorisationsDTO read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  findByIdDTOResponse = class(TRemotable)
  private
    Freturn: taAutorisationsDTO;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property return: taAutorisationsDTO read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergeDTO = class(TRemotable)
  private
    Farg0: taAutorisationsDTO;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisationsDTO read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  mergeDTOValidationContext = class(TRemotable)
  private
    Farg0: taAutorisationsDTO;
    Farg1: WideString;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisationsDTO read Farg0 write Farg0;
    property arg1: WideString read Farg1 write Farg1;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  persistDTO = class(TRemotable)
  private
    Farg0: taAutorisationsDTO;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisationsDTO read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  persistDTOValidationContext = class(TRemotable)
  private
    Farg0: taAutorisationsDTO;
    Farg1: WideString;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisationsDTO read Farg0 write Farg0;
    property arg1: WideString read Farg1 write Farg1;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  removeDTO = class(TRemotable)
  private
    Farg0: taAutorisationsDTO;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisationsDTO read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateDTO = class(TRemotable)
  private
    Farg0: taAutorisationsDTO;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisationsDTO read Farg0 write Farg0;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateDTOProperty = class(TRemotable)
  private
    Farg0: taAutorisationsDTO;
    Farg1: WideString;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisationsDTO read Farg0 write Farg0;
    property arg1: WideString read Farg1 write Farg1;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateDTOPropertyValidationContext = class(TRemotable)
  private
    Farg0: taAutorisationsDTO;
    Farg1: WideString;
    Farg2: WideString;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisationsDTO read Farg0 write Farg0;
    property arg1: WideString read Farg1 write Farg1;
    property arg2: WideString read Farg2 write Farg2;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoLiteralParam]
  // ************************************************************************ //
  validateDTOValidationContext = class(TRemotable)
  private
    Farg0: taAutorisationsDTO;
    Farg1: WideString;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property arg0: taAutorisationsDTO read Farg0 write Farg0;
    property arg1: WideString read Farg1 write Farg1;
  end;

  return     = array of taAutorisations;        { "http://service.autorisations.legrain.fr/" }


  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  selectAllResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaAutorisationsArray(Index: Integer): taAutorisations;
    function   GettaAutorisationsArrayLength: Integer;
    property   taAutorisationsArray[Index: Integer]: taAutorisations read GettaAutorisationsArray; default;
    property   Len: Integer read GettaAutorisationsArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  selectAllDTOResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaAutorisationsArray(Index: Integer): taAutorisations;
    function   GettaAutorisationsArrayLength: Integer;
    property   taAutorisationsArray[Index: Integer]: taAutorisations read GettaAutorisationsArray; default;
    property   Len: Integer read GettaAutorisationsArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  listEntityToListDTOResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaAutorisationsArray(Index: Integer): taAutorisations;
    function   GettaAutorisationsArrayLength: Integer;
    property   taAutorisationsArray[Index: Integer]: taAutorisations read GettaAutorisationsArray; default;
    property   Len: Integer read GettaAutorisationsArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  findWithNamedQueryDTOResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaAutorisationsArray(Index: Integer): taAutorisations;
    function   GettaAutorisationsArrayLength: Integer;
    property   taAutorisationsArray[Index: Integer]: taAutorisations read GettaAutorisationsArray; default;
    property   Len: Integer read GettaAutorisationsArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;



  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  findWithJPQLQueryDTOResponse = class(TRemotable)
  private
    Freturn: return;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaAutorisationsArray(Index: Integer): taAutorisations;
    function   GettaAutorisationsArrayLength: Integer;
    property   taAutorisationsArray[Index: Integer]: taAutorisations read GettaAutorisationsArray; default;
    property   Len: Integer read GettaAutorisationsArrayLength;
  published
    property return: return read Freturn write Freturn;
  end;

  arg0       = array of taAutorisations;        { "http://service.autorisations.legrain.fr/" }


  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // Serializtn : [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  listEntityToListDTO = class(TRemotable)
  private
    Farg0: arg0;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GettaAutorisationsArray(Index: Integer): taAutorisations;
    function   GettaAutorisationsArrayLength: Integer;
    property   taAutorisationsArray[Index: Integer]: taAutorisations read GettaAutorisationsArray; default;
    property   Len: Integer read GettaAutorisationsArrayLength;
  published
    property arg0: arg0 read Farg0 write Farg0;
  end;


  // ************************************************************************ //
  // Espace de nommage : http://service.autorisations.legrain.fr/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // liaison   : TaAutorisationsServiceServiceSoapBinding
  // service   : TaAutorisationsServiceService
  // port      : TaAutorisationsServicePort
  // URL       : http://localhost:8888/fr.legrain.autorisations.ejb/TaAutorisationsService
  // ************************************************************************ //
  TaAutorisationsService = interface(IInvokable)
  ['{BF39F08A-E21B-2BFA-15EE-2EDE183452AA}']
    function  removeDTO(const parameters: removeDTO): removeDTOResponse; stdcall;
    function  findById(const parameters: findById): findByIdResponse; stdcall;
    function  validateDTOPropertyValidationContext(const parameters: validateDTOPropertyValidationContext): validateDTOPropertyValidationContextResponse; stdcall;
    function  remove(const parameters: remove): removeResponse; stdcall;
    function  merge(const parameters: merge): mergeResponse; stdcall;
    function  mergeDTOValidationContext(const parameters: mergeDTOValidationContext): mergeDTOValidationContextResponse; stdcall;
    function  selectAllDTO(const parameters: selectAllDTO): selectAllDTOResponse; stdcall;
    function  persistDTOValidationContext(const parameters: persistDTOValidationContext): persistDTOValidationContextResponse; stdcall;
    function  findByCode(const parameters: findByCode): findByCodeResponse; stdcall;
    function  validateEntityValidationContext(const parameters: validateEntityValidationContext): validateEntityValidationContextResponse; stdcall;
    function  selectAll(const parameters: selectAll): selectAllResponse; stdcall;
    function  findByCodeDTO(const parameters: findByCodeDTO): findByCodeDTOResponse; stdcall;
    function  findByIdDTO(const parameters: findByIdDTO): findByIdDTOResponse; stdcall;
    function  listEntityToListDTO(const parameters: listEntityToListDTO): listEntityToListDTOResponse; stdcall;
    function  selectCount(const parameters: selectCount): selectCountResponse; stdcall;
    function  validateDTOValidationContext(const parameters: validateDTOValidationContext): validateDTOValidationContextResponse; stdcall;
    function  findByTiersTypeProduit(const parameters: findByTiersTypeProduit): findByTiersTypeProduitResponse; stdcall;
    function  validateDTO(const parameters: validateDTO): validateDTOResponse; stdcall;
    function  entityToDTO(const parameters: entityToDTO): entityToDTOResponse; stdcall;
    function  persistValidationContext(const parameters: persistValidationContext): persistValidationContextResponse; stdcall;
    function  validateEntity(const parameters: validateEntity): validateEntityResponse; stdcall;
    function  persist(const parameters: persist): persistResponse; stdcall;
    function  validateEntityPropertyValidationContext(const parameters: validateEntityPropertyValidationContext): validateEntityPropertyValidationContextResponse; stdcall;
    function  validateEntityProperty(const parameters: validateEntityProperty): validateEntityPropertyResponse; stdcall;
    function  findWithNamedQueryDTO(const parameters: findWithNamedQueryDTO): findWithNamedQueryDTOResponse; stdcall;
    function  mergeValidationContext(const parameters: mergeValidationContext): mergeValidationContextResponse; stdcall;
    function  validateDTOProperty(const parameters: validateDTOProperty): validateDTOPropertyResponse; stdcall;
    function  persistDTO(const parameters: persistDTO): persistDTOResponse; stdcall;
    function  error(const parameters: error): errorResponse; stdcall;
    function  findWithJPQLQueryDTO(const parameters: findWithJPQLQueryDTO): findWithJPQLQueryDTOResponse; stdcall;
    function  mergeDTO(const parameters: mergeDTO): mergeDTOResponse; stdcall;
  end;

function GetTaAutorisationsService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): TaAutorisationsService;


implementation

function GetTaAutorisationsService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): TaAutorisationsService;
const
  defWSDL = 'http://localhost:8888/fr.legrain.autorisations.ejb/TaAutorisationsService?wsdl';
  defURL  = 'http://localhost:8888/fr.legrain.autorisations.ejb/TaAutorisationsService';
  defSvc  = 'TaAutorisationsServiceService';
  defPrt  = 'TaAutorisationsServicePort';
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
    Result := (RIO as TaAutorisationsService);
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


constructor errorResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor mergeDTOResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor mergeDTOValidationContextResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor persistDTOResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor persistDTOValidationContextResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor persistResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor persistValidationContextResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor removeDTOResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor removeResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor selectAll.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor selectAllDTO.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor selectCount.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor validateDTOPropertyResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor validateDTOPropertyValidationContextResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor validateDTOResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor validateDTOValidationContextResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor validateEntityPropertyResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor validateEntityPropertyValidationContextResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor validateEntityResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor validateEntityValidationContextResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor listeModules.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fmodules)-1 do
    if Assigned(Fmodules[I]) then
      Fmodules[I].Free;
  SetLength(Fmodules, 0);
  inherited Destroy;
end;

constructor findByTiersTypeProduitResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor findByTiersTypeProduitResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor findWithNamedQueryDTO.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findWithJPQLQueryDTO.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findByCodeDTO.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findByCode.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor selectCountResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findByTiersTypeProduit.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findByIdDTO.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor findById.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor taTypeProduit.Destroy;
begin
  if Assigned(FquandCree) then
    FquandCree.Free;
  if Assigned(FquandModif) then
    FquandModif.Free;
  inherited Destroy;
end;

destructor taAutorisations.Destroy;
begin
  if Assigned(FquandCree) then
    FquandCree.Free;
  if Assigned(FquandModif) then
    FquandModif.Free;
  if Assigned(FtaTypeProduit) then
    FtaTypeProduit.Free;
  inherited Destroy;
end;

constructor entityToDTO.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor entityToDTO.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor findByCodeResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor findByCodeResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor findByIdResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor findByIdResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor merge.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor merge.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor mergeResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor mergeResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor mergeValidationContext.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor mergeValidationContext.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor mergeValidationContextResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor mergeValidationContextResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor persist.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor persist.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor persistValidationContext.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor persistValidationContext.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor remove.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor remove.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor validateEntity.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor validateEntity.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor validateEntityProperty.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor validateEntityProperty.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor validateEntityPropertyValidationContext.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor validateEntityPropertyValidationContext.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor validateEntityValidationContext.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor validateEntityValidationContext.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor entityToDTOResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor entityToDTOResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor error.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor error.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor findByCodeDTOResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor findByCodeDTOResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor findByIdDTOResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor findByIdDTOResponse.Destroy;
begin
  if Assigned(Freturn) then
    Freturn.Free;
  inherited Destroy;
end;

constructor mergeDTO.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor mergeDTO.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor mergeDTOValidationContext.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor mergeDTOValidationContext.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor persistDTO.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor persistDTO.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor persistDTOValidationContext.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor persistDTOValidationContext.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor removeDTO.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor removeDTO.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor validateDTO.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor validateDTO.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor validateDTOProperty.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor validateDTOProperty.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor validateDTOPropertyValidationContext.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor validateDTOPropertyValidationContext.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor validateDTOValidationContext.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor validateDTOValidationContext.Destroy;
begin
  if Assigned(Farg0) then
    Farg0.Free;
  inherited Destroy;
end;

constructor selectAllResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor selectAllResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function selectAllResponse.GettaAutorisationsArray(Index: Integer): taAutorisations;
begin
  Result := Freturn[Index];
end;

function selectAllResponse.GettaAutorisationsArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

constructor selectAllDTOResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor selectAllDTOResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function selectAllDTOResponse.GettaAutorisationsArray(Index: Integer): taAutorisations;
begin
  Result := Freturn[Index];
end;

function selectAllDTOResponse.GettaAutorisationsArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

constructor listEntityToListDTOResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor listEntityToListDTOResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function listEntityToListDTOResponse.GettaAutorisationsArray(Index: Integer): taAutorisations;
begin
  Result := Freturn[Index];
end;

function listEntityToListDTOResponse.GettaAutorisationsArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

constructor findWithNamedQueryDTOResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor findWithNamedQueryDTOResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function findWithNamedQueryDTOResponse.GettaAutorisationsArray(Index: Integer): taAutorisations;
begin
  Result := Freturn[Index];
end;

function findWithNamedQueryDTOResponse.GettaAutorisationsArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

constructor findWithJPQLQueryDTOResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor findWithJPQLQueryDTOResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Freturn)-1 do
    if Assigned(Freturn[I]) then
      Freturn[I].Free;
  SetLength(Freturn, 0);
  inherited Destroy;
end;

function findWithJPQLQueryDTOResponse.GettaAutorisationsArray(Index: Integer): taAutorisations;
begin
  Result := Freturn[Index];
end;

function findWithJPQLQueryDTOResponse.GettaAutorisationsArrayLength: Integer;
begin
  if Assigned(Freturn) then
    Result := Length(Freturn)
  else
  Result := 0;
end;

constructor listEntityToListDTO.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

destructor listEntityToListDTO.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Farg0)-1 do
    if Assigned(Farg0[I]) then
      Farg0[I].Free;
  SetLength(Farg0, 0);
  inherited Destroy;
end;

function listEntityToListDTO.GettaAutorisationsArray(Index: Integer): taAutorisations;
begin
  Result := Farg0[Index];
end;

function listEntityToListDTO.GettaAutorisationsArrayLength: Integer;
begin
  if Assigned(Farg0) then
    Result := Length(Farg0)
  else
  Result := 0;
end;

initialization
 //InvRegistry.RegisterInterface(TypeInfo(EconomicWebServiceSoap),'http://e-conomic.com', 'utf-8');
  //InvRegistry.RegisterDefaultSOAPAction(TypeInfo(EconomicWebServiceSoap),'http://e-conomic.com/%operationName%');
  //InvRegistry.RegisterInvokeOptions(TypeInfo(EconomicWebServiceSoap), ioDocument);

  InvRegistry.RegisterInterface(TypeInfo(TaAutorisationsService), 'http://service.autorisations.legrain.fr/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(TaAutorisationsService), 'http://service.autorisations.legrain.fr/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(TaAutorisationsService), ioDocument);

  InvRegistry.RegisterInvokeOptions(TypeInfo(TaAutorisationsService), ioLiteral);
  RemClassRegistry.RegisterXSClass(errorResponse, 'http://service.autorisations.legrain.fr/', 'errorResponse');
  RemClassRegistry.RegisterSerializeOptions(errorResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergeDTOResponse, 'http://service.autorisations.legrain.fr/', 'mergeDTOResponse');
  RemClassRegistry.RegisterSerializeOptions(mergeDTOResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergeDTOValidationContextResponse, 'http://service.autorisations.legrain.fr/', 'mergeDTOValidationContextResponse');
  RemClassRegistry.RegisterSerializeOptions(mergeDTOValidationContextResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(persistDTOResponse, 'http://service.autorisations.legrain.fr/', 'persistDTOResponse');
  RemClassRegistry.RegisterSerializeOptions(persistDTOResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(persistDTOValidationContextResponse, 'http://service.autorisations.legrain.fr/', 'persistDTOValidationContextResponse');
  RemClassRegistry.RegisterSerializeOptions(persistDTOValidationContextResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(persistResponse, 'http://service.autorisations.legrain.fr/', 'persistResponse');
  RemClassRegistry.RegisterSerializeOptions(persistResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(persistValidationContextResponse, 'http://service.autorisations.legrain.fr/', 'persistValidationContextResponse');
  RemClassRegistry.RegisterSerializeOptions(persistValidationContextResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(removeDTOResponse, 'http://service.autorisations.legrain.fr/', 'removeDTOResponse');
  RemClassRegistry.RegisterSerializeOptions(removeDTOResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(removeResponse, 'http://service.autorisations.legrain.fr/', 'removeResponse');
  RemClassRegistry.RegisterSerializeOptions(removeResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectAll, 'http://service.autorisations.legrain.fr/', 'selectAll');
  RemClassRegistry.RegisterSerializeOptions(selectAll, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectAllDTO, 'http://service.autorisations.legrain.fr/', 'selectAllDTO');
  RemClassRegistry.RegisterSerializeOptions(selectAllDTO, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectCount, 'http://service.autorisations.legrain.fr/', 'selectCount');
  RemClassRegistry.RegisterSerializeOptions(selectCount, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateDTOPropertyResponse, 'http://service.autorisations.legrain.fr/', 'validateDTOPropertyResponse');
  RemClassRegistry.RegisterSerializeOptions(validateDTOPropertyResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateDTOPropertyValidationContextResponse, 'http://service.autorisations.legrain.fr/', 'validateDTOPropertyValidationContextResponse');
  RemClassRegistry.RegisterSerializeOptions(validateDTOPropertyValidationContextResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateDTOResponse, 'http://service.autorisations.legrain.fr/', 'validateDTOResponse');
  RemClassRegistry.RegisterSerializeOptions(validateDTOResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateDTOValidationContextResponse, 'http://service.autorisations.legrain.fr/', 'validateDTOValidationContextResponse');
  RemClassRegistry.RegisterSerializeOptions(validateDTOValidationContextResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateEntityPropertyResponse, 'http://service.autorisations.legrain.fr/', 'validateEntityPropertyResponse');
  RemClassRegistry.RegisterSerializeOptions(validateEntityPropertyResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateEntityPropertyValidationContextResponse, 'http://service.autorisations.legrain.fr/', 'validateEntityPropertyValidationContextResponse');
  RemClassRegistry.RegisterSerializeOptions(validateEntityPropertyValidationContextResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateEntityResponse, 'http://service.autorisations.legrain.fr/', 'validateEntityResponse');
  RemClassRegistry.RegisterSerializeOptions(validateEntityResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateEntityValidationContextResponse, 'http://service.autorisations.legrain.fr/', 'validateEntityValidationContextResponse');
  RemClassRegistry.RegisterSerializeOptions(validateEntityValidationContextResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(module, 'http://service.autorisations.legrain.fr/', 'module');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(module), 'nom_module', 'nom-module');
  RemClassRegistry.RegisterXSInfo(TypeInfo(modules), 'http://service.autorisations.legrain.fr/', 'modules');
  RemClassRegistry.RegisterXSClass(listeModules, 'http://service.autorisations.legrain.fr/', 'listeModules');
  RemClassRegistry.RegisterXSClass(findByTiersTypeProduitResponse, 'http://service.autorisations.legrain.fr/', 'findByTiersTypeProduitResponse');
  RemClassRegistry.RegisterSerializeOptions(findByTiersTypeProduitResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(CreateException, 'http://service.autorisations.legrain.fr/', 'CreateException');
  RemClassRegistry.RegisterXSClass(EJBException, 'http://service.autorisations.legrain.fr/', 'EJBException');
  RemClassRegistry.RegisterXSClass(FinderException, 'http://service.autorisations.legrain.fr/', 'FinderException');
  RemClassRegistry.RegisterXSClass(RemoveException, 'http://service.autorisations.legrain.fr/', 'RemoveException');
  RemClassRegistry.RegisterXSClass(findWithNamedQueryDTO, 'http://service.autorisations.legrain.fr/', 'findWithNamedQueryDTO');
  RemClassRegistry.RegisterSerializeOptions(findWithNamedQueryDTO, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findWithJPQLQueryDTO, 'http://service.autorisations.legrain.fr/', 'findWithJPQLQueryDTO');
  RemClassRegistry.RegisterSerializeOptions(findWithJPQLQueryDTO, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findByCodeDTO, 'http://service.autorisations.legrain.fr/', 'findByCodeDTO');
  RemClassRegistry.RegisterSerializeOptions(findByCodeDTO, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findByCode, 'http://service.autorisations.legrain.fr/', 'findByCode');
  RemClassRegistry.RegisterSerializeOptions(findByCode, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectCountResponse, 'http://service.autorisations.legrain.fr/', 'selectCountResponse');
  RemClassRegistry.RegisterSerializeOptions(selectCountResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findByTiersTypeProduit, 'http://service.autorisations.legrain.fr/', 'findByTiersTypeProduit');
  RemClassRegistry.RegisterSerializeOptions(findByTiersTypeProduit, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findByIdDTO, 'http://service.autorisations.legrain.fr/', 'findByIdDTO');
  RemClassRegistry.RegisterSerializeOptions(findByIdDTO, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findById, 'http://service.autorisations.legrain.fr/', 'findById');
  RemClassRegistry.RegisterSerializeOptions(findById, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(taTypeProduit, 'http://service.autorisations.legrain.fr/', 'taTypeProduit');
  RemClassRegistry.RegisterXSClass(taAutorisations, 'http://service.autorisations.legrain.fr/', 'taAutorisations');
  RemClassRegistry.RegisterXSClass(entityToDTO, 'http://service.autorisations.legrain.fr/', 'entityToDTO');
  RemClassRegistry.RegisterSerializeOptions(entityToDTO, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findByCodeResponse, 'http://service.autorisations.legrain.fr/', 'findByCodeResponse');
  RemClassRegistry.RegisterSerializeOptions(findByCodeResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findByIdResponse, 'http://service.autorisations.legrain.fr/', 'findByIdResponse');
  RemClassRegistry.RegisterSerializeOptions(findByIdResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(merge, 'http://service.autorisations.legrain.fr/', 'merge');
  RemClassRegistry.RegisterSerializeOptions(merge, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergeResponse, 'http://service.autorisations.legrain.fr/', 'mergeResponse');
  RemClassRegistry.RegisterSerializeOptions(mergeResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergeValidationContext, 'http://service.autorisations.legrain.fr/', 'mergeValidationContext');
  RemClassRegistry.RegisterSerializeOptions(mergeValidationContext, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergeValidationContextResponse, 'http://service.autorisations.legrain.fr/', 'mergeValidationContextResponse');
  RemClassRegistry.RegisterSerializeOptions(mergeValidationContextResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(persist, 'http://service.autorisations.legrain.fr/', 'persist');
  RemClassRegistry.RegisterSerializeOptions(persist, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(persistValidationContext, 'http://service.autorisations.legrain.fr/', 'persistValidationContext');
  RemClassRegistry.RegisterSerializeOptions(persistValidationContext, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(remove, 'http://service.autorisations.legrain.fr/', 'remove');
  RemClassRegistry.RegisterSerializeOptions(remove, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateEntity, 'http://service.autorisations.legrain.fr/', 'validateEntity');
  RemClassRegistry.RegisterSerializeOptions(validateEntity, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateEntityProperty, 'http://service.autorisations.legrain.fr/', 'validateEntityProperty');
  RemClassRegistry.RegisterSerializeOptions(validateEntityProperty, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateEntityPropertyValidationContext, 'http://service.autorisations.legrain.fr/', 'validateEntityPropertyValidationContext');
  RemClassRegistry.RegisterSerializeOptions(validateEntityPropertyValidationContext, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateEntityValidationContext, 'http://service.autorisations.legrain.fr/', 'validateEntityValidationContext');
  RemClassRegistry.RegisterSerializeOptions(validateEntityValidationContext, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(modelObject, 'http://service.autorisations.legrain.fr/', 'modelObject');
  RemClassRegistry.RegisterXSClass(taAutorisationsDTO, 'http://service.autorisations.legrain.fr/', 'taAutorisationsDTO');
  RemClassRegistry.RegisterXSClass(entityToDTOResponse, 'http://service.autorisations.legrain.fr/', 'entityToDTOResponse');
  RemClassRegistry.RegisterSerializeOptions(entityToDTOResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(error, 'http://service.autorisations.legrain.fr/', 'error');
  RemClassRegistry.RegisterSerializeOptions(error, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findByCodeDTOResponse, 'http://service.autorisations.legrain.fr/', 'findByCodeDTOResponse');
  RemClassRegistry.RegisterSerializeOptions(findByCodeDTOResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findByIdDTOResponse, 'http://service.autorisations.legrain.fr/', 'findByIdDTOResponse');
  RemClassRegistry.RegisterSerializeOptions(findByIdDTOResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergeDTO, 'http://service.autorisations.legrain.fr/', 'mergeDTO');
  RemClassRegistry.RegisterSerializeOptions(mergeDTO, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(mergeDTOValidationContext, 'http://service.autorisations.legrain.fr/', 'mergeDTOValidationContext');
  RemClassRegistry.RegisterSerializeOptions(mergeDTOValidationContext, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(persistDTO, 'http://service.autorisations.legrain.fr/', 'persistDTO');
  RemClassRegistry.RegisterSerializeOptions(persistDTO, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(persistDTOValidationContext, 'http://service.autorisations.legrain.fr/', 'persistDTOValidationContext');
  RemClassRegistry.RegisterSerializeOptions(persistDTOValidationContext, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(removeDTO, 'http://service.autorisations.legrain.fr/', 'removeDTO');
  RemClassRegistry.RegisterSerializeOptions(removeDTO, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateDTO, 'http://service.autorisations.legrain.fr/', 'validateDTO');
  RemClassRegistry.RegisterSerializeOptions(validateDTO, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateDTOProperty, 'http://service.autorisations.legrain.fr/', 'validateDTOProperty');
  RemClassRegistry.RegisterSerializeOptions(validateDTOProperty, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateDTOPropertyValidationContext, 'http://service.autorisations.legrain.fr/', 'validateDTOPropertyValidationContext');
  RemClassRegistry.RegisterSerializeOptions(validateDTOPropertyValidationContext, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(validateDTOValidationContext, 'http://service.autorisations.legrain.fr/', 'validateDTOValidationContext');
  RemClassRegistry.RegisterSerializeOptions(validateDTOValidationContext, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(return), 'http://service.autorisations.legrain.fr/', 'return');
  RemClassRegistry.RegisterXSClass(selectAllResponse, 'http://service.autorisations.legrain.fr/', 'selectAllResponse');
  RemClassRegistry.RegisterSerializeOptions(selectAllResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(selectAllDTOResponse, 'http://service.autorisations.legrain.fr/', 'selectAllDTOResponse');
  RemClassRegistry.RegisterSerializeOptions(selectAllDTOResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(listEntityToListDTOResponse, 'http://service.autorisations.legrain.fr/', 'listEntityToListDTOResponse');
  RemClassRegistry.RegisterSerializeOptions(listEntityToListDTOResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findWithNamedQueryDTOResponse, 'http://service.autorisations.legrain.fr/', 'findWithNamedQueryDTOResponse');
  RemClassRegistry.RegisterSerializeOptions(findWithNamedQueryDTOResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(findWithJPQLQueryDTOResponse, 'http://service.autorisations.legrain.fr/', 'findWithJPQLQueryDTOResponse');
  RemClassRegistry.RegisterSerializeOptions(findWithJPQLQueryDTOResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(arg0), 'http://service.autorisations.legrain.fr/', 'arg0');
  RemClassRegistry.RegisterXSClass(listEntityToListDTO, 'http://service.autorisations.legrain.fr/', 'listEntityToListDTO');
  RemClassRegistry.RegisterSerializeOptions(listEntityToListDTO, [xoInlineArrays,xoLiteralParam]);

end. 