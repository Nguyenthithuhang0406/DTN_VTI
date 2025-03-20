create database BTJavaCore;

use BTJavaCore;

drop table if exists Department;
create table Department(
	department_id int auto_increment primary key,
    department_name varchar(50) not null unique
);

create table User(
	id int primary key auto_increment,
    `role` enum('ADMIN', 'USER') not null,
    user_name nvarchar(20) not null unique,
    `password` nvarchar(20) not null,
    email varchar(30) not null unique,
    date_of_birth date,
    department_id int,
    foreign key (department_id) references Department(department_id)
);

insert into Department (department_name) 
values 
('java'),
('php'),
('scrum master');

insert into User (`role`, user_name, `password`, email, date_of_birth, department_id)
values
('ADMIN', 'ADMIN', '123456', 'admin@gmail.com', '2000-03-22', 1),
('USER', 'USER', '123456', 'user@gmail.com', '2001-03-22', 3);

