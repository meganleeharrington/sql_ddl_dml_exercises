--TARGET TABLE
create temporary table target_merge_null_fill_2 (
    id INTEGER
    ,value STRING
);

insert into target_merge_null_fill_2 (id, value)
values 
    (1, 'A')
    ,(2, 'A')
    ,(3, NULL)
    ,(5, 'A')
    ,(8, 'A')
    ,(9, NULL)
    ,(10, NULL)
    ;

select *
from target_merge_null_fill_2;


--SOURCE TABLE
create temporary table source_merge_null_fill_2 (
    id INTEGER
    ,value STRING
);

insert into source_merge_null_fill_2 (id, value)
values 
    (1, NULL)
    ,(2, 'B')
    ,(4, 'B')
    ,(8, 'B')
    ,(9, 'B')
    ,(10, NULL)
    ,(11, NULL)
;

select *
from source_merge_null_fill_2;


--MERGE_NULL_FILL TABLE
merge into target_merge_null_fill_2 as t
using source_merge_null_fill_2 as s
on t.id = s.id

when matched
    and t.value is NULL
    and s.value is not NULL
then update 
    set t.value = s.value

when not matched
then insert (id, value)
values (s.id, s.value);

select *
from target_merge_null_fill_2
order by id;