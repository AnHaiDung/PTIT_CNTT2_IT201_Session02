create database ss2_Bai3;

use ss2_Bai3;

create table student(
	id_student varchar(50) primary key,
    name_student varchar(50) not null
);

create table subject(
	id_subject varchar(50) primary key,
    name_subject varchar(50) not null,
    credits int not null,
    check(credits > 0)
);

create table enrollment(
	id_student varchar(50),
    id_subject varchar(50),
    primary key(id_student,id_subject),
    foreign key(id_student) references student(id_student),
    foreign key(id_subject) references subject(id_subject)
);