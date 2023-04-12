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
    p_number INT  NOT NULL,
    length   FLOAT       NOT NULL,
    salary   FLOAT       NOT NULL,
    brand    VARCHAR(50),
    PRIMARY KEY (p_number, brand),
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

INSERT INTO Coaches(coachID,fName,lName,title,email,bdate) VALUES (1,'Anatole','Jakucewicz','Human Resources Manager','ajakucewicz0@people.com.cn','1952-10-06');
INSERT INTO Coaches(coachID,fName,lName,title,email,bdate) VALUES (2,'Cristie','Marchelli','Operator','cmarchelli1@mapquest.com','1998-12-16');
INSERT INTO Coaches(coachID,fName,lName,title,email,bdate) VALUES (3,'Vikky','McGurk','Payment Adjustment Coordinator','vmcgurk2@japanpost.jp','1968-08-02');
INSERT INTO Coaches(coachID,fName,lName,title,email,bdate) VALUES (4,'Emmie','Deverock','VP Marketing','edeverock3@timesonline.co.uk','1954-12-27');
INSERT INTO Coaches(coachID,fName,lName,title,email,bdate) VALUES (5,'Lara','Raftery','Financial Analyst','lraftery4@nature.com','1988-01-28');
INSERT INTO Coaches(coachID,fName,lName,title,email,bdate) VALUES (6,'Bing','Ackroyd','Librarian','backroyd5@arstechnica.com','1974-09-18');
INSERT INTO Coaches(coachID,fName,lName,title,email,bdate) VALUES (7,'Myrwyn','Mil','Statistician III','mmil6@omniture.com','1953-08-13');

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

INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (1,'2022-08-16',56,'Yunmen');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (2,'2022-10-16',116,'Milicz');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (3,'2023-03-06',56,'Qili');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (4,'2022-10-19',63,'København');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (5,'2022-10-20',145,'Ngrejo');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (6,'2023-04-17',121,'Yong’an');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (7,'2022-11-04',103,'Chavães');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (8,'2023-05-12',110,'Dežanovac');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (9,'2022-12-17',125,'Huangliu');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (10,'2022-12-05',77,'Sho’rchi');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (11,'2023-04-05',108,'Shengli');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (12,'2023-03-19',162,'Cikiruh Wetan');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (13,'2023-05-18',67,'Madrid');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (14,'2022-12-15',82,'Menuma');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (15,'2022-08-08',84,'Ratchasan');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (16,'2022-12-16',173,'Natonin');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (17,'2023-05-27',132,'Paris 17');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (18,'2022-10-24',69,'Söderhamn');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (19,'2022-08-04',32,'Nanger');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (20,'2022-09-17',134,'Pasolapida');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (21,'2023-01-03',116,'Sakaraha');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (22,'2023-04-29',37,'Callao');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (23,'2022-10-20',149,'Gotputuk');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (24,'2023-04-07',125,'Rovensko pod Troskami');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (25,'2023-01-25',97,'Punta de Bombón');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (26,'2023-03-05',42,'Dongyuan');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (27,'2022-11-02',90,'Plaeng Yao');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (28,'2023-04-15',111,'Al Hāshimīyah');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (29,'2023-05-15',134,'Bobo-Dioulasso');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (30,'2023-03-14',44,'Ust’-Izhora');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (31,'2023-01-12',126,'North Battleford');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (32,'2022-11-02',173,'Kälviä');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (33,'2023-01-18',86,'Marisol');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (34,'2022-08-08',153,'Xankandi');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (35,'2023-01-11',141,'Stende');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (36,'2023-04-23',67,'Opechenskiy Posad');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (37,'2022-12-28',174,'Nanfeng');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (38,'2022-09-28',157,'Kapyl’');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (39,'2023-01-13',38,'Xiangang');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (40,'2023-03-27',170,'Sanming');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (41,'2022-12-15',148,'Upi');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (42,'2022-10-03',150,'Coutances');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (43,'2022-11-09',54,'Dungloe');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (44,'2023-05-07',119,'Napnapan');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (45,'2022-11-07',167,'Weichanglu');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (46,'2023-03-11',178,'Gostivar');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (47,'2023-05-17',101,'Chaiyo');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (48,'2022-10-28',77,'Shënmëri');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (49,'2022-11-10',124,'Martyush');
INSERT INTO Practices(practice_num,pract_date,duration,location) VALUES (50,'2023-03-20',156,'Pamedilan');

INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (1,'WSD','Xilaiqiao','Polish');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (2,'ARY','Figueiredo','New Zealand Sign Language');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (3,'WEA','Xinyang','Māori');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (4,'HDE','Avellaneda','Italian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (5,'YKA','De la Paz','Polish');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (6,'WAG','Slatina','Hungarian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (7,'ECA','Bedalewun','Irish Gaelic');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (8,'TWE','Houston','Georgian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (9,'PRM','Dillenburg','Northern Sotho');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (10,'KUY','Chambly','Luxembourgish');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (11,'KIR','Redon','Lithuanian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (12,'TLG','Xiangjiazhai','Bengali');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (13,'HRI','Santa Clara','Spanish');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (14,'ZMG','Villa Santa Rita','Maltese');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (15,'GNZ','Kuala Terengganu','Dari');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (16,'LTP','Krajan','Amharic');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (17,'CFF','Guifeng','Hindi');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (18,'GCH','Kovrov','Northern Sotho');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (19,'ULQ','Ketapang','Romanian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (20,'HVK','Mayma','Telugu');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (21,'MHX','Riosucio','Ndebele');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (22,'PWY','Karlshamn','Macedonian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (23,'IKO','Dazuo','English');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (24,'ZQW','Wenwuba','Pashto');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (25,'KRD','Kumba','Swedish');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (26,'PPC','Curug','Persian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (27,'KUA','Wangtuan','Moldovan');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (28,'SLK','Czarna Woda','Oriya');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (29,'TQN','Sibulan','Amharic');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (30,'SXJ','Telêmaco Borba','Persian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (31,'BFN','Majennang','Lithuanian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (32,'CIF','Erjiegou','Bengali');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (33,'AIA','Greensboro','Zulu');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (34,'SKQ','Alzamay','Tok Pisin');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (35,'KHV','Bascaron','Guaraní');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (36,'ESP','Dongyuan','Lithuanian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (37,'YPE','Gulariyā','Greek');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (38,'FLA','Pýli','Swahili');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (39,'ELM','Sirājganj','Swati');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (40,'ZRM','Mriyunan','Portuguese');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (41,'0','Jianqiao','Oriya');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (42,'MCG','Ciela Lebak','Moldovan');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (43,'FSD','Riyadh','Maltese');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (44,'TKT','Laval','Bosnian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (45,'ERA','Tonj','Bulgarian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (46,'SAR','Bingfang','Bulgarian');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (47,'MQT','Faqīrwāli','Ndebele');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (48,'LNZ','Nong Bua Lamphu','Thai');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (49,'NLA','Hepu','Papiamento');
INSERT INTO Broadcasters(broad_id,broad_name,region,broad_language) VALUES (50,'TTB','Yunlu','Gujarati');

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

INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (1,1,3418590,7,41125,'Behav insomnia-childhood','Ocular torticollis');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (2,2,16755189,4,10135,'Abn cervix NEC-delivered','Rumination disorder');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (3,3,22762710,5,7998,'Joint dis NEC-pelvis','Behcet''s syndrome');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (4,4,4097001,3,22841,'Palindrom rheum-forearm','Hodg lymph-histio abdom');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (5,5,12739169,7,36423,'Sensormotr disor lid NEC','Tox eff org lead compnd');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (6,6,8367791,3,17522,'Spinal cord inj at birth','Obs-susp cardiovasc dis');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (7,7,19405290,4,15567,'Diabetes-antepartum','Opn skull fx NEC/hem NEC');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (8,8,15883273,5,3203,'Angioneurotic edema','Lymphogranuloma venereum');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (9,9,4256070,8,44348,'Acc poisn-skin/eent agnt','Physical restrain status');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (10,10,16038569,2,13722,'Breast dis preg NEC-unsp','Poxvirus infection NOS');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (11,11,23162179,1,35178,'Infertility-uterine orig','Chronic tonsils&adenoids');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (12,12,18758610,6,1611,'Meningococc arthropathy','Terrorism,explosions');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (13,13,4068389,5,26108,'Adv eff mix bact vaccine','Anatomical narrow angle');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (14,14,18135254,7,35870,'Dracontiasis','Degen ciliary body');
INSERT INTO PlayerContracts(p_number,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (15,15,4952682,6,7235,'Postauricular fistula','Burn periocular area NEC');

INSERT INTO CoachContracts(coachID,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (1,1,28990787,4,13988,'Accident on farm','Hyposmolality');
INSERT INTO CoachContracts(coachID,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (2,2,8354863,6,28005,'Injury splenic artery','Enuresis');
INSERT INTO CoachContracts(coachID,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (3,3,7278168,4,56842,'Malig melanoma ear','Conduc hear loss mid ear');
INSERT INTO CoachContracts(coachID,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (4,4,11664810,10,31599,'Osteoarthros NOS-shlder','Face/brow present-deliv');
INSERT INTO CoachContracts(coachID,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (5,5,19476982,2,69288,'Reg enteritis, sm intest','Pulmonary actinomycosis');
INSERT INTO CoachContracts(coachID,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (6,6,11382601,1,78277,'Diverticulum of pharynx','Desquamatv interst pneu');
INSERT INTO CoachContracts(coachID,contractID,salary,term,fine,incentive_1,incentive_2) VALUES (7,7,2903981,6,26481,'Ca in situ stomach','Chr pept ulc hem/perf-ob');

INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (1,4.4,2.9,'Misopates orontium (L.) Raf.','Dicentra cucullaria (L.) Bernh.','Grammitis tenella Kaulf.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (2,0.8,0.7,'Luzula multiflora (Ehrh.) Lej. ssp. multiflora','Agalinis paupercula (A. Gray) Britton var. borealis Pennell','Pinus contorta Douglas ex Loudon var. murrayana (Balf.) Engelm.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (3,0.4,1.6,'Elodea bifoliata H. St. John','Thelypteris guadalupensis (Wikstr.) Proctor','Pseudocyphellaria rainierensis Imshaug');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (4,3.1,7.3,'Lecanora cladonioides Lynge','Schkuhria pinnata (Lam.) Kuntze ex Thell. var. guatemalensis (Rydb.) McVaugh','Salix atrocinerea Brot.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (5,5.1,9.1,'Cosmos parviflorus (Jacq.) Pers.','Lichinella Nyl.','Crataegus rufula Sarg.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (6,1.9,9.4,'Schiedea amplexicaulis H. Mann','Tortula chisosa Magill, Delgad. & L.R. Stark','Myosotis arvensis (L.) Hill');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (7,7.3,9.5,'Acarospora canadensis H. Magn.','Scutellaria texana B.L. Turner','Cladonia cryptochlorophaea Asah.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (8,0.4,5.7,'Mimulus cusickii (Greene) Rattan','Potentilla uliginosa B.C. Johnst. & Ertter','Genista aetnensis (Raf. ex Biv.) DC.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (9,8.9,3.4,'Castilleja grisea Dunkle','Melaspilea cupularis Müll. Arg.','Murdannia spirata (L.) Bruckner');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (10,9.4,9.6,'Heuchera L.','Astragalus ceramicus Sheldon','Solidago patula Muhl. ex Willd. var. patula');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (11,9.3,6.9,'Cyperus unioloides R. Br.','Ribes cereum Douglas var. colubrinum C.L. Hitchc.','Pylaisiella polyantha (Hedw.) Grout');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (12,3.6,4.9,'Triantha occidentalis (S. Watson) Gates ssp. montana (C.L. Hitchc.) Packer','Atriplex ×odontoptera Rydb. (pro sp.)','Chorizanthe parryi S. Watson var. parryi');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (13,6.3,7.1,'Galphimia Cav.','Ixia L.','Krameria grayi Rose & Painter');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (14,5.2,6.9,'Clarkia bottae (Spach) F.H. Lewis & M.E. Lewis','Stephanomeria fluminea Gottlieb','Hypericum calycinum L.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (15,8.8,7.5,'Xylosma hawaiiensis Seem.','Corylus ferox Wall.','Hyptis emoryi Torr.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (16,4.8,2.9,'Iris hartwegii Baker ssp. columbiana Lenz','Lecanora lividolutea Rasanen','Stevia Cav.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (17,4.5,1.0,'Triteleia lilacinum Greene','Spermacoce tenuior L.','Cassia roxburghii DC.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (18,8.9,6.4,'Phyla stoechadifolia (L.) Small','Eubotrys racemosus (L.) Nutt.','Eriogonum microthecum Nutt. var. corymbosoides Reveal');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (19,4.6,8.0,'Eucalyptus globulus Labill.','Rubus leviculus L.H. Bailey','Salvia verbenaca L.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (20,7.5,1.8,'Gahnia vitiensis Rendle','Asplenium juglandifolium Lam.','Sicyos cucumerinus A. Gray');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (21,7.1,4.0,'Lupinus texensis Hook.','Liatris scariosa (L.) Willd.','Polytrichastrum alpinum (Hedw.) G.L. Sm. var. fragile (Bryhn) Long');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (22,9.4,2.1,'Oreostemma alpigenum (Torr. & A. Gray) Greene','Nectouxia Kunth','Cotoneaster horizontalis Decne.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (23,8.0,4.2,'Salvia verbenaca L.','Laurera subdisjuncta (Müll. Arg.) R.C. Harris','Heliconia subulata Ruiz & Pav.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (24,1.6,1.9,'Elymus virginicus L. var. halophilus (E.P. Bicknell) Wiegand','Macrotyloma uniflorum (Lam.) Verdc.','Carex ×patuensis Lepage');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (25,1.0,3.2,'Luzula multiflora (Ehrh.) Lej. ssp. multiflora var. acadiensis Fernald','Ernodea cokeri Britton ex Coker','Gillenia stipulata (Muhl. ex Willd.) Baill.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (26,3.9,0.8,'Asclepias incarnata L. ssp. pulchra (Ehrh. ex Willd.) Woodson','Lithospermum californicum A. Gray','Cyperus phleoides (Nees ex Kunth) Hillebr. var. phleoides');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (27,0.5,8.0,'Abutilon mollicomum (Willd.) Sweet','Sphaeralcea ambigua A. Gray ssp. rugosa Kearney','Phoradendron hawksworthii (Wiens) Wiens');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (28,5.0,1.2,'Bambusa multiplex (Lour.) Raeusch. ex Schult. & Schult. f.','Silene aperta Greene','Eucalyptus deglupta Blume');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (29,5.0,7.6,'Sphaeralcea coccinea (Nutt.) Rydb.','Centaurium calycosum (Buckley) Fernald','Packera quaerens (Greene) W.A. Weber & Á. Löve');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (30,2.4,4.5,'Dichanthelium depauperatum (Muhl.) Gould','Arceuthobium douglasii Engelm.','Chrysoma Nutt.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (31,1.8,1.5,'Oenothera fruticosa L. ssp. fruticosa','Lecanora granulifera (Ach.) Nyl.','Lecidella viridans (Flotow) Körb.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (32,5.9,9.9,'Ptychosperma macarthuri (H. Wendl. ex hort.) G. Nicholson','Polycarpon tetraphyllum (L.) L. ssp. alsinifolium (Biv.) P.W. Ball','Kumlienia hystricula (A. Gray) Greene');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (33,6.5,2.3,'Senecio lemmonii A. Gray','Rhynchospora pusilla Chapm. ex M.A. Curtis','Syzygium aqueum (Burm. f.) Alston');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (34,8.4,1.1,'Virola calophylloidea Markgr.','Abies fraseri (Pursh) Poir.','Cicuta bulbifera L.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (35,4.6,10.0,'Vicia ocalensis Godfrey & Kral','Rubus pubescens Raf.','Acarospora impressula Th. Fr.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (36,1.0,8.1,'Solanum heterodoxum Dunal var. novomexicanum Bartlett','Rubus hypolasius Fernald','Rubus apogaeus L.H. Bailey');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (37,9.0,4.3,'Roldana petasitis (Sims) H. Rob. & Brettell','Allium geyeri S. Watson','Carex orestera Zika');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (38,8.4,5.2,'Gossypianthus lanuginosus (Poir.) Moq.','Delphinium tricorne Michx.','Stipa klemenzii Roshev.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (39,3.1,2.5,'Euclidium syriacum (L.) W.T. Aiton','Nomaphila Blume','Agalinis strictifolia (Benth.) Pennell');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (40,6.3,4.1,'Roccella peruensis Krempelh.','Eleocharis elongata Chapm.','Castilleja grisea Dunkle');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (41,2.6,3.7,'Fuscidea gyrodes (H. Magn.) ?, ined.?','Pinus torreyana Parry ex Carrière ssp. insularis J.R. Haller','Melicope anisata (H. Mann) T.G. Hartley & B.C. Stone');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (42,1.8,7.9,'Setaria tenacissima Schrad.','Heliotropium curassavicum L. var. curassavicum','Spiracantha cornifolia Kunth');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (43,0.0,3.1,'Hieracium gracile Hook. var. gracile','Gilia ophthalmoides Brand','Lecanora discoensis Lynge');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (44,9.7,4.4,'Helianthus gracilentus A. Gray','Hesperocyparis forbesii (Jeps.) Bartel','Selenia aurea Nutt.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (45,4.2,7.1,'Sanionia uncinata (Hedw.) Loeske var. uncinata','Taxodium mucronatum Ten.','Iris ×robusta E.S. Anderson');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (46,8.0,0.4,'Verbesina alata L.','Douglasia laevigata A. Gray','Heuchera americana L.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (47,4.8,5.1,'Justicia turneri Hilsenb.','Deinandra increscens (H.M. Hall ex D.D. Keck) B.G. Baldw. ssp. foliosa (Hoover) B.G. Baldw.','Cynoglossum virginianum L. var. virginianum');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (48,4.9,4.7,'Hatiora Britton & Rose','Viola ×modesta House','Aplodon wormskjoldii (Hornem.) Kindb.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (49,1.1,2.0,'Megalaria grossa (Pers. ex Nyl.) Hafellner','Polyblastia septentrionalis Lynge','Arabidopsis Heynh.');
INSERT INTO ScoutingReports(gameID,DRTG,ORTG,play_1,play_2,play_3) VALUES (50,6.8,0.7,'Galium hilendiae Dempster & Ehrend. ssp. carneum (Hilend & J.T. Howell) Dempster & Ehrend.','Diploschistes muscorum (Scop.) R. Sant.','Diervilla lonicera Mill.');


INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (1,0,'Green','Vinyl');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (2,1,'Yellow','Granite');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (3,0,'Crimson','Brass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (4,1,'Aquamarine','Brass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (5,0,'Crimson','Aluminum');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (6,1,'Purple','Vinyl');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (7,1,'Goldenrod','Steel');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (8,0,'Violet','Glass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (9,0,'Violet','Plastic');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (10,0,'Teal','Plexiglass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (11,1,'Crimson','Brass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (12,0,'Orange','Vinyl');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (13,1,'Blue','Aluminum');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (14,1,'Khaki','Aluminum');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (15,1,'Indigo','Plexiglass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (16,0,'Violet','Plexiglass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (17,1,'Indigo','Rubber');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (18,0,'Maroon','Glass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (19,1,'Blue','Plexiglass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (20,1,'Yellow','Glass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (21,1,'Crimson','Steel');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (22,0,'Turquoise','Brass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (23,0,'Pink','Plastic');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (24,1,'Mauv','Granite');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (25,1,'Maroon','Plastic');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (26,0,'Turquoise','Granite');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (27,1,'Turquoise','Vinyl');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (28,1,'Puce','Granite');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (29,0,'Indigo','Steel');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (30,0,'Khaki','Plastic');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (31,1,'Indigo','Steel');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (32,1,'Goldenrod','Plastic');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (33,0,'Orange','Glass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (34,1,'Purple','Plastic');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (35,0,'Yellow','Aluminum');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (36,1,'Indigo','Granite');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (37,0,'Indigo','Wood');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (38,0,'Violet','Glass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (39,1,'Violet','Wood');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (40,0,'Fuscia','Vinyl');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (41,0,'Aquamarine','Granite');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (42,0,'Goldenrod','Plexiglass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (43,0,'Aquamarine','Steel');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (44,1,'Aquamarine','Granite');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (45,0,'Indigo','Rubber');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (46,0,'Teal','Vinyl');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (47,0,'Yellow','Wood');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (48,1,'Khaki','Aluminum');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (49,1,'Turquoise','Plexiglass');
INSERT INTO PracticePlan(practice_num,lift,focus,equipment) VALUES (50,0,'Pink','Stone');

INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (1,43,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (2,8,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (3,16,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (4,5,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (5,28,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (6,2,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (7,8,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (8,11,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (9,7,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (10,1,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (11,6,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (12,33,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (13,50,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (14,29,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (15,25,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (1,11,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (2,38,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (3,4,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (4,2,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (5,40,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (6,39,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (7,42,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (8,43,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (9,30,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (10,5,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (11,35,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (12,27,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (13,48,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (14,22,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (15,32,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (1,22,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (2,29,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (3,21,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (4,47,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (5,39,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (6,16,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (7,35,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (8,16,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (9,36,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (10,23,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (11,7,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (12,42,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (13,19,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (14,30,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (15,24,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (1,2,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (2,9,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (3,27,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (4,5,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (5,21,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (6,33,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (7,1,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (8,43,0);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (9,44,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (10,47,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (11,16,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (12,5,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (13,23,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (14,47,1);
INSERT INTO Player_at_practice(p_number,practice_num,attendance) VALUES (15,2,1);

INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (17,35,3027,89610.67);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (31,6,1904,87673.49);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (33,26,9481,92777.67);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (13,28,4213,84294.5);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (20,37,2905,44207.76);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (13,16,7401,88717.98);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (27,38,8151,93960.44);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (34,42,5687,89719.41);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (3,26,2782,47134.13);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (50,35,3616,69687.87);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (25,36,2284,16229.89);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (3,23,9145,58078.88);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (18,25,1708,23897.94);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (32,20,3334,73197.33);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (10,24,8432,59273.61);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (43,11,9757,71829.62);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (29,2,1187,86175.62);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (12,18,8858,97640.31);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (9,38,5932,56204.05);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (15,36,6390,61052.76);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (11,41,6309,57063.67);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (8,33,7319,96986.02);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (6,39,1711,78721.58);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (13,5,8517,41332.94);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (6,28,1050,73660.96);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (23,19,4336,26034.94);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (2,49,2442,38545.52);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (41,34,1975,21268.02);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (48,3,1004,89307.73);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (29,13,8260,87896.01);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (24,13,3855,43792.49);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (2,46,7039,91683.67);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (28,28,5801,62744.69);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (23,21,4769,31002.45);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (37,13,9978,21430.54);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (22,24,7982,32475.46);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (8,43,9860,95876.44);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (37,41,4722,19130.81);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (23,27,9736,35841.65);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (39,35,9645,47985.94);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (31,42,6456,96038.11);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (18,31,7319,19460.29);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (30,19,7499,72523.21);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (12,33,8745,81316.49);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (10,47,8945,49461.36);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (2,30,5153,88351.33);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (6,41,3064,71290.71);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (34,15,1175,21021.55);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (26,48,5627,94953.12);
INSERT INTO AiredGames(broad_id,gameID,viewership,revenue) VALUES (48,12,4004,59680.88);

INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (6,38,9,45,36,28.96,3);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (13,36,5,34,39,43.19,9);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (2,11,5,34,29,15.17,4);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (9,26,9,69,10,9.09,2);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (13,49,5,66,10,10.08,15);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (3,4,17,71,39,48.99,11);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (7,45,3,29,22,40.03,18);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (2,18,27,87,3,54.78,13);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (13,31,7,64,4,32.95,6);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (5,45,3,77,40,17.28,2);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (11,7,29,59,31,42.03,12);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (12,13,25,19,2,9.72,18);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (9,28,7,35,7,43.58,12);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (7,2,4,40,10,44.57,19);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (11,21,5,93,23,2.78,17);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (2,1,5,19,20,11.96,20);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (8,46,21,100,10,25.05,12);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (4,13,28,91,1,56.49,7);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (9,29,20,97,25,49.36,14);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (10,8,15,94,30,42.79,11);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (13,11,30,36,31,35.39,10);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (2,45,20,83,21,46.22,18);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (9,10,29,53,36,21.43,15);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (7,4,30,1,16,43.99,10);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (2,7,4,62,12,4.04,8);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (13,36,25,66,11,22.83,5);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (5,38,9,62,26,32.89,7);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (2,21,4,7,25,37.1,19);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (13,49,10,41,29,44.35,2);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (9,50,9,88,29,15.93,11);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (12,7,9,89,19,58.15,4);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (4,15,5,88,6,53.05,4);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (7,21,3,25,19,21.55,18);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (10,6,10,78,1,18.61,1);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (6,21,19,9,16,58.48,14);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (4,39,6,79,9,7.01,16);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (15,37,6,34,36,43.42,9);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (2,9,1,31,16,32.03,12);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (11,21,8,30,36,10.24,6);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (5,26,19,97,12,8.41,16);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (14,27,4,33,11,54.9,15);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (9,10,23,96,37,38.26,11);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (1,50,14,91,23,41.41,9);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (8,23,13,47,24,32.37,4);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (10,36,14,55,11,47.92,14);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (4,43,8,84,36,14.24,17);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (15,11,18,64,10,9.84,18);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (3,18,8,34,37,18.92,6);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (13,3,29,14,2,42.5,18);
INSERT INTO PlayerAtGames(p_number,gameID,game_ast,game_pts,game_rebs,game_mins,game_stls) VALUES (6,46,15,88,1,14.11,9);

INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (5,4,'actuating');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (2,8,'non-volatile');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (3,11,'scalable');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (1,15,'Front-line');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (3,2,'productivity');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (6,5,'knowledge base');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (1,9,'benchmark');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (6,15,'upward-trending');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (5,3,'Sharable');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (4,10,'national');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (1,15,'stable');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (2,14,'Intuitive');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (6,5,'projection');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (1,6,'matrix');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (1,9,'archive');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (4,6,'bottom-line');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (5,12,'impactful');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (3,6,'fresh-thinking');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (4,12,'pricing structure');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (7,5,'client-server');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (7,3,'internet solution');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (5,8,'data-warehouse');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (2,15,'high-level');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (6,14,'homogeneous');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (2,3,'Extended');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (1,10,'Open-architected');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (3,15,'data-warehouse');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (7,8,'next generation');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (6,7,'actuating');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (7,14,'Phased');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (5,6,'Streamlined');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (1,15,'Multi-layered');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (2,6,'User-centric');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (5,10,'Reverse-engineered');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (7,10,'bifurcated');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (2,5,'24 hour');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (3,3,'Proactive');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (1,2,'Public-key');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (3,2,'application');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (5,7,'Organized');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (7,11,'throughput');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (2,4,'Synchronised');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (1,12,'artificial intelligence');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (4,10,'instruction set');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (6,8,'monitoring');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (7,5,'Sharable');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (2,1,'parallelism');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (5,13,'Devolved');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (3,14,'user-facing');
INSERT INTO PlayerCoaches(coachID,p_number,p_notes) VALUES (1,15,'content-based');
