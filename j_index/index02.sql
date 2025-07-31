### J_index >>> index02 ###

### 인덱스 사용 정리 ###
# : 검색 속도 향상 도구
# - 책의 목차처럼 빠르게 데이터를 찾게 해줌
# - 조건문(where), 정렬(order by), 조인(join) 등에 유용

/*
	인덱스 생성 방법 (키 살정 방식 X)
    
    create[unique] index 인덱스명
    on 테이블명 (열이름 [asc | desc]);
    
    cf) [] 괄호 카워드 생략 가능
    
    1) unique: 중복을 허용하지 않는 고유 인덱스 생성 (생략시 중복 허용)
    2) asc | desc: 오름차순 | 내림차순 (생략 시 오름차순)
    */
    use 인덱스;
    
    # 단순 인덱스 생성
    
    create index idx_member_addr
		on members (address);
        
	# 고유 인덱스 생성
    
    create unique index ind_member_name
    on member(mem_name);
    
    # cf) create index로 생상된 인덱스는 drop index로 제거
    #		>> 기본키(PK), 고유키(Unique)로 자동 생성된 인덱스는 drop index 불가
    #			- alter table로 기본키나 고유키 제어(자동 인덱스 제거)
    
    show index from members;
    
    show table status like 'members';
    # : 테이블에 대한 다양한 정보 확인 명령어
    # > 테이블 엔진 타입, 행 수, 데이터 크기, 인코딩, 자동 증가값, 주석 등
    # 1) Data_lengh(클러스터형 인덱스 크기): 16354 byte (16KB)
    # 2) Index_lengh(보조 인덱스 크기): 0;
    
    # cf) 생성된 인덱스 작용 방밥 (create index 이후 반드시 실행하여야 성능 최적화 기여)
    analyze table members;
    show table status like 'members';
    # Index_lengh: 65536 Byte (32KB)
    
    # cf) MySQL(InnoDB 엔진)의 기본 인덱스 페이지 크기 16KB



