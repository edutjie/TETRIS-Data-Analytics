with not_paid_do as (
	select
		td.no_do,
		mc.nama_customer,
		date(td.tgl_do) as tgl_do,
		date('2018-02-01') as date_measurement
	from tr_do td 
	inner join tr_so ts using(no_entry_so)
	inner join ms_customer mc using(kode_customer)
	left join tr_inv ti using(no_entry_do)
	where isnull(ti.no_inv)
)
select
	*,
	datediff(date_measurement, tgl_do) as aging
from not_paid_do
order by aging desc, no_do