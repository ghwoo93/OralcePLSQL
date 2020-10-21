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

insert into target_trigger_table values(3, '1번');
update target_trigger_table set title = '일번' where no = 1;
delete target_trigger_table;

create trigger trg_before_raise
before insert
on target_trigger_table
for each row
declare
begin
    if to_char(sysdate, 'dy') ='목' or to_char(sysdate, 'HH24') > 13  then
        raise_application_error(-20001, '목요일 혹은 오후 1시 이후에는 입력불가');
    else 
        insert into before_raise values('입력 성공',default);
    end if; 
end;
/
drop trigger trg_before_raise;
insert into target_trigger_table values(2, '2번');

--상품 
create table product(
    p_code char(4) primary key,
    p_name nvarchar2(10) not null,
    p_price number,
    p_qty number default 0
);

--입고
create table inp(
    i_no number primary key,
    p_code char(4) references product(p_code),
    i_date date default sysdate,
    i_qty number,
    i_price number
);

--판매
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

insert into product(p_code,p_name,p_price) values('B004','안드로이드',2500);
--입고 테이블에 insert트리거 걸기
--즉 입고 되면 상품 테이블의 재고 수량 자동 증가
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

--입고테이블에 update트리거 걸기
--즉 입고량이 수정되면 상품 테이블의 재고 수량 자동으로 수정
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

--판매 테이블에 insert트리거를 걸자(before 트리거)
--판매가 되면 상품 테이블의 재고 수량이 빠진다
--단, 재고 수량이 판매수량보다 적으면 판매불가

create trigger trg_insert_sales_before
before insert
on sales
for each row
declare
    qty number; --상품의 재고수량 저장
begin
    select p_qty into qty from product 
    where p_code = :new.p_code;
    --재고수량과 판매 수량 비교
    if qty < :new.s_qty then
        raise_application_error(-20002,'재고가 없어요');
    else
        update product set p_qty = p_qty - :new.s_qty
        where p_code = :new.p_code;
    end if;
end;
/
insert into sales(s_no,p_code,s_qty,s_price) 
values(1,'B004',7,3000);