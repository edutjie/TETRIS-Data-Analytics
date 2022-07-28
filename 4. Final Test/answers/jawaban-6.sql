with parents as (
	select node
	from nodes
	where node in (
		select parent from nodes
	)
)
select
	n.node as Node,
	case
		when isnull(n.parent) then 'akar'
		when isnull(p.node) then 'daun'
		else 'batang'
	end as Positions
from nodes n
left join parents p using(node)
order by 1
