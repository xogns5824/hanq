drop schema `jubongshop`;
CREATE SCHEMA `jubongshop` DEFAULT CHARACTER SET utf8 ;

use jubongshop;


create table member_list(
ml_id		varchar(20) primary key,	/* 회원아이디 */
ml_idx		int unsigned auto_increment unique,	/* 회원 일련번호 */
ml_pwd		varchar(20) not null,	/* 회원 비밀번호 */
ml_name		varchar(15) not null,	/* 회원 이름 */
ml_phone	varchar(13) not null,	/* 회원 전번호 */
ml_birth	char(10) not null,	/* 회원 생년월일 */
ml_email 	varchar(50) not null,	/* 회원 이메일 */
ml_gender	char(1) not null,	/* 회원 성별 */
ml_point	int unsigned default 0,	/* 총 사용 가능 포인트*/
ml_situ		int default 1,	/* 회원 상태 (0:관리자, 1:일반회원, 2:블랙리스트, 3:탈퇴회원)*/
ml_joindate	datetime default now()	/* 가입날짜 */
);

create table member_addr(
ma_idx	int unsigned auto_increment primary key,	/* 회원 주소 일련번호 */
ml_id	varchar(20) not null,	/* 회원아이디 */
ma_title varchar(100) not null,	/* 배송지명 */
ma_name varchar(20) not null,	/* 성명 */
ma_phone varchar(13) not null,	/* 휴대전화 */
ma_zip	char(5) not null,	/* 회원 우편번호 */
ma_addr1	varchar(100) not null,	/* 회원 주소1 */
ma_addr2	varchar(100) not null,	/* 회원 주소2 */
ma_isbasic	char(1) not null default 'n',	/* 기본주소 여부 */
ma_date	datetime default now(),	/* 주소기입날짜 */
foreign key (ml_id) references member_list(ml_id)
);

create table member_point(
mp_idx	int unsigned auto_increment primary key,	/* 회원 주소 일련번호 */
o_id	varchar(20) default '',	/* 주문번호 */
ml_id varchar(20) not null,
mp_point	int default 0,	/* 회원 우편번호 */
mp_content	varchar(30) not null,	/* 회원 주소1 */
mp_state	char(1) not null,	/* 포인트 상태 ( u : 사용, y : 적립 ) */ 
mp_date	datetime default now(),	/* 기본주소 여부 */
foreign key (ml_id) references member_list(ml_id)
);


create table product_category(
pc_idx	int unsigned auto_increment primary key,	-- 카테고리 일련번호
pc_title	varchar(10) not null,	-- 카테고리 명
pc_isview	char(1) default 'y'	-- 카테고리 사용여부
);

create table product(
p_idx	int unsigned auto_increment unique,	-- 상품 일련번호
p_id	varchar(20) primary key, -- 상품 번호
p_img	varchar(100) default './image/none.gif',	-- 상품 이미지
p_title	varchar(50) not null,	-- 상품 명
pc_idx	int unsigned not null,	-- 카테고리 일련번호
p_contact	text ,	-- 상품 상세 설명
p_price	int unsigned default 0,	-- 상품 가격
p_rprice	int unsigned default 0,	-- 소비자가
p_point	int unsigned default 0,	-- 적립금
p_delivery	int unsigned default 0,	-- 배송비
p_stock	int unsigned default 0,	-- 총 재고량
p_isview	int unsigned default 0,	-- 상품 상태 (0 : 상품 미게시 1 : 판매중 2 : 판매 종료 3 : 재입고  4 : 품절)
p_best	char(1) default'n',	-- 인기 상품 여부
p_regdate	datetime default now(),	-- 상품 등록일
foreign key (pc_idx) references product_category(pc_idx)

);


create table member_cart(
mc_id	int unsigned auto_increment primary key,	/* 회원 장바구니 일련번호 */
ml_id	varchar(20) not null,	/* 회원 아이디 */
p_id	varchar(20) not null,	/* 상품 아이디 */
po_idx	int unsigned not null,	/* 상품 옵션 일련번호 */ 
mc_cnt 	int unsigned default 1,	/* 상품수량 */
foreign key (ml_id) references member_list(ml_id),
foreign key (p_id) references product(p_id)

);

create table member_wishList
(
	w_idx int unsigned auto_increment primary key,
	ml_id varchar(20) not null,
	p_id varchar(20) not null,
	w_date datetime default now(),
	foreign key (ml_id) references member_list(ml_id),
    foreign key (p_id) references product(p_id)
);


create table product_option(
po_idx	int unsigned auto_increment primary key,	-- 상품 옵션 일련번호
p_id	varchar(20) not null,	-- 상품 번호
po_color	varchar(10) not null,	-- 상품 색상
po_size	int unsigned not null,	-- 상품 사이즈
po_stock	int unsigned default 0,	-- 상품 재고량
foreign key (p_id) references product (p_id)
);


create table product_board(
pb_idx	int unsigned auto_increment primary key,	-- 상품 게시판 일련번호
p_id	varchar(20),	-- 상품 번호
ml_id varchar(20) not null,		-- 회원앙이디
pb_type	char(1) not null,	-- 상품 게시판 대분류
pb_qtype int default 0,	-- Q&A 소분류
pb_title	varchar(50) not null,	-- 제목
pb_writer	varchar(20) not null,	-- 작성자
pb_contents	text,	-- 내용
pb_img	varchar(100) default './image/none.gif',	-- 이미지
pb_read	int default 0 ,	-- 조회수
pb_pwd	varchar(20) not null,	-- 비밀번호
pb_date	datetime default now()	-- 게시 날짜
);

create table notice (
n_idx	int unsigned auto_increment primary key,
n_title	varchar(50) not null,
n_contents	text not null,
n_img	varchar(100) default './image/none.gif',
n_date	datetime default now(),
n_writer	varchar(20) default '주봉샵'

);


create table reply (
r_idx	int unsigned auto_increment primary key,
pb_idx	int unsigned not null,
r_title	varchar(50) not null,
r_contents	text not null,
r_writer	varchar(20) default '주봉샵',
r_date	datetime default now(),
foreign key (pb_idx) references product_board(pb_idx)
);

create table order_info(
o_idx	int unsigned auto_increment unique,
o_id	varchar(20) primary key,
ml_id	varchar(20) default '',
o_pwd	varchar(20) default '',
o_name	varchar(15) not null,
o_phone	varchar(13) not null,
o_email	varchar(50) not null,
o_zip	char(5) not null,
o_addr1	varchar(30) not null,
o_addr2	varchar(30) not null,
o_rname 	varchar(15) not null,
o_rphone	varchar(13) not null,
o_rzip	varchar(50) not null,
o_raddr1	char(5) not null,
o_raddr2	varchar(30) not null,
o_message	varchar(30) not null,
o_totalprice	int unsigned default 0,
o_payment	char(1) default 'd',
o_situ	int default 0,
o_point	int default 0,
o_mileage	int default 0,
o_date	datetime default now()
);

create table order_detail (
od_idx	int unsigned auto_increment primary key,
o_id	varchar(20) not null,
p_id	varchar(20) not null,
od_size	char(3) not null,
od_color	varchar(10) not null,
od_cnt	int unsigned default 1,
foreign key (o_id) references order_info (o_id)
);