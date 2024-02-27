-- Nr. 1:
CREATE DATABASE	flughafen_db;

-- Nr. 2:
DROP TABLE IF EXISTS `fluglinien`;

-- Nr. 3:
CREATE TABLE fluglinien (
  `fluglinie_id` int(11) NOT NULL AUTO_INCREMENT,
  `iata_kennung` varchar(10) NOT NULL UNIQUE,
  `name` varchar(50) DEFAULT NULL,
  `heimatflughafen-ID` int(11),
  PRIMARY KEY (`fluglinie_id`),
  FULLTEXT KEY `idx_fulltext` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Nr. 4:
DESCRIBE fluglinien;

-- Nr. 5:
RENAME TABLE buchung_sample TO buchung;

-- Nr. 6:
SHOW TABLES;

-- Nr. 7:
INSERT INTO passagier (passnummer, vorname, nachname)
VALUES ("P139109", "Han", "Solo");

-- Nr. 8:
SELECT * FROM passagier
ORDER BY passagier_id DESC 
LIMIT 1;

-- Nr. 9:
ALTER TABLE passagier
ADD COLUMN `nationalität` varchar(27);

-- Nr. 10:
UPDATE passagier
SET nationalität = "Tatooine"
WHERE passagier_id = 36100;

-- Nr. 11:
ALTER TABLE passagier
DROP COLUMN nationalität;