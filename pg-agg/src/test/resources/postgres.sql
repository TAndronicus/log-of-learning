create table tbl
(
    id bigint primary key,
    a  int
);

insert into tbl (id, a)
select s, case when random() < .5 then s end
from generate_series(0, 100) s;
select *
from tbl;

create function coalesce_r_sfunc(state anyelement, value anyelement)
    returns anyelement immutable parallel safe
as
$$
select coalesce(value, state);
$$
language sql;

create
aggregate find_last_ignore_nulls(anyelement) (
    sfunc = coalesce_r_sfunc,
    stype = anyelement
    );

select *, find_last_ignore_nulls(a) over (order by id)
from tbl;

select *,
       (
           select a
           from tbl it
           where it.id <= t.id
             and it.a is not null
           order by id desc
           limit 1 ) lnn
from tbl t;
