SELECT DISTINCT D.ID_Piece, D1.ID,D2.ID_Piece, D3.ID
FROM Ecriture D, Piece D1, :Exercice:Ecriture D2, :Exercice:Piece D3
WHERE
(D1.ID = D.ID_Piece) and (D3.ID = D2.ID_Piece)
ORDER BY D.ID_Piece, D1.ID,D2.ID_Piece, D3.ID