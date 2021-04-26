--fundera om denna är nödvändig?
CREATE TABLE Users (
email varchar(100) NOT NULL,
uname text NOT NULL,
CONSTRAINT constraintName PRIMARY KEY (email)
);
CREATE TABLE ClockifyUser(
	email varchar(100) NOT NULL,
	workedHours REAL NOT NULL,
	clockID TEXT NOT NULL,
	CONSTRAINT ClockifyPrimaryKey PRIMARY KEY (email),
	CONSTRAINT UniqueUser UNIQUE (email,workedHours), 
	CONSTRAINT foreignKey FOREIGN KEY (email) REFERENCES Users (email)
);
CREATE TABLE LimeGoUser(
	email varchar(100) NOT NULL,
	salesMeetings INTEGER NOT NULL,
	--behöver ej ID annat än email
	--limeID TEXT NOT NULL,
	CONSTRAINT LimeGoPrimaryKey PRIMARY KEY (email),
	CONSTRAINT UniqueUserSales UNIQUE (email,salesMeetings),
	--behövs en reference key till users??
	--CONSTRAINT LimeGoforeignKey FOREIGN KEY (email) REFERENCES Users (email)
);
--la till denna, behöver troligtvis kollas över primary och foreign keys
CREATE TABLE LimeGoEvents(
	position varchar(100) NOT NULL,
	email varchar(100) NOT NULL,
	eventType varchar(100) NOT NULL,
	CONSTRAINT LimeGoEventPrimaryKey PRIMARY KEY (position),
);
CREATE TABLE API (
	APIkey varchar(100) NOT NULL, 
	CONSTRAINT APIPrimaryKey PRIMARY KEY (APIkey)
);
CREATE TABLE Program(
	pname varchar(100) NOT NULL, 
	APIkey varchar(100) NOT NULL UNIQUE,
	CONSTRAINT ProgramPrimaryKey PRIMARY KEY (pname), 
	CONSTRAINT ProgramforeignKey FOREIGN KEY (APIkey) REFERENCES API (APIkey)
);
CREATE TABLE Relation (
	email varchar(100) NOT NULL,
	workedHours REAL NOT NULL, 
	salesMeetings INTEGER NOT NULL,
	CONSTRAINT RelationPrimaryKey PRIMARY KEY (email),
	CONSTRAINT RelationforeignKey FOREIGN KEY (email) REFERENCES Users (email),
	CONSTRAINT RelationforeignKeyOne FOREIGN KEY (email, workedHours) REFERENCES ClockifyUser (email,workedHours),
	CONSTRAINT RelationforeignKeyTwo FOREIGN KEY (email, salesMeetings) REFERENCES LimeGoUser (email,salesMeetings)
);
CREATE TABLE Connections(
	email varchar(100) NOT NULL,
	pname varchar(100) NOT NULL, 
	workedHours REAL NOT NULL,
	salesMeetings INTEGER NOT NULL,
	APIkey varchar(100) NOT NULL, 
	CONSTRAINT ConnectionsPrimaryKey PRIMARY KEY (email,pname),
	CONSTRAINT ConncetionsforeignKey FOREIGN KEY (email) REFERENCES Users (email),
	CONSTRAINT ConnectionsforeignKeyOne FOREIGN KEY (email, workedHours) REFERENCES ClockifyUser (email,workedHours),
	CONSTRAINT ConnectionsforeignKeyTwo FOREIGN KEY (email, salesMeetings) REFERENCES LimeGoUser (email,salesMeetings),
	CONSTRAINT ConnectionsforeignKey FOREIGN KEY (APIkey) REFERENCES Program (APIkey)
);