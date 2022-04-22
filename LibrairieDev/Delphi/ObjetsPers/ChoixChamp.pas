unit ChoixChamp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TChChamp = class(TForm)
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    ListBox4: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox4Click(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  ChChamp: TChChamp;

implementation

{$R *.DFM}

procedure TChChamp.ListBox1Click(Sender: TObject);
begin
if ListBox1.Items.Count >= 0 then
ListBox2.Items.Add(ListBox1.Items[ListBox1.ItemIndex]);
end;

procedure TChChamp.ListBox4Click(Sender: TObject);
begin
if ListBox4.Items.Count >= 0 then
ListBox3.Items.Add(ListBox4.Items[ListBox4.ItemIndex]);
end;

procedure TChChamp.ListBox3DblClick(Sender: TObject);
begin
if ListBox3.Items.Count >=0 then
   if ListBox3.Items.Count<=ListBox2.Items.Count then begin
   ListBox3.Items.Delete(ListBox3.ItemIndex);
   ListBox2.Items.Delete(ListBox3.ItemIndex);
   end else ListBox3.Items.Delete(ListBox3.ItemIndex);
end;

procedure TChChamp.ListBox2DblClick(Sender: TObject);
begin
if ListBox2.Items.Count >=0 then
   if ListBox2.Items.Count<=ListBox3.Items.Count then begin
   ListBox3.Items.Delete(ListBox3.ItemIndex);
   ListBox2.Items.Delete(ListBox3.ItemIndex);
   end else ListBox2.Items.Delete(ListBox2.ItemIndex);

end;

end.
