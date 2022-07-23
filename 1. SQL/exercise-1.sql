select distinct nama_depan, nama_belakang
	from ms_karyawan
	where
		nama_depan like 'A%' and
		nama_belakang like '%i';
		
select (5/4)

select count(distinct kode_kasir)
	from tr_penjualan tp 
	where jumlah_pembelian > 15 
	
select
	kode_cabang,
	count(distinct kode_produk),
	avg(harga_berlaku_cabang),
	max(harga_berlaku_cabang),
	min(harga_berlaku_cabang)
from ms_harga_harian mhh 
where
	tgl_berlaku = date '2008-12-31'
group by kode_cabang 
having
	max(harga_berlaku_cabang) > 106000
	
select
	mk.nama_depan,
	mk.nama_belakang,
	count(tp.kode_kasir) total_transaksi,
	avg(tp.jumlah_pembelian) rata_pembelian
from ms_karyawan mk 
left join
	tr_penjualan tp on mk.kode_karyawan = tp.kode_kasir 
group by 1, 2, tp.kode_kasir
order by 3 desc

select
	mkar.nama_depan,
	mkar.nama_belakang,
	mp.nama_propinsi provinsi_kasir,
	mp.nama_propinsi provinsi_transaksi,
	count(tp.kode_kasir) total_transaksi,
	avg(tp.jumlah_pembelian) rata_jumlam_pembelian,
	sum(tp.jumlah_pembelian * mhh.harga_berlaku_cabang) total_amount,
	sum(tp.jumlah_pembelian * (mhh.harga_berlaku_cabang - mhh.modal_cabang - mhh.biaya_cabang)) total_keuntungan
from tr_penjualan tp 
left join ms_karyawan mkar on tp.kode_kasir = mkar.kode_karyawan 
left join ms_cabang mc on tp.kode_cabang = mc.kode_cabang
left join ms_harga_harian mhh on
	tp.kode_cabang = mhh.kode_cabang and
	tp.kode_produk = mhh.kode_produk and 
	tp.tgl_transaksi = mhh.tgl_berlaku 
left join ms_kota mkot on mc.kode_kota = mkot.kode_kota 
left join ms_propinsi mp on mkot.kode_propinsi = mp.kode_propinsi
group by 1, 2, mkar.kode_karyawan
order by mkar.nama_depan 
	
select 
    karyawan_transaksi.nama_depan                                 as nama,
    propinsi_kasir.nama_propinsi                                 as propinsi_kasir,
    propinsi_transaksi.nama_propinsi                             as propinsi_transaksi,
    count(1)                                                     as total_transaksi,
    avg(tp.jumlah_pembelian)                                     as mean_pembelian,
    sum(tp.jumlah_pembelian * mhh_tp.harga_berlaku_cabang)         as total_amount,
    sum(tp.jumlah_pembelian * (mhh_tp.harga_berlaku_cabang - 
                                mhh_tp.modal_cabang - 
                                mhh_tp.biaya_cabang))             as total_keuntungan
from tr_penjualan tp 

-- Hubungan karyawan dengan transaksi (untuk nama)
join ms_karyawan karyawan_transaksi on tp.kode_kasir  = karyawan_transaksi.kode_karyawan 

-- Karyawan - Propinsi
join ms_cabang cabang_kasir         on karyawan_transaksi.kode_cabang     = cabang_kasir.kode_cabang
join ms_kota kota_kasir             on cabang_kasir.kode_kota             = kota_kasir.kode_kota 
join ms_propinsi propinsi_kasir     on kota_kasir.kode_propinsi         = propinsi_kasir.kode_propinsi

-- Transaksi - Propinsi
join ms_cabang cabang_transaksi     on tp.kode_cabang                     = cabang_transaksi.kode_cabang 
join ms_kota kota_transaksi         on cabang_transaksi.kode_kota         = kota_transaksi.kode_kota 
join ms_propinsi propinsi_transaksi on kota_transaksi.kode_propinsi     = propinsi_transaksi.kode_propinsi 

-- Keuntungan dkk
join ms_harga_harian mhh_tp         on  tp.kode_produk                     = mhh_tp.kode_produk
                                    and tp.kode_cabang                     = mhh_tp.kode_cabang
                                    and tp.tgl_transaksi                 = mhh_tp.tgl_berlaku
-- Group by 
group by 1, 2, 3
