-- Nr. 1:
SELECT min(preis) AS "Minimaler Preis",
		max(preis) AS "Maximaler Preis",
        avg(preis) AS "Durchschnittlicher Preis"
FROM buchung;

-- Nr. 2:
SELECT p.vorname, 
		p.nachname,
        b.preis
FROM passagier p
JOIN buchung b ON b.passagier_id = p.passagier_id
ORDER BY b.preis DESC
LIMIT 1;

-- Nr. 3:
SELECT fl.name AS "Name der Fluglinie",
		avg(b.preis) AS "Durchschnittlicher Preis"
FROM fluglinien fl
JOIN flug f ON f.fluglinie_id = fl.fluglinie_id
JOIN buchung b ON b.flug_id = f.flug_id
GROUP BY fl.name
ORDER BY "Durchschnittlicher Preis"
LIMIT 1;

-- Nr. 4:
SELECT DISTINCT(ft.bezeichnung),
		fz.kapazitaet
FROM flugzeug_typ ft
JOIN flugzeug fz ON fz.typ_id = ft.typ_id
JOIN flug f ON f.flugzeug_id = fz.flugzeug_id
JOIN flughafen fh ON fh.flughafen_id = f.von
WHERE fh.name = "ALTAMIRA"
ORDER BY fz.kapazitaet DESC
LIMIT 5;

-- Nr. 5:
SELECT COUNT(b.passagier_id)
FROM buchung b
JOIN flug f ON f.flug_id = b.flug_id
JOIN fluglinien fl ON fl.fluglinie_id = f.fluglinie_id
WHERE fl.name = "Spain Airlines" AND DATE(f.abflug) BETWEEN "2015-06-06" AND "2015-06-08";

-- Nr. 6:
SELECT DISTINCT(f.flugnr) AS "Flugnummer",
		fz.kapazitaet,
        COUNT(b.buchung_id) AS "Auslastung",
	CASE
		WHEN COUNT(buchung_id) > (fz.kapazitaet * 0.1) THEN "Ja"
        ELSE "Nein"
    END AS "Mehr als 10% ausgelastet?"
FROM flug f
JOIN flugzeug fz ON fz.flugzeug_id = f.flugzeug_id
JOIN buchung b ON b.flug_id = f.flug_id
GROUP BY f.flugnr, fz.kapazitaet;

-- Nr. 7:
SELECT fl.name AS "Fluglinie",
		COUNT(f.nach) AS "Anzahl Anflüge"
FROM fluglinien fl
JOIN flug f ON f.fluglinie_id = fl.fluglinie_id
JOIN flughafen fh ON fh.flughafen_id = f.nach
WHERE fh.name = "KAGOSHIMA"
GROUP BY fl.name;

-- Nr. 8 (Mit Subselects lösen?):
SELECT DISTINCT(fl.name) AS "Fluglinie",
		COUNT(fz.flugzeug_id) AS "Anzahl Flüge",
		ft.bezeichnung AS "Typ"
FROM fluglinien fl
JOIN flugzeug fz ON fz.fluglinie_id = fl.fluglinie_id
JOIN flugzeug_typ ft ON ft.typ_id = fz.typ_id
JOIN flug f ON f.flugzeug_id = fz.flugzeug_id
JOIN flughafen fh ON fh.flughafen_id = fl.heimatflughafen_id
WHERE fh.land = "ITALY"
GROUP BY fl.name, ft.bezeichnung;

-- Nr. 9:
SELECT DISTINCT(ft.bezeichnung) AS "Flugzeug-Typ",
		(COUNT(b.flug_id) / (SELECT COUNT(*) FROM buchung) * 100) AS "Prozentsatz an Buchungen insgesamt"
 FROM flugzeug_typ ft
 JOIN flugzeug fz ON fz.typ_id = ft.typ_id
 JOIN flug f ON f.flugzeug_id = fz.flugzeug_id
 JOIN buchung b ON b.flug_id = f.flug_id
GROUP BY ft.bezeichnung

