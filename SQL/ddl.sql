-- Active: 1719384389661@@127.0.0.1@3306@rsp
-- 테이블 ( rsp )

-- ✅ 회원 테이블 
--    - 회원번호 ( PK auto_increment ) ( userNo )
--    - 닉네임 ( nickname )

-- ✅ 승수 테이블 
--    - 회원번호 ( FK ) ( userNo )
--    - 승 (win)
--    - 무 (draw)
--    - 패 (lose) 

CREATE TABLE users (
    user_no INT AUTO_INCREMENT PRIMARY KEY,
    nickname VARCHAR(50) NOT NULL
);

CREATE TABLE record (
    user_no INT,
    win INT DEFAULT 0,
    draw INT DEFAULT 0,
    lose INT DEFAULT 0,
    FOREIGN KEY (user_no) REFERENCES users(user_no)
);


-- User 테이블에 데이터 삽입
INSERT INTO users (nickname) VALUES ('user1');
INSERT INTO users (nickname) VALUES ('user2');
INSERT INTO users (nickname) VALUES ('user3');

-- Record 테이블에 데이터 삽입
INSERT INTO Record (user_no, win, draw, lose) VALUES (1, 10, 5, 3);
INSERT INTO Record (user_no, win, draw, lose) VALUES (2, 7, 8, 2);
INSERT INTO Record (user_no, win, draw, lose) VALUES (3, 5, 3, 10);
