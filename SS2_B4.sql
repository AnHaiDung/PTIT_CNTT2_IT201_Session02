create database ss2_B4;

use ss2_B4;

create table teacher(
	id_teacher varchar(50) primary key,
    name_teacher varchar(50) not null,
    email varchar(50) not null
);

create table subject(
	id_subject varchar(50) primary key,
    name_subject varchar(50) not null,
    credits int not null,
    check(credits > 0)
);

alter table subject
add column id_teacher varchar(50);

alter table subject
add foreign key (id_teacher) references teacher(id_teacher);
