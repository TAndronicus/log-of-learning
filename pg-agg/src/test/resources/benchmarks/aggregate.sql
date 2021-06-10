select *, find_last_ignore_nulls(a) over (order by id)
from tbl;
