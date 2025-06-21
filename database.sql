create database group6;

use group6;

CREATE table students(
                         id int PRIMARY key identity,
                         name nvarchar(100),
                         email varchar(100) unique,
                         phone varchar(15),
                         dob date,
                         class nvarchar(50),
                         password varchar(255)
);

CREATE TABLE courses(
                        id INT PRIMARY KEY IDENTITY,
                        name nvarchar(100),
                        description TEXT
);

create table enrollments(
                            id INT PRIMARY Key identity,
                            student_id INT FOREIGN KEY REFERENCES students(id),
                            courses_id INT FOREIGN KEY REFERENCES courses(id),
                            status nvarchar(20)
);

create table admins(
                       id int primary key identity,
                       email varchar(100),
                       password varchar(255)
);

INSERT INTO students (name, email, phone, dob, class, password) VALUES
                                                                    ('Alice Johnson', 'alice.johnson@example.com', '1234567890', '2004-05-12', '10-A', 'hashed_pwd1'),
                                                                    ('Bob Smith', 'bob.smith@example.com', '0987654321', '2003-11-23', '11-B', 'hashed_pwd2'),
                                                                    ('Carol Lee', 'carol.lee@example.com', '1122334455', '2005-01-15', '10-C', 'hashed_pwd3'),
                                                                    ('David Kim', 'david.kim@example.com', '5566778899', '2002-07-07', '12-A', 'hashed_pwd4'),
                                                                    ('Eva Brown', 'eva.brown@example.com', '6677889900', '2004-03-30', '11-A', 'hashed_pwd5');
INSERT INTO courses (name, description) VALUES
                                            ('Mathematics', 'Basic to advanced algebra, geometry, and calculus.'),
                                            ('Physics', 'Mechanics, electricity, magnetism, and modern physics.'),
                                            ('Chemistry', 'Organic, inorganic, and physical chemistry.'),
                                            ('Biology', 'Cell biology, genetics, and human physiology.'),
                                            ('English Literature', 'Analysis of classical and modern texts.');
INSERT INTO enrollments (student_id, courses_id, status) VALUES
                                                             (1, 1, 'ACTIVE'),
                                                             (1, 2, 'COMPLETED'),
                                                             (2, 1, 'ACTIVE'),
                                                             (2, 3, 'DROPPED'),
                                                             (3, 4, 'COMPLETED'),
                                                             (3, 5, 'ACTIVE'),
                                                             (4, 2, 'ACTIVE'),
                                                             (5, 1, 'COMPLETED'),
                                                             (5, 3, 'ACTIVE');
INSERT INTO admins (email, password) VALUES
                                         ('admin1@school.com', 'admin_pwd_1'),
                                         ('admin2@school.com', 'admin_pwd_2');