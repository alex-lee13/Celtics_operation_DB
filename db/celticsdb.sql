CREATE DATABASE celticsDB;


use celticsDB;


CREATE TABLE IF NOT EXISTS Players
(
    p_number   INTEGER     NOT NULL,
    fName      varchar(50) NOT NULL,
    lName      varchar(50) NOT NULL,
    inj_status varchar(50)          default 'Healthy',
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
    contractID  INTEGER UNIQUE NOT NULL,
    salary      INTEGER        NOT NULL,
    term        FLOAT          NOT NULL,
    fine        INTEGER DEFAULT 0,
    incentive_1 varchar(100),
    incentive_2 varchar(100),
    PRIMARY KEY (p_number, contractID),
    FOREIGN KEY (p_number) REFERENCES Players (p_number)
);


CREATE TABLE IF NOT EXISTS Coaches
(
    coachID INTEGER UNIQUE NOT NULL,
    fName varchar (50) NOT NULL,
    lName varchar(50) NOT NULL,
    title varchar(50) NOT NULL,
    email varchar(50) UNIQUE,
    bdate DATE        NOT NULL,
    PRIMARY KEY (coachID)
);


CREATE TABLE IF NOT EXISTS CoachContracts
(
    coachID INTEGER UNIQUE NOT NULL,
    contractID  INTEGER UNIQUE NOT NULL,
    salary      INTEGER        NOT NULL,
    term        FLOAT          NOT NULL,
    fine        INTEGER DEFAULT 0,
    incentive_1 varchar(100),
    incentive_2 varchar(100),
    PRIMARY KEY (coachID, contractID),
    FOREIGN KEY (coachID) REFERENCES Coaches (coachID)
);



CREATE TABLE IF NOT EXISTS Sponsorships
(
    p_number INT UNIQUE  NOT NULL,
    length   FLOAT       NOT NULL,
    salary   FLOAT       NOT NULL,
    brand    VARCHAR(50),
    PRIMARY KEY (p_number),
    FOREIGN KEY (p_number)
        REFERENCES Players (p_number)
);



CREATE TABLE IF NOT EXISTS Practices
(
    practice_num INT         NOT NULL,
    pract_date   DATE        NOT NULL,
    duration     FLOAT       NOT NULL,
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
        REFERENCES Practices (practice_num)
);



CREATE TABLE IF NOT EXISTS Player_at_practice
(
    p_number     INT         NOT NULL,
    practice_num INT,
    attendance   boolean     NOT NULL,
    PRIMARY KEY (p_number, practice_num),
    FOREIGN KEY (practice_num) REFERENCES Practices (practice_num),
    FOREIGN KEY (p_number) REFERENCES Players (p_number)
);


CREATE TABLE IF NOT EXISTS Stadium
(
    location VARCHAR(50)        NOT NULL,
    s_name   VARCHAR(50) UNIQUE NOT NULL,
    sponsor  VARCHAR(50)        NOT NULL,
    PRIMARY KEY (s_name)
);


CREATE TABLE IF NOT EXISTS Games
(
    gameID        INTEGER PRIMARY KEY,
    game_date     DATE        NOT NULL,
    opponent      VARCHAR(50) NOT NULL,
    num_tix       INTEGER     NOT NULL,
    avg_tix_price FLOAT       NOT NULL,
    s_name        VARCHAR(50) NOT NULL,
    FOREIGN KEY (s_name) REFERENCES Stadium (s_name)
);



CREATE TABLE IF NOT EXISTS ScoutingReports
(
    gameID INTEGER PRIMARY KEY,
    DRTG   INTEGER NOT NULL,
    ORTG   INTEGER NOT NULL,
    play_1 varchar(100),
    play_2 varchar(100),
    play_3 varchar(100),
    FOREIGN KEY (gameID) REFERENCES Games (gameID)
);



CREATE TABLE IF NOT EXISTS Broadcasters
(
    broad_id       INT PRIMARY KEY,
    broad_name     VARCHAR(50) NOT NULL,
    region         VARCHAR(50) NOT NULL,
    broad_language VARCHAR(50) NOT NULL
);



CREATE TABLE IF NOT EXISTS AiredGames
(
    broad_id   INT,
    gameID     INT,
    viewership INT   NOT NULL,
    revenue    FLOAT NOT NULL,

    PRIMARY KEY (broad_id, gameID),
    CONSTRAINT broad_id
        FOREIGN KEY (broad_id) REFERENCES Broadcasters (broad_id),
    CONSTRAINT gameID
        FOREIGN KEY (gameID) REFERENCES Games (gameID)
);



CREATE TABLE IF NOT EXISTS PlayerAtGames
(
    p_number  INT UNIQUE  NOT NULL,
    gameID    INT         NOT NULL,
    game_ast  INT         NOT NULL,
    game_pts  INT         NOT NULL,
    game_rebs INT         NOT NULL,
    game_mins FLOAT       NOT NULL,
    game_stls INT         NOT NULL,
    PRIMARY KEY (p_number, gameID),
    CONSTRAINT game_ID
        FOREIGN KEY (gameID) REFERENCES Games (gameID),
    CONSTRAINT player_id
        FOREIGN KEY (p_number) REFERENCES Players (p_number)
);


CREATE TABLE IF NOT EXISTS PlayerCoaches
(
    coachID INTEGER NOT NULL,
    p_number    INTEGER UNIQUE NOT NULL,
    p_notes     varchar(100),
    PRIMARY KEY (coachID, p_number),
    FOREIGN KEY (coachID) REFERENCES Coaches (coachID),
    FOREIGN KEY (p_number) REFERENCES Players (p_number)
);

INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (1,'Dotti','Lippini','Secura Antifungal',83,248,'2000-04-30',31,2726,1905,259,2499,1173,'dlippini0@t.co');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (2,'Annmaria','Wolffers','Nasal Ease Allergy Reliever',68,241,'1995-08-22',14,1601,328,125,2860,736,'awolffers1@shareasale.com');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (3,'Otho','Wraxall','Metoclopramide',64,175,'1981-08-19',55,836,974,277,374,3,'owraxall2@amazon.co.jp');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (4,'Booth','Lampen','Rescon GG',62,173,'1994-08-19',76,155,1992,28,3765,78,'blampen3@blogtalkradio.com');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (5,'Dyane','Bevar','Bromfed',65,245,'2003-07-06',70,3376,599,431,1323,1140,'dbevar4@de.vu');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (6,'Kingsly','Moulden','Amar',75,248,'1981-09-17',1,583,1201,82,3651,1172,'kmoulden5@whitehouse.gov');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (7,'Marja','Timny','Potassium Chloride',57,155,'1990-05-09',51,214,1064,488,3886,1069,'mtimny6@upenn.edu');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (8,'Ingar','Yendall','Red Cedar',82,222,'1985-02-04',71,3755,1106,492,2518,1018,'iyendall7@uiuc.edu');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (9,'Erl','Starmore','Carbinoxamine Maleate',84,269,'1999-07-04',58,565,1841,219,3178,988,'estarmore8@g.co');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (10,'Bonnibelle','Pilkington','Treatment Set TS332340',65,267,'1986-11-13',17,3195,1047,54,1862,700,'bpilkington9@example.com');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (11,'Archer','Tuley','Hormeel',90,231,'2001-02-26',6,3659,1697,256,1664,833,'atuleya@google.nl');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (12,'Vivienne','Elphinston','allergy eye',86,287,'1984-09-23',47,3724,1401,450,3085,178,'velphinstonb@nytimes.com');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (13,'Florian','Corrao','Hand Sanitizer',82,218,'1995-05-08',3,1512,959,369,2246,921,'fcorraoc@jugem.jp');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (14,'Hillier','Krolman','Glandulae suprarenales 6',85,175,'1984-12-07',30,1959,1973,258,622,44,'hkrolmand@smugmug.com');
INSERT INTO Players(p_number,fName,lName,inj_status,height,weight,bdate,GP,tot_pts,tot_rbds,tot_stls,tot_mins,tot_asts,email) VALUES (15,'Enrico','Hesbrook','Nasal Catarrh',76,171,'1998-12-24',39,853,1852,236,3902,611,'ehesbrooke@zimbio.com');

select * from Players;

