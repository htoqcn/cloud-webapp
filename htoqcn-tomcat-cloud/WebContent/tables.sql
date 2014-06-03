CREATE TABLE TD_MAIN (
	TheDate VARCHAR(10) PRIMARY KEY,
	Used BIGINT,
	Idle BIGINT,
	Gain BIGINT,
	ProcessFee BIGINT,
	Interest BIGINT,
	Deposit BIGINT
)

CREATE TABLE SMS_135 (
	ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	Partner VARCHAR(25),
	SendRecv SMALLINT,
	TheTime VARCHAR(20),
	Content VARCHAR(4096),
	Device SMALLINT -- 1: Nokia, 10: BENQ E72
)

CREATE TABLE ACCOUNT_BOOK (
	ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	AddTime VARCHAR(20),
	Amount BIGINT,
	TheDate VARCHAR(10),
	Description VARCHAR(100),
	PayDate VARCHAR(10),
	PayWay SMALLINT,
	Flag SMALLINT
)

CREATE TABLE ACCOUNT_BOOK_EXT (
	ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	MainID INT,
	Amount BIGINT,
	TheDate VARCHAR(10),
	Description VARCHAR(100),
	Delta BIGINT
)

CREATE TABLE SONGS (
	ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	TheName VARCHAR(100),
	UNIQUE (TheName)
)