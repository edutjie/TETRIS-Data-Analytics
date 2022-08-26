with raw_selected_data as (
	select
		regexp_substr(strdata, '[0-9]{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])') as tanggal,
		regexp_substr(regexp_substr(strdata, '[0-9]+ (lusin|buah)'), '[0-9]+') as qty,
		regexp_substr(strdata, '(lusin|buah)') as unit, 
		regexp_substr(regexp_substr(strdata, 'Rp [0-9]+'), '[0-9]+') as total
	from strdata s 
)
select
	date(tanggal) as tanggal,
	convert(qty, signed) as qty,
	convert(total/qty, signed) as harga_satuan,
	convert(total, signed) as total
from (
	select
	tanggal,
	case when unit = 'lusin' then 12 * qty else qty end as qty,
	total
	from raw_selected_data
) as selected_data
order by 1