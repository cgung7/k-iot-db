### c_select 폴더 >>> z_practice_question 파일 ###

use `korea_db`;
# members, purchases 테이블 사용

-- 1. 모든 회원의 이름, 연락처, 회원등급을 조회하시오.
select name, contact, grade
from `members`;

-- 2. 'SEOUL'에 거주하는 회원의 이름과 회원등급을 조회하시오.
select name, grade
from `members`
where 
	area_code = 'SEOUL';

-- 3. 회원등급이 'Gold' 이상인 회원의 이름과 가입일을 조회하시오.
select name, join_date
from `members`
where
	grade >= 'Gold';


-- 4. 2023년도에 가입한 회원의 이름과 가입일을 조회하시오.
select name, join_date
from `members`
where
	year(join_date) = '2023';

-- 5. 100포인트 이상을 가진 회원의 이름과 포인트를 조회하시오.
select name, points
from `members`
where
	points >= 100;

-- 6. 'Male' 성별의 회원 중에서 'Gold' 등급 이상의 회원을 조회하시오.
select name
from `members`
where
	gender = 'Male' and grade >= 'Gold';

-- 7. 최근에 구매한 회원과 구매일을 조회하시오. (가장 최근 구매일 기준 상위 3명)
-- group by, 집계함수, order by, limit
select * from `purchases`
order by
	purchase_date desc
limit 3;

-- 8. 회원별로 구매한 총 금액(amount의 합)을 조회하시오.
-- group by, 집계함수
select member_id, sum(amount) as sum_amount
from `purchases`
group by
	member_id
having 
	sum(amount);

-- 9. 구매 금액이 가장 높은 회원의 멤버아이디, 이름, 토탈 금액 검색(member_id, name, total_amount)
# 서브 쿼리를 이용한 값 출력
select P.member_id, M.name, P.amount as total_amount
from `members` M
	join `purchases` P
    on M.member_id = P.member_id
-- members와 purcharses을 결합(join) 그리고 member_id의 특정값을 공유 // ON 조인될 조건 (결합 조건)
where -- purcharses에 있는 amount 최대값을 확인
	P.amount = (
		select max(amount)
		from purchases
	
    );
