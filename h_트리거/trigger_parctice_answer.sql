### h_트리거 >>> trigger_practice_answer ###

##### 문제 1 #####
-- 기존 트리거 삭제
drop trigger if exists after_player_delete;

-- 트리거 생성
delimiter $$
create trigger after_player_delete
	after delete 			-- after delete 'delete' 문이 발생된 이후에 작동
    on players				-- after delete 적용 시킬 리스트는 '플레이어'
    for each row 			-- 각 행 마다 적용 (모든 행에 트리거 적용)
# 실제 트리거에서 작동할 부분
begin	
	insert into player_delete_logs (player_name, deleted_time) # 플레이어 삭제 로그에 목록 추가 // 저장될 목록: (플레이어 이름, 삭제 시간)
    values (OLD.name, now());  # 출력값들-values (OLD: update, delete 시 변경 사항이 임시로 저장되는 테이블(이름) , now() <- 현재 시간 출력)
end $$ # 트리거 종료
delimiter ; 

##### 문제 2 #####
-- 기존 트리거 삭제
drop trigger if exists after_player_position_update;

-- 트리거 생성
delimiter $$
create trigger after_player_position_update
	after update		-- after문이 발생된 이후 작동
    on players			-- 적용대상자는 플레이어
    for each row		-- 모든 행에 트리거 적용
begin
	if OLD.position != NEW.position then # 만약-if 임시-OLD. 포지션이 새로운-NEW 포지션과 일치하지 않는 경우(!=) 
		insert into player_position_logs (player_name, old_position, new_position, changed_time) # 플레이어 리스트 생성(이름, 기존 포지션, 변경 포지션, 시간)
        values (NEW.name, OLD.position, NEW.position, now()); # 출력(적용)값 ( 변경후 이름, 변경 전 포지션, 변경 후 포지션, 현재 시간 출력)
	end if;
end $$
delimiter ;

##### 문제 3 #####

-- teams 테이블에 player_count 컬럼 추가 
ALTER TABLE teams ADD COLUMN player_count INT DEFAULT 0;

-- 선수 추가 시 팀의 선수 수 증가 트리거
DROP TRIGGER IF EXISTS after_player_insert_count;

DELIMITER $$
CREATE TRIGGER after_player_insert_count
AFTER INSERT 
	ON players # 새로 적용될 리스트는 플레이어
FOR EACH ROW
BEGIN
	UPDATE teams
	SET player_count = player_count + 1 # 대입값-SET 플레이어 카운트 = 플레이어 카운트 증가(+ 1)
	WHERE team_id = NEW.team_id; # 어디서 적용? -WHERE 기존의 팀 이름 = 변경 후 팀 이름
END $$ # 트리거 종료
DELIMITER ;

-- 선수 삭제 시 팀의 선수 수 감소 트리거
DROP TRIGGER IF EXISTS after_player_delete_count;

DELIMITER $$
CREATE TRIGGER after_player_delete_count
AFTER DELETE 
	ON players
FOR EACH ROW
BEGIN
	UPDATE teams
	SET player_count = player_count - 1
	WHERE team_id = OLD.team_id;
END $$
DELIMITER ;