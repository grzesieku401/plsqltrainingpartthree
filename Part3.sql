--1
select d.department_name, avg(e.salary) "averge salary"
from employees e
natural join departments d
group by d.department_name;

--2
select d.department_name, avg(e.salary) "averge salary"
from employees e
natural join departments d
group by d.department_name
union
select 'All',avg(salary)
from employees;

select d.department_name, avg(e.salary) "averge salary"
from employees e
natural join departments d
group by rollup (d.department_name);

--3
select department_id,job_id,sum(salary)
from employees
group by department_id,job_id;

--4
select department_id,job_id,sum(salary),GROUPING(job_id)
from employees
group by rollup (job_id,department_id);

select department_id,job_id,sum(salary), GROUPING(job_id)
from employees
group by grouping SETS ((job_id,department_id), job_id);

--5
select department_id,job_id,sum(salary),GROUPING(job_id)
from employees
group by cube (job_id,department_id);

--6
select (select d.department_name from departments d where d.department_id = e.department_id),(select j.job_title from jobs j where j.job_id = e.job_id),sum(e.salary),GROUPING(e.job_id)
from employees e
group by cube (e.job_id,e.department_id);

--7
select job_id, max(salary), grouping(job_id)
from employees
group by rollup(job_id);

--8
select case when (select d.department_name from departments d where d.department_id = e.department_id) is null then 'RAZEM' else (select d.department_name from departments d where d.department_id = e.department_id) end departmentID, case when(select j.job_title from jobs j where j.job_id = e.job_id) is null then 'RAZEM' else (select j.job_title from jobs j where j.job_id = e.job_id) end jobID ,sum(e.salary),GROUPING(e.job_id)
from employees e
group by cube (e.job_id,e.department_id);

--9
select case when (select d.department_name from departments d where d.department_id = e.department_id) is null then 'Wszystkie dzialy'  else (select d.department_name from departments d where d.department_id = e.department_id) end departmentID, case when(select j.job_title from jobs j where j.job_id = e.job_id) is null then 'Wszystkie stanowiska' else (select j.job_title from jobs j where j.job_id = e.job_id) end jobID ,min(e.salary) min, max(e.salary) max,GROUPING(e.department_id)
from employees e
group by cube (e.job_id,e.department_id);

--10
select department_id, null job_id, salary_sum
from(
select department_id, sum(salary) salary_sum
from employees 
group by GROUPING sets (department_id))
UNION ALL
select null department_id, job_id, salary_sum
from(
select job_id, sum(salary) salary_sum
from employees 
group by GROUPING sets (job_id));

select e.department_id, e.job_id, sum(e.salary)
from employees e
group by grouping sets((e.department_id), (e.job_id));

--11
select e.department_id, e.job_id, sum(e.salary)
from employees e
group by grouping sets((e.department_id,e.job_id), (e.job_id),());
