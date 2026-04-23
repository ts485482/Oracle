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

select to_number('1,300', '999,999')-to_number('1,500','999,999') from dual;

select empno, ename, sal, comm, sal+comm,
nvl(comm,0),
sal+nvl(comm,0)
from emp;

select empno, ename, comm,
nvl2(comm,'O','X'),
nvl2(comm,sal*12+comm,sal*12)as annsal
from emp;

select empno, ename, job, sal,
case job
when 'MANAGER' then sal*1.1
when 'SALESMAN' then sal*1.05
when 'ANALYST' then sal
else sal*1.03
end as upsal
from emp;

select empno, ename, comm,
case
when comm is null then '해당사항 없음'
when comm = 0 then '수당없음'
when comm > 0 then concat('수당 : ',comm)
end as comm_text
from emp;

select count(*)
from emp;

select max(sal)
from emp
where deptno = 10;

select max(hiredate)
from emp
where deptno = 20;

--8교시에 7장 MIN부터 다시 작성

SELECT * FROM EMP;
SELECT * FROM DEPT;

--실무에서는 join시킨 값을 중복처리되지 않게 해야함
SELECT *
FROM EMP E,DEPT D 
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.EMPNO;

SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL>=3000;

SELECT * FROM SALGRADE;

--비등가 조인 BETWEEN A AND B
SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

SELECT * FROM EMP;

SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
E2.EMPNO AS MGR_EMPNO, 
E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
ORDER BY E1.EMPNO;

--NATURAL JOIN : 필드 중복 최소화
SELECT *
FROM EMP E NATURAL JOIN DEPT D
ORDER BY DEPTNO, E.EMPNO;

--JOIN ~ USING : 조인에 사용할 기준열 명시

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D USING(DEPTNO)
WHERE SAL >= 3000
ORDER BY DEPTNO, E.EMPNO;

--JOIN ~ ON : 조인 조건 직접 명시

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO, D.DNAME, D.LOC
FROM emp E JOIN dept D ON (E.DEPTNO = D.DEPTNO)
WHERE SAL <= 3000
ORDER BY E.DEPTNO, EMPNO;

--from table1 left outer join table2 on : table1과 table2 조인 후, 남은 table1값 전체 표기(table2 값 : null)
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
E2.EMPNO AS MGR_EMPNO,
E2.ENAME AS MGR_ENAME
FROM emp E1 left outer join emp E2 on (E1.MGR = E2.EMPNO)
Order by E1.EMPNO;

--from table1 right outer join table2 on : table1과 table2 조인 후, 남은 table2값 전체 표기(table1 값 : null)
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
E2.EMPNO AS MGR_EMPNO,
E2.ENAME AS MGR_ENAME
FROM emp E1 right outer join emp E2 on (E1.MGR = E2.EMPNO)
Order by E1.EMPNO, MGR_EMPNO;

--from table1 full outer join table2 on : table1과 table2 조인 후, 남은 table1값 전체 표기(table2값 : null) 후, 남은 table2값 전체 표기(table1값 : null)
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
E2.EMPNO AS MGR_EMPNO,
E2.ENAME AS MGR_ENAME
FROM emp E1 full outer join emp E2 on (E1.MGR = E2.EMPNO)
Order by E1.EMPNO, MGR_EMPNO;
