CREATE OR REPLACE VIEW num_of_lessons AS
SELECT 
    TO_CHAR(l.start_time, 'MM') AS month,
    COUNT(*) AS Total,
    COUNT(il.lesson_id) AS individual_lessons,
    COUNT(gl.lesson_id) AS group_lessons,
    COUNT(el.lesson_id) AS ensemble_lessons
FROM lesson l
LEFT JOIN individual_lesson il ON il.lesson_id = l.id
LEFT JOIN group_lesson gl ON gl.lesson_id = l.id
LEFT JOIN ensemble_lesson el ON el.lesson_id = l.id
WHERE l.start_time >= '2024-01-01' AND l.start_time < '2025-01-01'
GROUP BY TO_CHAR(l.start_time, 'MM')
ORDER BY month;



CREATE MATERIALIZED VIEW IF NOT EXISTS student_sibling_group_amount AS SELECT
    ssg.id, COUNT(s.*)
    FROM student s
    LEFT JOIN student_sibling_group ssg
    ON ssg.id = s.student_sibling_group_id
    GROUP BY ssg.id;

CREATE MATERIALIZED VIEW IF NOT EXISTS student_sibling_statistics AS SELECT
    count - 1 AS num_of_sibling,
    SUM(count)
    FROM student_sibling_group_amount
    GROUP BY count
    ORDER BY num_of_sibling;




CREATE VIEW instructor_lesson_statistics AS
SELECT
    i.person_id AS "Instructor Id",
    p.first_name AS "First Name",
    p.sur_name AS "Last Name",
    COUNT(l.id) AS "No of Lessons"
FROM instructor i
JOIN person p ON i.person_id = p.id
JOIN lesson l ON i.person_id = l.instructor_id
WHERE l.start_time BETWEEN '2024-11-01' AND '2024-12-01'
GROUP BY i.person_id, p.first_name, p.sur_name
ORDER BY "No of Lessons" DESC;



CREATE OR REPLACE VIEW ensemble_availability AS
SELECT 
    TO_CHAR(l.start_time, 'Dy') AS "Day",
    el.genre AS "Genre",
    CASE
        WHEN COUNT(bl.student_id) >= el.maximum_student THEN 'No Seats'
        WHEN el.maximum_student - COUNT(bl.student_id) BETWEEN 1 AND 2 THEN '1 or 2 Seats'
        ELSE 'Many Seats'
    END AS "No of Free Seats"
    FROM ensemble_lesson el
    JOIN lesson l ON el.lesson_id = l.id
    LEFT JOIN booking_lesson bl ON l.id = bl.lesson_id
    WHERE TO_CHAR(l.start_time, 'IW') = '45'
    GROUP BY "Day", el.genre, el.maximum_student
    ORDER BY "Day", el.genre; 