select * from emp ;

select ename from emp ;


select empno, ename from emp ;

select distinct job from emp ;

select job from emp;

select job as a from emp;

select * from dept;

select * from dept where deptno = 30;

select * from emp where deptno = 30 and job = 'SALESMAN';

select * from dept where deptno = 30 and dname = 'SALES';

select * from emp where deptno = 30 or job = 'CLERK';

/* === test === */

select * from emp where sal >= 3000;

select * from emp where ename >= 'F';

select * from emp where sal <> 3000;

select * from emp where not sal = 3000;

select * from emp where job in('MANAGER','SALESMAN','CLERK');
select * from emp where job = 'MANAGER' or job = 'SALESMAN' or job = 'CLERK';

select * from emp where sal between 2000 and 3000;
select * from emp where not sal between 2000 and 3000;

select * from emp where ename like 'S%';
select * from emp where ename like '_L%';
select * from emp where ename like '%AM%';
select * from emp where not ename like '%AM%';

select * from emp where comm is null;
select * from emp where mgr is not null;

select * from emp where sal > null and comm is null;

select * from emp where sal > null or comm is null;

select * from emp where deptno = 10 union select * from emp where deptno = 20;

select empno, ename, sal, deptno from emp minus select empno, ename, sal, deptno from emp where deptno = 10;

select empno, ename, sal, deptno from emp intersect select empno, ename, sal, deptno from emp where deptno = 10;

select ename, upper(ename), lower(ename), initcap(ename) from emp;

select * 
from emp 
where upper(ename) = upper('scott');

select * 
    from emp 
  where upper(ename) like upper('%scott%');

select * from emp;
select ename, length(ename) from emp;
select ename, length(ename) from emp where length(ename) >= 5;

select * from emp;
select job, substr(job,1,2), substr(job,3,2), substr(job,5) from emp;

select * from emp where instr(ename,'S')>0;

select '010-1234-5678' as replace_before, 
replace('010-1234-5678','-','')as replace_1, 
replace('010-1234-5678','-') as replace_2 from dual;

select 'Oracle',
lpad('Oracle',10,'#') as lpad_1,
rpad('Oracle',10,'*') as rpad_1,
lpad('Oracle',10) as lpad_2,
rpad('Oracle',10) as rpad_2
from dual;

select * from emp;

select concat(empno, ename),
concat(empno,concat(':',ename))
from emp
where ename = 'SCOTT';

select round(1234.5678) as round,
round(1234.5678, 0) as round_0,
round(1234.5678, 1) as round_1,
round(1234.5678, 2) as round_2,
round(1234.5678, -1) as round_minus1,
round(1234.5678, -2) as round_minus2
from dual;

select ceil(3.14),
floor(3.14),
ceil(-3.14),
floor(-3.14)
from dual;

select mod(15,6),
mod(10,2),
mod(11,2)
from dual;

select sysdate,
add_months(sysdate, 3)
from dual;

select * from emp;

select empno, ename, hiredate,
add_months(hiredate, 120)as work10year
from emp;

select empno, ename, hiredate,sysdate
from emp
where add_months(hiredate, 384) > sysdate;

select sysdate,
to_char(sysdate,'HH24:MI:SS') as hh24miss,
to_char(sysdate, 'HH12:MI:SS AM') as hhmiss_am,
to_char(sysdate, 'HH:MI:SS P.M.') as hhmiss_pm
from dual;
