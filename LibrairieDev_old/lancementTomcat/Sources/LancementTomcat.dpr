library LgrLib;

{ Remarque importante � propos de la gestion m�moire des DLL : ShareMem doit
  �tre la premi�re unit� dans la clause USES de votre biblioth�que,
  ET dans la clause USES de votre projet (s�lectionnez Voir-Source du projet)
  si vos DLLs exportent des proc�dures ou des fonctions passant en param�tre
  des cha�nes ou des r�sultats de fonction.
  Ceci s'applique � toutes les cha�nes pass�es par ou � vos DLLs - m�mes celles
  qui sont imbriqu�es dans des enregistrements ou des classes. ShareMem est
  l'unit� d'interface au gestionnaire de m�moire partag�e DELPHIMM.DLL, qui
  doit �tre d�ploy� avec vos propres DLLs. Pour �viter l'emploi de DELPHIMM.DLL,
  passez vos cha�nes en utilisant des param�tres PChar ou ShortString. }


uses
  SysUtils,
  Classes,IdHTTP;


Const

C_ToutesForm = -1;
C_A_Propos = 0;
C_AvertDemo = 1;
C_Sauvegarde = 2;
//C_Restauration = 3;

function DemarreServiceEditionTomcat:boolean;
var
IdHTTP1:TIdHTTP;
begin
  IdHTTP1.Get('http://localhost:8080/');
end;

begin

end.
