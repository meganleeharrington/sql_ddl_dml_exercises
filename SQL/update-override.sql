--TARGET TABLE
create temporary table target_update_override (
    id INTEGER
    ,value STRING
);

insert into target_update_override (id, value)
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
from target_update_override;


--SOURCE TABLE
create temporary table source_update_override (
    id INTEGER
    ,value STRING
);

insert into source_update_override (id, value)
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
from source_update_override;


--UPDATE_OVERRIDE TABLE
update target_update_override as t
set t.value = s.value
from source_update_override as s
where t.id = s.id and s.value IS NOT NULL;

select *
from target_update_override
order by id;