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