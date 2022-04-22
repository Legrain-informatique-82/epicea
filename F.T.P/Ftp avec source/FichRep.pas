unit FichRep;



interface
   uses SysUtils, Classes, QFileCtrls;
   function ListeFichRep(rep:string):TStrings;

implementation

   function ListeFichRep(rep:string):TStrings;
      var Repertoire : TDirectory;
      var I,
          Nbfich : integer;
      var Listefich : TStrings;
   begin
      Repertoire.Location:=rep;
      Repertoire.ListFiles;
      Nbfich := repertoire.Count;
      for  I:=0  to Nbfich do
      begin
          Listefich.Add(repertoire.Files(i).SR.Name);
      end;
      ListeFichRep:=Listefich;
   end;
end.
 