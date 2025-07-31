### h_트리거 >>> trigger03 ###

### 트래거 예시 ###
USE `baseball_league`;

select * from players;
select * from teams;

# 트리거 생성
# : 선수가 새로 등록될 때 마다 해당 선수가 속한 팀의 선수 수를 자동 업데이트
create table if not exists player_insert_logs (
	log_id bigint auto_increment primary key, -- 고정값
    team_id int, -- 팁 이름
    log_msg varchar(255), -- 팀 메세지
    log_time datetime -- 팁 가입 시간
);

drop trigger if exists after_player_insert;

delimiter $$
create trigger frter_player_insert
after insert
on players
	for each row
begin
	insert into player_insert_logs (team_id, log_msg, log_time)
    values
		(NEW.team_id, concat('team', NEW.team_id), now());
end $$

delimiter ;

# OLD: update, delete 시 변경 사항이 임시로 저장되는 테이블
# NEW: insert, update, delete 시 방급 삽입된 또는 갱신된 행을 참조

select * from player_insert_logs;

insert into players
values
	(106, 'LSA', '타자', '2025-07-31', 1);
    
insert into players
values
	(107, 'LSA', '타자', '2025-07-31', 1),
	(108, 'LDK', '타자', '2025-07-31', 1),
	(109, 'JSB', '타자', '2025-07-31', 2),
	(110, 'KMJ', '타자', '2025-07-31', 3);
    
select * from player_insert_logs;
	
    
    
















