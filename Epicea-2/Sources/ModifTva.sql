select distinct E.tvaCode, sum(H.montanttva) as TVADebit,divers,sum(H.part_declaree)as part_declaree from h_tva H
left join Ecriture E on (E.id=H.id_ecriture)
where ((E.debitsaisie<>0 and not(E.debitsaisie is null) and H.id_declaration=1)or(H.id_ecriture=1)) and en_attente=false
 group by E.tvaCode,divers
