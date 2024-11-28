![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

# IV1351 - Project

**This repository contains projects file for the course IV1351 Data Storage Paradigms given at KTH Royal Institute of Technology.**

## Setup

### Method 1
Download and execute the file called "setup.sql". This file will create a new database called music_school (and drop any existing before doing so), populate it with test data, and create views.

### Method 2
Create a new database (you choose the name). Download and execute the files "model.sql", "data.sql", and "views.sql" (in that order). This will just the method 1 create the database structure, insert test data, and generate views.

## Views

The "setup.sql" and "views.sql" generates the following views:
- num_of_lessons
- student_sibling_group_amount (usd by student_sibling_statistics)
- student_sibling_statistics
- instructor_lesson_statistics
- ensemble_availability