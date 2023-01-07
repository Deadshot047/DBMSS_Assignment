CREATE TABLE employee(
employee_name varchar(255) primary key,
street varchar(255),
city varchar(255));

CREATE TABLE works(
employee_name varchar(255),
company_name varchar(255),
salary int,
foreign key(employee_name) references employee(employee_name),
foreign key(company_name) references company(company_name));

CREATE TABLE company(
city varchar(255),
company_name varchar(255) primary key);

CREATE TABLE manages(
employee_name varchar(255),
manager_name varchar(255),
foreign key(employee_name) references employee(employee_name));



insert into employee(employee_name,street,city)
values
('Bikrant','Thamel','Kathmandu'),
('Dipesh', 'Tharke','Kasmir'),
('Nikhil','Rani Pokhari','Kathmandu'),
('Ngawang Singh','BusPark','Lalitpur'),
('Bishal','Pulchowk','Lalitpur'),
('Sujan','Vanasthali','Kathmandu'),
('Nistha','Kalanki','Kathmandu'),
('Prinsa','Radhe','Bhaktapur'),
('Amit','Bhaisipati','Lalitpur');

insert into company(company_name,city)
values
('Microsofty','Kathmandu'),
('Apollo', 'Kasmir'),
('Orange','Kathmandu'),
('Doggle','Lalitpur');

insert into works(employee_name,company_name,salary)
values
('Nikhil','Orange',1010),
('Ngawang Singh', 'Apollo',1000),
('Dipesh','Doggle',2000),
('Bikrant','Microsofty',150),
('Sujan','Orange',200),
('Nistha','Doggle',210),
('Prinsa','Apollo',500),
('Amit','Doggle',400),
('Bishal','Orange',600);

insert into manages(employee_name,manager_name)
values
('Bishal','Boss'),
('Nistha', 'Rani Maiya'),
('Dipesh','Rani Maiya'),
('Bikrant','Nandu Biaya'),
('Sujan','Boss'),
('Amit', 'Rani Maiya'),
('Prinsa','Cool Boy'),
('Ngawang Singh','Cool Boy'),
('Nikhil','Boss');
insert into employee(employee_name,street,city)
values
('Boss','Vanasthali','Kathmandu'),
('Rani Maiya','Kalanki','Kathmandu'),
('Nandu Biaya','Botebahal','Lalitpur'),
('Cool Boy','Buspark','Lalitpur');

ALTER TABLE works CHECK CONSTRAINT ALL;

insert into works(employee_name,company_name,salary)
values
('Boss','Orange',1010),
('Cool Boy', 'Apollo',1000),
('Rani Maiya','Doggle',2000),
('Nandu Bhaiya','Microsofty',150);


--2.1 Find the names of all employees who work for Orange
SELECT employee_name,company_name from works where company_name = 'Orange';

--2.2 Find the names and cities if residence of all employees who work for Orange
SELECT employee.employee_name,city from employee,works where works.employee_name = employee.employee_name and works.company_name = 'Orange';

--2.3 Find the names, street addresses, and cities of residence of all employees who work for Orange and earn more than $500
SELECT employee.employee_name,city,street from employee,works where works.employee_name = employee.employee_name and works.salary > 500 and works.company_name = 'Orange';

--2.4 Find all employees in the database who live in same cities as the companies for which they work
Select employee.employee_name from employee,works,company where employee.employee_name = works.employee_name and works.company_name = company.company_name and company.city = employee.city;

--2.5 Find all employees in the database who live in same cities and on the same streets as do their managers 
Select employee_name from manages where employee_name in (select employee_name from employee where street in (select street from employee group  by street, city having count(*)>1));

--2.6 Find all employees in the database who donot work for Orange
SELECT employee_name,company_name from works where company_name != 'Orange';

--2.7 Find all employees in the database who earn more than each employee of Apollo
SELECT employee_name from works where works.salary > (select max(salary) from works where works.company_name = 'Apollo');

--2.8 Assume that the companies may be located in several cities. Find all companies located in every city in which Orange is located
SELECT company_name from company where city = (select city from company where company_name = 'Orange');

--2.9 Find all employees who earn more than the average salary of all employees of their company
SELECT employee_name from works where works.salary > (select avg (salary) from works);

--2.10 Find the company that has the most employees
SELECT count(employee_name) cnt, company_name FROM works GROUP BY company_name Order By cnt desc;

--2.11 Find the company that has the smallest payroll
SELECT company_name from works where salary = (select min(salary) from works); 

--2.12 Find those companies whose employees earn a higher salary, on average, than the average salary at Orange
Select company_name from works group by company_name having avg(salary) > (select avg(salary) from works where company_name = 'Orange');


--3.1 Modify the database so that Bishal lives in Kathmandu
UPDATE employee set city = 'Kathmandu' where employee_name = 'Bishal';
Select * from employee where employee_name = 'Bishal';

--3.2 Give all employees of Orange a 10 percent raise
UPDATE works set salary = 1.1 * salary where company_name = 'Orange';

--3.3 Give all managers of Orange a 10 percent raise
UPDATE works set salary = 1.1 * salary where employee_name in (select manager_name from manages,works where works.company_name = 'Orange');

--3.4 Give all managers of Orange a 10 percent raise unless the salary becomes greater than 100000; in such cases give only a 3 percent raise
UPDATE works set salary = salary * (case when (salary*1.1 > 100000) then 1.03 else 1.1) where employee_name in (select manager_name from manages) and company_name = 'Orange';

--3.5 Delete all tuples in the works relation for employess of Orange
Delete from works where company_name = 'Orange';
