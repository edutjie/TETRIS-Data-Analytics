SET global sql_mode=(SELECT CONCAT(@@GLOBAL.sql_mode, ',ONLY_FULL_GROUP_BY'));

create view per_kasir as 
	select 
		kode_cabang,
		kode_kasir, 
		count(*) total_transaksi_kasir
	from tr_penjualan tp
	group by 1,2
	
	
select
	distinct mc.nama_cabang,
	mk.nama_kota 
from tr_penjualan tp 
inner join ms_cabang mc on mc.kode_cabang = tp.kode_cabang 
inner join ms_kota mk on mc.kode_kota = mk.kode_kota


select
	distinct mc.nama_cabang,
	mk.nama_kota 
from ms_cabang mc
left join tr_penjualan tp  on mc.kode_cabang = tp.kode_cabang 
inner join (
	select distinct mk2.kode_kota, mk2.nama_kota
	from ms_kota mk2 
	inner join ms_cabang mc2  on mc2.kode_kota = mk2.kode_kota 
	inner join tr_penjualan tp2 on mc2.kode_cabang = tp2.kode_cabang 
) mk on mc.kode_kota = mk.kode_kota
where tp.kode_transaksi is null
order by 2, 1


with kode_cabang_jualan as (
	select distinct
		tp.kode_cabang
	from
		tr_penjualan tp
)
select
	mk.kode_kota,
	group_concat(distinct mc.nama_cabang separator ',') as cabang_jualan,
	group_concat(distinct mc2.nama_cabang separator ',') as cabang_tidak_jualan
from 
	ms_kota mk
join 
	ms_cabang mc
on
	mc.kode_kota=mk.kode_kota
	and mc.kode_cabang in (select kode_cabang from kode_cabang_jualan)
left join
	ms_cabang mc2
on
	mc2.kode_kota=mk.kode_kota
	and mc2.kode_cabang not in (select kode_cabang from kode_cabang_jualan)
group by 1





