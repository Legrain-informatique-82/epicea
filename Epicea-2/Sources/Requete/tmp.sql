select E.* 
from
  Pointage Po
  Join Ecriture E On (E.Id = Po.Id_debit or E.Id = Po.Id_Credit)
  