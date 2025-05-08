CREATE SCHEMA IF NOT EXISTS `League`;
USE `League`;
/*

All Tables' non key attributes depend directly on primary key. They have no transitive dependencies

*/
CREATE TABLE Team (
    Team_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Manager VARCHAR(100),
    Stadium VARCHAR(100)
);

CREATE TABLE Matches (
    Match_ID INT PRIMARY KEY,
    Home_Team_ID INT NOT NULL,
    Away_Team_ID INT NOT NULL,
    Match_Date DATE NOT NULL,
    Score VARCHAR(10),
    FOREIGN KEY (Home_Team_ID) REFERENCES Team(Team_ID),
    FOREIGN KEY (Away_Team_ID) REFERENCES Team(Team_ID)
);

CREATE TABLE Player (
    Player_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Age INT,
    Height INT,
    Weight INT,
    Nationality VARCHAR(50),
    Team_ID INT,
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID)
);

CREATE TABLE Position (
    Player_ID INT PRIMARY KEY,
    Preferred_Position VARCHAR(50),
    Secondary_Position VARCHAR(50),
    FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID)
);

CREATE TABLE Statistics (
    Stat_ID INT AUTO_INCREMENT PRIMARY KEY,
    Player_ID INT NOT NULL,
    Goals_Scored INT DEFAULT 0,
    Assists INT DEFAULT 0,
    Minutes_Played INT DEFAULT 0,
    Pass_Accuracy DECIMAL(5,2),
    Red_Cards INT DEFAULT 0,
    Yellow_Cards INT DEFAULT 0,
    FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID)
);

INSERT INTO Team VALUES (1, 'Manchester United', 'Ruben Amorim', 'Old Trafford');
INSERT INTO Team VALUES (2, 'Manchester City', 'Pep Guardiola', 'Eithad Stadium');
INSERT INTO Team VALUES (3, 'Newcastle United', 'Eddie Howe', 'St James'' Park');
INSERT INTO Team VALUES (4, 'Arsenal', 'Mikael Arteta', 'Emirates Stadium');
INSERT INTO Team VALUES (5, 'Chelsea', 'Enzo Maresca', 'Stamford bridge');
INSERT INTO Team VALUES (6, 'Tottenham Hotspurs', 'Ange Postecoglu', 'Tottenham hotspur Stadium');

INSERT INTO Matches VALUES (101, 1, 2, '2025-04-20', '2-1');
INSERT INTO Matches VALUES (102, 3, 4, '2025-04-20', '2-1');
INSERT INTO Matches VALUES (103, 5, 6, '2025-04-20', '2-1');
INSERT INTO Matches VALUES (104, 5, 4, '2025-04-20', '2-1');
INSERT INTO Matches VALUES (105, 1, 3, '2025-04-20', '2-1');
INSERT INTO Matches VALUES (106, 6, 2, '2025-04-20', '2-1');

INSERT INTO Player (Player_ID, Name, DOB, Height, Weight, Nationality, Team_ID)
VALUES 
(201, 'Amad Dialo', '2000-07-15', 180, 75, 'Ivory Coast', 1),
(202, 'Savinho', '1998-04-20', 175, 70, 'Brazil', 2),
(203, 'Alexander Isak', '2000-07-15', 180, 75, 'Sweden', 3),
(204, 'Bukayo Saka', '2000-07-15', 180, 75, 'England', 4),
(205, 'Cole Palmer', '2000-07-15', 180, 75, 'England', 5),
(206, 'Son Heung Min', '2000-07-15', 180, 75, 'South Korea', 6);

INSERT INTO Position VALUES (201, 'Right Wing', 'Right Wing Back');
INSERT INTO Position VALUES (202, 'Right Wing', 'Central Attacking Midfield');
INSERT INTO Position VALUES (203, 'Striker', 'Left Wing');
INSERT INTO Position VALUES (204, 'Right Wing', 'Left back');
INSERT INTO Position VALUES (205, 'Right Wing', 'Central Attacking Midfield');
INSERT INTO Position VALUES (206, 'Left Wing', 'Striker');

INSERT INTO Statistics (Player_ID, Goals_Scored, Assists, Minutes_Played, Pass_Accuracy, Red_Cards, Yellow_Cards)
VALUES 
(201, 200, 150, 900, 100.0, 0, 0),
(202, 13, 1, 850, 88.2, 1, 2),
(203, 5, 3, 900, 82.5, 0, 1),
(204, 4, 1, 850, 88.2, 1, 2),
(205, 7, 3, 900, 82.5, 0, 1),
(206, 9, 1, 850, 88.2, 1, 2);