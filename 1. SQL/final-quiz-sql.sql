-- FINAL QUIZ SQL

select @@sql_mode

SET global sql_mode=(SELECT CONCAT(@@GLOBAL.sql_mode, ',ONLY_FULL_GROUP_BY'));

-- Perusahaan ingin mengetahui detail dari transaksi yang merupakan pembelian (jumlah_pembelian) terbanyak pada masing-masing produk dalam 1 transaksi (1 transaksi per produk).
-- Jika ada lebih dari 1 transaksi dengan jumlah pembelian yang sama untuk produk yang sama, ambil pembelian dengan tanggal paling pertama, jika masih ada yang sama, ambil kode_transaksi yang paling kecil.
-- 
-- Tampilkan 
-- - nama cabang, 
-- - nama depan kasir, 
-- - tanggal transaksi, 
-- - nama produk
-- - jumlah pembelian
-- Urutkan data berdasarkan kode produk

select
	mc.nama_cabang as 'nama cabang',
	mk.nama_depan as 'nama depan kasir',
	tp.tgl_transaksi as 'tanggal transaksi',
	mp.nama_produk as 'nama produk',
	tp.jumlah_pembelian as 'jumlah pembelian'
from tr_penjualan tp
inner join ms_produk mp using(kode_produk)
inner join ms_cabang mc using(kode_cabang)
inner join ms_karyawan mk on mk.kode_karyawan = tp.kode_kasir and mk.kode_cabang = mc.kode_cabang 
order by tp.kode_produk, tp.jumlah_pembelian desc, tp.tgl_transaksi, tp.kode_transaksi 


-- Perusahaan ingin mengetahu bagaimana growth dari keuntungan bulanan untuk setiap cabang supaya  nantinya bisa di-analisis lebih detail terkait pertumbuhan yang terjadi, kenapa ada perbedaan growth setiap cabang setiap bulan.
-- 
-- Tampilkan 
-- - nama cabang
-- - nama bulan dan tahun transaksi, 
-- - keuntungan per bulan
-- - persen growth 
-- Urutkan datanya berdasarkan nama cabang kemudian bulan
-- 
-- *persen growth = persen perubahan bulan ini dibandingkan dengan bulan sebelumnya, nilainya positif jika naik dan negatif jika turun

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