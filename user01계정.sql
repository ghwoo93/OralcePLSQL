create table nopk(
col1 number,
col2 varchar2(10)
);
desc nopk;

insert into nopk(col2) values('second');

select *
from nopk;

create table pk_noname(
col1 number primary key ,
col2 varchar2(10)
);

insert into pk_noname values(2,'first');

select * from pk_noname;
desc pk_noname;

SELECT * FROM user_cons_columns;

create table pk_name1(
col1 number constraint pk_pk_name1 primary key, 
col2 varchar2(10)
);

desc pk_name1;

insert into pk_name1 values(1,'first');
select * from user_cons_columns;

create table pk_name2(
col1 number , 
col2 varchar2(10),
col3 nvarchar2(10),
constraint pk_pk_name2 primary key(col1, col2) 
);

desc pk_name2;

insert into pk_name2 values(1,'first','ù��°');
insert into pk_name2 values(1,'second','�ι�°');
select * from pk_name2;
insert into pk_name2(col1, col3) values(2,'����°');

create table nn(
col1 number primary key,
col2 varchar2(10) constraint nn_col2_nn not null,
col3 varchar2(10)
);
desc nn;
insert into nn values(1, 'first', 'ù��°');
insert into nn(col1,col3) values(2, '�ι�°');
insert into nn(col1,col2) values(2, 'first');
select * from nn;

create table uq(
col1 number primary key,
col2 varchar2(10) constraint uq_col2_uq unique,
col3 varchar2(10) not null unique
);

desc uq;
insert into uq values(1,'first','ù��°');
insert into uq values(2,'second','ù��°');
insert into uq(col1,col3) values(3,'����°');
select * from uq;
insert into uq(col1,col2,col3) values(4,'second','�׹�°');

create table df(
col1 number primary key,
col2 char(1) default 'M',
col3 number(3) default 1,
col4 date default sysdate
);

select sysdate from dual;
desc df;
insert into df(col1) values(1);
select * from df;
insert into df(col1,col4) values(3,sysdate+1);

--���� �α� ��
create table nore_parent(
id varchar2(10) primary key,
name varchar2(10)
);
insert into nore_parent values('park','parkildong');
select * from nore_parent;
--drop table nore_parent purge;
create table nore_child(
no number primary key,
id varchar2(10),
title varchar2(10)
);

insert into nore_child values(3,'park','park1');
select * from nore_child;

delete nore_parent where id = 'kim';
select p.id , name, no, title
from nore_child n join nore_parent p on n.id = p.id;

--���� �ΰ� �� ��
create table parent(
id varchar2(10) primary key,
name varchar2(10)
);

create table child(
no number primary key,
id varchar2(10) references parent(id),
title varchar2(10)
--foreign key(id) references parent(id)
);
select * from parent;
select * from child;
insert into parent values('park','�ڱ浿');
insert into child values(1,'kim','kim1');
delete parent where id ='lee';
update child set id = 'park' where no = 1;

create table parent2(
id varchar2(10) primary key,
name varchar2(10)
);
create table child2(
no number primary key,
id varchar2(10) references parent2(id) on delete cascade,
title varchar2(10)
--foreign key(id) references parent(id)
);
insert into parent2 values('kim','��浿');
insert into child2 values(3,'park','����3');
select * from parent2;
select * from child2;
delete parent2 where id ='park';

create table parent3(
id varchar2(10) primary key,
name varchar2(10)
);
create table child3(
no number primary key,
id varchar2(10) references parent3(id) on delete set null,
title varchar2(10)
--foreign key(id) references parent(id)
);
insert into parent3 values('kim','��浿');
insert into child3 values(3,'kim','����3');
select * from parent3;
select * from child3;
delete parent3 where id ='kim';

create table chtable(
col1 number primary key,
col2 number(3) constraint ch_col2_chtable check(col2 >=1 and col2<=100),
col3 char(1) constraint ch_col3_chtable check(col3 in ('m','f')),
col4 char(14) check(regexp_like(col4,'^[0-9]{6}-[0-9]{7}$'))
);
--����ǥ������ �˻��ؼ� ���� ~~
select * from chtable;
insert into chtable values(1,99,'m','123456-1234567');
insert into chtable values(2,1,'f','123456-1234567');

select * from parent;
select * from child;

create table parent_copy
as
select * from parent;
desc parent;
desc parent_copy;
select * from parent_copy;
insert into parent_copy values('kim', '��浿');

delete chtable;
desc chtable;
alter table chtable add col5 varchar2(10) not null;
alter table chtable add constraint uq_col5_chtable unique(col5);
insert into chtable values(2,1,'f','123456-1234567','a');

alter table chtable drop constraint uq_col5_chtable ;
alter table chtable drop column col5 ;

alter table chtable modify col2 number(5) ;
alter table chtable rename column col4 to colfour;

rename chtable to ch_table;
select * from tab;
drop table ch_table;
SHOW RECYCLEBIN;
FLASHBACK TABLE ch_table TO BEFORE DROP;

create table tt(
no number);
drop table tt;
PURGE RECYCLEBIN;
drop table tt  purge;

drop table parent purge;
DROP TABLE parent CASCADE constraint;
FLASHBACK TABLE parent TO BEFORE DROP;

CREATE TABLE BBS(
NO NUMBER PRIMARY KEY,
TITLE NVARCHAR2(10)
);
SELECT * FROM bbs;
INSERT INTO bbs VALUES(1,'����1');
INSERT INTO bbs VALUES((SELECT MAX(NO)+1 FROM bbs),
'����' ||(SELECT MAX(NO)+1 FROM bbs));
INSERT INTO bbs VALUES(SQ_BBS.NEXTVAL,
'����' ||SQ_BBS.NEXTVAL);
DELETE BBS WHERE NO = 6;

SELECT * FROM bbs2;
CREATE TABLE BBS2(
NO NUMBER PRIMARY KEY,
TITLE NVARCHAR2(10)
);
INSERT INTO bbs2 VALUES(SQ_BBS.NEXTVAL,
'����' ||SQ_BBS.NEXTVAL);

CREATE SEQUENCE SQ_BBS
INCREMENT BY 2
START WITH 100
MAXVALUE 110
CYCLE;

SELECT SQ_BBS.NEXTVAL FROM DUAL;
SELECT SQ_BBS.CURRVAL FROM DUAL;
DROP SEQUENCE SQ_BBS;

CREATE SEQUENCE SQ_BBS
INCREMENT BY 2
START WITH 100
MAXVALUE 110
MINVALUE 100
NOCYCLE
NOCACHE;
DELETE BBS;

CREATE SEQUENCE SQ_BBS
--INCREMENT BY 2
--START WITH 100
--MAXVALUE 110
--MINVALUE 100
NOCYCLE
NOCACHE;

CREATE TABLE BOARD(
NO NUMBER PRIMARY KEY,
TITLE NVARCHAR2(10) NOT NULL,
POSTDATE DATE DEFAULT SYSDATE,
KINDS CHAR(4) 
);

--���ǰԽ���: BBS1, QNA: BBS2
CREATE SEQUENCE SQ_BOARD
NOCACHE
NOCYCLE;
desc board;
INSERT INTO BOARD VALUES(SQ_BOARD.NEXTVAL,'����'||SQ_BOARD.CURRVAL,SYSDATE,'BBS1');
INSERT INTO BOARD(no, title,postdate,KINDS) VALUES(SQ_BOARD.NEXTVAL,'����'||SQ_BOARD.CURRVAL,default,NULL);
select * from board;

UPDATE BOARD SET title ='�����Դϴ�' WHERE NO >=3;
UPDATE BOARD SET title = title || '�Դϴ�',postdate=SYSDATE -1,
kinds ='BBS1' WHERE no = 3;

DELETE BOARD WHERE kinds = 'BBS1' OR kinds is null;
TRUNCATE TABLE board;