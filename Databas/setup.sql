--Tables

CREATE TABLE Users(
	email TEXT,
	uname TEXT NOT NULL,
	PRIMARY KEY (email)
);
	
CREATE TABLE ClockifyUser(
	email TEXT,
	workedHours REAL NOT NULL,
	PRIMARY KEY (email), 
	FOREIGN KEY (email) REFERENCES Users (email)
);
	
CREATE TABLE LimeGoUser(
	email TEXT,
	salesMeetings INTEGER NOT NULL,
	PRIMARY KEY (email),
	FOREIGN KEY (email) REFERENCES Users (email)
);

CREATE TABLE API (
	APIkey TEXT, 
	PRIMARY KEY (APIkey)
);
	
CREATE TABLE Program(
	pname TEXT, 
	APIkey TEXT NOT NULL,
	PRIMARY KEY (pname), 
	FOREIGN KEY (APIkey) REFERENCES API (APIkey)
);

CREATE TABLE Relation (
	email TEXT,
	workedHours REAL NOT NULL, 
	salesMeetings INTEGER NOT NULL,
	PRIMARY KEY (email),
	FOREIGN KEY (email) REFERENCES Users (email),
	FOREIGN KEY (workedHours) REFERENCES ClockifyUser(workedHours),
	FOREIGN KEY (salesMeetings) REFERENCES LimeGoUser(salesMeetings)
);

CREATE TABLE Connections(
	email TEXT,
	pname TEXT, 
	workedHours REAL NOT NULL,
	salesMeetings INTEGER NOT NULL,
	APIkey TEXT NOT NULL, 
	PRIMARY KEY (email, pname),
	FOREIGN KEY (email) REFERENCES Users (email),
	FOREIGN KEY (workedHours) REFERENCES ClockifyUser(workedHours),
	FOREIGN KEY (salesMeetings) REFERENCES LimeGoUser(salesMeetings),
	FOREIGN KEY (APIkey) REFERENCES Program (APIkey)
);
	
	
	
	
	
	
	