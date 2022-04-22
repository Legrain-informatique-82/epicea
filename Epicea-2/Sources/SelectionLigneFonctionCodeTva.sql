select * from Ecriture E,Piece P where E.TVACode in 
(select TvaCode from :Program:TVACode where Classe in ('A','I','V')) and (E.ID_Piece=P.ID)
