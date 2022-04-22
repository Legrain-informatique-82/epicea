create table PieceSupprime (ID integer,Journal integer,Reference varchar(9),DatePiece date,Libelle varchar(100),
TypePiece integer,Compte varchar(8) ,primary key (id))

create table EcritureSupprime (ID integer,ID_Piece integer,tvatype varchar(2),primary key (id))

CREATE TABLE Compte_Rapp(compte varchar(8),PRIMARY KEY (compte))

Insert into PieceSupprime (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte)
 Select distinct P.id,P.Journal,P.Reference,P."Date",P.Libelle,P.TypePiece,P.Compte from piece P
 where P."date"  <= cast('31/10/2007' as date)
 and P.id not in (select P3.id from h_piecetva h join piece P3 on(P3.reference = h.reference_od) )
 and P.id not in (select id_piece from resteDC dc where dc.reste>0)
 and P.id not in (select E.id_piece from ecriture E where e.compte in (select compte from compte_Rapp )
 and (e.rapprochement is null or e.rapprochement =''''))
 and P.id not in(
 select E2.id_piece from pointage PO 
 join Ecriture E2 on (E2.id=PO.id_debit or E2.id=PO.id_credit)
 where  
    Po."date"  >cast('31/10/2007' as date)
    or  
    Po."Tvadate"  >cast('31/10/2007' as date))
 and P.id not in(select id_piece from h_tva
 where  en_attente=false
 group by id_piece
 having (sum(part_declaree))<1 or fin_periode >cast('31/10/2007' as date) )
 
 
 
insert into EcritureSupprime (id,ID_Piece,tvatype)select E.id,P.id,E.tvatype from PieceSupprime P join ecriture E on(e.id_piece = P.id);


select distinct E1.id_piece from ecrituresupprime E1 
join Ecriture E2 on(E2.id=E1.id)
where E2.tvatype='E' and E1.id in
(select P1.id_debit from pointage P1 where P1.id_credit not in (select E2.id from ecrituresupprime E2))
or E1.id in
(select P2.id_credit from pointage P2 where P2.id_debit not in (select E3.id from ecrituresupprime E3))


select distinct(id_piece) from ecrituresupprime 
WHERE  EXISTS (
select E1.id_piece from ecrituresupprime E1 where (E1.tvatype='E') and (E1.id in
(select P1.id_debit from pointage P1 where P1.id_credit not in (select E2.id from ecrituresupprime E2))
or E1.id in
(select P2.id_credit from pointage P2 where P2.id_debit not in (select E3.id from ecrituresupprime E3))))

select distinct(id_piece) from ecrituresupprime E1 
where 
(exists(select ec.id_piece from ecriture ec
join plancpt pl on pl.compte=ec.compte
 where (ec.id_piece=E1.id_piece) and ((ec.tiers is not null and ec.tiers <>'' or (pl.pointable=true))))) 
and 
 (E1.id in
 (select P1.id_debit from pointage P1 where P1.id_credit not in (select E2.id from ecrituresupprime E2))
 or E1.id in
 (select P2.id_credit from pointage P2 where P2.id_debit not in (select E3.id from ecrituresupprime E3)))
