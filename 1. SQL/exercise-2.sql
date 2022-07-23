select
	date_format(tgl_transaksi, '%M') as bulan,
	count(*) jumlah_transaksi
from tr_penjualan tp 
where
	year(tgl_transaksi) = '2008'
group by 1, month(tgl_transaksi)
order by month(tgl_transaksi) desc


select
	kode_kasir, count(1)
from tr_penjualan tp 
group by 1


select *
from tr_penjualan tp 
where jumlah_pembelian IN
	(
		select max(jumlah_pembelian) 
		from tr_penjualan tp
	)

with summary as (
		select
			kode_cabang,
			sum(case when mk.jenis_kelamin = 'P' then 1 else 0 end) jumlah_pria,
			sum(case when mk.jenis_kelamin = 'W' then 1 else 0 end) jumlah_wanita,
			count(*)
		from ms_karyawan mk
		group by 1
	),
total_transaksi_dec as (
		select
			kode_cabang,
			count(*) as total_transaksi_dec
		from tr_penjualan tp
		where
			year(tp.tgl_transaksi) = '2008' and 
			month(tp.tgl_transaksi) = '12'
		group by 1
	)
select
    mc.nama_cabang,
	jumlah_pria,
	jumlah_wanita,
	ttd.total_transaksi_dec
from summary
inner join total_transaksi_dec ttd on
	summary.kode_cabang = ttd.kode_cabang
inner join ms_cabang mc on mc.kode_cabang = summary.kode_cabang


select 
	count(*) jumlah_produk_ml_btl
from 
	ms_produk mp 
where 
	kode_satuan = 'btl' and 
	nama_produk like '%ml'
	

	
select
	sum(tp.jumlah_pembelian * (mhh.harga_berlaku_cabang - mhh.modal_cabang - mhh.biaya_cabang))
from ms_harga_harian mhh 
inner join ms_cabang mc on mhh.kode_cabang = mc.kode_cabang 
inner join tr_penjualan tp on
	mhh.kode_produk = tp.kode_produk and 
	mhh.kode_cabang = tp.kode_cabang and 
	mhh.tgl_berlaku = tp.tgl_transaksi 
where
	tgl_berlaku = date '2008-08-08' and 
	mc.nama_cabang like '%Makassar 01'
	
	
select 
	count(*)
from ms_cabang mc 
inner join ms_kota mk on mc.kode_kota = mk.kode_kota 
inner join ms_propinsi mp on mk.kode_propinsi = mp.kode_propinsi 
where
	mp.nama_propinsi like '%Yogyakarta'
	
	
select 
	count(distinct tp.kode_produk)
from tr_penjualan tp 
where
	tp.kode_kasir = '039-127' and 	
	tp.tgl_transaksi = date '2008-08-08'
	

with total_per_cabang as (select tp.kode_cabang, 
count(*) as jumlah_transaksi 
from tr_penjualan tp
group by 1
)
select *, avg(jumlah_transaksi) over()
from total_per_cabang 
	

with total_per_kasir as (
	select 
		kode_cabang,
		kode_kasir,
		count(kode_transaksi) total_transaksi
	from tr_penjualan tp 
	group by kode_cabang, kode_kasir
)
select *, 
	sum(total_transaksi) over(partition by kode_cabang) as total_transaksi_cabang
from total_per_kasir






