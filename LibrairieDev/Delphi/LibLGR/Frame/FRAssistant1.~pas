unit FRAssistant1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,LibSQL;

type
  TFRAssistant = class(TFrame)
    PaBtn: TPanel;
    BtnPrecedent: TButton;
    BtnSuivant: TButton;
    BtnAnnuler: TButton;
    procedure BtnAnnulerClick(Sender: TObject);
    Procedure Etape0(Sender : TObject);
    Procedure Etape1(Sender : TObject);
    Procedure Etape2(Sender : TObject);
    Procedure Etape3(Sender : TObject);
    Procedure Etape4(Sender : TObject);
    Procedure Etape5(Sender : TObject);
    Procedure Etape6(Sender : TObject);
    Procedure Etape7(Sender : TObject);
    Procedure Etape8(Sender : TObject);
    Procedure Etape9(Sender : TObject);
    Procedure EtapeFin(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    EvEtape0:TNotifyEvent;
    EvEtape1:TNotifyEvent;
    EvEtape2:TNotifyEvent;
    EvEtape3:TNotifyEvent;
    EvEtape4:TNotifyEvent;
    EvEtape5:TNotifyEvent;
    EvEtape6:TNotifyEvent;
    EvEtape7:TNotifyEvent;
    EvEtape8:TNotifyEvent;
    EvEtape9:TNotifyEvent;
    EvEtapeFin : TNotifyEvent;
    Procedure InitScenario(TAbAction:array of TNotifyEvent;EtapFin:TNotifyEvent);
  end;

implementation


{$R *.dfm}

Procedure TFRAssistant.InitScenario(TAbAction:array of TNotifyEvent;EtapFin:TNotifyEvent);
var
i:integer;
Begin
  try
    if @EtapFin = nil then
     showmessage('L''étape de fin est obligatoire !')
      else EvEtapeFin := EtapFin;
    for i:=0 to high(TAbAction) do
     begin
       case i of
         0:EvEtape0 := TAbAction[i];
         1:EvEtape1 := TAbAction[i];
         2:EvEtape2 := TAbAction[i];
         3:EvEtape3 := TAbAction[i];
         4:EvEtape4 := TAbAction[i];
         5:EvEtape5 := TAbAction[i];
         6:EvEtape6 := TAbAction[i];
         7:EvEtape7 := TAbAction[i];
         8:EvEtape8 := TAbAction[i];
         9:EvEtape9 := TAbAction[i];
         else showmessage('Erreur dans le parcours du tableau de InitScenario ! i = '+inttostr(i)) ;
       end;
     end;
    BtnPrecedent.OnClick :=Etape1;
    BtnSuivant.OnClick := Etape0;
    BtnSuivant.Caption := 'Démarrer';
    BtnPrecedent.Enabled := False;
  except
    showmessage('Erreur dans le Frame Assistant lors de InitScenario !') ;
    BtnPrecedent.Enabled := False;
    BtnPrecedent.Enabled := False;
  end;
End;


procedure TFRAssistant.BtnAnnulerClick(Sender: TObject);
var
WinControl:TWincontrol;
begin
  WinControl:=self.Parent;
  while not (WinControl is TForm) do
   WinControl:=WinControl.Parent;

   (WinControl as TForm).ModalResult := mrCancel;
  if (WinControl as TForm).Visible then
     (WinControl as TForm).Close;
end;

Procedure TFRAssistant.Etape0(Sender : TObject);
Begin
//  showmessage('Etape0');
  if (Sender is TButton) then
   begin
    try
      if @EvEtape0 <> nil then
       begin
         EvEtape0(sender);
       end;
    except
     abort;
    end;

    if (Sender as TButton) = BtnSuivant then
     begin
      BtnSuivant.Caption := 'Suivant ...';
      BtnPrecedent.OnClick := Etape0;
      BtnPrecedent.Enabled := true;
      if @EvEtape1 <> nil then
        begin
         (Sender as TButton).OnClick := Etape1;
        end
       else
        begin
          BtnSuivant.Caption :='Terminer';
          BtnSuivant.OnClick := EtapeFin;
        end;
     end;

    if (Sender as TButton) = BtnPrecedent then
     begin
      BtnPrecedent.Enabled := False;
      BtnSuivant.OnClick := Etape1;
      BtnSuivant.Caption := 'Suivant ...';
     end;
   end;
End;

Procedure TFRAssistant.Etape1(Sender : TObject);
Begin
//showmessage('Etape1');
  if (Sender is TButton) then
   begin
   try
    if @EvEtape1 <> nil then
     begin
       EvEtape1(sender);
     end;
   except
    abort;
   end;

    if (Sender as TButton) = BtnSuivant then
     begin
      BtnPrecedent.Enabled := true;
      BtnPrecedent.OnClick := Etape0;
      if @EvEtape2 <> nil then
         begin
          (Sender as TButton).OnClick := Etape2;
         end
        else
         begin
          BtnSuivant.Caption :='Terminer';
          BtnSuivant.OnClick := EtapeFin;
         end;
     end;
    if (Sender as TButton) = BtnPrecedent then
     begin
      BtnSuivant.OnClick := Etape2;
      (Sender as TButton).OnClick := Etape0;
      BtnSuivant.Caption := 'Suivant ...';
     end;
   end;
End;

Procedure TFRAssistant.Etape2(Sender : TObject);
Begin
//showmessage('Etape2');
  if (Sender is TButton) then
   begin
    try
      if @EvEtape2 <> nil then
       begin
         EvEtape2(sender);
       end;
    except
      abort;
    end;

    if (Sender as TButton) = BtnSuivant then
     begin
       BtnPrecedent.Enabled := true;
       BtnPrecedent.OnClick := Etape1;
       if @EvEtape3 <> nil then
          begin
          (Sender as TButton).OnClick := Etape3;
          end
        else
           begin
            BtnSuivant.Caption :='Terminer';
            BtnSuivant.OnClick := EtapeFin;
           end;
     end;
    if (Sender as TButton) = BtnPrecedent then
     begin
       BtnSuivant.OnClick := Etape3;
      (Sender as TButton).OnClick := Etape1;
       BtnSuivant.Caption := 'Suivant ...';
     end;
   end;
End;

Procedure TFRAssistant.Etape3(Sender : TObject);
Begin
//showmessage('Etape3');
  if (Sender is TButton) then
   begin
    try
      if @EvEtape3 <> nil then
       begin
         EvEtape3(sender);
       end;
    except
      abort;
    end;

    if (Sender as TButton) = BtnSuivant then
     begin
       BtnPrecedent.Enabled := true;
       BtnPrecedent.OnClick := Etape2;
       if @EvEtape4 <> nil then
         begin
          (Sender as TButton).OnClick := Etape4;
         end
       else
         begin
           BtnSuivant.Caption :='Terminer';
           BtnSuivant.OnClick := EtapeFin;
         end;
     end;
    if (Sender as TButton) = BtnPrecedent then
     begin
      BtnSuivant.OnClick := Etape4;
      (Sender as TButton).OnClick := Etape2;
      BtnSuivant.Caption := 'Suivant ...';
     end;
   end;
End;

Procedure TFRAssistant.Etape4(Sender : TObject);
Begin
//showmessage('Etape4');
  if (Sender is TButton) then
   begin
    try
      if @EvEtape4 <> nil then
       begin
         EvEtape4(sender);
       end;
    except
      abort;
    end;

    if (Sender as TButton) = BtnSuivant then
     begin
      BtnPrecedent.Enabled := true;
      BtnPrecedent.OnClick := Etape3;
       if @EvEtape5 <> nil then
         begin
          (Sender as TButton).OnClick := Etape5;
         end
       else
         begin
           BtnSuivant.Caption :='Terminer';
           BtnSuivant.OnClick := EtapeFin;
         end;
     end;
    if (Sender as TButton) = BtnPrecedent then
     begin
      BtnSuivant.OnClick := Etape5;
      (Sender as TButton).OnClick := Etape3;
      BtnSuivant.Caption := 'Suivant ...';
     end;
   end;
End;

Procedure TFRAssistant.Etape5(Sender : TObject);
Begin
//showmessage('Etape5');
  if (Sender is TButton) then
   begin
    try
      if @EvEtape5 <> nil then
       begin
         EvEtape5(sender);
       end;
    except
      abort;
    end;

    if (Sender as TButton) = BtnSuivant then
     begin
      BtnPrecedent.Enabled := true;
      BtnPrecedent.OnClick := Etape4;
       if @EvEtape6 <> nil then
         begin
         (Sender as TButton).OnClick := Etape6;
         end
       else
         begin
           BtnSuivant.Caption :='Terminer';
           BtnSuivant.OnClick := EtapeFin;
         end;
     end;
    if (Sender as TButton) = BtnPrecedent then
     begin
      BtnSuivant.OnClick := Etape6;
      (Sender as TButton).OnClick := Etape4;
      BtnSuivant.Caption := 'Suivant ...';
     end;
   end;
End;

Procedure TFRAssistant.Etape6(Sender : TObject);
Begin
//showmessage('Etape6');
  if (Sender is TButton) then
   begin
    try
      if @EvEtape6 <> nil then
       begin
         EvEtape6(sender);
       end;
    except
      abort;
    end;

    if (Sender as TButton) = BtnSuivant then
     begin
       BtnPrecedent.Enabled := true;
       BtnPrecedent.OnClick := Etape5;
       if @EvEtape7 <> nil then
         begin
          (Sender as TButton).OnClick := Etape7;
         end
       else
         begin
           BtnSuivant.Caption :='Terminer';
           BtnSuivant.OnClick := EtapeFin;
         end;
     end;
    if (Sender as TButton) = BtnPrecedent then
     begin
      BtnSuivant.OnClick := Etape7;
      (Sender as TButton).OnClick := Etape5;
      BtnSuivant.Caption := 'Suivant ...';
     end;
   end;
End;

Procedure TFRAssistant.Etape7(Sender : TObject);
Begin
//showmessage('Etape7');
  if (Sender is TButton) then
   begin
    try
      if @EvEtape7 <> nil then
       begin
         EvEtape7(sender);
       end;
    except
      abort;
    end;

    if (Sender as TButton) = BtnSuivant then
     begin
      BtnPrecedent.Enabled := true;
      BtnPrecedent.OnClick := Etape6;
       if @EvEtape8 <> nil then
         begin
          (Sender as TButton).OnClick := Etape8;
         end
       else
         begin
           BtnSuivant.Caption :='Terminer';
           BtnSuivant.OnClick := EtapeFin;
         end;
     end;
    if (Sender as TButton) = BtnPrecedent then
     begin
      BtnSuivant.OnClick := Etape8;
      (Sender as TButton).OnClick := Etape6;
      BtnSuivant.Caption := 'Suivant ...';
     end;
   end;
End;

Procedure TFRAssistant.Etape8(Sender : TObject);
Begin
//showmessage('Etape8');
  if (Sender is TButton) then
   begin
    try
      if @EvEtape8 <> nil then
       begin
         EvEtape8(sender);
       end;
    except
      abort;
    end;

    if (Sender as TButton) = BtnSuivant then
     begin
       BtnPrecedent.Enabled := true;
       BtnPrecedent.OnClick := Etape7;
       if @EvEtape9 <> nil then
         begin
          (Sender as TButton).OnClick := Etape9;
         end
       else
         begin
           BtnSuivant.Caption :='Terminer';
           BtnSuivant.OnClick := EtapeFin;
         end;
     end;
    if (Sender as TButton) = BtnPrecedent then
     begin
      BtnSuivant.OnClick := Etape9;
      (Sender as TButton).OnClick := Etape7;
      BtnSuivant.Caption := 'Suivant ...';
     end;
   end;
End;

Procedure TFRAssistant.Etape9(Sender : TObject);
Begin
//showmessage('Etape9');
  if (Sender is TButton) then
   begin
    try
      if @EvEtape9 <> nil then
       begin
         EvEtape9(sender);
       end;
    except
      abort;
    end;

    if (Sender as TButton) = BtnSuivant then
     begin
       BtnPrecedent.Enabled := true;
       BtnPrecedent.OnClick := Etape8;

       BtnSuivant.Caption :='Terminer';
       (Sender as TButton).OnClick := EtapeFin;

     end;
    if (Sender as TButton) = BtnPrecedent then
     begin
      BtnSuivant.OnClick := nil;
      (Sender as TButton).OnClick := Etape8;
       BtnSuivant.Caption := 'Suivant ...';
     end;
   end;
End;

Procedure TFRAssistant.EtapeFin(Sender: TObject);
Begin
  try
    if @EvEtapeFin <> nil then
       EvEtapeFin(Sender)
       else
       Showmessage('L''étape de fin ne doit pas être nil !');
  except
   abort;
  end;

End;

end.
