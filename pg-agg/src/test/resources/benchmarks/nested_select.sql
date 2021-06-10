select *,
       (
           select a
           from tbl it
           where it.id <= t.id
             and it.a is not null
           order by id desc
           limit 1 ) lnn
from tbl t;
