Select
    e.typeligne, sum(E.debit)
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
   And Not  Exists (Select R1.Id_ecriture from restedc R1
                                               Join Ecriture E11 On (R1.Id_ecriture = E11.Id)
                    Where 
                      E11.TypeLigne = 'H' and E11.TVAType = 'E' and
                      r1."date" <= '10/10/2000' and  r1."date" >= '10/10/2000' and P.Id = e11.id_piece)

   And Exists (Select Po1.Id_Debit from Pointage Po1
                                               Join Ecriture E24 On (Po1.Id_Debit = E24.Id)
                    Where 
                      E24.TypeLigne = 'H' and E24.TVAType = 'E' and
                      Po1.Tvadate <= '10/10/2000' and  Po1.Tvadate >= '10/10/2000' and P.Id = e24.id_piece)
group By
  E.TypeLigne
   
union

Select
    e3.typeligne,  sum(E3.debit)
From
   Piece P3
   Join Ecriture E3 On (P3.Id = E3.Id_Piece)
where
   E3.TypeLigne = 'T'
   And Not exists (Select P4.Id from Piece P4
                                Join Ecriture E4 On (P4.Id = E4.Id_Piece)
                  Where
                      E4.TypeLigne = 'H' and E4.TVAType <> 'E' and P3.Id = P4.Id)
   And Not  Exists (Select R2.Id_ecriture from restedc R2
                                               Join Ecriture E12 On (R2.Id_ecriture = E12.Id)
                    Where 
                      E12.TypeLigne = 'H' and E12.TVAType = 'E' and
                      r2."date" <= '10/10/2000' and  r2."date" >= '10/10/2000' and P3.Id = e12.id_piece)
   And Exists (Select Po.Id_Debit from Pointage Po
                                               Join Ecriture E23 On (Po.Id_Debit = E23.Id)
                    Where 
                      E23.TypeLigne = 'H' and E23.TVAType = 'E' and
                      Po.Tvadate <= '10/10/2000' and  Po.Tvadate >= '10/10/2000' and P3.Id = e23.id_piece)
group by E3.TypeLigne
  

