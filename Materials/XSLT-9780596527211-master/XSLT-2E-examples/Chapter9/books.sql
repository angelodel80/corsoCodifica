-- books.sql - Create sample database from O'Reilly's XSLT, Second Edition
connect 'jdbc:derby://localhost:1527/books;create=true';
create schema doug;
set schema doug;
create table compbks (ISBN varchar(10) primary key, title varchar(50),
author varchar(50), pages int, price double, publisher varchar(50));
insert into compbks values ('0596527217', 'XSLT', 'Doug Tidwell',
800, 49.95, 'O''Reilly');
insert into compbks values ('0974152129', 'DocBook XSL: The Complete Guide',
'Bob Strayton', 560, 49.95, 'Sagehill Enterprises');
insert into compbks values ('1565925807', 'DocBook: The Definitive Guide',
'Norman Walsh and Leonard Muellner', 652, 39.95, 'O''Reilly');
insert into compbks values ('0596009747', 'XSLT Cookbook', 'Sal Mangano',
751, 49.95, 'O''Reilly');
insert into compbks values ('0596003277', 'Learning XSLT',
'Michael Fitzgerald', 352, 34.95, 'O''Reilly');