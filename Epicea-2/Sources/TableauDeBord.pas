unit TableauDeBord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ComCtrls, StdCtrls, xmldom, XMLIntf,
  msxmldom, XMLDoc, oxmldom, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP;

type


  TParamAfficheTableauDeBord = Record
   Affiche:Boolean;
   AffichageModal:Boolean;
   TitreForm:String;
   SousTitreForm:String;
   Nomfichier:string;
   NomEdition:string;
   FormatEdition:string;
   navigation:boolean;
   end;

  TE2_TableauDeBord = class(TForm)
    WebBrowser1: TWebBrowser;
    StatusBar1: TStatusBar;
    procedure WebBrowser1DownloadBegin(Sender: TObject);
    procedure WebBrowser1DownloadComplete(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure afficheEdition();
    procedure afficheBrowser();
  private
    { Déclarations privées }
  public
    { Déclarations publiques }

       Affiche:Boolean;
   AffichageModal:Boolean;
   TitreForm:String;
   SousTitreForm:String;
   Nomfichier:string;
   NomEdition:string;
   FormatEdition:string;
   navigation:boolean;
  end;

var
  E2_TableauDeBord: TE2_TableauDeBord;
    Function TableauDeBordAffiche(ParamAffiche:TParamAfficheTableauDeBord):Boolean;
implementation

uses DMRecherche, LibSQL, DatasetVersXml, DiversProjets, DmTableauBord,
  LibGestionParamXML, E2_Librairie_Obj, DMConstantes, LibDates, Math;

{$R *.dfm}





procedure TE2_TableauDeBord.WebBrowser1DownloadBegin(Sender: TObject);
begin
StatusBar1.SimpleText:='Ouverture de '+WebBrowser1.LocationName; //Message indiquant le nom de la page qui se charge
end;

procedure TE2_TableauDeBord.WebBrowser1DownloadComplete(Sender: TObject);
begin
StatusBar1.SimpleText:='Terminé'; //Message indiquant que le chargement de la page est terminé
end;

procedure TE2_TableauDeBord.FormShow(Sender: TObject);
begin
//WebBrowser1.GoHome;
//webBrowser1.navigate('http://localhost:8080/birt/frameset?__report=report/TableauDeBord.rptdesign&data=http://localhost:8080/birt/TableauDeBord.xml&__format=pdf');
if (navigation) then
  afficheBrowser
else afficheEdition;
end;


Function TableauDeBordAffiche(ParamAffiche:TParamAfficheTableauDeBord):Boolean;
var
listeExo:Tstringlist;
i,depart:integer;
Begin
  if (E2_TableauDeBord = nil) then
     E2_TableauDeBord:=TE2_TableauDeBord.Create(Application.MainForm);
   E2_TableauDeBord.Caption :='Tableau de bord';
   if(ParamAffiche.TitreForm<>'')then
      E2_TableauDeBord.Caption := ParamAffiche.TitreForm;
  E2_TableauDeBord.SousTitreForm := '';
//  E2_TableauDeBord.RxLabTitre.Caption:=E2_TableauDeBord.SousTitreForm;
  if(DmTableauDeBord=nil)then DmTableauDeBord:=TDmTableauDeBord.Create(Application.MainForm);

  E2_TableauDeBord.Nomfichier:=ParamAffiche.Nomfichier;
  E2_TableauDeBord.NomEdition:=ParamAffiche.NomEdition;
  E2_TableauDeBord.FormatEdition:=ParamAffiche.FormatEdition;
  E2_TableauDeBord.navigation:=ParamAffiche.navigation;
  E2_TableauDeBord.ShowModal;
  E2_TableauDeBord.Destroy;
End;

procedure TE2_TableauDeBord.affichebrowser();
begin
webBrowser1.navigate(E2_TableauDeBord.NomEdition);
end;

procedure TE2_TableauDeBord.afficheEdition();
var
datejour:string;
heure:string;
FichierEdition:string;
locale:string;
begin
//WebBrowser1.GoHome;
//webBrowser1.navigate('http://localhost:8080/birt/frameset?__report=report/TableauDeBord.rptdesign&data=http://localhost:8080/birt/TableauDeBord.xml&__format=pdf');
locale:=GetWindowsLanguage(LOCALE_SISO639LANGNAME)+'_'+GetWindowsLanguage(LOCALE_SISO3166CTRYNAME);
datejour:=DateInfos(now,'').DateStrFormat;
heure:=HeureInfos(now,'').HeureStrFormate;
FichierEdition:='report/'+E2_TableauDeBord.NomEdition+'&data='+E2_TableauDeBord.Nomfichier+'&__format=pdf'+'&__document=doc'+datejour+heure;
webBrowser1.navigate('http://localhost:8080/birt/frameset?__report=report/'+E2_TableauDeBord.NomEdition+'&data='+E2_TableauDeBord.Nomfichier+'&__format='+FormatEdition+'&date='+datejour+heure+'&__locale='+locale);
//showmessage('http://localhost:8080/birt/frameset?__report=report/'+E2_TableauDeBord.NomEdition+'&data='+E2_TableauDeBord.Nomfichier+'&__format='+FormatEdition+'&date='+datejour+heure+'&__locale='+locale);
end;
procedure TE2_TableauDeBord.FormDestroy(Sender: TObject);
begin
LibGestionParamXML.DestroyForm(Self,e.user);
E2_TableauDeBord:=nil;
end;

procedure TE2_TableauDeBord.FormCreate(Sender: TObject);
begin
    try//except
        LibGestionParamXML.InitialiseForm(E.USer,Self);
    except
        InitialiseFormPosDefaut(self);
    end;
end;

end.
