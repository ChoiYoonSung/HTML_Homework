
/* Drop Indexes */

DROP INDEX IDX_ZIPTB_ZIPCODE;



/* Drop Tables */

DROP TABLE BUYPROD CASCADE CONSTRAINTS;
DROP TABLE cart CASCADE CONSTRAINTS;
DROP TABLE PROD CASCADE CONSTRAINTS;
DROP TABLE BUYER CASCADE CONSTRAINTS;
DROP TABLE LPROD CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE ziptb CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE BUYER
(
	-- 거래처 코드
	BUYER_ID char(6) NOT NULL UNIQUE,
	-- 거래처 명
	BUYER_NAME varchar2(60) NOT NULL,
	-- 상품 분류 코드
	BUYER_LGU char(4) NOT NULL UNIQUE,
	-- 은행
	BUYER_BANK varchar2(60),
	-- 계좌번호
	BUYER_BANKNO varchar2(60),
	-- 예금주
	BUYER_BANKNAME varchar2(15),
	-- 우편번호
	BUYER_ZIP char(7),
	-- 주소1
	BUYER_ADD1 varchar2(100),
	-- 주소2
	BUYER_ADD2 varchar2(70),
	-- 전화번호
	BUYER_COMTEL varchar2(14) NOT NULL,
	-- FAX 번호
	BUYER_FAX varchar2(20) NOT NULL,
	-- 이메일 주소
	BUYER_MAIL varchar2(60) NOT NULL,
	-- 담당자
	BUYER_CHARGER varchar2(20),
	-- 구내 전화 번호
	BUYER_TELEXT varchar2(2),
	PRIMARY KEY (BUYER_ID)
);


CREATE TABLE BUYPROD
(
	-- 입고일자
	buy_date date NOT NULL UNIQUE,
	-- 상품코드
	buy_prod varchar2(10) NOT NULL UNIQUE,
	-- 매입수량
	buy_qty number(10) NOT NULL,
	-- 매입단가
	buy_cost number(10) NOT NULL,
	PRIMARY KEY (buy_date, buy_prod)
);


CREATE TABLE cart
(
	-- 주문번호
	cart_no char(13) NOT NULL UNIQUE,
	-- 상품코드
	prod_id varchar2(10) NOT NULL UNIQUE,
	-- 회원 id
	mem_id varchar2(15) NOT NULL UNIQUE,
	-- 수량
	cart_qty number(8) NOT NULL,
	PRIMARY KEY (cart_no, prod_id)
);


CREATE TABLE LPROD
(
	-- 순번
	LPROD_ID number(5,0) NOT NULL,
	-- 상품 분류 코드
	LPROD_GU char(4) NOT NULL UNIQUE,
	-- 상품 분류 명
	LPROD_NM varchar2(40) NOT NULL,
	PRIMARY KEY (LPROD_GU)
);


CREATE TABLE member
(
	-- 회원 id
	mem_id varchar2(15) NOT NULL UNIQUE,
	-- 비밀번호
	mem_pass varchar2(15) NOT NULL,
	-- 성명
	mem_name varchar2(20) NOT NULL,
	-- 주민등록번호 앞 6자리
	mem_regno1 char(6) NOT NULL,
	-- 주민등록번호 뒤 7자리
	mem_regno2 char(7) NOT NULL,
	-- 집 전화번호
	mem_hometel varchar2(14) NOT NULL,
	-- 회사전화번호
	mem_comtel varchar2(14) NOT NULL,
	-- 이동전화
	mem_hp varchar2(15),
	-- 이메일 주소
	mem_mail varchar2(60) NOT NULL,
	-- 직업
	mem_job varchar2(40),
	-- 취미
	mem_like varchar2(40),
	-- 기념일명
	mem_memorial varchar2(40),
	-- 기념일 날짜
	mem_memorialday date,
	-- 마일리지
	mem_mileage number(10),
	PRIMARY KEY (mem_id)
);


CREATE TABLE PROD
(
	-- 상품코드
	prod_id varchar2(10) NOT NULL UNIQUE,
	-- 상품명
	prod_name varchar2(40) NOT NULL,
	-- 매입가
	prod_cost number(10) NOT NULL,
	-- 소비자가
	prod_price number(10) NOT NULL,
	-- 판매가
	prod_sale number(10) NOT NULL,
	-- 상품 분류 코드
	LPROD_GU char(4) NOT NULL UNIQUE,
	-- 거래처 코드
	BUYER_ID char(6) NOT NULL UNIQUE,
	-- 상품 개략 설명
	prod_outline varchar2(100) NOT NULL,
	-- 상품 상세 설명
	prod_detail clob,
	PRIMARY KEY (prod_id)
);


CREATE TABLE ziptb
(
	-- 우편번호
	zipcode char(7) NOT NULL,
	-- 특별시 광역시 도
	sido nvarchar2(2) NOT NULL,
	-- 시 군 구
	gugun nvarchar2(10) NOT NULL,
	-- 읍 면 동 리 건물명
	dong nvarchar2(30) NOT NULL,
	-- 번지 아파트동 호수
	bunji nvarchar2(10),
	-- 자료순서
	seq number(5) NOT NULL
);



/* Create Foreign Keys */

ALTER TABLE PROD
	ADD FOREIGN KEY (BUYER_ID)
	REFERENCES BUYER (BUYER_ID)
;


ALTER TABLE BUYER
	ADD FOREIGN KEY (BUYER_LGU)
	REFERENCES LPROD (LPROD_GU)
;


ALTER TABLE PROD
	ADD FOREIGN KEY (LPROD_GU)
	REFERENCES LPROD (LPROD_GU)
;


ALTER TABLE cart
	ADD FOREIGN KEY (mem_id)
	REFERENCES member (mem_id)
;


ALTER TABLE BUYPROD
	ADD FOREIGN KEY (buy_prod)
	REFERENCES PROD (prod_id)
;


ALTER TABLE cart
	ADD FOREIGN KEY (prod_id)
	REFERENCES PROD (prod_id)
;



/* Create Indexes */

CREATE INDEX IDX_ZIPTB_ZIPCODE ON ziptb USING BTREE (zipcode);



/* Comments */

COMMENT ON COLUMN BUYER.BUYER_ID IS '거래처 코드';
COMMENT ON COLUMN BUYER.BUYER_NAME IS '거래처 명';
COMMENT ON COLUMN BUYER.BUYER_LGU IS '상품 분류 코드';
COMMENT ON COLUMN BUYER.BUYER_BANK IS '은행';
COMMENT ON COLUMN BUYER.BUYER_BANKNO IS '계좌번호';
COMMENT ON COLUMN BUYER.BUYER_BANKNAME IS '예금주';
COMMENT ON COLUMN BUYER.BUYER_ZIP IS '우편번호';
COMMENT ON COLUMN BUYER.BUYER_ADD1 IS '주소1';
COMMENT ON COLUMN BUYER.BUYER_ADD2 IS '주소2';
COMMENT ON COLUMN BUYER.BUYER_COMTEL IS '전화번호';
COMMENT ON COLUMN BUYER.BUYER_FAX IS 'FAX 번호';
COMMENT ON COLUMN BUYER.BUYER_MAIL IS '이메일 주소';
COMMENT ON COLUMN BUYER.BUYER_CHARGER IS '담당자';
COMMENT ON COLUMN BUYER.BUYER_TELEXT IS '구내 전화 번호';
COMMENT ON COLUMN BUYPROD.buy_date IS '입고일자';
COMMENT ON COLUMN BUYPROD.buy_prod IS '상품코드';
COMMENT ON COLUMN BUYPROD.buy_qty IS '매입수량';
COMMENT ON COLUMN BUYPROD.buy_cost IS '매입단가';
COMMENT ON COLUMN cart.cart_no IS '주문번호';
COMMENT ON COLUMN cart.prod_id IS '상품코드';
COMMENT ON COLUMN cart.mem_id IS '회원 id';
COMMENT ON COLUMN cart.cart_qty IS '수량';
COMMENT ON COLUMN LPROD.LPROD_ID IS '순번';
COMMENT ON COLUMN LPROD.LPROD_GU IS '상품 분류 코드';
COMMENT ON COLUMN LPROD.LPROD_NM IS '상품 분류 명';
COMMENT ON COLUMN member.mem_id IS '회원 id';
COMMENT ON COLUMN member.mem_pass IS '비밀번호';
COMMENT ON COLUMN member.mem_name IS '성명';
COMMENT ON COLUMN member.mem_regno1 IS '주민등록번호 앞 6자리';
COMMENT ON COLUMN member.mem_regno2 IS '주민등록번호 뒤 7자리';
COMMENT ON COLUMN member.mem_hometel IS '집 전화번호';
COMMENT ON COLUMN member.mem_comtel IS '회사전화번호';
COMMENT ON COLUMN member.mem_hp IS '이동전화';
COMMENT ON COLUMN member.mem_mail IS '이메일 주소';
COMMENT ON COLUMN member.mem_job IS '직업';
COMMENT ON COLUMN member.mem_like IS '취미';
COMMENT ON COLUMN member.mem_memorial IS '기념일명';
COMMENT ON COLUMN member.mem_memorialday IS '기념일 날짜';
COMMENT ON COLUMN member.mem_mileage IS '마일리지';
COMMENT ON COLUMN PROD.prod_id IS '상품코드';
COMMENT ON COLUMN PROD.prod_name IS '상품명';
COMMENT ON COLUMN PROD.prod_cost IS '매입가';
COMMENT ON COLUMN PROD.prod_price IS '소비자가';
COMMENT ON COLUMN PROD.prod_sale IS '판매가';
COMMENT ON COLUMN PROD.LPROD_GU IS '상품 분류 코드';
COMMENT ON COLUMN PROD.BUYER_ID IS '거래처 코드';
COMMENT ON COLUMN PROD.prod_outline IS '상품 개략 설명';
COMMENT ON COLUMN PROD.prod_detail IS '상품 상세 설명';
COMMENT ON COLUMN ziptb.zipcode IS '우편번호';
COMMENT ON COLUMN ziptb.sido IS '특별시 광역시 도';
COMMENT ON COLUMN ziptb.gugun IS '시 군 구';
COMMENT ON COLUMN ziptb.dong IS '읍 면 동 리 건물명';
COMMENT ON COLUMN ziptb.bunji IS '번지 아파트동 호수';
COMMENT ON COLUMN ziptb.seq IS '자료순서';



