create table boardServlet (
    num     	number, 				-- Unique 번호
    writer    	varchar2(20),		-- 글쓴이 
    title   		varchar2(60),		-- 글제목
    content 	varchar2(4000),	-- 글내용
    regtime 	varchar2(20),		-- 글쓴 날짜
    hits    		number					-- 조회수
);

-- Sample Data 
insert into boardServlet values
    (1, '홍길동', '글 1', '글의 내용 1', '2017-07-30 10:10:11', 0);
insert into board values
    (2, '이순신', '글 2', '글의 내용 2', '2017-07-30 10:10:12', 0);
insert into board values
    (3, '강감찬', '글 3', '글의 내용 3', '2017-07-30 10:10:13', 0);
insert into board values
    (4, '김수로', '글 4', '글의 내용 4', '2017-07-30 10:10:14', 0);
insert into board values
    (5, '장길산', '글 5', '글의 내용 5', '2017-07-30 10:10:15', 0);
insert into board values
    (6, '김수로', '글 6', '글의 내용 6', '2017-07-30 10:10:16', 0);
insert into board values
    (7, '홍길동', '글 7', '글의 내용 7', '2017-07-30 10:10:17', 0);
insert into board values
    (8, '이순신', '글 8', '글의 내용 8', '2017-07-30 10:10:18', 0);
    
---------------------------------------------------------------------
-- db초기화
delete boardServlet; 
purge recyclebin;

-- 선언
DECLARE
  TYPE sanameTab IS TABLE OF sawon.saname%TYPE 	
  INDEX BY BINARY_INTEGER;				
  sanameT sanameTab; 				

BEGIN
    FOR i IN 1 .. 255 LOOP 
       SELECT saname INTO sanameT(i) 		
       FROM sawon
       WHERE sabun = MOD(i, 20) + 1; 	
	
       INSERT INTO boardServlet (num, writer, title, content, regtime, hits)
       VALUES (i, sanameT(i), sanameT(i) || ' 안녕하세요', sanameT(i)||' 입니다.', sysdate-i, 0);
    END LOOP;
END;
/
