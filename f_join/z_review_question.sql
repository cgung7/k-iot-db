### f_join >>> z_review_question ###

/*
	문제 1
	모든 회원의 이름, 등급, 구매한 상품 코드, 구매일, 구매 금액(amount)을 조회하세요.
	구매 기록이 없는 회원도 모두 포함되도록 하세요.
	단, 구매일이 오래된 순으로 정렬하세요.

	문제 2
	2023년 이후 가입한 회원 중 구매 총액이 30000원 이상인 
    회원의 이름, 지역코드, 총 구매금액을 조회하세요.

	문제 3
	회원 등급별로 구매 총액 평균을 구하고,
	회원 등급(grade), 구매건수(COUNT), 구매총액합계(SUM), 구매평균(AVG)을 모두 출력하세요.
	단, 구매가 한 건도 없는 등급은 제외하세요.
*/

USE `korea_db`;


/*
문제 1
	모든 회원의 이름, 등급, 구매한 상품 코드, 구매일, 구매 금액(amount)을 조회하세요.
	구매 기록이 없는 회원도 모두 포함되도록 하세요.
	단, 구매일이 오래된 순으로 정렬하세요.
*/
SELECT
	M.name , M.area_code , P.product_code, P.purchase_date, P.amount
FROM
	`members` M
    join `purchases` P
    ON M.member_id = P.member_id;
    
/*
문제 2
	2023년 이후 가입한 회원 중 구매 총액이 30000원 이상인 
    회원의 이름, 지역코드, 총 구매금액을 조회하세요.
*/

SELECT  
	M.name, M.area_code, SUM(P.amount) as total_amount
FROM
	`members` M
    join `purchases` P
    ON M.member_id = P.member_id
GROUP BY
	M.name, M.area_code
HAVING
	SUM(P.amount) >= 30000;

/*
문제 3
	회원 등급별로 구매 총액 평균을 구하고,
	회원 등급(grade), 구매건수(COUNT), 구매총액합계(SUM), 구매평균(AVG)을 모두 출력하세요.
	단, 구매가 한 건도 없는 등급은 제외하세요.

*/
SELECT
	M.grade, COUNT(P.quantity) as 'COUNT', SUM(P.amount) as 'total_amount', ROUND(AVG(P.amount), 2) as 'AVG_avount'
FROM
	`members` M
    join `purchases` P
    ON M.member_id = P.member_id
WHERE
	P.quantity IS NOT NULL
    
GROUP BY
	M.grade;
	












