--TARGET TABLE
create temporary table target_merge_override (
    id INTEGER
    ,value STRING
);

insert into target_merge_override (id, value)
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
from target_merge_override;


--SOURCE TABLE
create temporary table source_merge_override (
    id INTEGER
    ,value STRING
);

insert into source_merge_override (id, value)
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
from source_merge_override;


--MERGE_OVERRIDE TABLE
merge into target_merge_override as t
using source_merge_override as s
on t.id = s.id

when matched
    and s.value is not null 
then update 
    set t.value = s.value

when not matched
then insert (id, value)
values (s.id, s.value);

select *
from target_merge_override
order by id;