drop database company_database;
CREATE DATABASE company_database;
USE company_database;

CREATE TABLE employee (
    idEmployee int auto_increment primary key,
    Fname VARCHAR(50),
    Minit CHAR(1),
    Lname VARCHAR(50),
    Ssn CHAR(9),
    Bdate DATE,
    Address VARCHAR(100),
    Sex CHAR(1),
    Salary DECIMAL(10, 2),
    Super_ssn CHAR(9),
    Dno INT
);

CREATE TABLE department (
    idDepartment int auto_increment primary key,
    Dname VARCHAR(50),
    Dnumber INT,
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE
);

CREATE TABLE dept_locations (
    idDept_locations int,
    Dnumber INT,
    Dlocation VARCHAR(100)
);

CREATE TABLE project (
    idProject int auto_increment primary key,
    Pname VARCHAR(50),
    Pnumber INT,
    Plocation VARCHAR(100),
    Dnum INT
);

CREATE TABLE works_on (
    idWorks_on int auto_increment primary key,
    Essn CHAR(9),
    Pno INT,
    Hours DECIMAL(5, 2)
);

CREATE TABLE dependent (
    idDependent int auto_increment primary key,
    Dessn CHAR(9),
    Dependent_name VARCHAR(50),
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(20)
);

show tables;