--Department Table
CREATE TABLE departments
  (
    dept_code NUMBER(5),
    dept_name VARCHAR2(10),
    CONSTRAINT dept_code_pk PRIMARY KEY(dept_code)
  );
--Student Table
CREATE TABLE students
  (
    s_id           NUMBER(10),
    first_name     VARCHAR2(10) NOT NULL,
    last_name      VARCHAR2(15) NOT NULL,
    sex            VARCHAR2(2),
    date_of_birth  DATE,
    nationality    VARCHAR2(10),
    main_phone     NUMBER(10)NOT NULL,
    sec_phone      NUMBER(10),
    city           VARCHAR2(5),
    street         VARCHAR(10),
    zipcode        VARCHAR(5),
    degree_program VARCHAR(3),
    classification VARCHAR2(5),
    s_category     VARCHAR2(2),
    s_credit       NUMBER(8,2),
    dept_code      NUMBER(5),
    CONSTRAINT s_id_pk PRIMARY KEY(s_id),
    CONSTRAINT departments_fk FOREIGN KEY (dept_code) REFERENCES departments(dept_code)
  );
--Faculty
CREATE TABLE faculty
  (
    f_id        NUMBER(10),
    first_name  VARCHAR2(10) NOT NULL,
    last_name   VARCHAR2(15) NOT NULL,
    sex         VARCHAR2(2),
    nationality VARCHAR2(10),
    f_category  VARCHAR2(10),
    f_credit    NUMBER(8,2),
    dept_code   NUMBER(5),
    CONSTRAINT f_id_pk PRIMARY KEY(f_id),
    CONSTRAINT departments_faculty_fk FOREIGN KEY (dept_code) REFERENCES departments(dept_code)
  );
--Courses
CREATE TABLE courses
  (
    c_id      NUMBER(5),
    c_name    VARCHAR2(10),
    term      VARCHAR2(10),
    dept_code NUMBER(5),
    CONSTRAINT c_id_pk PRIMARY KEY(c_id),
    CONSTRAINT departments_courses_fk FOREIGN KEY (dept_code) REFERENCES departments(dept_code)
  );
--Enrols
CREATE TABLE enrols
  (
    s_id NUMBER(5),
    c_id NUMBER(5),
    CONSTRAINT enrollss_pk PRIMARY KEY(s_id,c_id),
    CONSTRAINT students_fk FOREIGN KEY (s_id) REFERENCES students(s_id),
    CONSTRAINT courses_fk FOREIGN KEY (c_id) REFERENCES courses(c_id)
  );
--Teaches
CREATE TABLE teaches
  (
    f_id NUMBER(5),
    c_id NUMBER(5),
    CONSTRAINT teaches_pk PRIMARY KEY(f_id,c_id),
    CONSTRAINT faculty_fk FOREIGN KEY (f_id) REFERENCES faculty(f_id),
    CONSTRAINT courses1_fk FOREIGN KEY (c_id) REFERENCES courses(c_id)
  );
--Library
CREATE TABLE library
  (
    l_id   NUMBER(2),
    l_name VARCHAR2(10),
    CONSTRAINT library_pk PRIMARY KEY(l_id)
  );
  
  
--Books
CREATE TABLE books
  (
    isbn      NUMBER(12),
    b_id      NUMBER(3),
    title     VARCHAR2(15),
    author    VARCHAR2(10),
    b_edition   NUMBER(5),
    p_year      NUMBER(4),
    Publisher VARCHAR2(10),
    Queue     Number(3) Default 0,
    l_id      NUMBER(2),
    c_id      NUMBER(5), 
    CONSTRAINT books_pk PRIMARY KEY(isbn,b_id),
    CONSTRAINT books_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id),
    CONSTRAINT books_courses_fk FOREIGN KEY (c_id) REFERENCES courses(c_id)
    );
 
--journals    
create table journals
 (
    issn      NUMBER(12),
    j_id      NUMBER(3),
    title     VARCHAR2(15),
    author    VARCHAR2(10),
    p_year      NUMBER(4),
    Queue     Number(3) Default 0,
    type      varchar2(7),
    l_id      NUMBER(2),
    CONSTRAINT journals_pk PRIMARY KEY(issn,j_id),
    CONSTRAINT journals_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
    );
    
--conference_proceedings

create table confproceedings
(
    conf_num   NUMBER(12),
    cp_id      NUMBER(3),
    title      VARCHAR2(15),
    author     VARCHAR2(10),
    cp_year    NUMBER(4),
    conf_name  VARCHAR2(7),
    Queue      Number(3) Default 0,
    type       varchar2(7),
    l_id       NUMBER(2),
    CONSTRAINT confp_pk PRIMARY KEY(conf_num,cp_id),
    CONSTRAINT confp_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
);   

--camera
CREATE TABLE cameras
  (
    cam_id      NUMBER(10),
    model       VARCHAR(7),
    make        VARCHAR(7),
    lens_config NUMBER(4,2),
    memory      VARCHAR(5),
    Queue       NUMBER(3),
    l_id        NUMBER(2),
    CONSTRAINT cameras_pk PRIMARY KEY(cam_id),
    CONSTRAINT cameras_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
  );
 
CREATE TABLE rooms
  (
    r_id     NUMBER(10),
    type     VARCHAR2(10),
    capacity NUMBER(3),
    floor    NUMBER(2),
    status   Char(1),
    l_id     NUMBER(2),
    CONSTRAINT rooms_pk PRIMARY KEY(r_id,l_id),
    CONSTRAINT rooms_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
  );