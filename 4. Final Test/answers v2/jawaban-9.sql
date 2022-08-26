with age_in_day as (
	select
		nama,
		datediff(tanggal_registrasi, tanggal_lahir) as age
	from people p
)
select 
	a.nama as nama1,
	b.nama as nama2,
	abs(a.age - b.age) as selisih
from age_in_day a
cross join age_in_day b
where a.nama != b.nama
order by selisih, a.age
limit 1