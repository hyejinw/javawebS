show tables;

create table board2 (
	idx int not null auto_increment,
	mid varchar(20) not null,
	nickName varchar(20) not null,
	title varchar(100) not null,  /* 게시글 제목 */
	email varchar(50),
	homePage varchar(50),
 	content text not null,        /* 게시글 내용 */
	readNum int default 0,        /* 조회수 */
 	hostIp varchar(40) not null,
	openSw char(2) default 'OK',  /* 게시글 공개 여부 */
	wDate datetime default now(), /* 글 올린 날짜와 시간 */
	good int default 0,           /* 좋아요 클릭 횟수 누적 */
	primary key(idx)   /*primary key는 여러 개 올 수 있다만 항상 그럴 필요는 없다.*/
	
);

/* 게시판에 댓글 달기 */
create table board2Reply (
	idx int not null auto_increment,        /* 댓글의 고유번호 */
	boardIdx int not null,                  /* 원본 글의 고유번호(외래키로 지정) */
	mid varchar(20) not null,							  /* 댓글 올린이의 아이디 */
	nickName varchar(20) not null,				  /* 댓글 올린이의 닉네임, 왜 두 개? 닉네임은 변경가능하니까! */
	wDate datetime default now(),           /* 댓글 올린 날짜 */
	hostIp varchar(50) not null,            /* 댓글 올린 pc의 고유 IP */
	content text not null,                  /* 내용 */
	
	primary key(idx),
	foreign key(boardIdx) references board2(idx)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete restrict                             /* 원본의 idx를 삭제해도 기본의 값은 유지하게 한다. */
);


desc board2;
desc board2Reply;

insert into board2 values (default,'admin','관리맨','게시판 서비스 시작합니다.','secret@secret.com','somewhere.lulook@naver.com','이곳은 게시판입니다.',default,'192.168.50.83',default,default,default);

select* from board2;

drop table board2;


/* 날짜 함수 처리 연습 */
select now();  /*오늘 날짜*/
select year(now());
select month(now());
select day(now());
select concat(year(now()),'년 ',month(now()),'월 ',day(now()),'일');
select concat(year(now()),'년 ',month(now()),'월 ',day(now()),'일') as date; /* VO에 등록해두면 변수로 사용 가능!! */
select weekday(now());   /* 0=월요일 */
select dayofweek(now()); /* 1=일요일 */
select date(now());      /* 날짜를 '년-월-일' 로 출력 */

select year('2023-5-3');
select idx, wDate from board2;
select idx, year(wDate) from board2;

/* 날짜 연산 */
/* date_add(date, interval 값 Type) */
select date_add(now(), interval 1 day); /* 오늘 날짜보다 +1 = 내일 날짜 출력 */
select date_add(now(), interval -1 day); /* 오늘 날짜보다 -1 = 어제 날짜 출력 */
/*오늘 날짜보다 +10시간 이후의 날짜와 시간 출력 */
select now(),date_add(now(), interval 10 day_hour);

/* date_sub(date, interval 값 Type) */
select date_sub(now(), interval 1 day); /* 오늘 날짜보다 -1 = 어제 날짜 출력 */
select date_sub(now(), interval -1 day); /* 오늘 날짜보다 1 = 내일 날짜 출력 */

/* board2테이블에 적용 */
/* 1. 게시글 중에서 하루 전에 올려온 글만 보여주시오. == 노노 안 됑! 비교만 해볼게*/
select wDate, date_add(now(), interval -1 day) from board2;

/* 2. 어제 올라온 글만 보여줘~~ */
select idx, wDate from board2 where substring(wDate,1,10) = substring(date_add(now(), interval -1 day),1,10);

/* 3. 24시간 전에 올라온 글만 보여줘! */
select idx, wDate, now() from board2 where wDate >= date_add(now(), interval -24 day_hour);
select * from board2 where wDate > date_add(now(), interval -24 day_hour);


/* 날짜차이 계산 : DATEDIFF(시작날짜, 마지막날짜) */
select datediff('2023-05-04', '2023-05-01');
select datediff(now(), '2023-05-01');
select idx, datediff(now(), wDate) from board2;
select idx, datediff(now(), wDate) as day_diff from board2;   /* 앞에서 뒤를 뺀다. 값이 +로 */
select idx, datediff(wDate, now()) as day_diff from board2;   /* 값이 -로 */

select timestampdiff(hour, now(), '2023-05-04');   /* 뒤에서 앞을 뺀다. 값이 -로 */
select timestampdiff(hour, '2023-05-04', now());   /* 값이 +로 */
select timestampdiff(hour, wDate, now()) from board2;
select timestampdiff(hour, wDate, now()) as hour_diff from board2;
select *,timestampdiff(hour, wDate, now()) as hour_diff from board2 order by idx desc;
select *,timestampdiff(hour, wDate, now()) as hour_diff from board2 order by idx desc limit 0, 5;
select *,timestampdiff(hour, wDate, now()) as hour_diff, datediff(now(), wDate) as day_diff from board2 order by idx desc limit 0, 5;

select timestampdiff(day,'2023-05-01', now());

select *,timestampdiff(minute, wDate, now()) as minute_diff from board2;
select *,timestampdiff(second, wDate, now()) as second_diff from board2;


/* 날짜양식(date_format()) : (4자리)년(%Y), (2자리)년(%y), 월(%m), 일(%d) */
select wDate, date_format(wDate, '%Y-%m-%d %H:%i') as English from board2;
select wDate, date_format(wDate, '%Y-%m-%d %H:%i') as '수정 후' from board2;


/* 이전글, 다음글 꺼내오기 */
select * from board2;
select * from board2 where idx=5;
select * from board2 where idx < 5 order by idx desc limit 1;
select * from board2 where idx > 5 limit 1;
select idx, title from board2 where idx < 5 order by idx desc limit 1;
select idx, title from board2 where idx > 5 limit 1;


/* 게시판 리스트 글 제목 옆에 해당 글의 댓글(board2Reply) 수 출력 */

/* 댓글의 수를 전체 list에 출력하기 위한 연습 */
-- 전체 board2 테이블의 내용을 최신순으로 출력?
select * from board2 order by idx desc;


-- board2 테이블 고유번호 22번에 해당하는 댓글테이블의 개수?
select count(*) from board2Reply where boardIdx = 22;

-- 앞의 예에서 원본글의 고유번호와 함께, 총 댓글 개수는 replyCnt 로 출력?
select boardIdx, count(*) as replyCnt from board2Reply where boardIdx = 22;

-- 이때, 원본글을 쓴 닉네임도 함께 출력. 단, 닉네임은 원본글(board2) 테이블에서 가져와 출력?
select boardIdx, count(*) as replyCnt, 
	(select nickName from board2 where idx=22) as nickName
	from board2Reply 
	where boardIdx = 22;

-- 앞의 내용을 부모관점에서 본다면?
select mid, nickName from board2 where idx = 22;

-- 이때 앞의 닉네임을 자식(댓글)테이블 (board2Reply)에서 가져와 출력?
select mid, 
	(select nickName from board2Reply where boardIdx = 22 limit 1) as nickName
	from board2 where idx = 22;

select *, 
	(select nickName from board2Reply where boardIdx = 22) as replyCnt
	from board2 where idx = 22;

-- 여기부턴 부모관점!
-- board2 테이블의 1 페이지 5건을 출력하되, board2 테이블의 모든 내용과 현재 출력된 게시글의 댓글 개수를 출력?
-- 단, 최신글을 먼저 
select *,
	(select count(*) from board2Reply where boardIdx = b.idx) as replyCnt
	from board2 b
	order by idx desc
	limit 5;

