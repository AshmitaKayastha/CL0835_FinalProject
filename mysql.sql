CREATE DATABASE IF NOT EXISTS employees;
USE employees;

CREATE TABLE IF NOT EXISTS employee(
emp_id VARCHAR(20),
first_name VARCHAR(20),
last_name VARCHAR(20),
primary_skill VARCHAR(20),
location VARCHAR(20));

INSERT INTO employee VALUES ('1','Ashmita','Kayastha','Student','Scarborough');
INSERT INTO employee VALUES ('2','Pujan','Limbu','Student','Scarborough');
INSERT INTO employee VALUES ('3','Yubraj','Ghimire','Student','Scarborough');
INSERT INTO employee VALUES ('4','Limbu','Pujan','Student','Scarborough');


SELECT * FROM employee;

