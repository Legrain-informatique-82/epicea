unit Lib1;

interface
Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics,
     Controls,
     Dialogs,
     Math,stdctrls;


type

TChamp=(GrNum,GrCurr,GrDate,GrCompte,GrBool,GrTous);
//TChamp_Readonly=(T,F);
//TCellule_Readonly=TChamp_Readonly;



TListBool = Class(TList)

Private
   Function GetItems(Index :Integer) :Boolean;
   Procedure SetItems(Index :Integer; NewValue :Boolean);
Public
	Destructor Destroy; override;
	function Add(Valeur :Boolean): Integer;
	Procedure Insert(Index: Integer; Valeur :Boolean);
	procedure Delete(Index: Integer);
	procedure Clear;
        property Items[Index: Integer]: Boolean Read GetItems Write SetItems;
End;
TListInt = Class(TList)

Private
//FListInt:Tlist;
	Function GetItems(Index :Integer) :LongInt;
   Procedure SetItems(Index :Integer; NewValue :LongInt);
Public
	Destructor Destroy; override;
//        constructor Create(Aowner:Tcomponent);
	function Add(Valeur :LongInt): Integer;
	Procedure Insert(Index: Integer; Valeur :LongInt);
	procedure Delete(Index: Integer);
	procedure Clear;
   property Items[Index: Integer]: LongInt Read GetItems Write SetItems;
End;


TListChamp = Class(TList)

Private
   Function GetItems(Index :Integer) :TChamp;
   Procedure SetItems(Index :Integer; NewValue :TChamp);
Public
	Destructor Destroy; override;
	function Add(Valeur :TChamp): Integer;
	Procedure Insert(Index: Integer; Valeur :TChamp);
	procedure Delete(Index: Integer);
	procedure Clear;
        property Items[Index: Integer]: TChamp Read GetItems Write SetItems;
End;


implementation

uses LibFichRep;



//constructor TListInt.Create(Aowner:Tcomponent);
//Begin
//inherited Create(Aowner);
//
//End;

Destructor TListInt.Destroy;
Begin
	Clear;
   Inherited Destroy;
End;


//******************************************************************************
Function TListInt.GetItems(Index :Integer) :LongInt;
Var
	i :^LongInt;
Begin
	i:= Inherited Items[Index];
	Result:= i^;
End;

//******************************************************************************
Procedure TListInt.SetItems(Index :Integer; NewValue :LongInt);
Var
	i :^LongInt;
Begin
	i:= Inherited Items[Index];
   i^:= NewValue;
End;

//******************************************************************************
function TListInt.Add(Valeur :LongInt): Integer;
Var
	i :^LongInt;
Begin
	New(i);
   i^:= Valeur;
	Result:= Inherited Add(i);
End;

//******************************************************************************
Procedure TListInt.Insert(Index: Integer; Valeur :LongInt);
Var
	i :^LongInt;
Begin
	New(i);
   i^:= Valeur;
	Inherited Insert(Index, i);
End;

//******************************************************************************
procedure TListInt.Delete(Index: Integer);
Var
	i :^LongInt;
Begin
	i:= Inherited Items[Index];
   Dispose(i);
	Inherited Delete(Index);
End;

//******************************************************************************
procedure TListInt.Clear;
Var
	i :^LongInt;
   Index :Integer;
Begin
	for index:= 0 to Count -1 do Begin
		i:= Inherited Items[Index];
   	Dispose(i);
   End;
	Inherited Clear;
End;

//******************************************************************************
//******************************************************************************
Destructor TListBool.Destroy;
Begin
	Clear;
   Inherited Destroy;
End;


//******************************************************************************
Function TListBool.GetItems(Index :Integer) :Boolean;
Var
	i :^Boolean;
Begin
	i:= Inherited Items[Index];
	Result:= i^;
End;

//******************************************************************************
Procedure TListBool.SetItems(Index :Integer; NewValue :Boolean);
Var
	i :^Boolean;
Begin
	i:= Inherited Items[Index];
   i^:= NewValue;
End;

//******************************************************************************
function TListBool.Add(Valeur :Boolean): Integer;
Var
	i :^Boolean;
Begin
	New(i);
   i^:= Valeur;
	Result:= Inherited Add(i);
End;

//******************************************************************************
Procedure TListBool.Insert(Index: Integer; Valeur :Boolean);
Var
	i :^Boolean;
Begin
	New(i);
   i^:= Valeur;
	Inherited Insert(Index, i);
End;

//******************************************************************************
procedure TListBool.Delete(Index: Integer);
Var
	i :^Boolean;
Begin
	i:= Inherited Items[Index];
   Dispose(i);
	Inherited Delete(Index);
End;

//******************************************************************************
procedure TListBool.Clear;
Var
	i :^Boolean;
   Index :Integer;
Begin
	for index:= 0 to Count -1 do Begin
		i:= Inherited Items[Index];
   	Dispose(i);
   End;
	Inherited Clear;
End;

//**************************************************************************************
//**************************************************************************************
//**************************************************************************************

Destructor TListChamp.Destroy;
Begin
	Clear;
   Inherited Destroy;
End;


//******************************************************************************
Function TListChamp.GetItems(Index :Integer) :TChamp;
Var
	i :^TChamp;
Begin
	i:= Inherited Items[Index];
	Result:= i^;
End;

//******************************************************************************
Procedure TListChamp.SetItems(Index :Integer; NewValue :TChamp);
Var
	i :^TChamp;
Begin
	i:= Inherited Items[Index];
   i^:= NewValue;
End;

//******************************************************************************
function TListChamp.Add(Valeur :TChamp): Integer;
Var
	i :^TChamp;
Begin
	New(i);
   i^:= Valeur;
	Result:= Inherited Add(i);
End;

//******************************************************************************
Procedure TListChamp.Insert(Index: Integer; Valeur :TChamp);
Var
	i :^TChamp;
Begin
	New(i);
   i^:= Valeur;
	Inherited Insert(Index, i);
End;

//******************************************************************************
procedure TListChamp.Delete(Index: Integer);
Var
	i :^TChamp;
Begin
	i:= Inherited Items[Index];
   Dispose(i);
	Inherited Delete(Index);
End;

//******************************************************************************
procedure TListChamp.Clear;
Var
	i :^TChamp;
   Index :Integer;
Begin
	for index:= 0 to Count -1 do Begin
		i:= Inherited Items[Index];
   	Dispose(i);
   End;
	Inherited Clear;
End;





end.
