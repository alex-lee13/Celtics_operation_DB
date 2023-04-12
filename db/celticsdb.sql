CREATE DATABASE celticsDB;


USE celticsDB;


CREATE TABLE IF NOT EXISTS Players
(
   p_number   INTEGER     NOT NULL,
   fName      varchar(50) NOT NULL,
   lName      varchar(50) NOT NULL,
   inj_status varchar(50) default 'Healthy',
   height     INTEGER     NOT NULL,
   weight     INTEGER     NOT NULL,
   bdate      date        NOT NULL,
   GP         INTEGER              DEFAULT 0,
   tot_pts    INTEGER     NOT NULL DEFAULT 0,
   tot_rbds   INTEGER     NOT NULL DEFAULT 0,
   tot_stls   INTEGER     NOT NULL DEFAULT 0,
   tot_mins   INTEGER     NOT NULL DEFAULT 0,
   tot_asts   INTEGER     NOT NULL DEFAULT 0,
   email      varchar(50) UNIQUE,
   PRIMARY KEY (p_number)
);


CREATE TABLE IF NOT EXISTS PlayerContracts
(
   p_number    INTEGER UNIQUE NOT NULL,
   fName       varchar(50)    NOT NULL,
   lName       varchar(50)    NOT NULL,
   contractID  INTEGER UNIQUE NOT NULL,
   salary      INTEGER        NOT NULL,
   term        FLOAT          NOT NULL,
   fine        INTEGER DEFAULT 0,
   incentive_1 varchar(100),
   incentive_2 varchar(100),
   PRIMARY KEY (p_number, fName, lName, contractID),
   FOREIGN KEY (p_number, fName, lName) REFERENCES Players (p_number, fName, lName) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS Coaches
(
   fName varchar(50) NOT NULL,
   lName varchar(50) NOT NULL,
   title varchar(50) NOT NULL,
   email varchar(50) UNIQUE,
   bdate DATE        NOT NULL,
   PRIMARY KEY (fName, lName, title)
);


CREATE TABLE IF NOT EXISTS CoachContracts
(
   fName       varchar(50)    NOT NULL,
   lName       varchar(50)    NOT NULL,
   title       varchar(50)    NOT NULL,
   contractID  INTEGER UNIQUE NOT NULL,
   salary      INTEGER        NOT NULL,
   term        FLOAT          NOT NULL,
   fine        INTEGER DEFAULT 0,
   incentive_1 varchar(100),
   incentive_2 varchar(100),
   PRIMARY KEY (fName, lName, title, contractID),
   FOREIGN KEY (fName, lName, title) REFERENCES Coaches (fName, lName, title) ON UPDATE CASCADE ON DELETE CASCADE
);




CREATE TABLE IF NOT EXISTS Sponsorships
(
   p_number INT UNIQUE  NOT NULL,
   fName    VARCHAR(50) NOT NULL,
   lName    VARCHAR(50) NOT NULL,
   length   FLOAT NOT NULL,
   salary   FLOAT NOT NULL,
   brand    VARCHAR(50),
   PRIMARY KEY (p_number, fName, lName),
   FOREIGN KEY (p_number, fName, lName)
       REFERENCES Players (p_number, fName, lName) ON UPDATE CASCADE ON DELETE CASCADE
);






CREATE TABLE IF NOT EXISTS Practices
(
   practice_num INT NOT NULL,
   pract_date   DATE NOT NULL,
   duration     FLOAT NOT NULL,
   location     VARCHAR(50) NOT NULL,
   PRIMARY KEY (practice_num)
);




CREATE TABLE IF NOT EXISTS PracticePlan
(
   practice_num INT NOT NULL,
   lift         boolean default false,
   focus        VARCHAR(50),
   equipment    VARCHAR(50),
   PRIMARY KEY (practice_num),
   FOREIGN KEY (practice_num)
       REFERENCES Practices (practice_num) ON UPDATE CASCADE ON DELETE CASCADE
);




CREATE TABLE IF NOT EXISTS Player_at_practice
(
   p_number     INT         NOT NULL,
   fName        VARCHAR(50) NOT NULL,
   lName        VARCHAR(50) NOT NULL,
   practice_num INT,
   attendance boolean NOT NULL,
   PRIMARY KEY (p_number, practice_num),
   FOREIGN KEY (practice_num) REFERENCES Practices (practice_num) ON UPDATE CASCADE ON DELETE CASCADE,
   FOREIGN KEY (p_number, fName, lName) REFERENCES Players (p_number, fName, lName) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS Stadium
(
  location VARCHAR(50) NOT NULL,
  s_name VARCHAR(50) UNIQUE NOT NULL,
  sponsor VARCHAR(50) NOT NULL,
  PRIMARY KEY (location, s_name)
);


CREATE TABLE IF NOT EXISTS Games
(
  gameID INTEGER PRIMARY KEY,
  game_date DATE NOT NULL,
  opponent VARCHAR(50) NOT NULL,
  num_tix INTEGER NOT NULL,
  avg_tix_price FLOAT NOT NULL,
  location VARCHAR(50) NOT NULL,
  s_name VARCHAR(50) NOT NULL,
  FOREIGN KEY (location, s_name) REFERENCES Stadium (location, s_name) ON UPDATE CASCADE ON DELETE RESTRICT
);




CREATE TABLE IF NOT EXISTS ScoutingReports
(
   gameID INTEGER PRIMARY KEY,
   DRTG   INTEGER NOT NULL,
   ORTG   INTEGER NOT NULL,
   play_1 varchar(100),
   play_2 varchar(100),
   play_3 varchar(100),
   FOREIGN KEY (gameID) REFERENCES Games (gameID) ON UPDATE CASCADE ON DELETE CASCADE
);




CREATE TABLE IF NOT EXISTS Broadcasters
(
  broad_id INT PRIMARY KEY,
  broad_name VARCHAR(50) NOT NULL,
  region VARCHAR(50) NOT NULL,
  broad_language VARCHAR(50) NOT NULL
);




CREATE TABLE IF NOT EXISTS AiredGames
(
  broad_id INT,
  gameID INT,
  viewership INT NOT NULL,
  revenue FLOAT NOT NULL,

  PRIMARY KEY(broad_id, gameID),
  CONSTRAINT broad_id
      FOREIGN KEY (broad_id) REFERENCES Broadcasters (broad_id) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT gameID
      FOREIGN KEY (gameID) REFERENCES Games (gameID) ON UPDATE CASCADE ON DELETE CASCADE
);




CREATE TABLE IF NOT EXISTS PlayerAtGames
(
  p_number INT UNIQUE NOT NULL,
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR (50) NOT NULL,
  gameID INT NOT NULL,
  game_ast INT NOT NULL,
  game_pts INT NOT NULL,
  game_rebs INT NOT NULL,
  game_mins FLOAT NOT NULL,
  game_stls INT NOT NULL,
  PRIMARY KEY(p_number, gameID),
  CONSTRAINT game_ID
      FOREIGN KEY (gameID) REFERENCES Games (gameID) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT player_id
      FOREIGN KEY (p_number, fname, lname) REFERENCES Players (p_number, fname, lname) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS PlayerCoaches
(
 coach_fName varchar(50) NOT NULL,
 coach_lName varchar(50) NOT NULL,
 title varchar(50) NOT NULL,
 p_number INTEGER UNIQUE NOT NULL,
 p_fName varchar(50) NOT NULL,
 p_lName varchar(50) NOT NULL,
 p_notes varchar(100),
 PRIMARY KEY (coach_fName, coach_lName, title, p_number),
 FOREIGN KEY (coach_fName, coach_lName, title) REFERENCES Coaches (fName, lName, title) ON UPDATE CASCADE ON DELETE CASCADE,
 FOREIGN KEY (p_number, p_fName, p_lName) REFERENCES Players (p_number, fName, lName) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Players values (0, 'Jayson', 'Tatum', 'Healthy', 80, 220, '1995-10-20', 0, 0, 0, 0, 0, 0, 'jt@gmail.com');
INSERT INTO Players values (7, 'Jaylen', 'Brown', 'Healthy', 76, 200, '1992-11-02', 0, 0, 0, 0, 0, 0, 'jb@gmail.com');

INSERT INTO Coaches VALUES ('Joe', 'Mazzula', 'Head Coach', 'Joe.mazzula@gmail.com', '1988-06-30');
INSERT INTO Coaches VALUES ('Damon', 'Stoudamire', 'Assistant Coach', 'Damon.stoudamire@gmail.com', '1973-09-03');

INSERT INTO Stadium VALUES ('100 Legends Way', 'TD Garden', 'Whole Foods');
INSERT INTO Stadium VALUES ('4 Plaza', 'Madison Square Garden', 'Colgate');

INSERT INTO CoachContracts VALUES ('Joe', 'Mazzula', 'Head Coach', 1, 6000000, 4, 5000,
'1 million if the Celtics win the championship', '1 million if Celtics win the Eastern Conference');
INSERT INTO CoachContracts VALUES ('Damon', 'Stoudamire', 'Assistant Coach', 2, 2000000, 3, 0,
'1 million if the Celtics win the championship', '500k if Celtics win the Eastern Conference');

INSERT INTO PlayerCoaches VALUES ('Joe', 'Mazzula', 'Head Coach', 0, 'Jayson', 'Tatum', 'Good at creating space and driving to the hoop');
INSERT INTO PlayerCoaches VALUES ('Joe', 'Mazzula', 'Head Coach', 7, 'Jaylen', 'Brown', 'Good shooter as well as finishing through contact');

INSERT INTO Sponsorships VALUES (0, 'Jayson', 'Tatum', 7, 5000000, 'Jordan Brand');
INSERT INTO Sponsorships VALUES (7, 'Jaylen', 'Brown', 10, 20000000, 'Nike');

INSERT INTO Games VALUES(01234, '2022-12-20', 'Lakers' , 20000, 88.0,'100 Legends Way', 'TD Garden');
INSERT INTO Games VALUES(02318, '2022-12-25', 'Knicks' , 26500, 95.5,'4 Plaza', 'Madison Square Garden');

INSERT INTO PlayerAtGames VALUES(0, 'Jayson', 'Tatum', 01234, 4, 25, 7, 32, 2);
INSERT INTO PlayerAtGames VALUES(7, 'Jaylen', 'Brown', 01234, 5, 12, 13, 31, 4);

INSERT INTO ScoutingReports VALUES(01234, 6, 8, 'celtics up', 'pick and roll', 'backdoor');
INSERT INTO ScoutingReports VALUES(02318, 7, 6, 'celtics up', 'pick and roll', 'backdoor');

INSERT INTO Broadcasters values (1, 'Telemundo', 'USA', 'English');
INSERT INTO Broadcasters values (2, 'ESPN', 'USA', 'English');

INSERT INTO AiredGames values (1, 01234, 500000, 12345678.99);
INSERT INTO AiredGames values (2, 01234, 250000, 1234567.89);

INSERT INTO Practices VALUES (1, '2023-04-06', 2, 'Boston');
INSERT INTO Practices VALUES (2, '2023-04-07', 2.5, 'Brookline');

INSERT INTO PracticePlan values (1, False, 'Shooting', 'Shooting Machine');
INSERT INTO PracticePlan values (2, True, 'Defense', 'Cones');

INSERT INTO PlayerContracts values (0, 'Jayson', 'Tatum', 1, 100000, 4.5, 0, 'All Star','First Team');
INSERT INTO PlayerContracts values (7, 'Jaylen', 'Brown', 2, 90000, 4, 0, 'All Star', 'Second Team');

INSERT INTO Player_at_practice VALUES (0, 'Jayson', 'Tatum', 1, True);
INSERT INTO Player_at_practice VALUES (7, 'Jaylen', 'Brown', 1, True);


SELECT * FROM Players;
SELECT * FROM PlayerContracts;
SELECT * FROM Coaches;
SELECT * FROM Sponsorships;
SELECT * FROM Practices;
SELECT * FROM PracticePlan;
SELECT * FROM Player_at_practice;
SELECT * FROM Stadium;
SELECT * FROM Games;
SELECT * FROM ScoutingReports;
SELECT * FROM Broadcasters;
SELECT * FROM AiredGames;
SELECT * FROM PlayerAtGames;
