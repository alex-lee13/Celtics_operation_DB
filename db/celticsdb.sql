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

INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (1,'2022-12-15','Eagle, pallas''s fish',11278,122.7,'Flatley and Sons');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (2,'2020-11-15','Netted rock dragon',51363,470.85,'Hamill, Lang and Wehner');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (3,'2019-12-25','Hornbill, southern ground',67038,398.51,'Runolfsdottir, Gerlach and Lind');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (4,'2020-07-14','Oryx, beisa',76824,340.34,'Fay, Altenwerth and Grant');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (5,'2021-09-09','Giraffe',84108,226.98,'Klein, Schaefer and Friesen');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (6,'2023-02-03','Stork, yellow-billed',27813,176.14,'Hirthe and Sons');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (7,'2021-07-07','Ring-tailed lemur',70257,245.61,'Haley, Smitham and Toy');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (8,'2021-03-27','Flamingo, chilean',52113,186.76,'Kub LLC');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (9,'2020-09-05','River wallaby',95050,178.61,'Walker, Langworth and Runolfsson');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (10,'2020-08-01','Gonolek, burchell''s',48861,478.2,'Hamill, Lang and Wehner');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (11,'2020-09-10','Monster, gila',7605,254.27,'Hirthe and Sons');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (12,'2021-04-12','Stork, woolly-necked',11531,428.85,'Heidenreich, Labadie and Krajcik');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (13,'2022-02-23','Pied butcher bird',20648,339.43,'Klein, Schaefer and Friesen');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (14,'2021-12-13','Greater blue-eared starling',86180,164.19,'Barton Inc');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (15,'2022-11-28','Vulture, white-rumped',10868,373.14,'Hirthe and Sons');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (16,'2021-11-29','Jackal, silver-backed',90324,453.18,'Waters LLC');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (17,'2019-10-30','Grey mouse lemur',72631,489.18,'Waters LLC');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (18,'2022-01-12','Owl, great horned',76815,410.25,'Hudson-Johnson');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (19,'2020-05-16','Dabchick',51494,177.25,'Kub LLC');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (20,'2021-08-23','Hawk-headed parrot',99820,118.66,'Klein, Schaefer and Friesen');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (21,'2022-10-29','Alligator, mississippi',64018,80.78,'Waters LLC');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (22,'2021-02-25','Langur, common',64876,370.13,'Fay, Altenwerth and Grant');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (23,'2019-09-23','Python, carpet',36910,135.65,'Hamill, Lang and Wehner');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (24,'2022-04-19','Brocket, brown',61263,422.01,'Rowe, Bergnaum and Hagenes');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (25,'2019-12-07','Blue-footed booby',79080,143.93,'Hudson-Johnson');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (26,'2021-02-11','Partridge, coqui',49329,400.92,'Barton Inc');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (27,'2021-07-24','Dove, white-winged',64290,322.04,'Fay, Altenwerth and Grant');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (28,'2019-11-21','Kingfisher, pied',37423,377.21,'Toy, Swift and Keeling');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (29,'2020-03-15','White-winged tern',26716,231.75,'Fay, Altenwerth and Grant');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (30,'2023-03-05','Heron, striated',3478,450.31,'Flatley and Sons');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (31,'2022-06-25','Fox, cape',2446,444.98,'Flatley and Sons');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (32,'2021-05-10','Starfish, crown of thorns',81081,268.07,'Barton Inc');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (33,'2022-10-25','Galapagos dove',49004,499.27,'Runolfsdottir, Gerlach and Lind');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (34,'2021-01-28','American bighorn sheep',68109,92.63,'Kassulke, Torphy and McDermott');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (35,'2023-02-18','Margay',89277,368.69,'Greenfelder-Kertzmann');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (36,'2020-05-13','Raven, white-necked',41793,246.11,'Koch, Raynor and O''Hara');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (37,'2020-06-07','Lizard, giant girdled',55814,155.07,'Waters LLC');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (38,'2022-05-10','Pigeon, feral rock',51280,429.38,'Lueilwitz-Hayes');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (39,'2021-03-27','Squirrel, indian giant',26010,383.9,'Hirthe and Sons');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (40,'2021-07-02','Yellow baboon',96554,413.21,'Ankunding LLC');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (41,'2020-01-12','Stork, greater adjutant',7833,428.2,'Heidenreich, Labadie and Krajcik');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (42,'2022-12-15','Springhare',6311,200.26,'Lueilwitz-Hayes');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (43,'2020-05-23','African clawless otter',93362,429.12,'Klein, Schaefer and Friesen');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (44,'2020-06-16','Egyptian vulture',67629,159.32,'Rowe, Bergnaum and Hagenes');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (45,'2019-11-01','Little grebe',82972,450.42,'Barton Inc');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (46,'2021-09-11','Gerenuk',39871,216.56,'Hudson-Johnson');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (47,'2019-11-08','Asian lion',55668,442.01,'Runolfsdottir, Gerlach and Lind');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (48,'2021-03-03','Stork, european',57322,379.58,'Greenfelder-Kertzmann');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (49,'2022-01-03','Dove, rock',65670,445.31,'Toy, Swift and Keeling');
INSERT INTO Games(gameID,game_date,opponent,num_tix,avg_tix_price,s_name) VALUES (50,'2022-12-16','Cat, long-tailed spotted',84176,201.8,'Waters LLC');

INSERT INTO Stadium(location,s_name,sponsor) VALUES ('072 Dexter Junction','Ankunding LLC','Dabjam');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('8534 Waxwing Avenue','Toy, Swift and Keeling','Zoozzy');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('659 Katie Road','Flatley and Sons','Yoveo');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('56280 Melvin Road','Fay, Altenwerth and Grant','Eare');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('162 Carioca Court','Hirthe and Sons','Skivee');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('2592 Little Fleur Court','Waters LLC','Blognation');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('6 Mockingbird Point','Heidenreich, Labadie and Krajcik','Aivee');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('83 Sunbrook Center','Hamill, Lang and Wehner','Reallinks');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('45041 Forest Drive','Klein, Schaefer and Friesen','Podcat');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('9 Brentwood Circle','Kub LLC','Skyndu');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('83863 Upham Trail','Haley, Smitham and Toy','Pixonyx');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('30 Sommers Terrace','Hudson-Johnson','Meemm');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('8 Riverside Alley','Rowe, Bergnaum and Hagenes','Eimbee');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('27 Superior Way','Lueilwitz-Hayes','Skibox');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('75288 Lawn Trail','Greenfelder-Kertzmann','Jabbertype');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('470 Redwing Avenue','Runolfsdottir, Gerlach and Lind','Skyba');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('65 Grim Crossing','Koch, Raynor and O''Hara','Edgetag');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('462 Sunfield Point','Barton Inc','Riffwire');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('4 Di Loreto Hill','Walker, Langworth and Runolfsson','Vimbo');
INSERT INTO Stadium(location,s_name,sponsor) VALUES ('8 Amoth Pass','Kassulke, Torphy and McDermott','Trilith');


