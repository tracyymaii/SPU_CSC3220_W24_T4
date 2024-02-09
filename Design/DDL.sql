--
-- File generated with SQLiteStudio v3.4.4 on Fri Feb 9 15:35:34 2024
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: goal
CREATE TABLE goal (
    userId      INTEGER REFERENCES user (userId) 
                        NOT NULL,
    dueDate     INTEGER NOT NULL,
    dateEntered INTEGER NOT NULL,
    amount      INTEGER NOT NULL,
    completion  TEXT    NOT NULL
                        DEFAULT incomplete,
    goalId      INTEGER PRIMARY KEY ASC AUTOINCREMENT
                        UNIQUE
                        NOT NULL
);


-- Table: pet
CREATE TABLE pet (
    petId       INTEGER PRIMARY KEY ASC AUTOINCREMENT
                        UNIQUE
                        NOT NULL,
    petName     TEXT    NOT NULL,
    accessories TEXT,
    happiness   INTEGER DEFAULT (80) 
                        NOT NULL,
    food        TEXT,
    skin        TEXT    NOT NULL,
    userId      INTEGER REFERENCES user (userId) 
                        UNIQUE
                        NOT NULL
);


-- Table: user
CREATE TABLE user (
    userId     INTEGER PRIMARY KEY ASC AUTOINCREMENT
                       UNIQUE
                       NOT NULL,
    birthDate  INTEGER NOT NULL,
    joinedDate INTEGER NOT NULL,
    petId      INTEGER REFERENCES pet (petId) 
                       UNIQUE
                       NOT NULL
);


-- Table: waterIntake
CREATE TABLE waterIntake (
    amount        INTEGER NOT NULL,
    userId        INTEGER REFERENCES user (userId) 
                          NOT NULL,
    date          TEXT    NOT NULL,
    time          INTEGER NOT NULL,
    waterIntakeId INTEGER PRIMARY KEY ASC AUTOINCREMENT
                          UNIQUE
                          NOT NULL
);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
