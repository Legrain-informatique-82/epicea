unit OutilsEdition;
//Outils de création d'édition au format HTML
//à partir de XML et de feuille XSL

interface
  uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, db, DBTables, StrUtils,lib_chaine,math;

  const couleur : string='#E6E6E6';   //couleur pour les cases en couleur

  type
  TCSSparam = record         //ensemble des paramètres concernant le CSS
      CSSCouleur,            //correspond à la couleur de fond de la page
      CSSCouleurTLigne,      //couleur du texte des lignes des tableaux (nom d'une couleur en anglais)
      CSSPoliceTLigne,       //police du texte des lignes des tableaux (times,arial,...)
      CSSTailleTLigne,       //taille du texte des lignes des tableaux (12,...)
      CSSCouleurTEntete,     //couleur du texte des entetes des tableaux (nom d'une couleur en anglais)
      CSSPoliceTEntete,      //police du texte des entetes des tableaux (times,arial,...)
      CSSTailleTEntete,      //taille du texte des entetes des tableaux (12,...)
      CSSBordureTable,       //enlève ou ajoute les bordures des tableaux (none ou ' ')
      CSSEspaceBordure,      //bordure séparées ou fusionnées (separate ou collapse)
      CSSCouleurTTable,      //couleur du texte des tableaux (nom d'une couleur en anglais)
      CSSTailleTTable,       //taille du texte des tableaux (12,...)
      CSSPoliceTTable,       //police du texte des tableaux (times,arial,...)
      CSSMargeTableG,        //marges gauches des tableaux
      CSSMargeTableD,        //marges droites des tableaux
      CSSLargeurTable:string;//Largeur des tables
  end;
  const CSSdefaut : TCSSParam = (CSSCouleur:'white';    //paramètres par défaut du CSS
      CSSCouleurTLigne:'black';
      CSSPoliceTLigne:'times';
      CSSTailleTLigne:'10';
      CSSCouleurTEntete:'black';
      CSSPoliceTEntete:'times';
      CSSTailleTEntete:'10';
      CSSBordureTable:'none';
      CSSEspaceBordure:'separate';
      CSSCouleurTTable:'black';
      CSSTailleTTable:'10';
      CSSPoliceTTable:'times';
      CSSMargeTableG:'0';
      CSSMargeTableD:'auto';
      CSSLargeurTable:'100%');

  type
  TLigneTabparam = record     //paramètres concernant LigneTab
      LigneLien,              //si LigneLien=true il y a des liens internes
      LigneGroupe:boolean;    //si LigneGroupe=true les lignes ne sont pas groupées
  end;

  type
  TTitreparam = record        //paramètres concernant TitreEdition
      AlignementTitre,        //alignement du titre
      CouleurTitre,           //couleur du titre
      TailleTitre,            //taille du titre
      PoliceTitre,            //police du titre
      CleTitre:string;        //cle pour les liens internes
  end;
  const StyleTitreEd : TTitreparam =(AlignementTitre:'right'; CouleurTitre:'black'; TailleTitre:'4';
                                  PoliceTitre:'times'; CleTitre:''); //Style pour les titres d'éditions

  const StyleSousTitreEd : TTitreparam =(AlignementTitre:'right'; CouleurTitre:'black'; TailleTitre:'2';
                                  PoliceTitre:'times'; CleTitre:''); //Style pour les soustitres d'éditions

  const StyleTitre : TTitreparam =(AlignementTitre:'left'; CouleurTitre:'black'; TailleTitre:'4';
                                  PoliceTitre:'times'; CleTitre:''); //Style pour les titres

  const StylePhrase : TTitreparam =(AlignementTitre:'left'; CouleurTitre:'black'; TailleTitre:'3';
                                  PoliceTitre:'times'; CleTitre:''); //Style pour les titres

  type
  TCelluleparam = record       //paramètres concernant Cellule
      contenu,                 //contenu de la cellule
      nbcol,                   //étirement de la cellule (colspan)
      align,                   //alignement du contenu dans la cellule
      cle:string;              //cle pour les liens internes
  end;

  const CelluleVide : TCelluleparam =(contenu:' ';nbcol:'1';align:'right';cle:'');
  //pramètres pour une cellule vide

  Procedure InitialiseCellule (var param : TCelluleparam; contenu,nbcol,align,cle:string);
  //initialise une cellule
  //la cellule contiendra contenu sur nbcol colones et sera alignés à align ("left","right")
  //cle est une ancre permettant des liens dans le document

  Procedure InitialiseTitre (var param : TTitreparam; alignement,couleur,taille,police,Cle:string);
  //initialise un style de titre
  //position,couleur,taille et police
  //peu servir pour n'importe quelle phrase en dehors d'un tableau
  //cle est une ancre permettant des liens dans le document

  Procedure InitialiseLigneTab (var param : TLigneTabparam; lien,groupe:boolean);
  //Si groupe=false les lignes peuvent êtres séparées par des saut de page
  //(utile pour les grands tableaux)

  Procedure InitialiseCSS (var param : TCSSparam; couleur,CouleurTLigne, PoliceTLigne, TailleTLigne,
      CouleurTEntete, PoliceTEntete, TailleTEntete,BordureTable,EspaceBordure, CouleurTTable,
      TailleTTable, PoliceTTable, MargeTableG,MargeTableD,LargeurTable:string);
  //Initialise les valeur pour le CSS de la page
  //couleur correspond à la couleur de fond de la page
  //LgBordure     => largeur des bordures des tableaux
  //TraitBordure  => type de trait des bordures (solid,none,hidden,dotted,dashed,double,groove,ridge,inset,outset)
  //CouleurBordure=> couleur des bordures des tableaux (nom d'une couleur en anglais)
  //CouleurTLigne => couleur du texte des lignes des tableaux (nom d'une couleur en anglais)
  //PoliceTLigne  => police du texte des lignes des tableaux (times,arial,...)
  //TailleTLigne  => taille du texte des lignes des tableaux (12,...)
  //CouleurTEntete=> couleur du texte des entetes des tableaux (nom d'une couleur en anglais)
  //PoliceTEntete => police du texte des entetes des tableaux (times,arial,...)
  //TailleTEntete => taille du texte des entetes des tableaux (12,...)
  //BordureTable  => enlève ou ajoute les bordures des tableaux (none ou ' ')
  //EspaceBordure => bordure séparées ou fusionnées (separate ou collapse)
  //CouleurTTable => couleur du texte des tableaux (nom d'une couleur en anglais)
  //TailleTTable  => taille du texte des tableaux (12,...)
  //PoliceTTable  => police du texte des tableaux (times,arial,...)
  //MargeTableG et MargeTableD => marges gauches et droites des tableaux
  //LargeurTable  => Largeur des tables

  Function DebutSection (fxml,fxsl:TFileStream) : Integer;
  //A UTILISER AVEC FINSECTION
  //debute une section (une section par tableau différent)

  Function FinSection (fxml,fxsl:TFileStream) : Integer;
  //A UTILISER AVEC DEBUTSECTION
  //termine un section (une section par tableau différent)

  Procedure TemplateValeurXSL(fxsl:TFileStream; Balise:string);
  //ajoute un template value-of select='.' dans le fichier xsl pour balise

  Procedure TemplateSpeciauxValeurXSL(fxsl:TFileStream;grd_livre_cg,grd_livre_tiers,journal_piece:string);
  //ajoute un template qui génére un lien value-of select='.' dans le fichier xsl pour balise
  //et créer un lien vers une ancre dans un des 3 fichiers suivant
  //grd_livre_cg nom du fichier xml contenant le grand livre des comptes généraux
  //grd_livre_tiers nom du fichier xml contenant le grand livre des comptes généraux
  //journal_piece nom du fichier xml contenant le grand livre des comptes généraux

  Procedure TemplateBooleen (fxsl:TFileStream);
  //ajoute les templates pour les booléens

  Function DebutXML(fxml,fxsl:TFileStream; NomFichierXSL,Typedoc,NomProg,Intitule:string;
      CSS:TCSSparam):Integer;
  //debute le fichier xml avec typedoc comme élément racine , fait le liens ver le fichier xsl NomFichierXSLet insère dans le xsl
  //le nom du programme NomProg et l'intitule de l'édition Intitulé
  //renvoie -1 si erreur

  Function DebutEdition(fxml,fxsl:TFileStream; NomFichierXSL,Typedoc:string):Integer;
  //A UTILISER AVEC FINEDITION
  //debute le fichier xml avec typedoc comme élément racine
  //renvoie -1 si erreur

  Function FinEdition(fxml,fxsl:TFileStream; Typedoc:string):Integer;
  //A UTILISER AVEC DEBUTEDITION
  //termine le fichier xml en fermant la balise typedoc de l'élément racine
  //renvoie -1 si erreur

  Function LigneTab(fxml,fxsl:TFileStream; DataSet:TDataSet;
                    const NomChamp:array of string;lien_grp:TLigneTabparam):Integer;
  //insère dans le fichier le contenu des lignes correspondant
  //aux colones NomChamp
  //lien_grp contient les informations relatives aux liens et au groupement des lignes
  //renvoie -1 si erreur

  Function LigneTabSpe(fxml,fxsl:TFileStream; DataSet:TDataSet;
                    const NomChamp:array of string;rupt:string;nbcol:integer;lien_grp:TLigneTabparam):Integer;
  //insère dans le fichier le contenu des lignes correspondant aux colones NomChamp
  //pour chaque rupt différent la ligne est affiché en entier.
  //Pour les autres lignes, les nbcol premieres colones sont vides
  //lien_grp contient les informations relatives aux liens et au groupement des lignes
  //renvoie -1 si erreur

  Function Ligne(fxml,fxsl:TFileStream; chaine:string;hauteur:string;nbcol:string):Integer;
  //insère une ligne de tableau avec chaine à l'intérieur qui s'étend sur nbcol colones

  Function TitreTab(fxml,fxsl:TFileStream;const Titre:array of Tstringlist):Integer;
  //insère dans le fichier le titre des différentes colones(Titre) du tableau
  //correspondant au nom des champs
  //Dans les listes, le premier élément est un titre principal, le deuxième correspond
  //à la largeur de la colone et les suivants sont ses sous-titres
  //renvoie -1 si erreur

  Function TitreEdition(fxml,fxsl:TFileStream; Titre:string;style:TTitreparam):Integer;
  //insère un titre d'édition et parametre son extraction(position,couleur,taille,
  //et police) dans le fichier xsl
  //peu servir pour n'importe quelle phrase en dehors d'un tableau
  //cle est une ancre permettant des liens dans le document
  //la chaine clé formera une ancre permettant des liens interne
  //renvoie -1 si erreur

  Function Periode(fxml,fxsl:TFileStream; DataSet:TDataSet):Integer;
  //insére la période sur laquelle porte d'édition
  //renvoie -1 si erreur

  Function Totaux(fxml,fxsl:TFileStream; DataSet:TDataSet;const NomTotal:array of string):Integer;
  //insère les totaux et leurs noms
  //renvoie -1 si erreur

  Function Total(fxml,fxsl:TFileStream; DataSet:TDataSet; NomTotal:string;nbcol:Integer;hauteur:string;negatif:boolean=false):Integer;
  //insère les totaux (présent dans le dataset), un nom pour cette ligne
  //et indique sur combien de colone s'étend le total(nbcol)
  //ainsi que la hauteur de la ligne si hauteur='0' la hauteur est "standard"
  //si negatif = vrai, les valeurs négatives sont affichées, sinon elles sont supprimées (utile pour les soldes)
  //renvoie -1 si erreur

  Function SautDeLigne (fxml,fxsl:TFileStream) : Integer;
  //Saute une ligne

  Function SautDePage (fxml,fxsl:TFileStream) : Integer;
  //Change de page

  Function DebutLigne (fxml,fxsl:TFileStream) : Integer;
  //Débute une ligne (<tr>)

  Function Cellule (fxml,fxsl:TFileStream;cell : TCelluleparam) : Integer;
  //Ajoute un cellule (<td>) et carctèrisée par Celluleparam

implementation

  Procedure InitialiseCellule (var param : TCelluleparam; contenu,nbcol,align,cle:string);
  //initialise une cellule
  //la cellule contiendra contenu sur nbcol colones et sera alignés à align ("left","right")
  //cle est une ancre permettant des liens dans le document
  begin
      param.contenu:= contenu;
      param.nbcol  := nbcol;
      param.align  := align;
      param.Cle    := Cle;
  end;

  Procedure InitialiseTitre (var param : TTitreparam; alignement,couleur,taille,police,Cle:string);
  //initialise un style de titre
  //position,couleur,taille et police
  //peu servir pour n'importe quelle phrase en dehors d'un tableau
  //cle est une ancre permettant des liens dans le document
  begin
      param.AlignementTitre:= alignement;
      param.CouleurTitre   := couleur;
      param.TailleTitre    := taille;
      param.PoliceTitre    := police;
      param.CleTitre       := Cle;
  end;

  Procedure InitialiseLigneTab (var param : TLigneTabparam; lien,groupe:boolean);
  //Si groupe=false les lignes peuvent êtres séparées par des saut de page
  //(utile pour les grands tableaux)
  begin
      param.LigneLien   := lien;
      param.LigneGroupe := groupe;
  end;

  Procedure InitialiseCSS (var param : TCSSparam; couleur,CouleurTLigne, PoliceTLigne, TailleTLigne,
      CouleurTEntete, PoliceTEntete, TailleTEntete, BordureTable, EspaceBordure, CouleurTTable,
      TailleTTable, PoliceTTable, MargeTableG, MargeTableD, LargeurTable:string);
  //Initialise les valeur pour le CSS de la page
  //couleur correspond à la couleur de fond de la page
  //LgBordure     => largeur des bordures des tableaux
  //TraitBordure  => type de trait des bordures (solid,none,hidden,dotted,dashed,double,groove,ridge,inset,outset)
  //CouleurBordure=> couleur des bordures des tableaux (nom d'une couleur en anglais)
  //CouleurTLigne => couleur du texte des lignes des tableaux (nom d'une couleur en anglais)
  //PoliceTLigne  => police du texte des lignes des tableaux (times,arial,...)
  //TailleTLigne  => taille du texte des lignes des tableaux (12,...)
  //CouleurTEntete=> couleur du texte des entetes des tableaux (nom d'une couleur en anglais)
  //PoliceTEntete => police du texte des entetes des tableaux (times,arial,...)
  //TailleTEntete => taille du texte des entetes des tableaux (12,...)
  //BordureTable  => enlève ou ajoute les bordures des tableaux (none ou ' ')
  //EspaceBordure => bordure séparées ou fusionnées (separate ou collapse)
  //CouleurTTable => couleur du texte des tableaux (nom d'une couleur en anglais)
  //TailleTTable  => taille du texte des tableaux (12,...)
  //PoliceTTable  => police du texte des tableaux (times,arial,...)
  //MargeTableG et MargeTableD => marges gauches et droites des tableaux
  //LargeurTable  => Largeur des tables
  begin
      param.CSSCouleur        :=couleur;
      param.CSSCouleurTLigne  :=CouleurTLigne;
      param.CSSPoliceTLigne   :=PoliceTLigne;
      param.CSSTailleTLigne   :=TailleTLigne;
      param.CSSCouleurTEntete :=CouleurTEntete;
      param.CSSPoliceTEntete  :=PoliceTEntete;
      param.CSSTailleTEntete  :=TailleTEntete;
      param.CSSBordureTable   :=BordureTable;
      param.CSSEspaceBordure  :=EspaceBordure;
      param.CSSCouleurTTable  :=CouleurTTable;
      param.CSSTailleTTable   :=TailleTTable;
      param.CSSPoliceTTable   :=PoliceTTable;
      param.CSSMargeTableG    :=MargeTableG;
      param.CSSMargeTableD    :=MargeTableD;
      param.CSSLargeurTable   :=LargeurTable;
  end;

  Function DebutSection (fxml,fxsl:TFileStream) : Integer;
  //A UTILISER AVEC FINSECTION
  //debute une section (une section par tableau différent)
      const TemplateSection : string ='<xsl:template match="section">'+
                                      '<table  border="1">'+
                                      '<xsl:apply-templates/>'+
                                      '</table>'+
                                      '</xsl:template>';
  begin
      fxml.Write(PChar('<section>')^,Length('<section>'));
      fxsl.Write(PChar(TemplateSection)^,Length(TemplateSection));
      DebutSection :=0;
  end;

  Function FinSection (fxml,fxsl:TFileStream) : Integer;
  //A UTILISER AVEC DEBUTSECTION
  //termine un section (une section par tableau différent)
  begin
      fxml.Write(PChar('</section>')^,Length('</section>'));
      FinSection :=0;
  end;

  Procedure TemplateSpeciauxValeurXSL(fxsl:TFileStream;grd_livre_cg,grd_livre_tiers,journal_piece:string);
  //ajoute un template qui génére un lien value-of select='.' dans le fichier xsl pour balise
  //et créer un lien vers une ancre dans un des 3 fichiers suivant
  //grd_livre_cg nom du fichier xml contenant le grand livre des comptes généraux
  //grd_livre_tiers nom du fichier xml contenant le grand livre des comptes généraux
  //journal_piece nom du fichier xml contenant le grand livre des comptes généraux
      var tempcompte,               //template special compte
          tempcomptec,              //template special compte avec couleur
          tempcomptiers,            //template special compte de tiers
          tempcomptiersc,           //template special compte de tiers avec couleur
          templateref,              //template special référence pièce
          templaterefc : string;    //template special référence pièce avec couleur
  begin
      ////////////////////// Template XSL générateur de lien HTML //////////////
      tempcompte :='<xsl:template match="'+'Compte'+'">'+
          '<xsl:variable name="val" select='+'''.'''+'/>'+
          '<td align="left">'+
          '<a href="'+grd_livre_cg+'.xml#{$val}" target="mainFrame">'+
          '<xsl:value-of select='+'''.'''+'/>'+
          '</a>'+
          '</td>'+
          '</xsl:template>';
      fxsl.Write(PChar(tempcompte)^,Length(tempcompte));

      tempcomptec :='<xsl:template match="'+'Comptec'+'">'+
          '<xsl:variable name="val" select='+'''.'''+'/>'+
          '<td style="background:'+couleur+'" align="left">'+
          '<a href="'+grd_livre_cg+'.xml#{$val}" target="mainFrame">'+
          '<xsl:value-of select='+'''.'''+'/>'+
          '</a>'+
          '</td>'+
          '</xsl:template>';
      fxsl.Write(PChar(tempcomptec)^,Length(tempcomptec));

      tempcomptiers := '<xsl:template match="'+'Comptet'+'">'+
          '<xsl:variable name="val" select='+'''.'''+'/>'+
          '<td align="left">'+
          '<a href="'+grd_livre_tiers+'.xml#{$val}" target="mainFrame">'+
          '<xsl:value-of select='+'''.'''+'/>'+
          '</a>'+
          '</td>'+
          '</xsl:template>';
      fxsl.Write(PChar(tempcomptiers)^,Length(tempcomptiers));

      tempcomptiersc :='<xsl:template match="'+'Comptetc'+'">'+
          '<xsl:variable name="val" select='+'''.'''+'/>'+
          '<td style="background:'+couleur+'" align="left">'+
          '<a href="'+grd_livre_tiers+'.xml#{$val}" target="mainFrame">'+
          '<xsl:value-of select='+'''.'''+'/>'+
          '</a>'+
          '</td>'+
          '</xsl:template>';
      fxsl.Write(PChar(tempcomptiersc)^,Length(tempcomptiersc));

      templateref :='<xsl:template match="'+'Reference'+'">'+
          '<xsl:variable name="val" select='+'''.'''+'/>'+
          '<td align="left">'+
          '<a href="'+journal_piece+'.xml#{$val}" target="mainFrame">'+
          '<xsl:value-of select='+'''.'''+'/>'+
          '</a>'+
          '</td>'+
          '</xsl:template>';
      fxsl.Write(PChar(templateref)^,Length(templateref));

      templaterefc :='<xsl:template match="'+'Referencec'+'">'+
          '<xsl:variable name="val" select='+'''.'''+'/>'+
          '<td style="background:'+couleur+'" align="left">'+
          '<a href="'+journal_piece+'.xml#{$val}" target="mainFrame">'+
          '<xsl:value-of select='+'''.'''+'/>'+
          '</a>'+
          '</td>'+
          '</xsl:template>';
      fxsl.Write(PChar(templaterefc)^,Length(templaterefc));
  end;
   
  Procedure TemplateValeurXSL(fxsl:TFileStream ;Balise:string);
  //ajoute un template value-of select='.' dans le fichier xsl pour balise
      var template,
          templatec : string;  //template des cas généraux
  begin
      {$B+}
      if ((Balise<>'Compte') and (Balise<>'Compte_1') and(Balise<>'Designation')
          and (Balise<>'Libelle') and (Balise<>'ComptePlanCpt') and (Balise<>'Libelle_model') 
          and (Balise<>'Libelle2') and (Balise<>'reference') and (Balise<>'Reference')
          and (Balise<>'Tiers') and (Balise<>'Date') and (Balise<>'ContreP') and (Balise<>'ReferencePiece')
          and (Balise<>'Nom') and (Balise<>'Classe') and (Balise<>'TVACode')
          and (Balise<>'Journal') and (Balise<>'Code') and (Balise<>'Libelle_Model')
          and (Balise<>'Type') and (Balise<>'Tiers') and (Balise<>'CodeLong')) then begin
          // alignement à droite dans la cellule
          template :='<xsl:template match="'+Balise+'">'+
                 '<td align="right">'+
                 '<xsl:value-of select='+'''.'''+'/>'+
                 '</td>'+
                 '</xsl:template>';
          templatec :='<xsl:template match="'+Balise+'c">'+
                 '<td style="background:'+couleur+'" align="right">'+
                 '<xsl:value-of select='+'''.'''+'/>'+
                 '</td>'+
                 '</xsl:template>';
      end
      else begin
      // alignement à gauche dans la cellule
          template :='<xsl:template match="'+Balise+'">'+
                '<td align="left">'+
                '<xsl:value-of select='+'''.'''+'/>'+
                '</td>'+
                '</xsl:template>';
          templatec :='<xsl:template match="'+Balise+'c">'+
                '<td style="background:'+couleur+'" align="left">'+
                '<xsl:value-of select='+'''.'''+'/>'+
                '</td>'+
                '</xsl:template>';
      end;

      fxsl.Write(PChar(template)^,Length(template));
      fxsl.Write(PChar(templatec)^,Length(templatec));
  end;

  Procedure TemplateBooleen (fxsl:TFileStream);
  //ajoute les templates pour les booléens
      var temp_vrai,
          temp_vraic,
          temp_faux,
          temp_fauxc :string;
  begin
      temp_vrai :='<xsl:template match="vrai">'+
          '<td align="center">'+
          '<input type="checkbox" checked="yes" disabled="true"></input>'+
          '</td>'+
          '</xsl:template>';
      fxsl.Write(PChar(temp_vrai)^,Length(temp_vrai));

      temp_vraic :='<xsl:template match="vraic" >'+
          '<td style="background:'+couleur+'" align="center">'+
          '<input type="checkbox" checked="yes" disabled="true"></input>'+
          '</td>'+
          '</xsl:template>';
      fxsl.Write(PChar(temp_vraic)^,Length(temp_vraic));

      temp_faux := '<xsl:template match="faux">'+
          '<td align="center">'+
          '<input type="checkbox" disabled="true"></input>'+
          '</td>'+
          '</xsl:template>';
      fxsl.Write(PChar(temp_faux)^,Length(temp_faux));

      temp_fauxc :='<xsl:template match="fauxc">'+
          '<td style="background:'+couleur+'" align="center">'+
          '<input type="checkbox" disabled="true"></input>'+
          '</td>'+
          '</xsl:template>';
      fxsl.Write(PChar(temp_fauxc)^,Length(temp_fauxc));
  end;

  Function DebutXML(fxml,fxsl:TFileStream; NomFichierXSL,Typedoc,NomProg,Intitule:string;
        CSS:TCSSparam):Integer;
  //debute le fichier xml avec typedoc comme élément racine , fait le liens ver le fichier xsl NomFichierXSLet insère dans le xsl
  //renvoie -1 si erreur
      //XML
      const DebXML : string = '<?xml version="1.0" encoding="iso-8859-1" ?>';

      //XSL
      const DebXSL : string = '<xsl:stylesheet version="1.0" '+
                            'xmlns:xsl="http://www.w3.org/1999/XSL/Transform">';
      var TemplateRacine : string;
      var Balise : String;
      var InclusionXSL : string;
  begin
      TemplateRacine := '<xsl:template match="/">'+
                                      '<html>'+
                                      '<head>'+'<title>'+Nomprog+' - '+Intitule+'</title>'+
                                      '<style>'+
                                      '@media print,screen {'+
                                      'TABLE { display: inline-table; border:'+CSS.CSSBordureTable+';empty-cells:show; border-collapse:'+CSS.CSSEspaceBordure+';'+
                                      'margin-left: '+CSS.CSSMargeTableG+'; margin-right:'+CSS.CSSMargeTableD+';'+  // 'width:'+CSS.CSSLargeurTable+';'+
                                      'color:'+CSS.CSSCouleurTTable+'; font-family:'+CSS.CSSPoliceTTable+'; font-size:'+CSS.CSSTailleTTable+'pt;}'+
                                      'TR {display: table-row; border:1px solid;}'+
                                      'TBODY { display: table-row-group;color:'+CSS.CSSCouleurTLigne+';font-family:'+CSS.CSSPoliceTLigne+'; font-size: '+CSS.CSSTailleTLigne+'pt}'+
                                      'THEAD { display: table-header-group; color:'+CSS.CSSCouleurTEntete+'; font-family:'+CSS.CSSPoliceTEntete+'; font-size: '+CSS.CSSTailleTEntete+'pt}}'+
                                      'COL { display: table-column;}'+
                                      'COLGROUP { display: table-column-group;}'+
                                      'TH { display: table-cell; border:1px solid black;}'+
                                      'TD {border:none; }'+                     //sans bordure
                                    //'TD {border:1px solid '+couleur+';}'+     //avec bordure couleur fond
                                    //'TD {border:1px solid black;}'+           //avec bordure en noir
                                    //'TD {border:border-top:1px solid black; border-bottom:none;border-left:none;border-right:none}'+              //avec 1 trait noir
                                    //'TD {border:border-top:none; border-bottom:none;border-left:1px solid black;border-right:1px solid black;}'+  //avec 2 traits noir verticaux
                                      'CAPTION { display: table-caption;}'+
                                      'HR {display:none; page-break-after:always;}'+
                                      '}'+
                                      '</style>'+
                                      '</head>'+
                                      '<body bgcolor="'+CSS.CSSCouleur+'">'+
                                      '<xsl:apply-templates/>'+
                                      '</body>'+'</html>'+
                                      '</xsl:template>';
      InclusionXSL := '<?xml-stylesheet type="text/xsl" href="'+NomFichierXSL+'" ?>';
      fxml.Write(PChar(DebXML)^,Length(DebXML));
      fxml.Write(PChar(InclusionXSL)^,Length(InclusionXSL));
      Balise := '<'+Typedoc+'>';
      fxml.Write(PChar(Balise)^, Length(Balise));
      fxsl.Write(PChar(DebXML)^, Length(DebXML));
      fxsl.Write(PChar(DebXSL)^, Length(DebXSL));
      fxsl.Write(PChar(TemplateRacine)^, Length(TemplateRacine));
      DebutXML := 0;
  end;

  Function DebutEdition(fxml,fxsl:TFileStream; NomFichierXSL,Typedoc:string):Integer;
  //A UTILISER AVEC FINEDITION
  //debute le fichier xml avec typedoc comme élément racine
  //renvoie -1 si erreur

      var TemplateVraiRacine : string;

  begin
      //XSL
      TemplateVraiRacine := '<xsl:template match="'+Typedoc+'">'+
                                      '<xsl:apply-templates/>'+
                                      '</xsl:template>';

      fxsl.Write(PChar(TemplateVraiRacine)^, Length(TemplateVraiRacine));
      DebutEdition := 0;
  end;

  Function FinEdition(fxml,fxsl:TFileStream; Typedoc:string):Integer;
  //A UTILISER AVEC DEBUTEDITION
  //termine le fichier xml en fermant la balise typedoc de l'élément racine
  //renvoie -1 si erreur
      var Balise : String;
  begin
      //XML
      Balise := '</'+Typedoc+'>';
      fxml.Write(PChar(Balise)^, Length(Balise));

      //XSL
      fxsl.Write(PChar('</xsl:stylesheet>')^, Length('</xsl:stylesheet>'));
      FinEdition:= 0;
  end;

  Function Ligne(fxml,fxsl:TFileStream; chaine,hauteur,nbcol:string):Integer;
  //insère une ligne de tableau avec chaine à l'intérieur qui s'étend sur nbcol colones
      const TemplateLigneVide : string = '<xsl:template match="lignevide">'+
                                         '<xsl:variable name="nbcol" select='+'''@nbcol'''+'/>'+
                                         '<xsl:variable name="hauteur" select='+'''@hauteur'''+'/>'+
                                         '<tr height="{$hauteur}" valign="middle">'+ //'<td colspan="{$nbcol}">'+
                                         '<xsl:value-of select='+'''.'''+'/>'+
                                         //'</td>'+
                                         '</tr>'+
                                         '</xsl:template>';

  begin
      fxml.Write(PChar('<lignevide nbcol="'+nbcol+'" hauteur="'+hauteur+'">'+chaine+'</lignevide>')^,
                                Length('<lignevide nbcol="'+nbcol+'" hauteur="'+hauteur+'">'+chaine+'</lignevide>'));
      fxsl.Write(PChar(TemplateLigneVide)^, Length(TemplateLigneVide));
      Ligne :=0;
  end;

  Function LigneTab(fxml,fxsl:TFileStream; DataSet:TDataSet;
                  const NomChamp:array of string; lien_grp:TLigneTabparam):Integer;
  //insère dans le fichier le contenu des lignes
  //correspondant aux colones NomChamp
  //lien_grp contient les informations relatives aux liens et au groupement des lignes
  //renvoie -1 si erreur
      //XML
      const DebCorpsTab : string = '<corps_tableau>';
            FinCorpsTab : string = '</corps_tableau>';
            DebLigne    : string = '<ligne>';
            FinLigne    : string = '</ligne>';
      var BaliseDeb,
          BaliseFin,
          Valeur,
          Ligne : String;
          I : integer;     //compteur de boucle

      //XSL
      var TemplateCorps:string;
      const TemplateLigne : string = '<xsl:template match="ligne">'+
                                     '<tr>'+
                                     '<xsl:apply-templates/>'+
                                     '</tr>'+
                                     '</xsl:template>';
      var lg:integer;
  begin
      lg:=0;
      if lien_grp.LigneGroupe then
          TemplateCorps := '<xsl:template match="corps_tableau">'+
                                     '<tbody>'+
                                     '<xsl:apply-templates/>'+
                                     '</tbody>'+
                                     '</xsl:template>'
      else
          TemplateCorps := '<xsl:template match="corps_tableau">'+
                                     '<xsl:apply-templates/>'+
                                     '</xsl:template>';
      DataSet.First;
      if not Dataset.Eof then begin  //il y a des données dans la table
          fxml.Write(PChar(DebCorpsTab)^, Length(DebCorpsTab));
          while not Dataset.Eof do begin
          //parcours du DataSet et insertion des lignes
          lg:=lg+1;
          fxml.Write(PChar(DebLigne)^, Length(DebLigne));

              for I:=0 to high(NomChamp) do begin
              //insetion du contenu de la ligne
                  if DataSet.FindField(NomChamp[i])<>nil then begin
                  //NomChamp[i] existe bien dans la table
                      Valeur:=DataSet.FindField(NomChamp[i]).AsString;
                      if (lg mod 2 =0) then begin
                          if (lien_grp.LigneLien) and (NomChamp[i]='Compte') then begin
                              if (rightstr(Valeur,1)>='0') and (rightstr(Valeur,1)<='9') then begin
                              //compte général
                                  BaliseDeb := '<'+NomChamp[i]+'>';
                                  BaliseFin := '</'+NomChamp[i]+'>';
                              end
                              else begin
                              //compte de tiers
                                  BaliseDeb := '<'+NomChamp[i]+'t>';
                                  BaliseFin := '</'+NomChamp[i]+'t>';
                              end
                          end
                          else begin
                          //cas général
                              BaliseDeb := '<'+NomChamp[i]+'>';
                              BaliseFin := '</'+NomChamp[i]+'>';
                          end
                      end
                      else begin
                      // autre couleur
                          if (lien_grp.LigneLien) and (NomChamp[i]='Compte') then begin
                              if (rightstr(Valeur,1)>='0') and (rightstr(Valeur,1)<='9') then begin
                              //compte général
                                  BaliseDeb := '<'+NomChamp[i]+'c>';
                                  BaliseFin := '</'+NomChamp[i]+'c>';
                              end
                              else begin
                              //compte de tiers
                                  BaliseDeb := '<'+NomChamp[i]+'tc>';
                                  BaliseFin := '</'+NomChamp[i]+'tc>';
                              end
                          end
                          else begin
                          //cas général
                              BaliseDeb := '<'+NomChamp[i]+'c>';
                              BaliseFin := '</'+NomChamp[i]+'c>';
                          end
                      end;
                      //Récupère la valeur dans le champ NomChamp[i]
                     // AnsiReplaceStr Delphi7 ou str_remplacesouschaine
                      Valeur :=AnsiReplaceStr(Valeur,'&','&amp;');
                      Valeur :=AnsiReplaceStr(Valeur,'<','&lt;');
                      Valeur :=AnsiReplaceStr(Valeur,'>','&gt;');
                      Valeur :=AnsiReplaceStr(Valeur,'€','&euro;');
                      Valeur :=AnsiReplaceStr(Valeur,'"','&quot;');
                  //Arrondi
                      if (DataSet.FindField(NomChamp[i]).DataType=ftCurrency)	and (DataSet.FindField(NomChamp[i]).AsString<>'') then begin
                          Valeur:=FloatToStr(SimpleRoundTo(StrToFloat(Valeur)));
                      end;

                      if Valeur='0' then //Suppression des valeurs nulles
                          Valeur:=' ';
                      if DataSet.FindField(NomChamp[i]).DataType=ftBoolean then begin
                          //cas d'un booleen
                          if DataSet.FindField(NomChamp[i]).AsBoolean=true then begin
                              if (lg mod 2=0) then
                                  Ligne:='<vrai/>'
                              else
                                  Ligne:='<vraic/>'
                          end
                          else begin
                              if (lg mod 2=0) then
                                  Ligne:='<faux/>'
                              else
                                  Ligne:='<fauxc/>'
                          end
                      end
                      else begin
                          //cas normal
                          Ligne := BaliseDeb + Valeur + BaliseFin;
                      end;
                      fxml.Write(PChar(Ligne)^, Length(Ligne));
                  end;
              end;
              fxml.Write(PChar(FinLigne)^, Length(FinLigne));

              Dataset.Next;
          end;    
          for I:=0 to high(NomChamp) do begin
              TemplateValeurXSL(fxsl,NomChamp[i]);
          end;
          TemplateBooleen(fxsl);

          fxml.Write(PChar(FinCorpsTab)^, Length(FinCorpsTab));
          fxsl.Write(PChar(TemplateCorps)^, Length(TemplateCorps));
          fxsl.Write(PChar(TemplateLigne)^, Length(TemplateLigne));
      end;
      LigneTab :=0;
  end;

  Function TitreTab(fxml,fxsl:TFileStream;const Titre:array of Tstringlist):Integer;
  //insère dans le fichier le titre des différentes colones(Titre) du tableau
  //correspondant au nom des champs
  //Dans les listes, le premier élément est un titre principal, le deuxième correspond
  //à la largeur de la colone et les suivants sont ses sous-titres
  //renvoie -1 si erreur
      //XML
      const DebTitreCol : string = '<titre_colones>';
            FinTitreCol : string = '</titre_colones>';
            DebSousTitreCol : string = '<sous_titre_colones>';
            FinSousTitreCol : string = '</sous_titre_colones>';
            DebEntete : string = '<entete>';
            FinEntete : string = '</entete>';
      var I,J,nbstring : integer;     //compteur de boucle

      //XSL
      const TemplateEntete : string ='<xsl:template match="entete">'+
                                      '<thead>'+
                                      '<xsl:apply-templates/>'+
                                      '</thead>' +
                                      '</xsl:template>';
      const TemplateTitreColones : string ='<xsl:template match="titre_colones">'+
                                           '<tr>'+
                                           '<xsl:apply-templates/>'+
                                           '</tr>'+
                                           '</xsl:template>';
      const TemplateSousTitreColone : string ='<xsl:template match="sous_titre_colones">'+
                                              '<tr>'+
                                              '<xsl:apply-templates/>'+
                                              '</tr>'+
                                              '</xsl:template>';
      const TemplateTitre : string ='<xsl:template match="titre">'+
                                    '<xsl:variable name="larg" select='+'''@largeur'''+'/>'+
                                    '<xsl:variable name="var" select='+'''@nbsoustitre'''+'/>'+
                                    '<th colspan="{$var}" width="{$larg}">'+
                                    '<xsl:value-of select='+'''@t'''+'/>'+
                                    '</th>'+
                                    '</xsl:template>';
      const TemplateSousTitre : string ='<xsl:template match="sous_titre">'+
                                        '<th>'+
                                        '<xsl:value-of select='+'''.'''+'/>'+
                                        '</th>'+
                                        '</xsl:template>';

  begin
      fxml.Write(PChar(DebEntete)^, Length(DebEntete));
      fxml.Write(PChar(DebTitreCol)^, Length(DebTitreCol));
      for I:=0 to high(Titre) do begin
      //insertion des titres
          nbstring:= titre[I].Count-2;
          if nbstring = 0 then nbstring:=1; 
          fxml.Write(PChar('<titre t="'+titre[I].Strings[0]+'" nbsoustitre="'
                      +inttostr(nbstring)+'" largeur="'+titre[I].Strings[1]+'">')^,
          Length('<titre t="'+titre[I].Strings[0]+'" nbsoustitre="'+inttostr(nbstring)+
                                  '" largeur="'+titre[I].Strings[1]+'">'));
          fxml.Write(PChar('</titre>')^, Length('</titre>'));
      end;
      fxml.Write(PChar(FinTitreCol)^, Length(FinTitreCol));

       //insertion des sous-titres
       fxml.Write(PChar(DebSousTitreCol)^, Length(DebSousTitreCol));
       for I:=0 to high(Titre) do begin
          nbstring:= titre[I].Count-1;
          for J:=2 to nbstring do begin
            fxml.Write(PChar('<sous_titre>'+titre[I].Strings[J]+'</sous_titre>')^,
                   Length('<sous_titre>'+titre[I].Strings[J]+'</sous_titre>'));
          end;
       end;
      fxml.Write(PChar(FinSousTitreCol)^, Length(FinSousTitreCol));
      fxml.Write(PChar(FinEntete)^, Length(FinEntete));
      fxsl.Write(PChar(TemplateEntete)^, Length(TemplateEntete));
      fxsl.Write(PChar(TemplateTitreColones)^, Length(TemplateTitreColones));
      fxsl.Write(PChar(TemplateSousTitreColone)^, Length(TemplateSousTitreColone));
      fxsl.Write(PChar(TemplateTitre)^, Length(TemplateTitre));
      fxsl.Write(PChar(TemplateSousTitre)^, Length(TemplateSousTitre));

      TitreTab :=0;
  end;

  Function TitreEdition(fxml,fxsl:TFileStream; Titre:string;style:TTitreparam):Integer;
  //insère un titre d'édition et son style d'affichage
  //renvoie -1 si erreur
      //XML
      var   DebTitre : string;
      const FinTitre : string = '</titre_edition>';

      //XSL
      const TemplateTitreEd : string ='<xsl:template match="titre_edition">'+
                                     '<xsl:variable name="align" select='+'''@alignement'''+'/>'+
                                     '<xsl:variable name="color" select='+'''@couleur'''+'/>'+
                                     '<xsl:variable name="size" select='+'''@taille'''+'/>'+
                                     '<xsl:variable name="face" select='+'''@police'''+'/>'+
                                     '<xsl:variable name="cle" select='+'''@id'''+'/>'+
                                     '<div align="{$align}" style="page-break-after:avoid"><font color="{$color}" '+
                                     'size="{$size}" face="{$face}" style="page-break-after:avoid">'+
                                     '<a id="{$cle}" name="{$cle}">'+
                                     '<xsl:value-of select='+'''.'''+'/>'+
                                     '</a>'+
                                     '</font></div>'+
                                     '</xsl:template>';
      var Balise : String;
  begin
      DebTitre := '<titre_edition id="'+style.CleTitre+'" alignement="'+style.AlignementTitre+'" couleur="'+style.CouleurTitre+
      '" taille="'+style.TailleTitre+'"'+' police="'+style.PoliceTitre+'">';
      //DebTitre := '<titre_edition alignement="'+alignement+'" couleur="'+couleur+
      //'" taille="'+taille+'"'+' police="'+police+'">';
      Balise := DebTitre+Titre+FinTitre;
      fxml.Write(PChar(Balise)^, Length(Balise));
      fxsl.Write(PChar(TemplateTitreEd)^, Length(TemplateTitreEd));
      TitreEdition:= 0;
  end;

  Function Periode(fxml,fxsl:TFileStream; DataSet:TDataSet):Integer;
  //insére la période sur laquelle porte d'édition
  //renvoie -1 si erreur
      const DebPeriode : string = '<periode>';
            FinPeriode : string = '</periode>';
            DebDate    : string = '<date>';
            FinDate    : string = '</date>';
      var Valeur : String;
          I : integer;     //compteur de boucle
  begin
      DataSet.First;
      if not Dataset.Eof then begin     //il y a des données dans la table
          fxml.Write(PChar(DebPeriode)^, Length(DebPeriode));
          while not Dataset.Eof do begin
          //parcours du dataset et insertion des lignes
              for I:=0 to DataSet.FieldCount-1 do begin
                  Valeur:=DataSet.Fields[i].AsString;
                  //Récupère la valeur dans le champ NomChamp[i]
                  fxml.Write(PChar(DebDate+Valeur+FinDate)^,
                            Length(DebDate+Valeur+FinDate));
              end;
              Dataset.Next;
          end;
          fxml.Write(PChar(FinPeriode)^, Length(FinPeriode));
      end;

      Periode :=0;
  end;

  Function Totaux(fxml,fxsl:TFileStream; DataSet:TDataSet;
                 const NomTotal:array of string):Integer;
  //insère les totaux et leurs noms
  //renvoie -1 si erreur
      const DebTotaux     : string = '<totaux>';
            FinTotaux     : string = '</totaux>';
            DebNomTotaux  : string = '<nom_total>';
            FinNomTotaux  : string = '</nom_total>';
            DebValTotal   : string = '<vtotal>';
            FinValTotal   : string = '</vtotal>';
      var Valeur : String;
          I : integer;     //compteur de boucle
  begin
      DataSet.First;
      if not Dataset.Eof then begin     //il y a des données dans la table
          fxml.Write(PChar(DebTotaux)^, Length(DebTotaux));
          while not Dataset.Eof do begin
          //parcours du dataset et insertion des lignes
              for I:=0 to high(NomTotal) do begin
                  Valeur:=DataSet.Fields[I].AsString;
                  //Récupère la valeur dans le champ NomChamp[i]
                  fxml.Write(PChar(DebNomTotaux+NomTotal[I]+FinNomTotaux)^,
                                Length(DebNomTotaux+NomTotal[I]+FinNomTotaux));
                  fxml.Write(PChar(DebValTotal+Valeur+FinValTotal)^,
                                Length(DebValTotal+Valeur+FinValTotal));
              end;
              Dataset.Next;
          end;
          fxml.Write(PChar(FinTotaux)^, Length(FinTotaux));
      end;
      Totaux :=0;
  end;

  Function Total(fxml,fxsl:TFileStream; DataSet:TDataSet; NomTotal:string;nbcol:Integer;hauteur:string;negatif:boolean):Integer;
  //insère les totaux (présent dans le dataset), un nom pour cette ligne
  //et indique sur combien de colone s'étend le total(nbcol)
  //ainsi que la hauteur de la ligne si hauteur=0 la hauteur est "standard"
  //si negatif = vrai, les valeurs négatives sont affichées, sinon elles sont supprimées (utile pour les soldes)
  //renvoie -1 si erreur
      const DebValTot : string = '<tot>';
            FinValTot : string = '</tot>';
      var Valeur : String;
          I : integer;     //compteur de boucle

      const TemplateTotal : string = '<xsl:template match="total">'+
                                      '<xsl:variable name="nbcol" select='+'''@nbcol'''+'/>'+
                                      '<xsl:variable name="hauteur" select='+'''@hauteur'''+'/>'+
                                      '<tr height="{$hauteur}" valign="middle">'+
                                      '<th colspan="{$nbcol}" align="right">'+
                                      '<xsl:value-of select='+'''@nom_total'''+'/>'+'</th>'+
                                      '<xsl:apply-templates/>'+
                                      '</tr>'+
                                      '</xsl:template>';
                         
      const TemplateTot : string = '<xsl:template match="tot">'+
                                    '<th align="right">'+
                                    '<xsl:value-of select='+'''.'''+'/>'+
                                    '</th>'+
                                    '</xsl:template>';
  begin
      DataSet.First;
      if not Dataset.Eof then begin     //il y a des données dans la table
          fxml.Write(PChar('<total nom_total="'+NomTotal+'" nbcol="'+inttostr(nbcol)+'" hauteur="'+hauteur+'">')^,
                                    Length('<total nom_total="'+NomTotal+'" nbcol="'+inttostr(nbcol)+'" hauteur="'+hauteur+'">'));
          while not Dataset.Eof do begin
          //parcours du dataset et insertion des lignes
              for I:=0 to DataSet.FieldCount-1 do begin
                  Valeur:=DataSet.Fields[I].AsString;
              //Arrondi
                  if (Valeur='') then Valeur:='0';
                  if (strtoFloat(Valeur)<0) and not negatif then Valeur:='0';
                  Valeur:=FloatToStr(SimpleRoundTo(StrToFloat(Valeur)));
                  if Valeur='0' then Valeur:='';
                  //Récupère la valeur dans le champ NomChamp[i]
                  fxml.Write(PChar(DebValTot+Valeur+FinValTot)^,
                                        Length(DebValTot+Valeur+FinValTot));
              end;
              Dataset.Next; 
          end;
          fxml.Write(PChar('</total>')^, Length('</total>'));
          fxsl.Write(PChar(TemplateTotal)^, Length(TemplateTotal));
          fxsl.Write(PChar(TemplateTot)^, Length(TemplateTot));
      end;
      Total :=0;
  end;

  Function SautDeLigne (fxml,fxsl:TFileStream) : Integer;
  //Saute une ligne
      const TemplateSautLigne : string = '<xsl:template match="saut_de_ligne">'+
                                    '<br/>'+
                                    '</xsl:template>';
  begin
      fxml.Write(PChar('<saut_de_ligne>')^, Length('<saut_de_ligne>'));
      fxml.Write(PChar('</saut_de_ligne>')^, Length('</saut_de_ligne>'));
      fxsl.Write(PChar(TemplateSautLigne)^, Length(TemplateSautLigne));
      SautDeLigne :=0;
  end;

  Function SautDePage (fxml,fxsl:TFileStream) : Integer;
  //Change de page
      const TemplateSautPage : string = '<xsl:template match="saut_de_page">'+
                                    '<hr></hr>'+
                                    '</xsl:template>';
  begin
    fxml.Write(PChar('<saut_de_page>')^, Length('<saut_de_page>'));
    fxml.Write(PChar('</saut_de_page>')^, Length('</saut_de_page>'));
    fxsl.Write(PChar(TemplateSautPage)^, Length(TemplateSautPage));
    SautDePage :=0;
  end;

  Function DebutLigne (fxml,fxsl:TFileStream) : Integer;
  //Débute une ligne (<tr>)
      const TemplateDebutLigne : string = '<xsl:template match="debut_ligne">'+
                                    '<tr>'+
                                    '<xsl:apply-templates/>'+
                                    '</tr>'+
                                    '</xsl:template>';
  begin
      fxml.Write(PChar('<debut_ligne>')^, Length('<debut_ligne>'));
      fxml.Write(PChar('</debut_ligne>')^, Length('</debut_ligne>'));
      fxsl.Write(PChar(TemplateDebutLigne)^, Length(TemplateDebutLigne));
      DebutLigne :=0;
  end;

  Function Cellule (fxml,fxsl:TFileStream;cell : TCelluleparam) : Integer;
  //Ajoute un cellule (<td>) et carctèrisée par Celluleparam 
      var TemplateCellule : string ;
  begin
      if cell.contenu='0' then cell.contenu:='';
      TemplateCellule := '<xsl:template match="cellule">'+
                          '<xsl:variable name="nbcol" select='+'''@nbcol'''+'/>'+
                          '<xsl:variable name="cle" select='+'''@id'''+'/>'+
                          '<xsl:variable name="align" select='+'''@align'''+'/>'+
                              '<td align="{$align}" colspan="{$nbcol}" style="border:1px solid black">'+
                              '<a  id="{$cle}" name="{$cle}">'+
                              '<xsl:value-of select='+'''@contenu'''+'/>'+
                              '</a>'+
                              '</td>'+
                              '</xsl:template>';
      fxml.Write(PChar('<cellule id="'+cell.cle+'" align="'+cell.align+'" nbcol="'+cell.nbcol+'" contenu="'+cell.contenu+'">')^,
                Length('<cellule id="'+cell.cle+'" align="'+cell.align+'" nbcol="'+cell.nbcol+'" contenu="'+cell.contenu+'">'));
      fxml.Write(PChar('</cellule>')^, Length('</cellule>'));
      fxsl.Write(PChar(TemplateCellule)^, Length(TemplateCellule));
      Cellule :=0;
  end;

  Function LigneTabSpe(fxml,fxsl:TFileStream; DataSet:TDataSet;
                    const NomChamp:array of string;rupt:string;nbcol:integer;lien_grp:TLigneTabparam):Integer;
  //insère dans le fichier le contenu des lignes correspondant aux colones NomChamp
  //pour chaque rupt différent la ligne est affiché en entier.
  //Pour les autres lignes, les nbcol premieres colones sont vides
  //lien_grp contient les informations relatives aux liens et au groupement des lignes
  //renvoie -1 si erreur//XML
      const DebCorpsTab : string = '<corps_tableau>';
            FinCorpsTab : string = '</corps_tableau>';
            DebLigne    : string = '<ligne>';
            FinLigne    : string = '</ligne>';
      var BaliseDeb,
          BaliseFin,
          Valeur,
          Ligne : String;
          I : integer;     //compteur de boucle

      //XSL
      var TemplateCorps:string;
      const TemplateLigne : string = '<xsl:template match="ligne">'+
                                     '<tr>'+
                                     '<xsl:apply-templates/>'+
                                     '</tr>'+
                                     '</xsl:template>';
      var lg,     //coloration
          premier_passage : integer; // 0 si premier passage
      var rupt_pre: string; //rupture précedente
  begin
      lg:=0;
      premier_passage:=0;
      if lien_grp.LigneGroupe then
          TemplateCorps := '<xsl:template match="corps_tableau">'+
                                     '<tbody>'+
                                     '<xsl:apply-templates/>'+
                                     '</tbody>'+
                                     '</xsl:template>'
      else
          TemplateCorps := '<xsl:template match="corps_tableau">'+
                                     '<xsl:apply-templates/>'+
                                     '</xsl:template>';
      DataSet.First;
      
      if not Dataset.Eof then begin  //il y a des données dans la table
          fxml.Write(PChar(DebCorpsTab)^, Length(DebCorpsTab));
          rupt_pre:=DataSet.FindField(rupt).AsString;
          while not Dataset.Eof do begin
          //parcours du DataSet et insertion des lignes
          lg:=lg+1;
          fxml.Write(PChar(DebLigne)^, Length(DebLigne));

              if (DataSet.FindField(rupt).AsString<>rupt_pre) or (premier_passage=0) then begin
              //premiere ligne concernant rupt
                  for I:=0 to high(NomChamp) do begin
                  //insetion du contenu de la ligne
                      if DataSet.FindField(NomChamp[i])<>nil then begin
                      //NomChamp[i] existe bien dans la table
                          if (lg mod 2 =0) then begin
                              BaliseDeb := '<'+NomChamp[i]+'>';
                              BaliseFin := '</'+NomChamp[i]+'>';
                          end
                          else begin
                              BaliseDeb := '<'+NomChamp[i]+'c>';
                              BaliseFin := '</'+NomChamp[i]+'c>';
                          end;
                          Valeur:=DataSet.FindField(NomChamp[i]).AsString;
                          //Récupère la valeur dans le champ NomChamp[i]
                          Valeur :=AnsiReplaceStr(Valeur,'&','&amp;');
                          Valeur :=AnsiReplaceStr(Valeur,'<','&lt;');
                          Valeur :=AnsiReplaceStr(Valeur,'>','&gt;');
                          Valeur :=AnsiReplaceStr(Valeur,'€','&euro;');
                          Valeur :=AnsiReplaceStr(Valeur,'"','&quot;');

                      //Arrondi
                          if (DataSet.FindField(NomChamp[i]).DataType=ftCurrency)	and (DataSet.FindField(NomChamp[i]).AsString<>'')	then begin
                              Valeur:=FloatToStr(SimpleRoundTo(StrToFloat(Valeur)));
                          end;
                          
                          if (Valeur='0') then //Suppression des valeurs nulles
                              Valeur:=' ';
                          if DataSet.FindField(NomChamp[i]).DataType=ftBoolean then begin
                              //cas d'un booleen
                              if DataSet.FindField(NomChamp[i]).AsBoolean=true then begin
                                  if (lg mod 2=0) then
                                      Ligne:='<vrai/>'
                                  else
                                      Ligne:='<vraic/>'
                              end
                              else begin
                                  if (lg mod 2=0) then
                                      Ligne:='<faux/>'
                                  else
                                      Ligne:='<fauxc/>'
                              end
                          end
                          else begin
                          //cas normal
                               Ligne := BaliseDeb + Valeur + BaliseFin;
                          end;
                          fxml.Write(PChar(Ligne)^, Length(Ligne));
                      end;
                  end;
              end
              else begin //suite des lignes concernant rupt
                  for I:=0 to high(NomChamp) do begin
                  //insetion du contenu de la ligne
                      if DataSet.FindField(NomChamp[i])<>nil then begin
                      //NomChamp[i] existe bien dans la table
                          if (lg mod 2 =0) then begin
                              BaliseDeb := '<'+NomChamp[i]+'>';
                              BaliseFin := '</'+NomChamp[i]+'>';
                          end
                          else begin
                              BaliseDeb := '<'+NomChamp[i]+'c>';
                              BaliseFin := '</'+NomChamp[i]+'c>';
                          end;
                          Valeur:=DataSet.FindField(NomChamp[i]).AsString;
                          //Récupère la valeur dans le champ NomChamp[i]
                          if (Valeur='0') or (i<nbcol) then //Suppression des valeurs nulles
                              Valeur:=' ';
                          if DataSet.FindField(NomChamp[i]).DataType=ftBoolean then begin
                          //cas d'un booleen
                              if DataSet.FindField(NomChamp[i]).AsBoolean=true then begin
                                  if (lg mod 2=0) then
                                      Ligne:='<vrai/>'
                                  else
                                      Ligne:='<vraic/>'
                                  end
                                  else begin
                                      if (lg mod 2=0) then
                                          Ligne:='<faux/>'
                                      else
                                          Ligne:='<fauxc/>'
                              end
                          end
                          else begin
                          //cas normal
                              Ligne := BaliseDeb + Valeur + BaliseFin;
                          end;
                          fxml.Write(PChar(Ligne)^, Length(Ligne));
                      end;
                  end;
              end;
              fxml.Write(PChar(FinLigne)^, Length(FinLigne));

              rupt_pre:=DataSet.FindField(rupt).AsString;
              premier_passage:=premier_passage+1;
              Dataset.Next;
          end;
          for I:=0 to high(NomChamp) do begin
              TemplateValeurXSL(fxsl,NomChamp[i]);
          end;
          TemplateBooleen(fxsl);

          fxml.Write(PChar(FinCorpsTab)^, Length(FinCorpsTab));
          fxsl.Write(PChar(TemplateCorps)^, Length(TemplateCorps));
          fxsl.Write(PChar(TemplateLigne)^, Length(TemplateLigne));
      end;
      LigneTabSpe :=0;
  end;

end.
 