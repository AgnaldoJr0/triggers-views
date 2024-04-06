USE company_database;
show tables;

CREATE VIEW employees_per_department_location AS
SELECT d.Dname AS Department, dl.Dlocation AS Location, COUNT(e.idEmployee) AS Number_of_Employees
FROM department d
INNER JOIN dept_locations dl ON d.Dnumber = dl.Dnumber
INNER JOIN employee e ON d.Dnumber = e.Dno
GROUP BY d.Dname, dl.Dlocation;

CREATE VIEW department_managers AS
SELECT d.Dname AS Department, e.Fname AS Manager_First_Name, e.Lname AS Manager_Last_Name
FROM department d
INNER JOIN employee e ON d.Mgr_ssn = e.Ssn;

CREATE VIEW projects_most_employees AS
SELECT p.Pname AS Project_Name, COUNT(w.Essn) AS Number_of_Employees
FROM project p
INNER JOIN works_on w ON p.Pnumber = w.Pno
GROUP BY p.Pname
ORDER BY COUNT(w.Essn) DESC;

CREATE VIEW projects_departments_managers AS
SELECT p.Pname AS Project_Name, d.Dname AS Department, e.Fname AS Manager_First_Name, e.Lname AS Manager_Last_Name
FROM project p
INNER JOIN department d ON p.Dnum = d.Dnumber
INNER JOIN employee e ON d.Mgr_ssn = e.Ssn;

CREATE VIEW employees_with_dependents_and_managers AS
SELECT e.Fname AS Employee_First_Name, e.Lname AS Employee_Last_Name,
    (CASE WHEN d.Dessn IS NOT NULL THEN 'Yes' ELSE 'No' END) AS Has_Dependents,
    (CASE WHEN e.Ssn IN (SELECT Mgr_ssn FROM department) then 'Yes' ELSE 'No' END) AS Is_Manager
FROM employee e
LEFT JOIN dependent d ON e.Ssn = d.Dessn;

 -- Criação de usuário Gerente
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'UserGerente';

grant select on company_database.employee to 'gerente'@'localhost';
grant select on company_database.department to 'gerente'@'localhost';

 -- Criação de usuário Funcionário
 create user 'employee'@'localhost' IDENTIFIED BY 'UserEmployee';
 grant select on company_database.employee to 'employee'@'localhost';


-- Trigger para remoção
DELIMITER //
CREATE TRIGGER before_delete_user
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    INSERT INTO deleted_users (id, username, email, deleted_at)
    VALUES (OLD.id, OLD.username, OLD.email, NOW());
END;
//
DELIMITER ;

-- Trigger para atualização
DELIMITER //
CREATE TRIGGER before_update_employee_salary
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
    IF NEW.Salary <> OLD.Salary THEN
        INSERT INTO salary_changes (employee_id, old_salary, new_salary, changed_at)
        VALUES (OLD.idEmployee, OLD.Salary, NEW.Salary, NOW());
    END IF;
END;
//
DELIMITER ;

show tables;