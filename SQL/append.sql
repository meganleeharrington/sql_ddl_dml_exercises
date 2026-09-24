--TARGET TABLE
create temporary table target_append (
    id INTEGER
    ,value STRING
);

insert into target_append (id, value)
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
from target_append;


--SOURCE TABLE
create temporary table source_append (
    id INTEGER
    ,value STRING
);

insert into source_append (id, value)
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
from source_append;


--APPEND TABLE
insert into target_append
select * from source_append;

select * from target_append
order by id;