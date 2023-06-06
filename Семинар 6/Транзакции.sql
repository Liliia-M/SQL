-- Транзакции

DROP TABLE IF EXISTS bankaccounts;
CREATE TABLE bankaccounts(accountno varchar(20) PRIMARY KEY NOT NULL, funds decimal(8,2));
INSERT INTO bankaccounts VALUES("ACC1", 1000);
INSERT INTO bankaccounts VALUES("ACC2", 1000);

SELECT * 
FROM bankaccounts;

START TRANSACTION;
UPDATE bankaccounts SET funds = funds-100 WHERE accountno  = "ACC1";
UPDATE bankaccounts SET funds = funds+100 WHERE accountno  = "ACC2";
COMMIT;

SELECT * 
FROM bankaccounts;