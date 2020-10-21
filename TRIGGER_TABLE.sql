create table before_raise(
    event_string nvarchar2(10),
    postdate date default sysdate
);
create table target_trigger_table(
    no number primary key,
    title nvarchar2(10)
);

create trigger trg_before_raise_all
after insert or delete or update
on target_trigger_table
for each row
declare
begin
    if inserting then
        insert into before_raise values('INSERT', SYSDATE);
    elsif deleting then
        insert into before_raise values('DELETE', SYSDATE);
    elsif updating then
        insert into before_raise values('UPDATE', SYSDATE);
    end if;
end;
/

SELECT * FROM target_trigger_table;
SELECT * FROM before_raise;

insert into target_trigger_table values(3, '1��');
update target_trigger_table set title = '�Ϲ�' where no = 1;
delete target_trigger_table;

create trigger trg_before_raise
before insert
on target_trigger_table
for each row
declare
begin
    if to_char(sysdate, 'dy') ='��' or to_char(sysdate, 'HH24') > 13  then
        raise_application_error(-20001, '����� Ȥ�� ���� 1�� ���Ŀ��� �ԷºҰ�');
    else 
        insert into before_raise values('�Է� ����',default);
    end if; 
end;
/
drop trigger trg_before_raise;
insert into target_trigger_table values(2, '2��');

--��ǰ 
create table product(
    p_code char(4) primary key,
    p_name nvarchar2(10) not null,
    p_price number,
    p_qty number default 0
);

--�԰�
create table inp(
    i_no number primary key,
    p_code char(4) references product(p_code),
    i_date date default sysdate,
    i_qty number,
    i_price number
);

--�Ǹ�
create table sales(
    s_no number primary key,
    p_code char(4) references product(p_code),
    s_date date default sysdate,
    s_qty number,
    s_price number
);

select * from product;
select * from inp;
select * from sales;
----------------------------------------------------------

insert into product(p_code,p_name,p_price) values('B004','�ȵ���̵�',2500);
--�԰� ���̺� insertƮ���� �ɱ�
--�� �԰� �Ǹ� ��ǰ ���̺��� ��� ���� �ڵ� ����
create trigger trg_insert_inp
after insert
on inp
for each row
declare
begin
    update product set p_qty = p_qty + :new.i_qty 
    where p_code = :new.p_code;
end;
/
insert into inp(i_no,p_code,i_qty, i_price) 
values(1,'B004',5,2200);

--�԰����̺� updateƮ���� �ɱ�
--�� �԰��� �����Ǹ� ��ǰ ���̺��� ��� ���� �ڵ����� ����
create trigger trg_update_inp
after update
on inp
for each row
declare
begin
    update product set p_qty = p_qty - :old.i_qty + :new.i_qty
    where p_code = :new.p_code;
end;
/
update inp set i_qty = 10 where i_no = 1;

--�Ǹ� ���̺� insertƮ���Ÿ� ����(before Ʈ����)
--�ǸŰ� �Ǹ� ��ǰ ���̺��� ��� ������ ������
--��, ��� ������ �Ǹż������� ������ �ǸźҰ�

create trigger trg_insert_sales_before
before insert
on sales
for each row
declare
    qty number; --��ǰ�� ������ ����
begin
    select p_qty into qty from product 
    where p_code = :new.p_code;
    --�������� �Ǹ� ���� ��
    if qty < :new.s_qty then
        raise_application_error(-20002,'��� �����');
    else
        update product set p_qty = p_qty - :new.s_qty
        where p_code = :new.p_code;
    end if;
end;
/
insert into sales(s_no,p_code,s_qty,s_price) 
values(1,'B004',7,3000);