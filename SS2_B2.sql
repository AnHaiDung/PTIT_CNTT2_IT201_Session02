create database Ss2_B2;

use Ss2_B2;

create table student(
	id_student varchar(50) primary key,
    name_student varchar(50) not null
);

create table subject(
	id_subject varchar(50) primary key,
    name_subject varchar(50) not null,
    credits int not null
    check(credits > 0)
);
