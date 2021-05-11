USE Konsulttrappan
CREATE TABLE ClockifyUser(
	email varchar(100) NOT NULL,
	workedHours REAL NOT NULL,
	clockID TEXT NOT NULL,
	isITconsultant bit NOT NULL,
	CONSTRAINT ClockifyPrimaryKey PRIMARY KEY (email),
	CONSTRAINT UniqueUser UNIQUE (email,workedHours,isITconsultant), 
);
CREATE TABLE LimeGoUser(
	email varchar(100) NOT NULL,
	salesMeetings INTEGER NOT NULL,
	CONSTRAINT LimeGoPrimaryKey PRIMARY KEY (email),
	CONSTRAINT UniqueUserSales UNIQUE (email,salesMeetings),
);
--la till denna, behöver troligtvis kollas över primary och foreign keys
CREATE TABLE LimeGoEvents(
	position varchar(100) NOT NULL,
	email varchar(100) NOT NULL,
	eventType varchar(100) NOT NULL,
	CONSTRAINT LimeGoEventPrimaryKey PRIMARY KEY (position),
);

CREATE TABLE API(
	pname varchar(100) NOT NULL, 
	APIkey varchar(100) NOT NULL UNIQUE,
	CONSTRAINT ProgramPrimaryKey PRIMARY KEY (pname)
); 
CREATE TABLE Relation (
	email varchar(100) NOT NULL,
	workedHours REAL NOT NULL, 
	salesMeetings INTEGER NOT NULL,
	isITconsultant bit NOT NULL,
	CONSTRAINT RelationPrimaryKey PRIMARY KEY (email),
	--CONSTRAINT RelationforeignKeyOne FOREIGN KEY (email, workedHours,isITconsultant) REFERENCES ClockifyUser (email,workedHours, isITconsultant),
	--CONSTRAINT RelationforeignKeyTwo FOREIGN KEY (email, salesMeetings) REFERENCES LimeGoUser (email, salesMeetings)
);
