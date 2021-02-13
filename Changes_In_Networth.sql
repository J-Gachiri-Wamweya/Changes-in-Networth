-- CHANGES IN NETWORTH

-- From the following table of transactions between two users, 
-- write a query to return the change in net worth for each user, 
-- ordered by decreasing net change.

create database if not exists practicedb;
use practicedb;

create table if not exists transactions(
sender integer not null,
reciever integer not null,
amount integer not null,
date date
);
/*
insert into  transactions (sender, reciever, amount, date) 
VALUES 
(5, 2, 10, CAST('12-02-20' AS date)),
(1, 3, 15, CAST('13-02-20' AS date)), 
(2, 1, 20, CAST('13-02-20' AS date)), 
(2, 3, 25, CAST('14-02-20' AS date)), 
(3, 1, 20, CAST('15-02-20' AS date)), 
(3, 2, 15, CAST('15-02-20' AS date)), 
(1, 4, 5, CAST('16-02-20' AS date));
*/
select sender, sum(amount) as `out` from transactions group by sender;
select reciever, sum(amount) as `in` from transactions group by reciever;

with t1 as (
select sender, sum(amount) as `out` 
from transactions 
group by sender
),
t2 as (select reciever, sum(amount) as `in` 
from transactions 
group by reciever
)
select sender, coalesce(`in`,0) - coalesce(`out`,0) as net from t1 left join t2 on sender = reciever
union
select reciever, coalesce(`in`,0) - coalesce(`out`,0) as net from t1 right join t2 on sender = reciever;
