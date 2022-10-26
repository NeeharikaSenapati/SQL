# Datasets used: employee_details.csv and Department_Details.csv
# Use subqueries to answer every question

CREATE SCHEMA IF NOT EXISTS SQL2Takehome1;
USE SQL2Takehome1;
# import csv files in Employee database.

SELECT * FROM DEPARTMENT_DETAILS;
SELECT * FROM EMPLOYEE_DETAILS;

#Q1. Retrive employee_id , first_name , last_name and salary details of those employees 
#whose salary is greater than the average salary of all the employees.(11 Rows)
select employee_id,first_name,last_name,salary
from employee_details
where salary>(select avg(salary) from employee_details);
#Q2. Display first_name , last_name and department_id of those employee where the
# location_id of their department is 1700(3 Rows)
select first_name,last_name,department_id
from employee_details
where department_id in (select department_id from department_details where location_id=1700);
#Q3. From the table employees_details, extract the employee_id, first_name, last_name,
# job_id and department_id who work in  any of the departments of Shipping,
# Executive and Finance.(9 Rows)
select * from department_details;
select * from employee_details;
select employee_id,first_name,last_name,job_id,department_id
from employee_details
where department_id in (select department_id from department_details where department_id in (select department_id from department_details where department_name in( 'Shipping','finance','executive')));
#Q4. Extract employee_id, first_name, last_name,salary, phone_number and email of the 
#CLERKS who earn more than the salary of any IT_PROGRAMMER.(3 Rows)
select employee_id,first_name,last_name,phone_number,email,salary
from employee_details
where salary>(select min(salary) from employee_details where job_id ='IT_PROG') and job_id like '%clerk%';
-- or
select employee_id, first_name, last_name,salary, phone_number, email from employee_details 
where salary > ANY (select salary from employee_details where JOB_ID = 'IT_PROG') and JOB_ID like '%clerk%';

#Q5. Extract employee_id, first_name, last_name,salary, phone_number, 
#email of the AC_ACCOUNTANTs who earn a salary more than all the AD_VPs.(2 Rows)
select employee_id, first_name, last_name,salary, phone_number, email 
from employee_details 
where salary >all( select salary from employee_details where job_id='AD_VPs') and job_id ='AC_ACCOUNTANT' ;

#Q6. Write a Query to display the employee_id, first_name, last_name,
# department_id of the employees who have been recruited after the middle(avg) hire_date. (10 Rows)
select employee_id,first_name,last_name,DEPARTMENT_ID
from employee_details
where HIRE_DATE>(select avg(HIRE_DATE) from employee_details);
#Q7. Extract employee_id, first_name, last_name, phone_number, salary and job_id 
#of the employees belonging to the 'Contracting' department (3 Rows)
select employee_id,first_name,last_name,phone_number,job_id
from employee_details
where department_id  in (select department_id from department_details where department_name like 'Contracting');
#Q8. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the
# employees who does not belong to 'Contracting' department(18 Rows)
select employee_id,first_name,last_name,phone_number,job_id
from employee_details
where department_id not in (select department_id from department_details where department_name like 'Contracting');
#Q9. Display the employee_id, first_name, last_name, job_id and department_id of the 
#employees who were recruited first in the department(7 Rows)
select employee_id, first_name, last_name, job_id, department_id 
From employee_details 
Where str_to_date(HIRE_DATE, '%d-%m-%Y') in (Select min(str_to_date(HIRE_DATE, '%d-%m-%Y')) 
From employee_details group by DEPARTMENT_ID);


#Q10. Display the employee_id, first_name, last_name, salary and job_id of the 
#employees who earn maximum salary for every job.( 7Rows)
select employee_id,first_name,last_name,job_id
from employee_details 
where salary in (select max(salary) from employee_details group by job_id);

