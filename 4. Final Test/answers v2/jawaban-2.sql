with product_x_so as (
		select
			*,
			mp.harga_satuan * ts_edited.qty as total_harga
		from (
			select
				case when ts.satuan = 'krat' then ts.qty * 24 when ts.satuan = 'dus' then ts.qty * 30 else ts.qty * 1 end as qty,
				ts.kode_customer,
				ts.kode_barang,
				ts.no_entry_so 
			from tr_so ts 
		) as ts_edited
		inner join ms_product mp on mp.kode_produk = ts_edited.kode_barang
)
select
	td.no_do,
	mc.kode_customer,
	td.tgl_do,
	convert(pxs.qty, signed) as qty,
	convert(pxs.total_harga * 1.1 + mc.ongkos_kirim, signed)  as amount
from tr_do td 
inner join product_x_so pxs using(no_entry_so)
inner join ms_customer mc using(kode_customer)
order by 1

