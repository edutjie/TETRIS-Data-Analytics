with product_x_so as (
		select
			case when ts.satuan = 'krat' then ts.qty * 24 when ts.satuan = 'dus' then ts.qty * 30 else ts.qty * 1 end as qty,
			mp.nama_product 
		from tr_so ts 
		inner join ms_product mp on mp.kode_produk = ts.kode_barang
)
select
	nama_product,
	convert(sum(qty), signed) as qty
from product_x_so
group by 1
order by 2 desc, 1
limit 3