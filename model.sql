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


