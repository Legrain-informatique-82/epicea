Select
    P.Id, E.*
From
   Piece P
   Join Ecriture E On (P.Id = E.Id_Piece)
   Join :program:TvaCode T On(E.TvaCode = T.Tvacode)
Where
   E.TypeLigne = 'H' and E.TVAType = 'E'
   And E.TvaDate <= '10/10/2000' and  E.TvaDate >= '10/10/2000'
   And T.Classe In ('A','V','I')
   And Not exists (Select P1.Id from Piece P1
                                Join Ecriture E1 On (P1.Id = E1.Id_Piece)
                  Where
                      E1.TypeLigne = 'H' and E1.TVAType <> 'E' and P1.Id = P.Id)
   
union

Select
    P3.Id, E3.*
From
   Piece P3
   Join Ecriture E3 On (P3.Id = E3.Id_Piece)
where
   E3.TypeLigne = 'T'
   And Not exists (Select P4.Id from Piece P4
                                Join Ecriture E4 On (P4.Id = E4.Id_Piece)
                  Where
                      E4.TypeLigne = 'H' and E4.TVAType <> 'D' and P3.Id = P4.Id)
  

