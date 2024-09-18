PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE alembic_version (
	version_num VARCHAR(32) NOT NULL, 
	CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);
INSERT INTO alembic_version VALUES('9ef75af6420b');
CREATE TABLE sleep (
	user_id INTEGER, 
	go_to_bed_time DATETIME, 
	wake_up_time DATETIME, 
	sleep_duration FLOAT, 
	id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	CONSTRAINT user_id FOREIGN KEY(user_id) REFERENCES user (id)
);
INSERT INTO sleep VALUES(1,'2024-09-14 22:00:00.000000','2024-09-15 05:00:00.000000',7.0,1);
CREATE TABLE schedule (
	user_id INTEGER, 
	start_course DATETIME, 
	stop_reminder_train BOOLEAN, 
	stop_reminder_sleep BOOLEAN, 
	stop_reminder_calories BOOLEAN, 
	id INTEGER NOT NULL, utc_offset INTEGER, stop_reminder_adv BOOLEAN, 
	PRIMARY KEY (id), 
	FOREIGN KEY(user_id) REFERENCES user (id)
);
INSERT INTO schedule VALUES(1,'2024-07-21 14:07:15.413477',1,0,0,1,10800,0);
CREATE TABLE calorie (
	gender VARCHAR(255), 
	activity VARCHAR(255), 
	picture VARCHAR, 
	id INTEGER NOT NULL, purpose VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO calorie VALUES('MALE','INFREQUENT','m_weight_loss.jpg',1,'GO_SLIM');
CREATE TABLE IF NOT EXISTS "user" (
	telegram_id INTEGER NOT NULL, 
	name VARCHAR(100) NOT NULL, 
	gender VARCHAR(255), 
	age INTEGER NOT NULL, 
	weight INTEGER NOT NULL, 
	height INTEGER NOT NULL, 
	activity VARCHAR(255), 
	email VARCHAR(320) NOT NULL, 
	hashed_password VARCHAR(1024) NOT NULL, 
	is_active BOOLEAN NOT NULL, 
	is_superuser BOOLEAN NOT NULL, 
	is_verified BOOLEAN NOT NULL, 
	id INTEGER NOT NULL, 
	purpose VARCHAR(255), location VARCHAR(128), 
	PRIMARY KEY (id), 
	UNIQUE (telegram_id), 
	UNIQUE (name)
);
INSERT INTO user VALUES(494600213,'Дима Красиков','MALE',43,82,180,'INFREQUENT','z1r0-d@yandex.ru','nkajipfncu89288)*&^guyb',1,0,0,1,'GO_SLIM','Europe/Moscow');
CREATE TABLE workoutexercise (
	exercise_id INTEGER NOT NULL, 
	workout_id INTEGER NOT NULL, 
	id INTEGER NOT NULL, sequence_number INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(exercise_id) REFERENCES exercise (id) ON DELETE CASCADE, 
	FOREIGN KEY(workout_id) REFERENCES workout (id) ON DELETE CASCADE
);
INSERT INTO workoutexercise VALUES(2,1,1,1);
INSERT INTO workoutexercise VALUES(1,1,2,3);
INSERT INTO workoutexercise VALUES(3,1,3,2);
INSERT INTO workoutexercise VALUES(2,3,4,1);
INSERT INTO workoutexercise VALUES(4,3,5,2);
INSERT INTO workoutexercise VALUES(3,3,6,3);
INSERT INTO workoutexercise VALUES(2,4,7,1);
INSERT INTO workoutexercise VALUES(5,4,8,2);
INSERT INTO workoutexercise VALUES(6,4,9,3);
INSERT INTO workoutexercise VALUES(3,4,10,4);
CREATE TABLE IF NOT EXISTS "exercise" (
	name VARCHAR(128) NOT NULL, 
	video VARCHAR NOT NULL, 
	id INTEGER NOT NULL, 
	description VARCHAR NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (name)
);
INSERT INTO exercise VALUES('Отжимание','push_up.mp4',1,'Отжимание');
INSERT INTO exercise VALUES('Разминка','start_workout.mp4',2,'Разминка');
INSERT INTO exercise VALUES('Заминка','finish_workout.mp4',3,'Заминка');
INSERT INTO exercise VALUES('Приседания','sit_down.mp4',4,'Приседания');
INSERT INTO exercise VALUES('Гантели','exercise_dumbbells.mp4',5,'Гантели');
INSERT INTO exercise VALUES('Жим штанги лежа от груди','raise__barbell_chest.mp4',6,'Жим штанги лежа от груди');
CREATE TABLE IF NOT EXISTS "workout" (
	name VARCHAR(128) NOT NULL, 
	"group" VARCHAR(255) NOT NULL, 
	gender VARCHAR(255) NOT NULL, 
	purpose VARCHAR(255) NOT NULL, 
	id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (name)
);
INSERT INTO workout VALUES('Кардио Мужчина Сброс массы сет 1','Cardio','MALE','GO_SLIM',1);
INSERT INTO workout VALUES('Кардио Мужчина Сброс массы сет 2','Cardio','MALE','GO_SLIM',2);
INSERT INTO workout VALUES('Ноги Мужчина Сброс массы сет 1 ','Legs','MALE','GO_SLIM',3);
INSERT INTO workout VALUES('Грудь, бицепс Мужчина Сброс массы сет 1','Front','MALE','GO_SLIM',4);
CREATE TABLE advertisement (
	name VARCHAR(128) NOT NULL, 
	text VARCHAR(1024), 
	image VARCHAR, 
	hour_to_adv INTEGER NOT NULL, 
	active BOOLEAN, 
	gender VARCHAR(255), 
	id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	CONSTRAINT check_min_max_hour CHECK ((8<hour_to_adv) and (hour_to_adv<21)), 
	CONSTRAINT unique_hour_and_active UNIQUE (hour_to_adv, active), 
	UNIQUE (name)
);
INSERT INTO advertisement VALUES('Name of schedule job -1','Some advertisment text <a href="https://mail.ru/">mail.ru</a>','lazy_python.jpg',15,1,'NOT_SELECTED',1);
INSERT INTO advertisement VALUES('Name of schedule job -2','Some advertisment text',NULL,16,0,'NOT_SELECTED',2);
CREATE UNIQUE INDEX ix_user_email ON user (email);
COMMIT;
