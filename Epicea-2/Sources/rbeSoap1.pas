// ************************************************************************ //
// Les types déclaré dans ce fichier ont été générés à partir de données lues dans le fichier
// WSDL décrit ci-dessous :
// WSDL     : http://rbe.legrain.fr/ws/rbeSoap?wsdl
// Encodage : utf-8
// Version  : 1.0
// (29/06/2015 10:56:51 - 1.33.2.5)
// ************************************************************************ //

unit rbeSoap1;

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
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:float           - "http://www.w3.org/2001/XMLSchema"
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"

  datetime             = class;                 { "http://rbe.legrain.fr/ws/RbeApi/1.0/" }
  Complement           = class;                 { "http://rbe.legrain.fr/ws/RbeApi/1.0/" }
  Mouvement            = class;                 { "http://rbe.legrain.fr/ws/RbeApi/1.0/" }
  Entete               = class;                 { "http://rbe.legrain.fr/ws/RbeApi/1.0/" }



  // ************************************************************************ //
  // Espace de nommage : http://rbe.legrain.fr/ws/RbeApi/1.0/
  // ************************************************************************ //
  datetime = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // Espace de nommage : http://rbe.legrain.fr/ws/RbeApi/1.0/
  // ************************************************************************ //
  Complement = class(TRemotable)
  private
    Fid: Integer;
    FcodeOperationInterne: WideString;
    FcodeOperationInterbancaire: WideString;
    FdateComptabilisationOperation: datetime;
    Fqualifiant: WideString;
    FinformationsComplementaires: WideString;
  public
    destructor Destroy; override;
  published
    property id: Integer read Fid write Fid;
    property codeOperationInterne: WideString read FcodeOperationInterne write FcodeOperationInterne;
    property codeOperationInterbancaire: WideString read FcodeOperationInterbancaire write FcodeOperationInterbancaire;
    property dateComptabilisationOperation: datetime read FdateComptabilisationOperation write FdateComptabilisationOperation;
    property qualifiant: WideString read Fqualifiant write Fqualifiant;
    property informationsComplementaires: WideString read FinformationsComplementaires write FinformationsComplementaires;
  end;

  ArrayOfComplement = array of Complement;      { "http://rbe.legrain.fr/ws/RbeApi/1.0/" }


  // ************************************************************************ //
  // Espace de nommage : http://rbe.legrain.fr/ws/RbeApi/1.0/
  // ************************************************************************ //
  Mouvement = class(TRemotable)
  private
    Fid: Integer;
    FcodeOperationInterne: WideString;
    FcodeOperationInterbancaire: WideString;
    FdateComptabilisationOperation: datetime;
    FcodeMotifRejet: Integer;
    FdateValeur: datetime;
    Flibelle: WideString;
    FnumeroEcriture: Integer;
    FindiceExoneration: WideString;
    FindiceIndisponibilite: WideString;
    FmontantMouvement: Single;
    FzoneReference: WideString;
    Fcomplements: ArrayOfComplement;
  public
    destructor Destroy; override;
  published
    property id: Integer read Fid write Fid;
    property codeOperationInterne: WideString read FcodeOperationInterne write FcodeOperationInterne;
    property codeOperationInterbancaire: WideString read FcodeOperationInterbancaire write FcodeOperationInterbancaire;
    property dateComptabilisationOperation: datetime read FdateComptabilisationOperation write FdateComptabilisationOperation;
    property codeMotifRejet: Integer read FcodeMotifRejet write FcodeMotifRejet;
    property dateValeur: datetime read FdateValeur write FdateValeur;
    property libelle: WideString read Flibelle write Flibelle;
    property numeroEcriture: Integer read FnumeroEcriture write FnumeroEcriture;
    property indiceExoneration: WideString read FindiceExoneration write FindiceExoneration;
    property indiceIndisponibilite: WideString read FindiceIndisponibilite write FindiceIndisponibilite;
    property montantMouvement: Single read FmontantMouvement write FmontantMouvement;
    property zoneReference: WideString read FzoneReference write FzoneReference;
    property complements: ArrayOfComplement read Fcomplements write Fcomplements;
  end;

  ArrayOfMouvement = array of Mouvement;        { "http://rbe.legrain.fr/ws/RbeApi/1.0/" }


  // ************************************************************************ //
  // Espace de nommage : http://rbe.legrain.fr/ws/RbeApi/1.0/
  // ************************************************************************ //
  Entete = class(TRemotable)
  private
    Fid: Integer;
    FcodeBanque: WideString;
    FcodeGuichet: WideString;
    FcodeDevise: WideString;
    FnumeroCompte: WideString;
    FdateAncienSolde: datetime;
    FmontantAncienSolde: Single;
    FdateNouveauSolde: datetime;
    FmontantNouveauSolde: Single;
    Fmouvements: ArrayOfMouvement;
  public
    destructor Destroy; override;
  published
    property id: Integer read Fid write Fid;
    property codeBanque: WideString read FcodeBanque write FcodeBanque;
    property codeGuichet: WideString read FcodeGuichet write FcodeGuichet;
    property codeDevise: WideString read FcodeDevise write FcodeDevise;
    property numeroCompte: WideString read FnumeroCompte write FnumeroCompte;
    property dateAncienSolde: datetime read FdateAncienSolde write FdateAncienSolde;
    property montantAncienSolde: Single read FmontantAncienSolde write FmontantAncienSolde;
    property dateNouveauSolde: datetime read FdateNouveauSolde write FdateNouveauSolde;
    property montantNouveauSolde: Single read FmontantNouveauSolde write FmontantNouveauSolde;
    property mouvements: ArrayOfMouvement read Fmouvements write Fmouvements;
  end;

  ArrayOfEntete = array of Entete;              { "http://rbe.legrain.fr/ws/RbeApi/1.0/" }

  // ************************************************************************ //
  // Espace de nommage : http://rbe.legrain.fr/ws/RbeApi/1.0/
  // soapAction : http://rbe.legrain.fr/ws/RbeApi/1.0/listRelevesBancaires
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // liaison   : RbeSoapBinding
  // service   : RbeSoapService
  // port      : RbeSoapPort
  // URL       : http://rbe.legrain.fr/ws/rbeSoap
  // ************************************************************************ //
  RbeSoapPortType = interface(IInvokable)
  ['{64937855-DF88-578C-386F-533CDD5752D4}']
    function  listRelevesBancaires(const username: WideString; const password: WideString; const codeBanque: WideString; const codeGuichet: WideString; const numeroCompte: WideString; const dateDebut: Integer; const dateFin: Integer; const dejaReleve: Boolean): ArrayOfEntete; stdcall;
  end;

function GetRbeSoapPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): RbeSoapPortType;


implementation

function GetRbeSoapPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): RbeSoapPortType;
const
  defWSDL = 'http://rbe.legrain.fr/ws/rbeSoap?wsdl';
  defURL  = 'http://rbe.legrain.fr/ws/rbeSoap';
  defSvc  = 'RbeSoapService';
  defPrt  = 'RbeSoapPort';
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
    Result := (RIO as RbeSoapPortType);
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


destructor Complement.Destroy;
begin
  if Assigned(FdateComptabilisationOperation) then
    FdateComptabilisationOperation.Free;
  inherited Destroy;
end;

destructor Mouvement.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fcomplements)-1 do
    if Assigned(Fcomplements[I]) then
      Fcomplements[I].Free;
  SetLength(Fcomplements, 0);
  if Assigned(FdateComptabilisationOperation) then
    FdateComptabilisationOperation.Free;
  if Assigned(FdateValeur) then
    FdateValeur.Free;
  inherited Destroy;
end;

destructor Entete.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fmouvements)-1 do
    if Assigned(Fmouvements[I]) then
      Fmouvements[I].Free;
  SetLength(Fmouvements, 0);
  if Assigned(FdateAncienSolde) then
    FdateAncienSolde.Free;
  if Assigned(FdateNouveauSolde) then
    FdateNouveauSolde.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(RbeSoapPortType), 'http://rbe.legrain.fr/ws/RbeApi/1.0/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(RbeSoapPortType), 'http://rbe.legrain.fr/ws/RbeApi/1.0/listRelevesBancaires');
  InvRegistry.RegisterInvokeOptions(TypeInfo(RbeSoapPortType), ioLiteral);
  RemClassRegistry.RegisterXSClass(datetime, 'http://rbe.legrain.fr/ws/RbeApi/1.0/', 'datetime');
  RemClassRegistry.RegisterXSClass(Complement, 'http://rbe.legrain.fr/ws/RbeApi/1.0/', 'Complement');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfComplement), 'http://rbe.legrain.fr/ws/RbeApi/1.0/', 'ArrayOfComplement');
  RemClassRegistry.RegisterXSClass(Mouvement, 'http://rbe.legrain.fr/ws/RbeApi/1.0/', 'Mouvement');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfMouvement), 'http://rbe.legrain.fr/ws/RbeApi/1.0/', 'ArrayOfMouvement');
  RemClassRegistry.RegisterXSClass(Entete, 'http://rbe.legrain.fr/ws/RbeApi/1.0/', 'Entete');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfEntete), 'http://rbe.legrain.fr/ws/RbeApi/1.0/', 'ArrayOfEntete');

end. 