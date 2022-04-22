
{********************************************************************************}
{                                                                                }
{                             Liaison de données XML                             }
{                                                                                }
{         Généré le : 27/03/2015 13:23:13                                        }
{       Généré depuis : C:\LGRDOSS\EPICEA\essai_autorisations_epicea.xml         }
{   Paramètres stockés dans : C:\LGRDOSS\EPICEA\essai_autorisations_epicea.xdb   }
{                                                                                }
{********************************************************************************}

unit essai_autorisations_epicea;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Décl. Forward }

  IXMLAutorisation = interface;
  IXMLModulesType = interface;
  IXMLModuleType = interface;

{ IXMLAutorisation }

  IXMLAutorisation = interface(IXMLNode)
    ['{301042D0-D9BA-476A-8C53-523BDCA8F341}']
    { Accesseurs de propriétés }
    function Get_Modules: IXMLModulesType;
    { Méthodes & propriétés }
    property Modules: IXMLModulesType read Get_Modules;
  end;

{ IXMLModulesType }

  IXMLModulesType = interface(IXMLNodeCollection)
    ['{9D638CFD-06DE-4A64-8535-AC82A2C8B2B8}']
    { Accesseurs de propriétés }
    function Get_Module(Index: Integer): IXMLModuleType;
    { Méthodes & propriétés }
    function Add: IXMLModuleType;
    function Insert(const Index: Integer): IXMLModuleType;
    property Module[Index: Integer]: IXMLModuleType read Get_Module; default;
  end;

{ IXMLModuleType }

  IXMLModuleType = interface(IXMLNode)
    ['{179BC688-CEF8-4316-A36B-C7A143D196E0}']
    { Accesseurs de propriétés }
    function Get_Nommodule: WideString;
    procedure Set_Nommodule(Value: WideString);
    { Méthodes & propriétés }
    property Nommodule: WideString read Get_Nommodule write Set_Nommodule;
  end;

{ Décl. Forward }

  TXMLAuthType = class;
  TXMLModulesType = class;
  TXMLModuleType = class;

{ TXMLAuthType }

  TXMLAuthType = class(TXMLNode, IXMLAutorisation)
  protected
    { IXMLAutorisation }
    function Get_Modules: IXMLModulesType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLModulesType }

  TXMLModulesType = class(TXMLNodeCollection, IXMLModulesType)
  protected
    { IXMLModulesType }
    function Get_Module(Index: Integer): IXMLModuleType;
    function Add: IXMLModuleType;
    function Insert(const Index: Integer): IXMLModuleType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLModuleType }

  TXMLModuleType = class(TXMLNode, IXMLModuleType)
  protected
    { IXMLModuleType }
    function Get_Nommodule: WideString;
    procedure Set_Nommodule(Value: WideString);
  end;

{ Fonctions globales }

function Getauth(Doc: IXMLDocument): IXMLAutorisation;
function Loadauth(const FileName: WideString): IXMLAutorisation;
function Newauth: IXMLAutorisation;

const
  TargetNamespace = '';

implementation

{ Fonctions globales }

function Getauth(Doc: IXMLDocument): IXMLAutorisation;
begin
  Result := Doc.GetDocBinding('auth', TXMLAuthType, TargetNamespace) as IXMLAutorisation;
end;

function Loadauth(const FileName: WideString): IXMLAutorisation;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('auth', TXMLAuthType, TargetNamespace) as IXMLAutorisation;
end;

function Newauth: IXMLAutorisation;
begin
  Result := NewXMLDocument.GetDocBinding('auth', TXMLAuthType, TargetNamespace) as IXMLAutorisation;
end;

{ TXMLAuthType }

procedure TXMLAuthType.AfterConstruction;
begin
  RegisterChildNode('modules', TXMLModulesType);
  inherited;
end;

function TXMLAuthType.Get_Modules: IXMLModulesType;
begin
  Result := ChildNodes['modules'] as IXMLModulesType;
end;

{ TXMLModulesType }

procedure TXMLModulesType.AfterConstruction;
begin
  RegisterChildNode('module', TXMLModuleType);
  ItemTag := 'module';
  ItemInterface := IXMLModuleType;
  inherited;
end;

function TXMLModulesType.Get_Module(Index: Integer): IXMLModuleType;
begin
  Result := List[Index] as IXMLModuleType;
end;

function TXMLModulesType.Add: IXMLModuleType;
begin
  Result := AddItem(-1) as IXMLModuleType;
end;

function TXMLModulesType.Insert(const Index: Integer): IXMLModuleType;
begin
  Result := AddItem(Index) as IXMLModuleType;
end;

{ TXMLModuleType }

function TXMLModuleType.Get_Nommodule: WideString;
begin
  Result := AttributeNodes['nom-module'].Text;
end;

procedure TXMLModuleType.Set_Nommodule(Value: WideString);
begin
  SetAttribute('nom-module', Value);
end;

end. 