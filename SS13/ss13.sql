drop database ss13_b1;
create database ss13_b1;

use ss13_b1;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text,
    created_at datetime,
    like_count int default 0,
    foreign key (user_id) references users(user_id) on delete cascade
);

create table likes (
    like_id int primary key auto_increment,
    user_id int not null,
    post_id int not null,
    liked_at datetime,
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (post_id) references posts(post_id) on delete cascade
);

create table post_history (
    history_id int primary key auto_increment,
    post_id int not null,
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int not null,
    foreign key (post_id) references posts(post_id) on delete cascade
);

create table friendships (
    follower_id int,
    followee_id int,
    status enum('pending', 'accepted') default 'accepted',
    primary key (follower_id, followee_id),
    constraint fk_friendships_follower
        foreign key (follower_id)
        references users(user_id)
        on delete cascade,
    constraint fk_friendships_followee
        foreign key (followee_id)
        references users(user_id)
        on delete cascade
);

INSERT INTO users (username, email, created_at) VALUES

('alice', 'alice@example.com', '2025-01-01'),

('bob', 'bob@example.com', '2025-01-02'),

('charlie', 'charlie@example.com', '2025-01-03');

-- B1
delimiter //
create trigger trigger_after_insert_posts
after insert on posts
for each row
begin
	update users
    set post_count = post_count + 1
    where user_id = new.user_id;
end //


delimiter //
create trigger trigger_after_delete_posts
after delete on posts
for each row
begin
	update users
    set post_count = post_count - 1
    where user_id = old.user_id;
end //

INSERT INTO posts (user_id, content, created_at) VALUES

(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),

(1, 'Second post by Alice', '2025-01-10 12:00:00'),

(2, 'Bob first post', '2025-01-11 09:00:00'),

(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

SELECT * FROM users;

delete from posts where post_id = 2;

SELECT * FROM users;

-- B2
INSERT INTO likes (user_id, post_id, liked_at) VALUES

(2, 1, '2025-01-10 11:00:00'),

(3, 1, '2025-01-10 13:00:00'),

(1, 3, '2025-01-11 10:00:00'),

(3, 4, '2025-01-12 16:00:00');

delimiter //
create trigger trigger_after_insert_like
after insert on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
    if new.user_id = (select p.user_id from posts p where p.post_id = new.post_id) then
		signal sqlstate '45000' set message_text = 'khong duoc like chinh minh';
	end if;
end //

delimiter //
create trigger trigger_after_delete_like
after delete on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end //

INSERT INTO likes (user_id, post_id, liked_at) VALUES (2, 4, NOW());

SELECT * FROM posts WHERE post_id = 4;

drop view user_statistics;
create view user_statistics as
select u.user_id, u.username, u.post_count,sum(p.like_count) as total_received_likes
from users u
join posts p on u.user_id = p.user_id
group by u.user_id;

select * from user_statistics;

-- B3

-- Trên b2

delimiter //
create trigger trigger_after_like_update
after update on likes
for each row
begin
    if old.post_id != new.post_id then
        update posts 
        set like_count = like_count - 1 
        where post_id = old.post_id;
        
        update posts 
        set like_count = like_count + 1 
        where post_id = new.post_id;
    end if;
end //

insert into likes(user_id, post_id, liked_at) values(1,1,now());

-- B4 
delimiter //
create trigger trigger_before_update_posts
before update on posts
for each row
begin
	if new.content <> old.content then 
		insert into post_history (post_id,old_content,new_content,changed_at,changed_by_user_id) values
        (new.post_id,old.content,new.content,now(),new.user_id);
	end if;
end //

update posts
set content = 'aabbcc'
where post_id = 1;

select * from posts;
select * from post_history;

delimiter //
create trigger trigger_before_update_posts
after delete on posts
for each row
begin
	insert into post_history (post_id,old_content,new_content,changed_at,changed_by_user_id) values
    (old.post_id,old.content,'Bài đăng đã bị xóa',now(),old.user_id);
end //

-- B5
delimiter //
create procedure add_user( in p_username varchar(50),in p_email varchar(50),in p_created_at date)
begin
	insert into users (username, email, created_at)
    values (p_username, p_email, p_created_at);
end//

call add_user('HonLoan','hoanloan@gmail.',now());
select * from users

delimiter //
create trigger tg_before_insert_users
before insert on users
for each row
begin
    if new.email not like '%@%.%' then
        signal sqlstate '45000'
        set message_text = 'email không hợp lệ phải chứa @ và .';
    end if;
    
    if new.username regexp '^[a-zA-Z0-9_]+$' = 0 then
        signal sqlstate '45000'
        set message_text = 'username chỉ chứa chữ cái, số và underscore.';
    end if;
end //

-- B6 
delimiter //

create trigger trg_after_insert_friendships
after insert on friendships
for each row
begin
    if new.status = 'accepted' then
        update users
        set follower_count = follower_count + 1
        where user_id = new.followee_id;
    end if;
end //

create trigger trg_after_delete_friendships
after delete on friendships
for each row
begin
    if old.status = 'accepted' then
        update users
        set follower_count = follower_count - 1
        where user_id = old.followee_id;
    end if;
end //

delimiter ;


drop procedure if exists follow_user;

delimiter //

create procedure follow_user(
    in p_follower_id int,
    in p_followee_id int,
    in p_status enum('pending', 'accepted')
)
begin
    -- không cho tự follow
    if p_follower_id = p_followee_id then
        signal sqlstate '45000'
        set message_text = 'Không thể tự follow chính mình';
    end if;

    -- tránh follow trùng
    if exists (
        select 1
        from friendships
        where follower_id = p_follower_id
          and followee_id = p_followee_id
    ) then
        signal sqlstate '45000'
        set message_text = 'Đã tồn tại quan hệ follow';
    end if;

    insert into friendships (follower_id, followee_id, status)
    values (p_follower_id, p_followee_id, p_status);
end //

delimiter ;


drop view if exists user_profile;

create view user_profile as
select
    u.user_id,
    u.username,
    u.follower_count,
    u.post_count,
    ifnull(sum(p.like_count), 0) as total_likes,
    group_concat(
        concat(p.post_id, ': ', left(p.content, 30))
        order by p.created_at desc
        separator ' | '
    ) as recent_posts
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username, u.follower_count, u.post_count;



call follow_user(2, 1, 'accepted');
call follow_user(3, 1, 'accepted');

call follow_user(1, 2, 'pending');

select user_id, username, follower_count
from users;

delete from friendships
where follower_id = 2 and followee_id = 1;

select user_id, username, follower_count
from users;

select * from user_profile;

