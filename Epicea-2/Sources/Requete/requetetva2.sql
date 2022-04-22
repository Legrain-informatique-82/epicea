select E.Id_Piece, E.TypeLigne,E.TvaCode,E.TvaType, sum(E.CreditSaisie) as Credit,sum(E.DebitSaisie) as Debit
   from Ecriture E,:program:TvaCode Ta
   where 
   (E.Id_Piece='41' and E.TvaType <> '' and 
   E.TvaCode in (select T.TvaCode from :program:TvaCode T where
                                                          T.Compte <>''))

group by E.Id_Piece,E.TypeLigne,E.TvaCode,E.TvaType

