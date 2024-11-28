DROP DATABASE IF EXISTS music_school;
CREATE DATABASE music_school;

\c music_school;


CREATE TABLE address (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 street VARCHAR(50) NOT NULL,
 zip VARCHAR(25) NOT NULL,
 city VARCHAR(25) NOT NULL
);

ALTER TABLE address ADD CONSTRAINT PK_address PRIMARY KEY (id);


CREATE TABLE email (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 email VARCHAR(50) NOT NULL
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (id);


CREATE TABLE instrument_type (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 name VARCHAR(25) NOT NULL
);

ALTER TABLE instrument_type ADD CONSTRAINT PK_instrument_type PRIMARY KEY (id);


CREATE TABLE inventory (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 brand VARCHAR(25),
 price FLOAT(10) NOT NULL,
 instrument_type_id INT NOT NULL
);

ALTER TABLE inventory ADD CONSTRAINT PK_inventory PRIMARY KEY (id);


CREATE TABLE person (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 first_name VARCHAR(60) NOT NULL,
 sur_name VARCHAR(30) NOT NULL,
 ssn CHAR(12) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (id);


CREATE TABLE person_address (
 address_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE person_address ADD CONSTRAINT PK_person_address PRIMARY KEY (address_id,person_id);


CREATE TABLE person_email (
 email_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE person_email ADD CONSTRAINT PK_person_email PRIMARY KEY (email_id,person_id);


CREATE TABLE phone_number (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 phone_number VARCHAR(25) NOT NULL
);

ALTER TABLE phone_number ADD CONSTRAINT PK_phone_number PRIMARY KEY (id);


CREATE TABLE pricing_scheme (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 sibling_discount FLOAT(10) NOT NULL,
 price FLOAT(10) NOT NULL,
 valid_from TIMESTAMP NOT NULL,
 valid_until TIMESTAMP
);

ALTER TABLE pricing_scheme ADD CONSTRAINT PK_pricing_scheme PRIMARY KEY (id);


CREATE TABLE student_sibling_group (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL
);

ALTER TABLE student_sibling_group ADD CONSTRAINT PK_student_sibling_group PRIMARY KEY (id);


CREATE TABLE instructor (
 person_id INT NOT NULL,
 ensamble_skill BIT(1) NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (person_id);


CREATE TABLE instructor_availibility (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 start_time TIMESTAMP NOT NULL,
 end_time TIMESTAMP NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE instructor_availibility ADD CONSTRAINT PK_instructor_availibility PRIMARY KEY (id);


CREATE TABLE instrument (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 inventory_id INT NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE instrument_skill (
 instrument_type_id INT NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE instrument_skill ADD CONSTRAINT PK_instrument_skill PRIMARY KEY (instrument_type_id,instructor_id);


CREATE TABLE lesson (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 end_time TIMESTAMP NOT NULL,
 start_time TIMESTAMP NOT NULL,
 room_number VARCHAR(25) NOT NULL,
 pricing_scheme_id INT NOT NULL,
 instructor_id INT NOT NULL,
 skill_level INT NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE person_phone (
 phone_number_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE person_phone ADD CONSTRAINT PK_person_phone PRIMARY KEY (phone_number_id,person_id);


CREATE TABLE student (
 person_id INT NOT NULL,
 skill_level INT NOT NULL,
 registation_date TIMESTAMP NOT NULL,
 instrument_type_id INT NOT NULL,
 contact_person_id INT NOT NULL,
 student_sibling_group_id INT NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (person_id);


CREATE TABLE booking_lesson (
 lesson_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE booking_lesson ADD CONSTRAINT PK_booking_lesson PRIMARY KEY (lesson_id,student_id);


CREATE TABLE ensemble_lesson (
 lesson_id INT NOT NULL,
 genre VARCHAR(25) NOT NULL,
 maximum_student INT NOT NULL,
 minimum_student INT NOT NULL
);

ALTER TABLE ensemble_lesson ADD CONSTRAINT PK_ensemble_lesson PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 maximum_student INT NOT NULL,
 minimum_student INT NOT NULL,
 instrument_type_id INT NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id INT NOT NULL,
 instrument_type_id INT NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


CREATE TABLE rental (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 start_date TIMESTAMP NOT NULL,
 end_date TIMESTAMP NOT NULL,
 instrument_id INT,
 student_id INT
);

ALTER TABLE rental ADD CONSTRAINT PK_rental PRIMARY KEY (id);


ALTER TABLE inventory ADD CONSTRAINT FK_inventory_0 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (id);


ALTER TABLE person_address ADD CONSTRAINT FK_person_address_0 FOREIGN KEY (address_id) REFERENCES address (id) ON DELETE CASCADE;
ALTER TABLE person_address ADD CONSTRAINT FK_person_address_1 FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;


ALTER TABLE person_email ADD CONSTRAINT FK_person_email_0 FOREIGN KEY (email_id) REFERENCES email (id) ON DELETE CASCADE;
ALTER TABLE person_email ADD CONSTRAINT FK_person_email_1 FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;


ALTER TABLE instructor_availibility ADD CONSTRAINT FK_instructor_availibility_0 FOREIGN KEY (instructor_id) REFERENCES instructor (person_id) ON DELETE CASCADE;


ALTER TABLE instrument ADD CONSTRAINT FK_instrument_0 FOREIGN KEY (inventory_id) REFERENCES inventory (id);


ALTER TABLE instrument_skill ADD CONSTRAINT FK_instrument_skill_0 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (id);
ALTER TABLE instrument_skill ADD CONSTRAINT FK_instrument_skill_1 FOREIGN KEY (instructor_id) REFERENCES instructor (person_id) ON DELETE CASCADE;


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (pricing_scheme_id) REFERENCES pricing_scheme (id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (person_id) ON DELETE SET NULL;


ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_0 FOREIGN KEY (phone_number_id) REFERENCES phone_number (id) ON DELETE CASCADE;
ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_1 FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;
ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (id);
ALTER TABLE student ADD CONSTRAINT FK_student_2 FOREIGN KEY (contact_person_id) REFERENCES person (id);
ALTER TABLE student ADD CONSTRAINT FK_student_3 FOREIGN KEY (student_sibling_group_id) REFERENCES student_sibling_group (id);


ALTER TABLE booking_lesson ADD CONSTRAINT FK_booking_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;
ALTER TABLE booking_lesson ADD CONSTRAINT FK_booking_lesson_1 FOREIGN KEY (student_id) REFERENCES student (person_id) ON DELETE CASCADE;


ALTER TABLE ensemble_lesson ADD CONSTRAINT FK_ensemble_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (id);


ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (instrument_id) REFERENCES instrument (id) ON DELETE SET NULL;
ALTER TABLE rental ADD CONSTRAINT FK_rental_1 FOREIGN KEY (student_id) REFERENCES student (person_id) ON DELETE SET NULL;





INSERT INTO instrument_type (name) VALUES
('drums'),
('guitar'),
('piano'),
('violin'),
('flute'),
('trumpet'),
('saxophone'),
('cello'),
('clarinet'),
('harp'),
('trombone'),
('bass');



INSERT INTO person (first_name, sur_name, ssn) VALUES
('Charde', 'Frye', 196710488744),
('Xandra', 'Vega', 197215894021),
('Teegan', 'Whitaker', 198772607634),
('Burke', 'Everett', 196324370412),
('Bo', 'Hardy', 195793675650),
('Celeste', 'Delgado', 198764617504),
('Lillith', 'Lang', 199740068253),
('Hadley', 'Kramer', 196360760574),
('Brennan', 'Short', 197611737996),
('Elijah', 'Page', 197584134780),
('Adria', 'Shepherd', 197387987416),
('Logan', 'Rush', 198459938911),
('Amanda', 'Adams', 197665460968),
('Hillary', 'Ayers', 199350882268),
('Brianna', 'Snider', 200419855771),
('Patience', 'Maxwell', 195527944030),
('Petra', 'House', 198018610651),
('Martena', 'Talley', 195828327726),
('Allegra', 'Fry', 198340086247),
('Davis', 'Hammond', 199890402763),
('Ishmael', 'Nguyen', 196231551395),
('Kenyon', 'Mccormick', 199961562258),
('Logan', 'Horn', 196465816038),
('Kimberly', 'Coleman', 199632059107),
('Zachary', 'Emerson', 199943022745),
('Juliet', 'Hobbs', 199461161696),
('Christopher', 'Rice', 199158558630),
('Evangeline', 'Nguyen', 197553951608),
('Hillary', 'Dotson', 196380595173),
('Donna', 'Oneil', 197366478753),
('Oliver', 'Briggs', 200260249015),
('Fuller', 'Frank', 200588467470),
('Jin', 'Cook', 200478193194),
('Vivian', 'Robles', 200183522708),
('Anthony', 'Dejesus', 200219394541),
('Abraham', 'Steele', 200129363206),
('Brady', 'Giles', 200572767447),
('Hilel', 'Stuart', 200035096384),
('Kellie', 'Little', 199929125653),
('Maisie', 'Washington', 200389098337),
('Quon', 'Strong', 200296993396),
('Farrah', 'Massey', 199815297821),
('Louis', 'Norris', 200045202687),
('Caldwell', 'Duke', 200149791741),
('Mark', 'Cantu', 200416217129),
('Yeo', 'Hatfield', 200368162029),
('Judah', 'Weeks', 200578714636),
('Katell', 'Hart', 199876214409),
('Janna', 'Monroe', 199824901086),
('Gay', 'Austin', 200365195615),
('Wesley', 'Moses', 706768957311),
('Hall', 'Mcguire', 265284931422),
('Montana', 'Anthony', 126215263349),
('Damon', 'Ratliff', 328326044130),
('Asher', 'Mcmahon', 149505806200),
('Nichole', 'Burris', 703134512625),
('Christopher', 'Hayes', 160392214561),
('Aristotle', 'Dean', 561822021955),
('Richard', 'Oneal', 132366375550),
('Gareth', 'Frost', 194616658956),
('Rajah', 'Cox', 122154008949),
('Reed', 'Spence', 135541005737),
('Ezra', 'Bell', 191709200144),
('Kyla', 'Wise', 894365250219),
('Hoyt', 'Savage', 162641976306),
('James', 'Rollins', 105344116575),
('Ferdinand', 'Copeland', 451413719625),
('Alfreda', 'Sherman', 127472431356),
('Akeem', 'Lester', 787710977594),
('Ivor', 'Stevenson', 180352656743),
('Rama', 'Avery', 421458622084),
('Porter', 'Wells', 449390330929),
('Fiona', 'Wolf', 215874467033),
('Marny', 'Leon', 173060872396),
('Jessamine', 'Manning', 148284424534),
('Damian', 'Blevins', 125578196987);



INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;
INSERT INTO student_sibling_group DEFAULT VALUES;



INSERT INTO student (person_id, skill_level, registation_date, instrument_type_id, student_sibling_group_id, contact_person_id) VALUES
(28, 0, '2023-07-20', 8, 8, 55 ),
(37, 2, '2022-06-26', 11, 8, 57 ),
(34, 2, '2021-01-22', 11, 8, 53 ),
(26, 1, '2023-04-07', 4, 1, 54 ),
(25, 2, '2022-01-30', 3, 1, 55 ),
(30, 1, '2023-09-16', 10, 9, 56 ),
(4, 1, '2020-12-19', 4, 3, 57 ),
(13, 0, '2025-03-15', 3, 4, 58 ),
(21, 0, '2025-11-09', 8, 4, 59 ),
(36, 1, '2025-07-11', 9, 10, 60 ),
(11, 1, '2024-10-14', 5, 11, 61 ),
(39, 1, '2025-01-19', 8, 12, 62 ),
(3, 1, '2021-04-17', 5, 3, 63 ),
(2, 0, '2023-12-01', 5, 13, 64 ),
(27, 2, '2025-10-18', 9, 2, 65 ),
(22, 0, '2025-08-07', 1, 14, 66 ),
(12, 1, '2022-03-25', 3, 15, 67 ),
(16, 1, '2023-12-07', 6, 2, 68 ),
(40, 0, '2023-04-04', 2, 16, 69 ),
(1, 1, '2023-11-20', 12, 17, 70 ),
(33, 2, '2023-02-02', 1, 6, 71 ),
(35, 1, '2025-01-04', 7, 6, 72 ),
(32, 1, '2021-08-06', 10, 18, 73 ),
(31, 0, '2024-04-11', 3, 19, 74 ),
(15, 1, '2023-02-19', 10, 4, 75 ),
(38, 1, '2022-12-15', 1, 20, 76 ),
(14, 0, '2023-07-14', 7, 21, 76 ),
(29, 1, '2024-03-15', 5, 4, 70 ),
(24, 1, '2025-04-25', 4, 22, 61 ),
(5, 2, '2024-08-08', 8, 23, 62 ),
(9, 1, '2023-10-29', 8, 5, 53 ),
(23, 0, '2024-01-18', 1, 24, 54 ),
(6, 0, '2021-04-13', 1, 5, 55 ),
(7, 1, '2025-06-01', 7, 25, 56 ),
(19, 1, '2023-06-15', 3, 26, 57 ),
(18, 0, '2023-08-05', 1, 5, 58 ),
(8, 2, '2025-06-23', 10, 7, 59 ),
(10, 1, '2022-09-12', 7, 7, 60 ),
(17, 2, '2025-06-10', 3, 7, 61 ),
(20, 1, '2025-04-01', 11, 26, 62 );



INSERT INTO instructor (person_id, ensamble_skill) VALUES
(41, CAST(0 AS BIT)),
(42, CAST(0 AS BIT)),
(43, CAST(0 AS BIT)),
(44, CAST(0 AS BIT)),
(45, CAST(0 AS BIT)),
(46, CAST(1 AS BIT)),
(47, CAST(1 AS BIT)),
(48, CAST(1 AS BIT)),
(49, CAST(1 AS BIT)),
(50, CAST(1 AS BIT));



INSERT INTO instrument_skill (instructor_id, instrument_type_id) VALUES
(41, 1),
(42, 2),
(43, 3),
(44, 4),
(45, 5),
(46, 6),
(47, 7),
(48, 8),
(49, 9),
(50, 10),
(41, 11),
(42, 12),
(43, 1),
(44, 2),
(45, 3),
(46, 4);



INSERT INTO instructor_availibility (start_time, end_time, instructor_id) VALUES
('2024-05-11 08:00:00', '2024-05-11 09:00:00', 41),
('2024-07-03 12:00:00', '2024-07-03 13:00:00', 47),
('2024-07-04 10:00:00', '2024-07-04 11:00:00', 41),
('2025-02-17 12:00:00', '2025-02-17 13:00:00', 41),
('2025-07-28 14:00:00', '2025-07-28 13:00:00', 41),
('2024-06-12 08:00:00', '2024-06-12 09:00:00', 42),
('2024-02-22 14:00:00', '2024-02-22 15:00:00', 42),
('2024-04-02 15:00:00', '2024-04-02 16:00:00', 42),
('2024-09-26 15:00:00', '2024-09-26 16:00:00', 43),
('2024-10-14 14:00:00', '2024-10-14 15:00:00', 43),
('2025-01-17 08:00:00', '2025-01-17 09:00:00', 43),
('2025-05-25 10:00:00', '2025-05-25 11:00:00', 43),
('2025-09-11 14:00:00', '2025-09-11 15:00:00', 43),
('2025-10-10 15:00:00', '2025-10-10 16:00:00', 43),
('2025-10-28 12:00:00', '2025-10-28 13:00:00', 42),
('2025-09-30 12:00:00', '2025-09-30 13:00:00', 42),
('2024-09-20 12:00:00', '2024-09-20 13:00:00', 44),
('2025-05-30 08:00:00', '2025-05-30 09:00:00', 44),
('2025-06-13 09:00:00', '2025-06-13 10:00:00', 44),
('2025-10-18 10:00:00', '2025-10-18 11:00:00', 45),
('2024-08-23 12:00:00', '2024-08-23 13:00:00', 45),
('2024-10-30 10:00:00', '2024-10-30 11:00:00', 45),
('2025-06-20 14:00:00', '2025-06-20 15:00:00', 45),
('2025-07-21 08:00:00', '2025-07-21 09:00:00', 45),
('2024-01-16 08:00:00', '2024-01-16 09:00:00', 48),
('2024-01-07 12:00:00', '2024-01-07 13:00:00', 48),
('2025-05-08 12:00:00', '2025-05-08 13:00:00', 48),
('2025-05-23 15:00:00', '2025-05-23 16:00:00', 48),
('2024-03-20 08:00:00', '2024-03-20 09:00:00', 49),
('2025-08-29 13:00:00', '2025-08-29 14:00:00', 49),
('2024-08-26 14:00:00', '2024-08-26 15:00:00', 50),
('2024-01-21 15:00:00', '2024-01-21 16:00:00', 46),
('2024-05-15 12:00:00', '2024-05-15 13:00:00', 46),
('2024-07-02 09:00:00', '2024-07-02 10:00:00', 46),
('2024-11-25 13:00:00', '2024-11-25 14:00:00', 46),
('2024-12-04 08:00:00', '2024-12-04 09:00:00', 46),
('2025-09-19 08:00:00', '2025-09-19 09:00:00', 46),
('2024-11-09 08:00:00', '2024-11-09 09:00:00', 47),
('2025-08-25 12:00:00', '2025-08-25 13:00:00', 47);



INSERT INTO phone_number (phone_number) VALUES
('1-538-561-4577'),
('759-4683'),
('1-439-826-1177'),
('1-642-375-6546'),
('835-8835'),
('380-3284'),
('1-976-624-8148'),
('1-264-357-0137'),
('439-9389'),
('398-9500'),
('724-6540'),
('903-1741'),
('677-4314'),
('1-730-365-3885'),
('668-2152'),
('763-9447'),
('563-5676'),
('753-3124'),
('670-2361'),
('527-2851'),
('1-568-134-7824'),
('576-1467'),
('1-649-241-1086'),
('563-6272'),
('475-7744'),
('1-458-260-5557'),
('1-852-617-1762'),
('650-3171'),
('250-2267'),
('124-7157'),
('395-6778'),
('1-824-744-4056'),
('1-647-981-1748'),
('345-9465'),
('1-128-729-1923'),
('925-3535'),
('1-135-281-1113'),
('1-829-616-0461'),
('656-0256'),
('1-853-575-6761'),
('1-868-997-1375'),
('635-6749'),
('412-3787'),
('619-4778'),
('1-493-743-3221'),
('1-264-442-3235'),
('1-440-558-2289'),
('357-0172'),
('1-701-538-7093'),
('1-353-135-8227'),
('1-986-610-8691'),
('625-7435'),
('1-518-566-4621'),
('544-8582'),
('548-6463'),
('482-7303'),
('753-3705'),
('1-445-731-0118'),
('1-646-633-5582'),
('168-9326'),
('247-6649'),
('127-5351'),
('1-227-588-2977'),
('1-753-203-0963'),
('640-5418'),
('1-847-171-6172'),
('1-696-778-0627'),
('846-5369'),
('1-532-522-3497'),
('862-0718'),
('322-6541'),
('1-612-558-6674'),
('1-351-653-4107'),
('1-176-480-4470'),
('681-5542'),
('788-7278');




INSERT INTO person_phone (person_id, phone_number_id)
SELECT p.id, pn.id
FROM person p
JOIN (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id) AS row_num
    FROM phone_number
) pn ON p.id = pn.row_num
WHERE p.id BETWEEN 1 AND 76;




INSERT INTO email (email) VALUES
('neque@hotmail.org'),
('nec.ante@hotmail.edu'),
('quisque.porttitor.eros@hotmail.net'),
('vehicula@icloud.org'),
('vulputate.lacus.cras@icloud.org'),
('aliquet.lobortis@hotmail.org'),
('cursus@aol.couk'),
('augue.ut@aol.net'),
('egestas.a@google.ca'),
('mus.aenean@google.ca'),
('mollis@google.com'),
('ut.lacus@protonmail.edu'),
('dignissim.tempor@yahoo.edu'),
('ac.sem.ut@outlook.edu'),
('semper.nam@yahoo.ca'),
('in.hendrerit@aol.com'),
('aenean@hotmail.org'),
('lorem.sit@google.ca'),
('eu.turpis@icloud.ca'),
('vestibulum.ante@outlook.ca'),
('tristique.ac@hotmail.couk'),
('enim.etiam@protonmail.couk'),
('lacus.mauris.non@outlook.org'),
('ut.nisi@hotmail.edu'),
('purus@icloud.net'),
('ipsum.dolor.sit@aol.org'),
('ut.odio@yahoo.net'),
('adipiscing@google.couk'),
('tristique.senectus@hotmail.ca'),
('quam@hotmail.net'),
('venenatis.vel.faucibus@yahoo.ca'),
('suspendisse@outlook.ca'),
('aptent@hotmail.org'),
('ante@icloud.couk'),
('tincidunt.orci@icloud.com'),
('nullam@google.ca'),
('commodo.tincidunt@outlook.edu'),
('luctus.felis@yahoo.com'),
('sem.nulla@outlook.edu'),
('sit.amet@google.org'),
('mauris.rhoncus@hotmail.net'),
('in.faucibus@yahoo.com'),
('magna@yahoo.couk'),
('nec.enim.nunc@outlook.couk'),
('leo.in.lobortis@aol.net'),
('eget.volutpat.ornare@icloud.edu'),
('ut.molestie.in@outlook.com'),
('molestie@hotmail.couk'),
('gravida.praesent@hotmail.org'),
('id.sapien@yahoo.org'),
('nunc.quisque@icloud.org'),
('ac.mattis.ornare@icloud.couk'),
('pellentesque.massa@hotmail.com'),
('fusce.dolor.quam@google.org'),
('varius.orci.in@yahoo.net'),
('luctus.ut@icloud.ca'),
('porttitor.tellus@aol.net'),
('id.ante@hotmail.com'),
('magna@aol.ca'),
('consequat@hotmail.couk'),
('neque.sed@aol.net'),
('ac.feugiat.non@protonmail.edu'),
('neque.pellentesque.massa@icloud.ca'),
('ut.pellentesque.eget@hotmail.com'),
('elit@aol.couk'),
('dolor@icloud.net'),
('nulla@yahoo.org'),
('quis.pede.suspendisse@hotmail.net'),
('mi.felis@protonmail.edu'),
('suspendisse.dui@aol.net'),
('dolor.nonummy@outlook.org'),
('porttitor.eros.nec@outlook.net'),
('at.arcu@outlook.ca'),
('diam.eu@aol.org'),
('arcu@outlook.org'),
('aliquam.nec.enim@icloud.com');




INSERT INTO person_email (person_id, email_id)
SELECT person.id, email.id
FROM person
JOIN (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id) AS row_num
    FROM email
) email ON person.id = email.row_num
WHERE person.id BETWEEN 1 AND 76;




INSERT INTO address (street, zip, city)  VALUES
('112-6779 Morbi St.', '92784', 'Mora'),
('206-8689 Amet Rd.', '32322', 'Borlänge'),
('7360 Vestibulum St.', '56114', 'Ludvika'),
('796-6008 In, St.', '75245', 'Värnamo'),
('120-4391 Ipsum. St.', '21571', 'Värnamo'),
('4062 Commodo Ave', '45176', 'Boo'),
('551-2005 Non, Rd.', '73762', 'Mjölby'),
('2862 At St.', '17992', 'Lidköping'),
('P.O. Box 549, 1852 Auctor. Av.', '78780', 'Ludvika'),
('356-1653 Auctor. Road', '19211', 'Jönköping'),
('3768 Sit Road', '91507', 'Lidingo'),
('394-4602 Enim. Avenue', '47125', 'Vänersborg'),
('930-1996 Rutrum Rd.', '58563', 'Vetlanda'),
('1472 Nibh. St.', '44353', 'Sandviken'),
('191-7923 Nunc Avenue', '62735', 'Mora'),
('Ap #261-1192 Erat. Street', '78045', 'Göteborg'),
('833-7132 Luctus. Avenue', '51266', 'Borlänge'),
('Ap #471-3947 Dictum. Av.', '74682', 'Motala'),
('Ap #359-5540 Sed Street', '65761', 'Åkersberga'),
('6569 Dis Road', '82803', 'Värnamo'),
('870-9695 Commodo Ave', '39331', 'Uddevalla'),
('951-3614 Auctor Ave', '64755', 'Bollnäs'),
('Ap #363-3903 Aliquet. Avenue', '30685', 'Sandviken'),
('521-1615 Donec Rd.', '25849', 'Ludvika'),
('P.O. Box 766, 4054 Sed St.', '22610', 'Borås'),
('P.O. Box 463, 7629 Tempor Av.', '68610', 'Göteborg'),
('492-1100 Mi Rd.', '71310', 'Vänersborg'),
('P.O. Box 537, 6970 In St.', '85651', 'Lidköping'),
('Ap #870-5226 Erat. Street', '37428', 'Mora'),
('Ap #932-7847 Tellus, Rd.', '20762', 'Avesta'),
('Ap #832-6981 Id, Rd.', '76804', 'Tranås'),
('781-6341 Pede St.', '23748', 'Vallentuna'),
('479-8856 Diam. Avenue', '05476', 'Mora'),
('622-5207 Felis. Rd.', '87773', 'Trollhättan'),
('588-5007 Porta St.', '48066', 'Jönköping'),
('811-3965 Lorem Av.', '28458', 'Hudiksvall'),
('595-6449 Feugiat Av.', '33441', 'Mora'),
('Ap #835-9706 Libero. Street', '33451', 'Jönköping'),
('4726 Erat St.', '63899', 'Söderhamn'),
('Ap #209-5670 Risus. Rd.', '64352', 'Lidingo'),
('Ap #881-6662 Commodo Road', '12134', 'Finspång'),
('3091 Mauris Road', '66853', 'Sandviken'),
('963-6613 Egestas. Road', '11980', 'Trollhättan'),
('760-6542 Vitae Rd.', '55904', 'Märsta'),
('7538 Nunc Rd.', '85075', 'Ludvika'),
('233-594 Malesuada Av.', '30907', 'Trollhättan'),
('687-3807 Posuere Rd.', '42105', 'Åkersberga'),
('388-1862 Lobortis Av.', '25473', 'Göteborg'),
('Ap #791-6062 Amet Avenue', '21217', 'Tranås'),
('9610 Malesuada Road', '56147', 'Täby'),
('Ap #679-3920 Lacus. Ave', '23328', 'Tranås'),
('Ap #572-2436 Ullamcorper. Rd.', '24621', 'Vallentuna'),
('728-2180 Tempus Avenue', '82661', 'Avesta'),
('388-3752 Nunc Av.', '78628', 'Linköping'),
('Ap #212-7581 Et, St.', '00297', 'Jönköping'),
('Ap #386-5196 Nisi Avenue', '82560', 'Uddevalla'),
('P.O. Box 799, 3757 Lobortis Rd.', '12588', 'Alingsås'),
('Ap #951-7567 Nec Rd.', '75809', 'Jönköping'),
('245-1208 Phasellus Rd.', '18656', 'Nässjö'),
('Ap #545-3532 Laoreet Road', '91411', 'Finspång'),
('P.O. Box 486, 1113 Ullamcorper. St.', '54677', 'Gävle'),
('6582 Praesent Rd.', '09515', 'Ockelbo'),
('5331 Proin Av.', '41282', 'Hofors'),
('Ap #148-914 Eu St.', '32324', 'Värnamo'),
('P.O. Box 603, 1013 Porttitor Rd.', '51511', 'Värnamo'),
('P.O. Box 138, 4942 Donec St.', '82075', 'Linköping'),
('956-6362 Vitae, St.', '74630', 'Sandviken'),
('Ap #285-598 Eros Rd.', '14951', 'Borlänge'),
('9331 Curabitur Rd.', '29487', 'Linköping'),
('9559 Magna, Rd.', '83776', 'Ockelbo'),
('Ap #875-817 Vitae Road', '18670', 'Falun'),
('Ap #455-8301 Eu Rd.', '59249', 'Motala'),
('Ap #703-5434 Eleifend, Street', '16710', 'Sandviken'),
('P.O. Box 159, 9172 Torquent Ave', '51621', 'Märsta'),
('882-4258 Commodo St.', '82372', 'Ludvika'),
('Ap #497-1372 Vestibulum St.', '38655', 'Nässjö');




INSERT INTO person_address (person_id, address_id)
SELECT person.id, address.id
FROM person
JOIN (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id) AS row_num
    FROM address
) address ON person.id = address.row_num
WHERE person.id BETWEEN 1 AND 76;




INSERT INTO inventory (brand, price, instrument_type_id) VALUES
('yamaha', 24.75, 4),
('yamaha', 45.89, 2),
('yamaha', 12.47, 3),
('yamaha', 27.40, 1),
('fender', 32.48, 11),
('fender', 17.40, 9),
('fender', 38.93, 10),
('fender', 47.87, 12),
('gibson', 11.33, 5),
('gibson', 37.41, 6),
('gibson', 47.88, 7),
('gibson', 34.29, 8),
('yamaha', 24.75, 7),
('yamaha', 45.89, 6),
('yamaha', 12.47, 5),
('yamaha', 27.40, 2),
('fender', 32.48, 3),
('fender', 17.40, 10),
('fender', 38.93, 9),
('fender', 47.87, 11),
('gibson', 11.33, 1),
('gibson', 37.41, 8),
('gibson', 47.88, 5),
('gibson', 34.29, 4);




INSERT INTO instrument (inventory_id) VALUES
(1),
(1),
(2),
(2),
(2),
(3),
(4),
(5),
(6),
(6),
(6),
(7),
(8),
(9),
(10),
(11),
(11),
(11),
(11),
(12),
(13),
(14),
(14),
(14),
(15),
(15),
(16);




INSERT INTO rental (start_date, end_date, instrument_id, student_id) VALUES
('2022-05-13', '2023-09-28', 3, 10),
('2021-03-19', '2025-03-27', 12, 31),
('2022-09-09', '2025-09-30', 23, 12),
('2022-07-30', '2023-06-10', 24, 2),
('2021-02-18', '2024-06-25', 1, 25),
('2020-12-04', '2023-03-05', 20, 37),
('2021-01-21', '2023-12-02', 12, 31),
('2022-04-06', '2025-05-05', 6, 22),
('2022-02-16', '2023-10-11', 4, 11),
('2021-07-26', '2025-06-27', 23, 39),
('2022-02-27', '2024-05-10', 16, 17),
('2022-07-09', '2023-12-28', 23, 22),
('2021-03-26', '2023-01-31', 16, 3),
('2022-02-07', '2023-02-09', 10, 40),
('2020-09-04', '2024-08-09', 9, 3),
('2021-05-09', '2025-01-07', 1, 23),
('2021-02-20', '2024-09-25', 8, 18),
('2021-10-15', '2024-06-22', 12, 13),
('2022-07-28', '2024-12-12', 26, 11),
('2022-07-13', '2023-12-25', 20, 17);




INSERT INTO pricing_scheme (price, sibling_discount, valid_from, valid_until) VALUES
(500, 100, '2024-01-11 00:00:00', null),
(500, 150, '2024-02-11 00:00:00', '2024-05-11 00:00:00'),
(550, 200, '2024-03-11 00:00:00', '2024-05-11 00:00:00'),
(600, 60, '2024-04-11 00:00:00', '2024-06-11 00:00:00'),
(650, 120, '2024-05-11 00:00:00', '2024-07-11 00:00:00'),
(700, 150, '2024-06-11 00:00:00', '2025-05-11 00:00:00'),
(570, 160, '2024-07-11 00:00:00', '2025-05-11 00:00:00'),
(650, 170, '2024-08-11 00:00:00', '2026-05-11 00:00:00'),
(440, 50, '2024-09-11 00:00:00', '2026-05-11 00:00:00'),
(890, 200, '2024-10-11 00:00:00', null);



INSERT INTO lesson (start_time, end_time, room_number, pricing_scheme_id, instructor_id, skill_level) VALUES

('2024-11-04 08:00:00', '2024-11-20 10:00:00', 4, 1, 41, 0), 
('2024-11-05 10:30:00', '2024-11-20 12:30:00', 4, 1, 41, 1), 
('2024-11-06 14:00:00', '2024-10-20 16:00:00', 4, 1, 41, 2), 
('2024-11-07 09:00:00', '2024-10-21 11:00:00', 3, 2, 42, 0), 
('2024-11-08 11:15:00', '2024-10-21 13:15:00', 3, 2, 42, 1), 
('2024-11-04 15:00:00', '2024-10-21 17:00:00', 3, 2, 42, 2), 
('2024-11-06 08:30:00', '2024-11-22 10:30:00', 6, 3, 43, 0), 
    
('2024-12-22 11:00:00', '2024-12-22 13:00:00', 6, 3, 43, 1), 
('2024-12-22 14:30:00', '2024-12-22 16:30:00', 6, 3, 43, 2), 
('2024-12-23 09:00:00', '2024-12-23 11:00:00', 9, 4, 44, 0), 
('2024-11-23 12:00:00', '2024-11-23 14:00:00', 9, 4, 44, 1), 
('2024-10-23 15:30:00', '2024-10-23 17:30:00', 9, 4, 44, 2), 
('2024-10-24 07:00:00', '2024-10-24 09:00:00', 2, 5, 45, 0), 
('2024-10-24 09:30:00', '2024-10-24 11:30:00', 2, 5, 45, 1), 
('2024-12-24 12:30:00', '2024-12-24 14:30:00', 2, 5, 45, 2), 
('2024-12-25 08:00:00', '2024-12-25 10:00:00', 8, 6, 46, 0),
('2024-12-25 10:30:00', '2024-12-25 12:30:00', 8, 6, 46, 1), 
('2024-11-25 13:30:00', '2024-11-25 15:30:00', 8, 6, 46, 2),
('2024-11-26 09:00:00', '2024-11-26 11:00:00', 20, 7, 47, 0),
('2024-11-26 11:30:00', '2024-11-26 13:30:00', 20, 7, 47, 1), 
('2024-11-26 14:00:00', '2024-11-26 16:00:00', 20, 7, 47, 2);




INSERT INTO individual_lesson (lesson_id, instrument_type_id) VALUES
(8, 1),
(9, 2),
(10, 3),
(11, 4),
(12, 5),
(13, 6),
(14, 7);




INSERT INTO ensemble_lesson (lesson_id, genre, maximum_student, minimum_student) VALUES
(1, 'Jazz', 5, 2),
(2, 'Classical', 6, 4),
(3, 'Rock', 7, 4),
(4, 'Pop', 5, 2),
(5, 'Folk', 8, 5),
(6, 'Blues', 6, 4),
(7, 'Reggae', 5, 1);




INSERT INTO group_lesson (lesson_id, maximum_student, minimum_student, instrument_type_id) VALUES 
(15, 20, 10, 5), 
(16, 20, 10, 3), 
(17, 20, 10, 11),
(18, 20, 10, 12), 
(19, 20, 10, 7), 
(20, 20, 10, 9),
(21, 20, 10, 11);




INSERT INTO booking_lesson (lesson_id, student_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(1, 22),
(2, 23),
(3, 24),
(4, 25),
(5, 26),
(6, 27),
(7, 28),
(8, 29),
(9, 30),
(10, 31),
(11, 32),
(12, 33),
(13, 34),
(14, 35),
(15, 36),
(16, 37),
(17, 38),
(18, 39),
(19, 40),
(20, 1),
(21, 2),
(1, 3),
(2, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10),
(9, 11),
(10, 12),
(11, 13),
(12, 14),
(13, 15),
(14, 16),
(15, 17),
(16, 18),
(17, 19),
(18, 20),
(19, 21),
(20, 22),
(21, 23),
(1, 24),
(2, 25),
(3, 26),
(4, 27),
(5, 28),
(6, 29),
(7, 30),
(8, 31),
(9, 32),
(10, 33),
(11, 34),
(12, 35),
(13, 36),
(14, 37),
(15, 38),
(16, 39),
(17, 40),
(18, 1),
(19, 2),
(20, 3),
(21, 4),
(1, 5),
(2, 6),
(3, 7),
(4, 8),
(5, 9),
(6, 10),
(7, 11),
(8, 12),
(9, 13),
(10, 14),
(11, 15),
(12, 16),
(13, 17),
(14, 18),
(15, 19),
(16, 20);



CREATE VIEW num_of_lessons AS
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



CREATE MATERIALIZED VIEW student_sibling_group_amount AS SELECT
    ssg.id, COUNT(s.*)
    FROM student s
    LEFT JOIN student_sibling_group ssg
    ON ssg.id = s.student_sibling_group_id
    GROUP BY ssg.id;

CREATE MATERIALIZED VIEW student_sibling_statistics AS SELECT
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



CREATE VIEW ensemble_availability AS
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