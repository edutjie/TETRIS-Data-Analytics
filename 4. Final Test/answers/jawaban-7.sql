select
	distinct xy.X, xy.Y 
from xy
inner join xy xy2 on xy.X = xy2.Y and xy.Y = xy2.X
where xy.X <= xy.Y
order by 1