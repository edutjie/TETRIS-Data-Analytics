- 2.
-- Asumsi: Ingin menghitung keuntungan dan persentasi keuntungan per bulan untuk setiap cabang.

with keuntungan as (
	select
		mc.nama_cabang as nama_cabang,
		month(mhh.tgl_berlaku) as bulan,
		date_format(mhh.tgl_berlaku, '%M %Y') nama_bulan_dan_tahun_transaksi,
		sum(tp.jumlah_pembelian * (mhh.harga_berlaku_cabang - mhh.modal_cabang - mhh.biaya_cabang)) as keuntungan_per_bulan
	from ms_harga_harian mhh 
	inner join ms_cabang mc using(kode_cabang)
	inner join tr_penjualan tp on tp.kode_cabang = mhh.kode_cabang and tp.kode_produk = mhh.kode_produk and tp.tgl_transaksi = mhh.tgl_berlaku 
	group by 1, 2, 3
	order by 1, 2
)
select
	nama_cabang, nama_bulan_dan_tahun_transaksi, keuntungan_per_bulan,
	(keuntungan_per_bulan / lag(keuntungan_per_bulan, 1, 0) over(partition by nama_cabang) - 1) * 100 as 'persen growth'
from keuntungan