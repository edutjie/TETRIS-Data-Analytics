-- 1.
-- Asumsi: Ingin dilihat jumlah pembelian terbanyak yang partisinya PER PRODUK lalu diurutkan PER PRODUK terlebih dahulu, baru JUMLAH PEMBELIAN-nya dilanjutkan oleh tanggal transaksi dan kode transaksi

with max_jumlah_pembelian_per_produk as  (
	select
		mc.nama_cabang as nama_cabang,
		mk.nama_depan as nama_depan_kasir,
		tp.tgl_transaksi as tanggal_transaksi,
		mp.nama_produk as nama_produk,
		tp.jumlah_pembelian as jumlah_pembelian,
		row_number() over(
			partition by tp.kode_produk
			order by tp.kode_produk, tp.jumlah_pembelian desc, tp.tgl_transaksi, tp.kode_transaksi
		) as jumlah_pembelian_rank
	from tr_penjualan tp
	inner join ms_produk mp using(kode_produk)
	inner join ms_cabang mc using(kode_cabang)
	inner join ms_karyawan mk on mk.kode_karyawan = tp.kode_kasir and mk.kode_cabang = mc.kode_cabang 
)
select
	nama_cabang,
	nama_depan_kasir,
	tanggal_transaksi,
	nama_produk,
	jumlah_pembelian
from max_jumlah_pembelian_per_produk
where jumlah_pembelian_rank = 1