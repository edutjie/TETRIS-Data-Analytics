with data_per_product_inv as (
	select
		distinct nama_product,
		sum(qty * harga_satuan) as total_harga,
		kode_vendor,
		kode_customer
	from (
		select
			case when ts.satuan = 'krat' then ts.qty * 24 when ts.satuan = 'dus' then ts.qty * 30 else ts.qty * 1 end as qty,
			mp.nama_product,
			mp.harga_satuan,
			mp.kode_vendor,
			ts.kode_customer,
			ts.no_entry_so
		from tr_so ts 
		inner join ms_product mp on mp.kode_produk = ts.kode_barang
	) as product_x_so
	inner join tr_do td using(no_entry_so)
	inner join tr_inv ti using(no_entry_do)
	group by 1,3,4
)
select
	mv.vendor,
	convert(sum(dppi.total_harga), signed)  as amount
from data_per_product_inv dppi
inner join ms_vendor mv using(kode_vendor)
inner join ms_customer mc using(kode_customer)
group by 1
order by 2 desc, 1
limit 3