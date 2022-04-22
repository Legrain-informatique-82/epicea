select B.compte,sum(B.debit_report+B.debit_base)as debitCollectif,sum(B.credit_report+B.credit_base)as creditCollectif,
sum(Bt.debit_report+Bt.debit_base)as debitTiers,sum(Bt.credit_report+Bt.credit_base)as creditTiers 
from balance B, balanceTiers BT,"C:\Lgrdoss\EPICEA\92155\plancpt"P
where B.compte = BT.compte
and P.compte = B.compte
and P.collectif = true
group by B.compte
having (sum(B.debit_report+B.debit_base)<>sum(Bt.debit_report+Bt.debit_base)) or
(sum(B.credit_report+B.credit_base)<>sum(Bt.credit_report+Bt.credit_base))

select sum(RC.reste)-(select sum(Rd.reste)
from ResteDC Rd  
left join Tiers T on(rd.tiers=T.tiers )
where  T.compte='411' and Rd.sens='D' and Rd.reste<>0)
from ResteDC RC  
left join Tiers T on(rc.tiers=T.tiers )
where  T.compte='411' and RC.sens='C' and RC.reste<>0


select B.compte,sum(B.credit_report+B.credit_base)-sum(B.debit_report+B.debit_base)
from "C:\Lgrdoss\EPICEA\92155\2007\balance" B, "C:\Lgrdoss\EPICEA\92155\plancpt"P
where  P.compte = B.compte
and P.pointable = true
group by B.compte



update balance set debit_base =0 where debit_base is null
update balance set credit_base =0 where credit_base is null 
update balance set debit_report =0 where debit_report is null 
update balance set credit_report =0 where credit_report is null



update balanceTiers set debit_base =0 where debit_base is null
update balanceTiers set credit_base =0 where credit_base is null 
update balanceTiers set debit_report =0 where debit_report is null 
update balanceTiers set credit_report =0 where credit_report is null


select sum(RC.reste)-(select sum(Rd.reste)
from "C:\Lgrdoss\EPICEA\92155\ResteDC" Rd  
left join "C:\Lgrdoss\EPICEA\92155\Tiers" T on(rd.tiers=T.tiers )
where  Rd.reste<>0 and Rd.sens='D'
and T.compte='411')
from "C:\Lgrdoss\EPICEA\92155\ResteDC" RC  
left join "C:\Lgrdoss\EPICEA\92155\Tiers" T on(rc.tiers=T.tiers )
where  RC.sens='C' and RC.reste<>0 and T.compte='411'


select B.compte,sum(B.credit_report+B.credit_base)-sum(B.debit_report+B.debit_base)
from "C:\Lgrdoss\EPICEA\92155\2007\balanceTiers" B
group by B.compte
