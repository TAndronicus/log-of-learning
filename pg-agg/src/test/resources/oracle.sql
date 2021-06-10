create table tbl
(
    id number,
    a  integer
);

insert into tbl (id, a)
select level, case when dbms_random.value < .5 then level end
from dual connect by level < 100;

select id,
       a,
       last_value(a) ignore nulls over (order by id)
from tbl;
