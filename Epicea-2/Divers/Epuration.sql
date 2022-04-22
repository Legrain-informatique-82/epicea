Selection liste des pièces :

   
//travail sur tous les exercices clôturés
Select distinct P.id from piece P
where exists (select id_table from gdossier gd where cloture=true and 
P."date"  between gd.date_deb_exo and gd.date_fin_exo)
and P.id not in (select P3.id from h_piecetva h join piece P3 on(P3.reference = h.reference_od) )
and P.id not in (select id_piece from resteDC dc where dc.reste>0)
and P.id not in (select E.id_piece from ecriture E where e.compte in (select compte from compte_Rapp)
and (e.rapprochement is null or e.rapprochement =''''))
and P.id not in(
select E2.id_piece from pointage PO 
join Ecriture E2 on (E2.id=PO.id_debit or E2.id=PO.id_credit)
where (exists (select id_table from gdossier gd where cloture=false and 
   Po."date"  between gd.date_deb_exo and gd.date_fin_exo)
   or exists (select id_table from gdossier gd where cloture=false and 
   Po."Tvadate"  between gd.date_deb_exo and gd.date_fin_exo)))
and P.id not in (select id_piece from h_tva 
where  en_attente=false
group by id_piece 
having (sum(part_declaree))<1 or fin_periode >(select max(date_fin_exo)from gdossier where cloture=false)  
)


//travail jusqu''à l''exercice spécifié
Select distinct P.id from piece P
where p.id/10000000=04 and P."date"  <= cast('31/12/2004' as date)
and P.id not in (select P3.id from h_piecetva h join piece P3 on(P3.reference = h.reference_od) )
and P.id not in (select id_piece from resteDC dc where dc.reste>0)
and P.id not in (select E.id_piece from ecriture E where e.compte in (select compte from compte_Rapp)
and (e.rapprochement is null or e.rapprochement =''))
and P.id not in(
select E2.id_piece from pointage PO 
join Ecriture E2 on (E2.id=PO.id_debit or E2.id=PO.id_credit)
where Po."date"  > cast('31/12/2004' as date)
   or Po."Tvadate"  > cast('31/12/2004' as date))
and P.id not in (select id_piece from h_tva 
where  en_attente=false
group by id_piece 
having (sum(part_declaree))<1 or fin_periode > cast('31/12/2004' as date) )

//divers
//Création de la table pour les comptes rapprochables
CREATE TABLE Compte_Rapp(compte varchar(8),PRIMARY KEY (compte))
create table PieceSupprime (ID integer,Journal integer,Reference varchar(9),DatePiece date,Libelle varchar(100),TypePiece integer,Compte varchar(8) ,primary key (id))
insert into Compte_Rapp  (compte) select distinct compte from ecriture where rapprochement is not null and rapprochement<>''

create table EcritureSupprime (ID integer,ID_Piece integer,primary key (id))
insert into EcritureSupprime (id,ID_Piece)select E.id,P.id from PieceSupprime P join ecriture E on(e.id_piece = P.id)
select count(distinct id_piece) from ecrituresupprime

select count(distinct E1.id_piece) from ecrituresupprime E1 where E1.id in 
(select P1.id_debit from pointage P1 where P1.id_credit not in (select E2.id from ecrituresupprime E2))
or
E1.id in 
(select P2.id_credit from pointage P2 where P2.id_debit not in (select E3.id from ecrituresupprime E3))


delete from ecritureSupprime where id_piece in
(select distinct E1.id_piece from ecrituresupprime E1 where E1.id in 
(select id_debit from pointage where id_credit not in (select E2.id from ecrituresupprime E2))
or
E1.id in 
(select id_credit from pointage where id_debit not in (select E2.id from ecrituresupprime E2)))


//fin divers


Insert into PieceSupprime (ID ,Journal ,Reference ,DatePiece ,Libelle ,TypePiece ,Compte)
Select distinct P.id from piece P
where  P."date"  <= cast('31/12/2004' as date)
and P.id not in (select P3.id from h_piecetva h join piece P3 on(P3.reference = h.reference_od) )
and P.id not in (select id_piece from resteDC dc where dc.reste>0)
and P.id not in (select E.id_piece from ecriture E where e.compte in (select compte from compte_Rapp)
and (e.rapprochement is null or e.rapprochement =''))
and P.id not in(
select E2.id_piece from pointage PO 
join Ecriture E2 on (E2.id=PO.id_debit or E2.id=PO.id_credit)
where Po."date"  > cast('31/12/2004' as date)
   or Po."Tvadate"  > cast('31/12/2004' as date))
and P.id not in (select id_piece from h_tva 
where  en_attente=false
group by id_piece 
having (sum(part_declaree))<1 or fin_periode > cast('31/12/2004' as date) )
