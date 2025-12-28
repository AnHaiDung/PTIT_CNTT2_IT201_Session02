create database Ss2_B5;

use Ss2_B5;

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

create table score(
	id_student varchar(50),
    id_subject varchar(50),
    process_score decimal(4,2) not null,
    final_score decimal(4,2) not null,
    check (process_score >= 0 and process_score <= 10),
    check (final_score >= 0 and final_score <= 10),
    primary key(id_student,id_subject),
    foreign key(id_student) references student(id_student),
    foreign key(id_subject) references subject(id_subject)
);