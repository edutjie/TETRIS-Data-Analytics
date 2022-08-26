select 
	*,
	case when target > jumlah_so then 'ya' else 'tidak' end as kurang_dari_target
from (
	select
			mp.nama_pegawai,
			count(distinct ts.no_so) as jumlah_so,
			mp.target
	from ms_pegawai mp 
	inner join tr_so ts on mp.kode_pegawai = ts.kode_sales 
	group by 1,3
	order by nama_pegawai 
) as pegawai_x_so