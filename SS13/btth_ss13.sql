drop database  socialnetworkdb;

create database  socialnetworkdb;
use socialnetworkdb;

create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null unique,
    total_posts int not null,
    created_at datetime
);

create table posts (
    post_id int auto_increment primary key,
    user_id int not null,
    content text not null,
    created_at datetime,
    foreign key (user_id) references users(user_id)
);

create table post_audits (
    audit_id int primary key auto_increment,
    post_id int not null,
    old_content text,
    new_content text not null,
    changed_at datetime,
    foreign key (post_id) references posts(post_id)
);

-- Task 1
delimiter //
create trigger tg_CheckPostContent
before insert on posts
for each row
begin
    if trim(new.content) = '' then
        signal sqlstate '45000' set message_text = 'Nội dung bài viết không được để trống!';
    end if;
end//;
drop trigger tg_CheckPostContent;
-- Task 2
delimiter //
create trigger tg_UpdatePostCountAfterInsert
after insert on posts
for each row
begin
    update users
    set total_posts = total_posts + 1
    where user_id = new.user_id;
end//
drop trigger tg_UpdatePostCountAfterInsert;
-- Task 3
delimiter //
create trigger tg_LogPostChanges
after update on posts
for each row
begin
    if old.content <> new.content then
        insert into post_audits (post_id, old_content, new_content)
        values (old.post_id, old.content, new.content);
    end if;
end//
drop trigger tg_LogPostChanges;
-- Task 4
delimiter //
create trigger tg_UpdatePostCountAfterDelete
after delete on posts
for each row
begin
    update users
    set total_posts = total_posts - 1
    where user_id = old.user_id;
end//
drop trigger tg_UpdatePostCountAfterDelete;

insert into users (username,total_posts,created_at) 
values ('Hoanhello',0,now());

insert into posts (user_id,content,created_at) 
values (1,'okk',now());

select * from users;
select * from posts;
select * from post_audits;



