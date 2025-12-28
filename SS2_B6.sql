create database Ss2_B6;

use Ss2_B6;

create table classroom(
	id_class varchar(50) primary key,
    name_class varchar(50) not null,
    year_class varchar(50) not null
);

create table student(
	id_student varchar(50) primary key,
    name_student varchar(50) not null,
    birth_day date not null,
    id_class varchar(50) not null,
    foreign key(id_class) references classroom(id_class)
);

create table teacher(
	id_teacher varchar(50) primary key,
    name_teacher varchar(50) not null,
    email varchar(50) not null unique
);

create table subject(
	id_subject varchar(50) primary key,
    name_subject varchar(50) not null,
    credits int not null,
    id_teacher varchar(50),
    check(credits > 0),
    foreign key(id_teacher) references teacher(id_teacher)
);

create table enrollment(
	id_student varchar(50),
    id_subject varchar(50),
    date_register date not null,
    primary key (id_student,id_subject),
    foreign key(id_student) references student(id_student),
    foreign key(id_subject) references subject(id_subject)
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



