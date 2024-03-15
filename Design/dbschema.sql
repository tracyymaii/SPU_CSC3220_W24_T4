--
-- File generated with SQLiteStudio v3.4.4 on Fri Feb 9 16:27:08 2024
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Goal
CREATE TABLE Goal (
    GoalID     INTEGER PRIMARY KEY
                       NOT NULL
                       UNIQUE,
    UserID     INTEGER REFERENCES User (UserID) ON DELETE CASCADE
                       NOT NULL,
    Completion TEXT    NOT NULL
                       DEFAULT Incomplete,
    Due        TEXT    NOT NULL,
    Started    TEXT    NOT NULL,
    Amount     INTEGER NOT NULL,
    FOREIGN KEY (
        UserID
    )
    REFERENCES User (UserID) 
);


-- Table: Intake
CREATE TABLE Intake (
    IntakeID INTEGER PRIMARY KEY AUTOINCREMENT
                     NOT NULL
                     UNIQUE,
    UserID   INTEGER REFERENCES User (UserID) ON DELETE CASCADE
                     NOT NULL,
    Date     TEXT    NOT NULL,
    Time     TEXT    NOT NULL,
    Amount   INTEGER NOT NULL
);


-- Table: Pet/Character
CREATE TABLE [Pet/Character] (
    PetID       INTEGER          PRIMARY KEY ASC AUTOINCREMENT
                                 NOT NULL
                                 UNIQUE,
    UserID                       REFERENCES User (UserID) 
                                 UNIQUE
                                 NOT NULL,
    Happiness   INTEGER (0, 100) DEFAULT (80) 
                                 NOT NULL,
    Skin        TEXT             NOT NULL,
    Name        TEXT             NOT NULL,
    Accessories TEXT,
    Food        TEXT,
    FOREIGN KEY (
        UserID
    )
    REFERENCES User (UserID) ON DELETE CASCADE
);

INSERT INTO "Pet/Character" (PetID, UserID, Happiness, Skin, Name, Accessories, Food) VALUES (1, 1, 88, 'spider', 'spidey', NULL, NULL);
INSERT INTO "Pet/Character" (PetID, UserID, Happiness, Skin, Name, Accessories, Food) VALUES (2, 2, 80, 'kitty', 'kitten', NULL, NULL);
INSERT INTO "Pet/Character" (PetID, UserID, Happiness, Skin, Name, Accessories, Food) VALUES (3, 3, 30, 'sheep', 'bahhh', 'flower headband', NULL);

-- Table: User
CREATE TABLE User (
    UserID     INTEGER PRIMARY KEY ASC AUTOINCREMENT
                       NOT NULL
                       UNIQUE,
    Birthday   TEXT    NOT NULL,
    JoinedDate TEXT    NOT NULL
);

INSERT INTO User (UserID, Birthday, JoinedDate) VALUES (1, 'march23', 'jan4');
INSERT INTO User (UserID, Birthday, JoinedDate) VALUES (2, 'march25', 'jan4');
INSERT INTO User (UserID, Birthday, JoinedDate) VALUES (3, 'may2', 'dec16');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
