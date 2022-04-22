Select
    distinct P.Id
From
   Piece P
   Join Ecriture E On (P.Id = E.Id_Piece)
   Join :program:TvaCode T On(E.TvaCode = T.Tvacode)
Where
   (E.TypeLigne = 'H' and E.TVAType In ('D')
   And E.TvaDate >= '01/01/2000' and  E.TvaDate <= '03/31/2000'
   And T.Classe In ('A','V','I')
   and exists (select 1 from Piece p3
                             join ecriture e2 on (P3.id = e2.id_piece)
                     where
                        E2.TypeLigne = 'H' and E2.TVAType = 'D' 
                        and E2.TvaDate < '01/01/2000' or E2.TvaDate >'03/31/2000'
                        and p3.id = p.id))
   or
   (E.TypeLigne = 'H' and E.TVAType In ('E')
   And T.Classe In ('A','V','I')
   and exists (select 1 from Piece p3
                             join ecriture e2 on (P3.id = e2.id_piece)
                     where
                        E2.TypeLigne = 'H' and E2.TVAType = 'E' 
                        and p3.id = p.id))

   
