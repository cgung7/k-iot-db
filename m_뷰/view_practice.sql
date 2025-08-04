### J_뷰 >>> view_practice ###

### 뷰 연습 문제 ###
CREATE DATABASE If NOT EXISTS `school`;
USE `school`;

CREATE TABLE `students` (
	student_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    age int,
    major varchar(50)
);

CREATE TABLE `courses` (
	course_id int primary key,
    course_name varchar(100),
    instructor varchar(100),
    credit_hours int
);

CREATE TABLE `student_courses` (
	student_id int,
	course_id int,
    primary key (student_id, course_id),
    foreign key (student_id) references `students`(student_id),
    foreign key (course_id) references `courses`(course_id)
);

# cf) 각 테이블에 데이터 삽입 4개 이상 
INSERT INTO students (student_id, first_name, last_name, age, major)
VALUES (1, 'John', 'Doe', 20, 'Computer Science'),
       (2, 'Jane', 'Smith', 22, 'Mathematics'),
       (3, 'Alice', 'Johnson', 19, 'Biology'),
       (4, 'Bob', 'Brown', 21, 'History');

INSERT INTO courses (course_id, course_name, instructor, credit_hours)
VALUES (101, 'Introduction to Programming', 'Prof. Smith', 3),
       (102, 'Calculus I', 'Prof. Johnson', 4),
       (103, 'Biology 101', 'Prof. Davis', 3),
       (104, 'World History', 'Prof. Wilson', 3);
       
INSERT INTO student_courses (student_id, course_id)
VALUES (1, 101),
       (2, 102),
       (3, 103),
       (4, 104);

SELECT * FROM `students`;
SELECT * FROM `courses`;
SELECT * FROM `student_courses`;

CREATE VIEW student_course_view
AS
	SELECT
	concat(S.first_name, S.last_name) as 'student name'
    , C.course_name
    , C.instructor
	FROM
		student_courses SC
        INNER JOIN students S
			ON SC.student_id = S.student_id
		INNER JOIN courses C
			ON SC.course_id = C.course_id;


SELECT * FROM student_course_view;







