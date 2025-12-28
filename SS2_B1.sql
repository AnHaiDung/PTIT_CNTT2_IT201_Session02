create database Ss2_B1;

use Ss2_B1;

create table Class(
	id_class varchar(50) primary key,
    name_class varchar(50) not null,
    year_study varchar(50) not null
);

create table Student(
	id_student varchar(50) primary key,
    name_student varchar(50) not null,
    bith_date  date not null,
    id_class varchar(50),
    foreign key (id_class) references Class(id_class)
);
