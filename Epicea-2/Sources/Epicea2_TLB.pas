unit Epicea2_TLB;

// ************************************************************************ //
// AVERTISSEMENT                                                                 
// -------                                                                    
// Les types d�clar�s dans ce fichier ont �t� g�n�r�s � partir de donn�es lues 
// depuis la biblioth�que de types. Si cette derni�re (via une autre biblioth�que de types 
// s'y r�f�rant) est explicitement ou indirectement r�-import�e, ou la commande "Rafra�chir"  
// de l'�diteur de biblioth�que de types est activ�e lors de la modification de la biblioth�que 
// de types, le contenu de ce fichier sera r�g�n�r� et toutes les modifications      
// manuellement apport�es seront perdues.                                     
// ************************************************************************ //

// PASTLWTR : 1.2
// Fichier g�n�r� le 25/03/2022 14:37:54 depuis la biblioth�que de types ci-dessous.

// ************************************************************************  //
// Bibl. types : C:\Projet\Epicea-2\Sources\Epicea2.tlb (1)
// LIBID: {420BB0C8-F16D-11D6-8AF1-00C0268E293C}
// LCID: 0
// Fichier d'aide : 
// Cha�ne d'aide : Epicea2 (biblioth�que)
// DepndLst: 
//   (1) v1.0 stdole, (C:\Windows\system32\stdole32.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // L'unit� doit �tre compil�e sans pointeur � type contr�l�. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS d�clar�s dans la biblioth�que de types. Pr�fixes utilis�s :    
//   Biblioth�ques de types : LIBID_xxxx                                      
//   CoClasses              : CLASS_xxxx                                      
//   DISPInterfaces         : DIID_xxxx                                       
//   Non-DISP interfaces    : IID_xxxx                                        
// *********************************************************************//
const
  // Versions majeure et mineure de la biblioth�que de types
  Epicea2MajorVersion = 1;
  Epicea2MinorVersion = 0;

  LIBID_Epicea2: TGUID = '{420BB0C8-F16D-11D6-8AF1-00C0268E293C}';

  IID_Interface1: TGUID = '{B1D35309-02E2-11D7-8AF1-00C0268E293C}';
type

// *********************************************************************//
// D�claration Forward des types d�finis dans la biblioth�que de types    
// *********************************************************************//
  Interface1 = interface;
  Interface1Disp = dispinterface;

// *********************************************************************//
// Interface   : Interface1
// Indicateurs : (4432) Hidden Dual OleAutomation Dispatchable
// GUID        : {B1D35309-02E2-11D7-8AF1-00C0268E293C}
// *********************************************************************//
  Interface1 = interface(IDispatch)
    ['{B1D35309-02E2-11D7-8AF1-00C0268E293C}']
  end;

// *********************************************************************//
// DispIntf :  Interface1Disp
// Flags :     (4432) Hidden Dual OleAutomation Dispatchable
// GUID :      {B1D35309-02E2-11D7-8AF1-00C0268E293C}
// *********************************************************************//
  Interface1Disp = dispinterface
    ['{B1D35309-02E2-11D7-8AF1-00C0268E293C}']
  end;

implementation

uses ComObj;

end.
