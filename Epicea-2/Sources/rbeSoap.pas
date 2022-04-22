// ************************************************************************ //
// Les types d�clar� dans ce fichier ont �t� g�n�r�s � partir de donn�es lues dans le fichier
// WSDL d�crit ci-dessous :
// WSDL     : http://rbe.legrain.fr/ws/rbeSoap?wsdl
// Encodage : utf-8
// Version  : 1.0
// (01/07/2015 11:42:05 - 1.33.2.5)
// ************************************************************************ //

unit rbeSoap;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // Les types suivants mentionn�s dans le document WSDL ne sont pas repr�sent�s
  // dans ce fichier. Ce sont soit des alias[@] de types repr�sent�s ou alors ils sont 
  // r�f�renc�s mais jamais[!] d�clar�s dans ce document. Les types de la derni�re cat�gorie
  // sont en principe mapp�s � des types Borland ou XML pr�d�finis/connus. Toutefois, ils peuvent aussi
  // signaler des documents WSDL incorrects n'ayant pas r�ussi � d�clarer ou importer un type de sch�ma.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:float           - "http://www.w3.org/2001/XMLSchema"
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"

  Complement           = class;                 { "http://rbe.legrain.fr/ws/RbeSoap/" }
  Mouvement            = class;                 { "http://rbe.legrain.fr/ws/RbeSoap/" }
  Entete               = class;                 { "http://rbe.legrain.fr/ws/RbeSoap/" }



  // ************************************************************************ //
  // Espace de nommage : http://rbe.legrain.fr/ws/RbeSoap/
  // ************************************************************************ //
  Complement = class(TRemotable)
  private
    Fid: Integer;
    FcodeOperationInterne: WideString;
    FcodeOperationInterbancaire: WideString;
    FdateComptabilisationOperation: WideString;
    Fqualifiant: WideString;
    FinformationsComplementaires: WideString;
  published
    property id: Integer read Fid write Fid;
    property codeOperationInterne: WideString read FcodeOperationInterne write FcodeOperationInterne;
    property codeOperationInterbancaire: WideString read FcodeOperationInterbancaire write FcodeOperationInterbancaire;
    property dateComptabilisationOperation: WideString read FdateComptabilisationOperation write FdateComptabilisationOperation;
    property qualifiant: WideString read Fqualifiant write Fqualifiant;
    property informationsComplementaires: WideString read FinformationsComplementaires write FinformationsComplementaires;
  end;

  ArrayOfComplement = array of Complement;      { "http://rbe.legrain.fr/ws/RbeSoap/" }


  // ************************************************************************ //
  // Espace de nommage : http://rbe.legrain.fr/ws/RbeSoap/
  // ************************************************************************ //
  Mouvement = class(TRemotable)
  private
    Fid: Integer;
    FcodeOperationInterne: WideString;
    FcodeOperationInterbancaire: WideString;
    FdateComptabilisationOperation: WideString;
    FcodeMotifRejet: Integer;
    FdateValeur: WideString;
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
    property dateComptabilisationOperation: WideString read FdateComptabilisationOperation write FdateComptabilisationOperation;
    property codeMotifRejet: Integer read FcodeMotifRejet write FcodeMotifRejet;
    property dateValeur: WideString read FdateValeur write FdateValeur;
    property libelle: WideString read Flibelle write Flibelle;
    property numeroEcriture: Integer read FnumeroEcriture write FnumeroEcriture;
    property indiceExoneration: WideString read FindiceExoneration write FindiceExoneration;
    property indiceIndisponibilite: WideString read FindiceIndisponibilite write FindiceIndisponibilite;
    property montantMouvement: Single read FmontantMouvement write FmontantMouvement;
    property zoneReference: WideString read FzoneReference write FzoneReference;
    property complements: ArrayOfComplement read Fcomplements write Fcomplements;
  end;

  ArrayOfMouvement = array of Mouvement;        { "http://rbe.legrain.fr/ws/RbeSoap/" }


  // ************************************************************************ //
  // Espace de nommage : http://rbe.legrain.fr/ws/RbeSoap/
  // ************************************************************************ //
  Entete = class(TRemotable)
  private
    Fid: Integer;
    FcodeBanque: WideString;
    FcodeGuichet: WideString;
    FcodeDevise: WideString;
    FnumeroCompte: WideString;
    FdateAncienSolde: WideString;
    FmontantAncienSolde: Single;
    FdateNouveauSolde: WideString;
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
    property dateAncienSolde: WideString read FdateAncienSolde write FdateAncienSolde;
    property montantAncienSolde: Single read FmontantAncienSolde write FmontantAncienSolde;
    property dateNouveauSolde: WideString read FdateNouveauSolde write FdateNouveauSolde;
    property montantNouveauSolde: Single read FmontantNouveauSolde write FmontantNouveauSolde;
    property mouvements: ArrayOfMouvement read Fmouvements write Fmouvements;
  end;

  ArrayOfEntete = array of Entete;              { "http://rbe.legrain.fr/ws/RbeSoap/" }

  // ************************************************************************ //
  // Espace de nommage : http://rbe.legrain.fr/ws/RbeSoap/
  // soapAction : http://rbe.legrain.fr/ws/RbeSoap/listRelevesBancaires
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // liaison   : RbeSoapBinding
  // service   : RbeSoapService
  // port      : RbeSoapPort
  // URL       : http://rbe.legrain.fr/ws/rbeSoap
  // ************************************************************************ //
  RbeSoapPortType = interface(IInvokable)
  ['{6C6E7578-386A-1EDC-0526-9421E738E385}']
    function  listRelevesBancaires(const username: WideString; const password: WideString; const codeBanque: WideString; const codeGuichet: WideString; const numeroCompte: WideString; const dateDebut: WideString; const dateFin: WideString; const dejaReleve: Boolean): ArrayOfEntete; stdcall;
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


destructor Mouvement.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(Fcomplements)-1 do
    if Assigned(Fcomplements[I]) then
      Fcomplements[I].Free;
  SetLength(Fcomplements, 0);
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
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(RbeSoapPortType), 'http://rbe.legrain.fr/ws/RbeSoap/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(RbeSoapPortType), 'http://rbe.legrain.fr/ws/RbeSoap/listRelevesBancaires');
  InvRegistry.RegisterInvokeOptions(TypeInfo(RbeSoapPortType), ioLiteral);
  RemClassRegistry.RegisterXSClass(Complement, 'http://rbe.legrain.fr/ws/RbeSoap/', 'Complement');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfComplement), 'http://rbe.legrain.fr/ws/RbeSoap/', 'ArrayOfComplement');
  RemClassRegistry.RegisterXSClass(Mouvement, 'http://rbe.legrain.fr/ws/RbeSoap/', 'Mouvement');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfMouvement), 'http://rbe.legrain.fr/ws/RbeSoap/', 'ArrayOfMouvement');
  RemClassRegistry.RegisterXSClass(Entete, 'http://rbe.legrain.fr/ws/RbeSoap/', 'Entete');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfEntete), 'http://rbe.legrain.fr/ws/RbeSoap/', 'ArrayOfEntete');

end. 