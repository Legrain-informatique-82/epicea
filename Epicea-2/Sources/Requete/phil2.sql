Select
    P.Id
From
   Piece P
   Join Ecriture E On (P.Id = E.Id_Piece)
Where
   E.TypeLigne = 'H' and E.TVAType = 'D'
   And E.TvaDate <= '10/10/2000' and  E.TvaDate >= '10/10/2000'
   And Not exists (Select P1.Id from Piece P1
                                Join Ecriture E1 On (P1.Id = E1.Id_Piece)
                  Where
                      E1.TypeLigne = 'H' and E1.TVAType <> 'D' and P1.Id = P.Id)
   
