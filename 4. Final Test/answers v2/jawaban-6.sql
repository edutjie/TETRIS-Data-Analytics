with parents as (
	select node
	from nodes
	where node in (
		select parent from nodes
	)
)
select
	n.node,
	case
		when isnull(n.parent) then 'Akar'
		when isnull(p.node) then 'Daun'
		else 'Batang'
	end as position
from nodes n
left join parents p using(node)
order by 1