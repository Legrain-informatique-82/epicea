unit Repart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDMRepart = class(TDataModule)
    Balance: TTable;
    Repartition: TTable;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    ListeCell : TStringList;    //contient la liste des cellules du PDF, leur montant
                              // et le d�tail des comptes la composant
  end;

type
  TRepartition = class(TObject)
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    MontantTotal : currency;   //montant total de la cellule
    compte : TStringList;      //compte intervenant dans le montant total
    constructor Create;
    destructor Destroy;
  end;

type
  TMontant = class(TObject)
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    MontantCpt : currency;    //montant pour chacun des comptes
    constructor Create;
    destructor Destroy;
  end;

var
  DMRepart : TDMRepart;

  function est_reparti_debit(cpt:string;Repartition:TDataSet):string;
  //retourne le code de la cellule de r�partition du PDF correspondant au compte cpt au d�bit
  //dans la table R�partition

  function est_reparti_credit(cpt:string;Repartition:TDataSet):string;
  //retourne le code de la cellule de r�partition du PDF correspondant au compte cpt au cr�dit
  //dans la table R�partition

  function pererepart(cpt:string;Repartition:TDataSet):string;
  //retourne le premier p�re du compte cpt qui est r�parti dans la table R�partition

  procedure liste_cellule(Balance,Repartition:TDataSet);
  //initialise ListeCell

implementation
{$R *.DFM}

  constructor TRepartition.Create;
    //constructeur
  begin
       inherited Create;
       compte := TStringList.Create;
  end;

  destructor TRepartition.Destroy;
    //destructeur
  begin
       compte.Free;
       inherited Destroy;
  end;

  constructor TMontant.Create;
    //constructeur
  begin
       inherited Create;
  end;

  destructor TMontant.Destroy;
    //destructeur
  begin
       inherited Destroy;
  end;

  function est_reparti_debit(cpt:string;Repartition:TDataSet):string;
  //retourne le code de la cellule de r�partition du PDF correspondant au compte cpt au d�bit
  //dans la table R�partition
      const ValDefaut : string = '00';      //valeur dans la table si le compte n'est pas r�parti
  begin
      est_reparti_debit := ValDefaut;
      DMRepart.Repartition.Filter := 'compte='''+cpt+'''';
      DMRepart.Repartition.Filtered := true;
      if (DMRepart.Repartition.RecordCount=1) and (DMRepart.Repartition.FindField('sfd').AsString <>ValDefaut) then
            //cpt existe et est r�parti
            est_reparti_debit := DMRepart.Repartition.FindField('sfd').AsString;
      DMRepart.Repartition.Filtered := false;
  end;

  function est_reparti_credit(cpt:string;Repartition:TDataSet):string;
  //retourne le code de la cellule de r�partition du PDF correspondant au compte cpt au cr�dit
  //dans la table R�partition
      const ValDefaut : string = '00';    //valeur dans la table si le compte n'est pas r�parti
  begin
      est_reparti_credit := ValDefaut;
      DMRepart.Repartition.Filter := 'compte='''+cpt+'''';
      DMRepart.Repartition.Filtered := true;
      if (DMRepart.Repartition.RecordCount=1) and (DMRepart.Repartition.FindField('sfc').AsString <>ValDefaut) then
            //cpt existe et est r�parti
            est_reparti_credit:=DMRepart.Repartition.FindField('sfc').AsString;
      DMRepart.Repartition.Filtered := false;
  end;

  function pererepart(cpt:string;Repartition:TDataSet):string;
  //retourne le premier p�re du compte cpt qui est r�parti dans la table R�partition
    const ValDefaut : string = '00';     //valeur dans la table si le compte n'est pas r�parti
    var i   : integer;
        res : boolean;
  begin
      i  := length(cpt);
      res:= false;
      while (res=false) and (i>1) do
      begin
          i := i-1;
          cpt:=copy(cpt,0,i);
          if est_reparti_debit(cpt,Repartition)<>ValDefaut then
             res := true;
      end;
      pererepart := cpt;
  end;

  procedure liste_cellule(Balance,Repartition:TDataSet);
  //initialise ListeCell
    var
      InfoRepartD, InfoRepartC : TRepartition;
      MontantD, MontantC :TMontant;
      cpt,                                   //compte r�ellement utilis� dans la r�partition
      cpt_a_repartir,                        //compte trait�
      cellule,                               //Nom de la cellule dans le PDF
      signe : string;
      Debit,                                 //D�bit dans la balance
      Credit : Currency;                     //Cr�dit dans la balance
      i : integer;
  begin
      DMRepart.ListeCell:=TStringList.Create;
      Balance.First;
      while not Balance.EOF do begin
        //parcours de la balance
        cpt_a_repartir:=DMRepart.Balance.FindField('compte').AsString;
        Debit:=DMRepart.Balance.FindField('Debit_Total').AsCurrency;
        Credit:=DMRepart.Balance.FindField('Credit_Total').AsCurrency;

        MontantD := TMontant.Create;
        MontantC := TMontant.Create;
        InfoRepartD := TRepartition.Create;
        InfoRepartC := TRepartition.Create;

        if est_reparti_debit(cpt_a_repartir,DMRepart.Repartition)<>'00' then
           //le compte est r�parti directement
           cpt:=cpt_a_repartir
        else
           //le compte n'est pas r�parti, il faut prendre son p�re
            cpt:=pererepart(cpt_a_repartir,DMRepart.Repartition);

        /////////////////--DEBIT--//////////////////////////////////////////////
        Cellule := copy(est_reparti_debit(cpt,DMRepart.Repartition),2,length(est_reparti_debit(cpt,DMRepart.Repartition)));
        signe   := copy(est_reparti_debit(cpt,DMRepart.Repartition),0,1);
        if signe='+' then
           MontantD.MontantCpt := Debit
        else
           MontantD.MontantCpt := -Debit;

        if DMRepart.ListeCell.IndexOf(Cellule)=-1 then begin
           //nouvelle cellule
           InfoRepartD.compte.AddObject(cpt_a_repartir,MontantD);
           if signe='+' then
              InfoRepartD.MontantTotal := debit
           else
              InfoRepartD.MontantTotal := -debit;
           DMRepart.ListeCell.AddObject(Cellule,InfoRepartD);
        end
        else begin
           //modification d'un cellule deja presente
           if signe='+' then
              TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal := TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal+debit
           else
              TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal := TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal-debit;
           TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.AddObject(cpt_a_repartir,MontantD);
        end;

        //////////////////--CREDIT--////////////////////////////////////////////
        Cellule := copy(est_reparti_credit(cpt,DMRepart.Repartition),2,length(est_reparti_credit(cpt,DMRepart.Repartition)));
        signe   := copy(est_reparti_credit(cpt,DMRepart.Repartition),0,1);
        if signe='+' then
           MontantC.MontantCpt := Credit
        else
           MontantC.MontantCpt := -Credit;

        if DMRepart.ListeCell.IndexOf(Cellule)=-1 then begin
           //nouvelle cellule
           InfoRepartC.compte.AddObject(cpt_a_repartir,MontantC);
           if signe='+' then
              InfoRepartC.MontantTotal := credit
           else
              InfoRepartC.MontantTotal := -credit;
           DMRepart.ListeCell.AddObject(Cellule,InfoRepartC);
        end
        else begin
           //modification d'un cellule deja presente
           if signe='+' then
              TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal := TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal+credit
           else
              TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal := TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).MontantTotal-credit;
           I := TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.indexof(cpt_a_repartir);
           if I<>-1 then
              if TMontant(TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.Objects[i]).MontantCpt=0 then
              //modification du montant du compte deja ajout� au debit avec un montant = 0
                 TMontant(TRepartition(DMRepart.ListeCell.Objects[DMRepart.ListeCell.IndexOf(Cellule)]).compte.Objects[i]).MontantCpt := MontantC.MontantCpt;
        end;

      Balance.Next;
      end;

  end;

end.
 