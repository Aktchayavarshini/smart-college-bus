-- SYNTHETIC TRANSPORT NETWORK FOR TESTING ONLY
-- Campus location assumption: Sriperumbudur, Tamil Nadu (placeholder; confirm actual institution before production use).
-- Localities are based on the Sriperumbudur / Chennai west corridor. Route permutations and timings are synthetic, not official transit schedules.
-- Adds one college, 146 feeder routes with 8:00, 15:00, 17:00 departures,
-- one main route with 50 buses at 10:00 and 12:00, plus stops, route sequences,
-- drivers and a rolling 30-day trip calendar. Does not modify/delete existing rows.
USE CollegeBusDB;

CREATE TABLE IF NOT EXISTS colleges (
 college_id BIGINT AUTO_INCREMENT PRIMARY KEY,
 college_code VARCHAR(40) NOT NULL UNIQUE,
 college_name VARCHAR(180) NOT NULL,
 campus_name VARCHAR(120) NOT NULL,
 address VARCHAR(255) NOT NULL,
 city VARCHAR(100) NOT NULL,
 state VARCHAR(100) NOT NULL,
 is_synthetic TINYINT(1) NOT NULL DEFAULT 1,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT IGNORE INTO colleges (college_code,college_name,campus_name,address,city,state,is_synthetic)
VALUES ('SYN-SRP-001','Synthetic Engineering College','Sriperumbudur Main Campus','Synthetic campus address, Sriperumbudur','Sriperumbudur','Tamil Nadu',1);

INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Sriperumbudur Bus Stop','Synthetic pickup/drop-off point for campus transport','Sriperumbudur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Sriperumbudur Bus Stop' AND area='Sriperumbudur');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Sunguvarchatram Bus Stop','Synthetic pickup/drop-off point for campus transport','Sunguvarchatram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Sunguvarchatram Bus Stop' AND area='Sunguvarchatram');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Irungattukottai Bus Stop','Synthetic pickup/drop-off point for campus transport','Irungattukottai','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Irungattukottai Bus Stop' AND area='Irungattukottai');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'SIPCOT Bus Stop','Synthetic pickup/drop-off point for campus transport','SIPCOT','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='SIPCOT Bus Stop' AND area='SIPCOT');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Pennalur Bus Stop','Synthetic pickup/drop-off point for campus transport','Pennalur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Pennalur Bus Stop' AND area='Pennalur');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Pillaipakkam Bus Stop','Synthetic pickup/drop-off point for campus transport','Pillaipakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Pillaipakkam Bus Stop' AND area='Pillaipakkam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Thandalam Bus Stop','Synthetic pickup/drop-off point for campus transport','Thandalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Thandalam Bus Stop' AND area='Thandalam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Chettipedu Bus Stop','Synthetic pickup/drop-off point for campus transport','Chettipedu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Chettipedu Bus Stop' AND area='Chettipedu');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Queensland Bus Stop','Synthetic pickup/drop-off point for campus transport','Queensland','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Queensland Bus Stop' AND area='Queensland');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Pappanchatram Bus Stop','Synthetic pickup/drop-off point for campus transport','Pappanchatram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Pappanchatram Bus Stop' AND area='Pappanchatram');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Chembarambakkam Bus Stop','Synthetic pickup/drop-off point for campus transport','Chembarambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Chembarambakkam Bus Stop' AND area='Chembarambakkam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Nazarathpet Bus Stop','Synthetic pickup/drop-off point for campus transport','Nazarathpet','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Nazarathpet Bus Stop' AND area='Nazarathpet');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Poonamallee Bus Stop','Synthetic pickup/drop-off point for campus transport','Poonamallee','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Poonamallee Bus Stop' AND area='Poonamallee');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Kumananchavadi Bus Stop','Synthetic pickup/drop-off point for campus transport','Kumananchavadi','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Kumananchavadi Bus Stop' AND area='Kumananchavadi');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Kattupakkam Bus Stop','Synthetic pickup/drop-off point for campus transport','Kattupakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Kattupakkam Bus Stop' AND area='Kattupakkam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Iyyappanthangal Bus Stop','Synthetic pickup/drop-off point for campus transport','Iyyappanthangal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Iyyappanthangal Bus Stop' AND area='Iyyappanthangal');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Porur Bus Stop','Synthetic pickup/drop-off point for campus transport','Porur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Porur Bus Stop' AND area='Porur');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Mugalivakkam Bus Stop','Synthetic pickup/drop-off point for campus transport','Mugalivakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Mugalivakkam Bus Stop' AND area='Mugalivakkam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Ramapuram Bus Stop','Synthetic pickup/drop-off point for campus transport','Ramapuram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Ramapuram Bus Stop' AND area='Ramapuram');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Guindy Bus Stop','Synthetic pickup/drop-off point for campus transport','Guindy','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Guindy Bus Stop' AND area='Guindy');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Kathipara Bus Stop','Synthetic pickup/drop-off point for campus transport','Kathipara','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Kathipara Bus Stop' AND area='Kathipara');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Vadapalani Bus Stop','Synthetic pickup/drop-off point for campus transport','Vadapalani','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Vadapalani Bus Stop' AND area='Vadapalani');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Valasaravakkam Bus Stop','Synthetic pickup/drop-off point for campus transport','Valasaravakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Valasaravakkam Bus Stop' AND area='Valasaravakkam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Kundrathur Bus Stop','Synthetic pickup/drop-off point for campus transport','Kundrathur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Kundrathur Bus Stop' AND area='Kundrathur');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Mangadu Bus Stop','Synthetic pickup/drop-off point for campus transport','Mangadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Mangadu Bus Stop' AND area='Mangadu');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Somangalam Bus Stop','Synthetic pickup/drop-off point for campus transport','Somangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Somangalam Bus Stop' AND area='Somangalam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Manimangalam Bus Stop','Synthetic pickup/drop-off point for campus transport','Manimangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Manimangalam Bus Stop' AND area='Manimangalam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Mudichur Bus Stop','Synthetic pickup/drop-off point for campus transport','Mudichur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Mudichur Bus Stop' AND area='Mudichur');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Perungalathur Bus Stop','Synthetic pickup/drop-off point for campus transport','Perungalathur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Perungalathur Bus Stop' AND area='Perungalathur');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Tambaram Bus Stop','Synthetic pickup/drop-off point for campus transport','Tambaram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Tambaram Bus Stop' AND area='Tambaram');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Vandalur Bus Stop','Synthetic pickup/drop-off point for campus transport','Vandalur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Vandalur Bus Stop' AND area='Vandalur');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Padappai Bus Stop','Synthetic pickup/drop-off point for campus transport','Padappai','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Padappai Bus Stop' AND area='Padappai');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Mannivakkam Bus Stop','Synthetic pickup/drop-off point for campus transport','Mannivakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Mannivakkam Bus Stop' AND area='Mannivakkam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Kilambakkam Bus Stop','Synthetic pickup/drop-off point for campus transport','Kilambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Kilambakkam Bus Stop' AND area='Kilambakkam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Urapakkam Bus Stop','Synthetic pickup/drop-off point for campus transport','Urapakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Urapakkam Bus Stop' AND area='Urapakkam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Guduvancheri Bus Stop','Synthetic pickup/drop-off point for campus transport','Guduvancheri','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Guduvancheri Bus Stop' AND area='Guduvancheri');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Maraimalai Nagar Bus Stop','Synthetic pickup/drop-off point for campus transport','Maraimalai Nagar','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Maraimalai Nagar Bus Stop' AND area='Maraimalai Nagar');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Singaperumal Koil Bus Stop','Synthetic pickup/drop-off point for campus transport','Singaperumal Koil','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Singaperumal Koil Bus Stop' AND area='Singaperumal Koil');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Oragadam Bus Stop','Synthetic pickup/drop-off point for campus transport','Oragadam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Oragadam Bus Stop' AND area='Oragadam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Vallam Bus Stop','Synthetic pickup/drop-off point for campus transport','Vallam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Vallam Bus Stop' AND area='Vallam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Vallakottai Bus Stop','Synthetic pickup/drop-off point for campus transport','Vallakottai','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Vallakottai Bus Stop' AND area='Vallakottai');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Sengadu Bus Stop','Synthetic pickup/drop-off point for campus transport','Sengadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Sengadu Bus Stop' AND area='Sengadu');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Thirumangalam Bus Stop','Synthetic pickup/drop-off point for campus transport','Thirumangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Thirumangalam Bus Stop' AND area='Thirumangalam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Thodukadu Bus Stop','Synthetic pickup/drop-off point for campus transport','Thodukadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Thodukadu Bus Stop' AND area='Thodukadu');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Mambakkam Bus Stop','Synthetic pickup/drop-off point for campus transport','Mambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Mambakkam Bus Stop' AND area='Mambakkam');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Manur Bus Stop','Synthetic pickup/drop-off point for campus transport','Manur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Manur Bus Stop' AND area='Manur');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Karanthangal Bus Stop','Synthetic pickup/drop-off point for campus transport','Karanthangal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Karanthangal Bus Stop' AND area='Karanthangal');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Beemanthangal Bus Stop','Synthetic pickup/drop-off point for campus transport','Beemanthangal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Beemanthangal Bus Stop' AND area='Beemanthangal');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Vadakal Bus Stop','Synthetic pickup/drop-off point for campus transport','Vadakal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Vadakal Bus Stop' AND area='Vadakal');
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Sunguvarchatram East Bus Stop','Synthetic pickup/drop-off point for campus transport','Sunguvarchatram East','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Sunguvarchatram East Bus Stop' AND area='Sunguvarchatram East');

-- One campus arrival/departure stop
INSERT INTO bus_stops (stop_name,location_description,area,stop_status)
SELECT 'Synthetic Engineering College Main Gate','Synthetic campus pickup/drop-off','Sriperumbudur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM bus_stops WHERE stop_name='Synthetic Engineering College Main Gate' AND area='Sriperumbudur');

INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-001','Sriperumbudur','Synthetic Engineering College','Synthetic test feeder via Sriperumbudur and Ramapuram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-001');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-002','Sunguvarchatram','Synthetic Engineering College','Synthetic test feeder via Sunguvarchatram and Somangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-002');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-003','Irungattukottai','Synthetic Engineering College','Synthetic test feeder via Irungattukottai and Mannivakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-003');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-004','SIPCOT','Synthetic Engineering College','Synthetic test feeder via SIPCOT and Vallam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-004');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-005','Pennalur','Synthetic Engineering College','Synthetic test feeder via Pennalur and Karanthangal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-005');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-006','Pillaipakkam','Synthetic Engineering College','Synthetic test feeder via Pillaipakkam and SIPCOT','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-006');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-007','Thandalam','Synthetic Engineering College','Synthetic test feeder via Thandalam and Chembarambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-007');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-008','Chettipedu','Synthetic Engineering College','Synthetic test feeder via Chettipedu and Mugalivakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-008');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-009','Queensland','Synthetic Engineering College','Synthetic test feeder via Queensland and Mangadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-009');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-010','Pappanchatram','Synthetic Engineering College','Synthetic test feeder via Pappanchatram and Padappai','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-010');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-011','Chembarambakkam','Synthetic Engineering College','Synthetic test feeder via Chembarambakkam and Oragadam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-011');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-012','Nazarathpet','Synthetic Engineering College','Synthetic test feeder via Nazarathpet and Manur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-012');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-013','Poonamallee','Synthetic Engineering College','Synthetic test feeder via Poonamallee and Irungattukottai','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-013');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-014','Kumananchavadi','Synthetic Engineering College','Synthetic test feeder via Kumananchavadi and Pappanchatram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-014');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-015','Kattupakkam','Synthetic Engineering College','Synthetic test feeder via Kattupakkam and Porur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-015');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-016','Iyyappanthangal','Synthetic Engineering College','Synthetic test feeder via Iyyappanthangal and Kundrathur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-016');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-017','Porur','Synthetic Engineering College','Synthetic test feeder via Porur and Vandalur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-017');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-018','Mugalivakkam','Synthetic Engineering College','Synthetic test feeder via Mugalivakkam and Singaperumal Koil','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-018');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-019','Ramapuram','Synthetic Engineering College','Synthetic test feeder via Ramapuram and Mambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-019');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-020','Guindy','Synthetic Engineering College','Synthetic test feeder via Guindy and Sunguvarchatram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-020');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-021','Kathipara','Synthetic Engineering College','Synthetic test feeder via Kathipara and Queensland','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-021');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-022','Vadapalani','Synthetic Engineering College','Synthetic test feeder via Vadapalani and Iyyappanthangal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-022');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-023','Valasaravakkam','Synthetic Engineering College','Synthetic test feeder via Valasaravakkam and Valasaravakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-023');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-024','Kundrathur','Synthetic Engineering College','Synthetic test feeder via Kundrathur and Tambaram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-024');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-025','Mangadu','Synthetic Engineering College','Synthetic test feeder via Mangadu and Maraimalai Nagar','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-025');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-026','Somangalam','Synthetic Engineering College','Synthetic test feeder via Somangalam and Thodukadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-026');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-027','Manimangalam','Synthetic Engineering College','Synthetic test feeder via Manimangalam and Sriperumbudur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-027');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-028','Mudichur','Synthetic Engineering College','Synthetic test feeder via Mudichur and Chettipedu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-028');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-029','Perungalathur','Synthetic Engineering College','Synthetic test feeder via Perungalathur and Kattupakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-029');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-030','Tambaram','Synthetic Engineering College','Synthetic test feeder via Tambaram and Vadapalani','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-030');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-031','Vandalur','Synthetic Engineering College','Synthetic test feeder via Vandalur and Perungalathur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-031');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-032','Padappai','Synthetic Engineering College','Synthetic test feeder via Padappai and Guduvancheri','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-032');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-033','Mannivakkam','Synthetic Engineering College','Synthetic test feeder via Mannivakkam and Thirumangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-033');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-034','Kilambakkam','Synthetic Engineering College','Synthetic test feeder via Kilambakkam and Sunguvarchatram East','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-034');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-035','Urapakkam','Synthetic Engineering College','Synthetic test feeder via Urapakkam and Thandalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-035');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-036','Guduvancheri','Synthetic Engineering College','Synthetic test feeder via Guduvancheri and Kumananchavadi','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-036');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-037','Maraimalai Nagar','Synthetic Engineering College','Synthetic test feeder via Maraimalai Nagar and Kathipara','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-037');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-038','Singaperumal Koil','Synthetic Engineering College','Synthetic test feeder via Singaperumal Koil and Mudichur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-038');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-039','Oragadam','Synthetic Engineering College','Synthetic test feeder via Oragadam and Urapakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-039');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-040','Vallam','Synthetic Engineering College','Synthetic test feeder via Vallam and Sengadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-040');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-041','Vallakottai','Synthetic Engineering College','Synthetic test feeder via Vallakottai and Vadakal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-041');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-042','Sengadu','Synthetic Engineering College','Synthetic test feeder via Sengadu and Pillaipakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-042');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-043','Thirumangalam','Synthetic Engineering College','Synthetic test feeder via Thirumangalam and Poonamallee','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-043');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-044','Thodukadu','Synthetic Engineering College','Synthetic test feeder via Thodukadu and Guindy','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-044');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-045','Mambakkam','Synthetic Engineering College','Synthetic test feeder via Mambakkam and Manimangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-045');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-046','Manur','Synthetic Engineering College','Synthetic test feeder via Manur and Kilambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-046');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-047','Karanthangal','Synthetic Engineering College','Synthetic test feeder via Karanthangal and Vallakottai','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-047');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-048','Beemanthangal','Synthetic Engineering College','Synthetic test feeder via Beemanthangal and Beemanthangal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-048');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-049','Vadakal','Synthetic Engineering College','Synthetic test feeder via Vadakal and Pennalur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-049');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-050','Sunguvarchatram East','Synthetic Engineering College','Synthetic test feeder via Sunguvarchatram East and Nazarathpet','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-050');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-051','Sriperumbudur','Synthetic Engineering College','Synthetic test feeder via Sriperumbudur and Ramapuram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-051');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-052','Sunguvarchatram','Synthetic Engineering College','Synthetic test feeder via Sunguvarchatram and Somangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-052');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-053','Irungattukottai','Synthetic Engineering College','Synthetic test feeder via Irungattukottai and Mannivakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-053');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-054','SIPCOT','Synthetic Engineering College','Synthetic test feeder via SIPCOT and Vallam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-054');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-055','Pennalur','Synthetic Engineering College','Synthetic test feeder via Pennalur and Karanthangal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-055');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-056','Pillaipakkam','Synthetic Engineering College','Synthetic test feeder via Pillaipakkam and SIPCOT','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-056');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-057','Thandalam','Synthetic Engineering College','Synthetic test feeder via Thandalam and Chembarambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-057');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-058','Chettipedu','Synthetic Engineering College','Synthetic test feeder via Chettipedu and Mugalivakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-058');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-059','Queensland','Synthetic Engineering College','Synthetic test feeder via Queensland and Mangadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-059');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-060','Pappanchatram','Synthetic Engineering College','Synthetic test feeder via Pappanchatram and Padappai','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-060');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-061','Chembarambakkam','Synthetic Engineering College','Synthetic test feeder via Chembarambakkam and Oragadam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-061');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-062','Nazarathpet','Synthetic Engineering College','Synthetic test feeder via Nazarathpet and Manur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-062');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-063','Poonamallee','Synthetic Engineering College','Synthetic test feeder via Poonamallee and Irungattukottai','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-063');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-064','Kumananchavadi','Synthetic Engineering College','Synthetic test feeder via Kumananchavadi and Pappanchatram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-064');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-065','Kattupakkam','Synthetic Engineering College','Synthetic test feeder via Kattupakkam and Porur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-065');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-066','Iyyappanthangal','Synthetic Engineering College','Synthetic test feeder via Iyyappanthangal and Kundrathur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-066');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-067','Porur','Synthetic Engineering College','Synthetic test feeder via Porur and Vandalur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-067');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-068','Mugalivakkam','Synthetic Engineering College','Synthetic test feeder via Mugalivakkam and Singaperumal Koil','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-068');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-069','Ramapuram','Synthetic Engineering College','Synthetic test feeder via Ramapuram and Mambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-069');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-070','Guindy','Synthetic Engineering College','Synthetic test feeder via Guindy and Sunguvarchatram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-070');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-071','Kathipara','Synthetic Engineering College','Synthetic test feeder via Kathipara and Queensland','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-071');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-072','Vadapalani','Synthetic Engineering College','Synthetic test feeder via Vadapalani and Iyyappanthangal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-072');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-073','Valasaravakkam','Synthetic Engineering College','Synthetic test feeder via Valasaravakkam and Valasaravakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-073');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-074','Kundrathur','Synthetic Engineering College','Synthetic test feeder via Kundrathur and Tambaram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-074');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-075','Mangadu','Synthetic Engineering College','Synthetic test feeder via Mangadu and Maraimalai Nagar','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-075');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-076','Somangalam','Synthetic Engineering College','Synthetic test feeder via Somangalam and Thodukadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-076');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-077','Manimangalam','Synthetic Engineering College','Synthetic test feeder via Manimangalam and Sriperumbudur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-077');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-078','Mudichur','Synthetic Engineering College','Synthetic test feeder via Mudichur and Chettipedu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-078');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-079','Perungalathur','Synthetic Engineering College','Synthetic test feeder via Perungalathur and Kattupakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-079');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-080','Tambaram','Synthetic Engineering College','Synthetic test feeder via Tambaram and Vadapalani','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-080');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-081','Vandalur','Synthetic Engineering College','Synthetic test feeder via Vandalur and Perungalathur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-081');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-082','Padappai','Synthetic Engineering College','Synthetic test feeder via Padappai and Guduvancheri','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-082');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-083','Mannivakkam','Synthetic Engineering College','Synthetic test feeder via Mannivakkam and Thirumangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-083');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-084','Kilambakkam','Synthetic Engineering College','Synthetic test feeder via Kilambakkam and Sunguvarchatram East','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-084');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-085','Urapakkam','Synthetic Engineering College','Synthetic test feeder via Urapakkam and Thandalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-085');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-086','Guduvancheri','Synthetic Engineering College','Synthetic test feeder via Guduvancheri and Kumananchavadi','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-086');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-087','Maraimalai Nagar','Synthetic Engineering College','Synthetic test feeder via Maraimalai Nagar and Kathipara','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-087');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-088','Singaperumal Koil','Synthetic Engineering College','Synthetic test feeder via Singaperumal Koil and Mudichur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-088');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-089','Oragadam','Synthetic Engineering College','Synthetic test feeder via Oragadam and Urapakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-089');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-090','Vallam','Synthetic Engineering College','Synthetic test feeder via Vallam and Sengadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-090');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-091','Vallakottai','Synthetic Engineering College','Synthetic test feeder via Vallakottai and Vadakal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-091');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-092','Sengadu','Synthetic Engineering College','Synthetic test feeder via Sengadu and Pillaipakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-092');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-093','Thirumangalam','Synthetic Engineering College','Synthetic test feeder via Thirumangalam and Poonamallee','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-093');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-094','Thodukadu','Synthetic Engineering College','Synthetic test feeder via Thodukadu and Guindy','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-094');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-095','Mambakkam','Synthetic Engineering College','Synthetic test feeder via Mambakkam and Manimangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-095');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-096','Manur','Synthetic Engineering College','Synthetic test feeder via Manur and Kilambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-096');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-097','Karanthangal','Synthetic Engineering College','Synthetic test feeder via Karanthangal and Vallakottai','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-097');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-098','Beemanthangal','Synthetic Engineering College','Synthetic test feeder via Beemanthangal and Beemanthangal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-098');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-099','Vadakal','Synthetic Engineering College','Synthetic test feeder via Vadakal and Pennalur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-099');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-100','Sunguvarchatram East','Synthetic Engineering College','Synthetic test feeder via Sunguvarchatram East and Nazarathpet','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-100');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-101','Sriperumbudur','Synthetic Engineering College','Synthetic test feeder via Sriperumbudur and Ramapuram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-101');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-102','Sunguvarchatram','Synthetic Engineering College','Synthetic test feeder via Sunguvarchatram and Somangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-102');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-103','Irungattukottai','Synthetic Engineering College','Synthetic test feeder via Irungattukottai and Mannivakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-103');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-104','SIPCOT','Synthetic Engineering College','Synthetic test feeder via SIPCOT and Vallam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-104');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-105','Pennalur','Synthetic Engineering College','Synthetic test feeder via Pennalur and Karanthangal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-105');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-106','Pillaipakkam','Synthetic Engineering College','Synthetic test feeder via Pillaipakkam and SIPCOT','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-106');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-107','Thandalam','Synthetic Engineering College','Synthetic test feeder via Thandalam and Chembarambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-107');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-108','Chettipedu','Synthetic Engineering College','Synthetic test feeder via Chettipedu and Mugalivakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-108');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-109','Queensland','Synthetic Engineering College','Synthetic test feeder via Queensland and Mangadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-109');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-110','Pappanchatram','Synthetic Engineering College','Synthetic test feeder via Pappanchatram and Padappai','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-110');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-111','Chembarambakkam','Synthetic Engineering College','Synthetic test feeder via Chembarambakkam and Oragadam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-111');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-112','Nazarathpet','Synthetic Engineering College','Synthetic test feeder via Nazarathpet and Manur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-112');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-113','Poonamallee','Synthetic Engineering College','Synthetic test feeder via Poonamallee and Irungattukottai','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-113');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-114','Kumananchavadi','Synthetic Engineering College','Synthetic test feeder via Kumananchavadi and Pappanchatram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-114');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-115','Kattupakkam','Synthetic Engineering College','Synthetic test feeder via Kattupakkam and Porur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-115');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-116','Iyyappanthangal','Synthetic Engineering College','Synthetic test feeder via Iyyappanthangal and Kundrathur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-116');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-117','Porur','Synthetic Engineering College','Synthetic test feeder via Porur and Vandalur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-117');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-118','Mugalivakkam','Synthetic Engineering College','Synthetic test feeder via Mugalivakkam and Singaperumal Koil','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-118');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-119','Ramapuram','Synthetic Engineering College','Synthetic test feeder via Ramapuram and Mambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-119');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-120','Guindy','Synthetic Engineering College','Synthetic test feeder via Guindy and Sunguvarchatram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-120');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-121','Kathipara','Synthetic Engineering College','Synthetic test feeder via Kathipara and Queensland','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-121');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-122','Vadapalani','Synthetic Engineering College','Synthetic test feeder via Vadapalani and Iyyappanthangal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-122');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-123','Valasaravakkam','Synthetic Engineering College','Synthetic test feeder via Valasaravakkam and Valasaravakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-123');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-124','Kundrathur','Synthetic Engineering College','Synthetic test feeder via Kundrathur and Tambaram','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-124');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-125','Mangadu','Synthetic Engineering College','Synthetic test feeder via Mangadu and Maraimalai Nagar','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-125');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-126','Somangalam','Synthetic Engineering College','Synthetic test feeder via Somangalam and Thodukadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-126');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-127','Manimangalam','Synthetic Engineering College','Synthetic test feeder via Manimangalam and Sriperumbudur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-127');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-128','Mudichur','Synthetic Engineering College','Synthetic test feeder via Mudichur and Chettipedu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-128');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-129','Perungalathur','Synthetic Engineering College','Synthetic test feeder via Perungalathur and Kattupakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-129');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-130','Tambaram','Synthetic Engineering College','Synthetic test feeder via Tambaram and Vadapalani','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-130');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-131','Vandalur','Synthetic Engineering College','Synthetic test feeder via Vandalur and Perungalathur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-131');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-132','Padappai','Synthetic Engineering College','Synthetic test feeder via Padappai and Guduvancheri','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-132');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-133','Mannivakkam','Synthetic Engineering College','Synthetic test feeder via Mannivakkam and Thirumangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-133');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-134','Kilambakkam','Synthetic Engineering College','Synthetic test feeder via Kilambakkam and Sunguvarchatram East','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-134');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-135','Urapakkam','Synthetic Engineering College','Synthetic test feeder via Urapakkam and Thandalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-135');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-136','Guduvancheri','Synthetic Engineering College','Synthetic test feeder via Guduvancheri and Kumananchavadi','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-136');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-137','Maraimalai Nagar','Synthetic Engineering College','Synthetic test feeder via Maraimalai Nagar and Kathipara','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-137');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-138','Singaperumal Koil','Synthetic Engineering College','Synthetic test feeder via Singaperumal Koil and Mudichur','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-138');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-139','Oragadam','Synthetic Engineering College','Synthetic test feeder via Oragadam and Urapakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-139');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-140','Vallam','Synthetic Engineering College','Synthetic test feeder via Vallam and Sengadu','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-140');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-141','Vallakottai','Synthetic Engineering College','Synthetic test feeder via Vallakottai and Vadakal','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-141');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-142','Sengadu','Synthetic Engineering College','Synthetic test feeder via Sengadu and Pillaipakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-142');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-143','Thirumangalam','Synthetic Engineering College','Synthetic test feeder via Thirumangalam and Poonamallee','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-143');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-144','Thodukadu','Synthetic Engineering College','Synthetic test feeder via Thodukadu and Guindy','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-144');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-145','Mambakkam','Synthetic Engineering College','Synthetic test feeder via Mambakkam and Manimangalam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-145');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-FEEDER-146','Manur','Synthetic Engineering College','Synthetic test feeder via Manur and Kilambakkam','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-FEEDER-146');
INSERT INTO routes (route_name,source,destination,route_description,route_status)
SELECT 'SRP-MAIN-001','Chennai West Corridor','Synthetic Engineering College','Synthetic main corridor route serving pooled buses','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM routes WHERE route_name='SRP-MAIN-001');

INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-001','TN-SYN-0001',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-001');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-002','TN-SYN-0002',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-002');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-003','TN-SYN-0003',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-003');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-004','TN-SYN-0004',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-004');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-005','TN-SYN-0005',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-005');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-006','TN-SYN-0006',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-006');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-007','TN-SYN-0007',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-007');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-008','TN-SYN-0008',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-008');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-009','TN-SYN-0009',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-009');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-010','TN-SYN-0010',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-010');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-011','TN-SYN-0011',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-011');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-012','TN-SYN-0012',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-012');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-013','TN-SYN-0013',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-013');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-014','TN-SYN-0014',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-014');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-015','TN-SYN-0015',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-015');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-016','TN-SYN-0016',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-016');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-017','TN-SYN-0017',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-017');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-018','TN-SYN-0018',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-018');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-019','TN-SYN-0019',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-019');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-020','TN-SYN-0020',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-020');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-021','TN-SYN-0021',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-021');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-022','TN-SYN-0022',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-022');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-023','TN-SYN-0023',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-023');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-024','TN-SYN-0024',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-024');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-025','TN-SYN-0025',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-025');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-026','TN-SYN-0026',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-026');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-027','TN-SYN-0027',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-027');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-028','TN-SYN-0028',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-028');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-029','TN-SYN-0029',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-029');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-030','TN-SYN-0030',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-030');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-031','TN-SYN-0031',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-031');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-032','TN-SYN-0032',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-032');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-033','TN-SYN-0033',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-033');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-034','TN-SYN-0034',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-034');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-035','TN-SYN-0035',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-035');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-036','TN-SYN-0036',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-036');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-037','TN-SYN-0037',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-037');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-038','TN-SYN-0038',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-038');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-039','TN-SYN-0039',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-039');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-040','TN-SYN-0040',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-040');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-041','TN-SYN-0041',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-041');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-042','TN-SYN-0042',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-042');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-043','TN-SYN-0043',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-043');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-044','TN-SYN-0044',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-044');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-045','TN-SYN-0045',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-045');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-046','TN-SYN-0046',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-046');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-047','TN-SYN-0047',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-047');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-048','TN-SYN-0048',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-048');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-049','TN-SYN-0049',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-049');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-050','TN-SYN-0050',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-050');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-051','TN-SYN-0051',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-051');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-052','TN-SYN-0052',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-052');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-053','TN-SYN-0053',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-053');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-054','TN-SYN-0054',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-054');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-055','TN-SYN-0055',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-055');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-056','TN-SYN-0056',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-056');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-057','TN-SYN-0057',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-057');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-058','TN-SYN-0058',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-058');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-059','TN-SYN-0059',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-059');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-060','TN-SYN-0060',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-060');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-061','TN-SYN-0061',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-061');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-062','TN-SYN-0062',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-062');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-063','TN-SYN-0063',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-063');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-064','TN-SYN-0064',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-064');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-065','TN-SYN-0065',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-065');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-066','TN-SYN-0066',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-066');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-067','TN-SYN-0067',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-067');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-068','TN-SYN-0068',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-068');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-069','TN-SYN-0069',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-069');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-070','TN-SYN-0070',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-070');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-071','TN-SYN-0071',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-071');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-072','TN-SYN-0072',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-072');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-073','TN-SYN-0073',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-073');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-074','TN-SYN-0074',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-074');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-075','TN-SYN-0075',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-075');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-076','TN-SYN-0076',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-076');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-077','TN-SYN-0077',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-077');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-078','TN-SYN-0078',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-078');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-079','TN-SYN-0079',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-079');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-080','TN-SYN-0080',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-080');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-081','TN-SYN-0081',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-081');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-082','TN-SYN-0082',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-082');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-083','TN-SYN-0083',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-083');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-084','TN-SYN-0084',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-084');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-085','TN-SYN-0085',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-085');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-086','TN-SYN-0086',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-086');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-087','TN-SYN-0087',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-087');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-088','TN-SYN-0088',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-088');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-089','TN-SYN-0089',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-089');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-090','TN-SYN-0090',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-090');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-091','TN-SYN-0091',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-091');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-092','TN-SYN-0092',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-092');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-093','TN-SYN-0093',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-093');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-094','TN-SYN-0094',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-094');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-095','TN-SYN-0095',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-095');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-096','TN-SYN-0096',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-096');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-097','TN-SYN-0097',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-097');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-098','TN-SYN-0098',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-098');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-099','TN-SYN-0099',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-099');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-100','TN-SYN-0100',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-100');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-101','TN-SYN-0101',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-101');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-102','TN-SYN-0102',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-102');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-103','TN-SYN-0103',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-103');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-104','TN-SYN-0104',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-104');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-105','TN-SYN-0105',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-105');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-106','TN-SYN-0106',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-106');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-107','TN-SYN-0107',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-107');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-108','TN-SYN-0108',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-108');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-109','TN-SYN-0109',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-109');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-110','TN-SYN-0110',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-110');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-111','TN-SYN-0111',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-111');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-112','TN-SYN-0112',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-112');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-113','TN-SYN-0113',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-113');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-114','TN-SYN-0114',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-114');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-115','TN-SYN-0115',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-115');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-116','TN-SYN-0116',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-116');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-117','TN-SYN-0117',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-117');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-118','TN-SYN-0118',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-118');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-119','TN-SYN-0119',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-119');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-120','TN-SYN-0120',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-120');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-121','TN-SYN-0121',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-121');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-122','TN-SYN-0122',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-122');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-123','TN-SYN-0123',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-123');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-124','TN-SYN-0124',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-124');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-125','TN-SYN-0125',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-125');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-126','TN-SYN-0126',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-126');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-127','TN-SYN-0127',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-127');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-128','TN-SYN-0128',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-128');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-129','TN-SYN-0129',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-129');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-130','TN-SYN-0130',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-130');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-131','TN-SYN-0131',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-131');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-132','TN-SYN-0132',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-132');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-133','TN-SYN-0133',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-133');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-134','TN-SYN-0134',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-134');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-135','TN-SYN-0135',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-135');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-136','TN-SYN-0136',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-136');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-137','TN-SYN-0137',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-137');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-138','TN-SYN-0138',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-138');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-139','TN-SYN-0139',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-139');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-140','TN-SYN-0140',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-140');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-141','TN-SYN-0141',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-141');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-142','TN-SYN-0142',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-142');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-143','TN-SYN-0143',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-143');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-144','TN-SYN-0144',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-144');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-145','TN-SYN-0145',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-145');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-146','TN-SYN-0146',40,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-146');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-147','TN-SYN-0147',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-147');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-148','TN-SYN-0148',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-148');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-149','TN-SYN-0149',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-149');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-150','TN-SYN-0150',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-150');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-151','TN-SYN-0151',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-151');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-152','TN-SYN-0152',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-152');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-153','TN-SYN-0153',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-153');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-154','TN-SYN-0154',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-154');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-155','TN-SYN-0155',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-155');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-156','TN-SYN-0156',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-156');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-157','TN-SYN-0157',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-157');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-158','TN-SYN-0158',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-158');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-159','TN-SYN-0159',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-159');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-160','TN-SYN-0160',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-160');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-161','TN-SYN-0161',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-161');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-162','TN-SYN-0162',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-162');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-163','TN-SYN-0163',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-163');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-164','TN-SYN-0164',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-164');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-165','TN-SYN-0165',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-165');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-166','TN-SYN-0166',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-166');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-167','TN-SYN-0167',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-167');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-168','TN-SYN-0168',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-168');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-169','TN-SYN-0169',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-169');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-170','TN-SYN-0170',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-170');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-171','TN-SYN-0171',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-171');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-172','TN-SYN-0172',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-172');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-173','TN-SYN-0173',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-173');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-174','TN-SYN-0174',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-174');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-175','TN-SYN-0175',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-175');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-176','TN-SYN-0176',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-176');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-177','TN-SYN-0177',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-177');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-178','TN-SYN-0178',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-178');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-179','TN-SYN-0179',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-179');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-180','TN-SYN-0180',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-180');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-181','TN-SYN-0181',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-181');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-182','TN-SYN-0182',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-182');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-183','TN-SYN-0183',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-183');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-184','TN-SYN-0184',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-184');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-185','TN-SYN-0185',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-185');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-186','TN-SYN-0186',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-186');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-187','TN-SYN-0187',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-187');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-188','TN-SYN-0188',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-188');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-189','TN-SYN-0189',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-189');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-190','TN-SYN-0190',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-190');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-191','TN-SYN-0191',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-191');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-192','TN-SYN-0192',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-192');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-193','TN-SYN-0193',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-193');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-194','TN-SYN-0194',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-194');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-195','TN-SYN-0195',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-195');
INSERT INTO buses (bus_number,registration_number,total_seats,bus_type,bus_status)
SELECT 'SYN-BUS-196','TN-SYN-0196',50,'NON_AC','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM buses WHERE bus_number='SYN-BUS-196');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 001','9000000001','SYN-DRV-001','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-001');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 002','9000000002','SYN-DRV-002','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-002');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 003','9000000003','SYN-DRV-003','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-003');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 004','9000000004','SYN-DRV-004','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-004');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 005','9000000005','SYN-DRV-005','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-005');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 006','9000000006','SYN-DRV-006','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-006');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 007','9000000007','SYN-DRV-007','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-007');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 008','9000000008','SYN-DRV-008','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-008');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 009','9000000009','SYN-DRV-009','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-009');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 010','9000000010','SYN-DRV-010','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-010');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 011','9000000011','SYN-DRV-011','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-011');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 012','9000000012','SYN-DRV-012','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-012');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 013','9000000013','SYN-DRV-013','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-013');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 014','9000000014','SYN-DRV-014','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-014');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 015','9000000015','SYN-DRV-015','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-015');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 016','9000000016','SYN-DRV-016','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-016');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 017','9000000017','SYN-DRV-017','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-017');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 018','9000000018','SYN-DRV-018','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-018');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 019','9000000019','SYN-DRV-019','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-019');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 020','9000000020','SYN-DRV-020','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-020');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 021','9000000021','SYN-DRV-021','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-021');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 022','9000000022','SYN-DRV-022','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-022');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 023','9000000023','SYN-DRV-023','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-023');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 024','9000000024','SYN-DRV-024','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-024');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 025','9000000025','SYN-DRV-025','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-025');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 026','9000000026','SYN-DRV-026','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-026');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 027','9000000027','SYN-DRV-027','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-027');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 028','9000000028','SYN-DRV-028','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-028');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 029','9000000029','SYN-DRV-029','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-029');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 030','9000000030','SYN-DRV-030','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-030');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 031','9000000031','SYN-DRV-031','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-031');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 032','9000000032','SYN-DRV-032','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-032');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 033','9000000033','SYN-DRV-033','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-033');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 034','9000000034','SYN-DRV-034','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-034');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 035','9000000035','SYN-DRV-035','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-035');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 036','9000000036','SYN-DRV-036','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-036');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 037','9000000037','SYN-DRV-037','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-037');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 038','9000000038','SYN-DRV-038','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-038');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 039','9000000039','SYN-DRV-039','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-039');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 040','9000000040','SYN-DRV-040','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-040');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 041','9000000041','SYN-DRV-041','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-041');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 042','9000000042','SYN-DRV-042','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-042');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 043','9000000043','SYN-DRV-043','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-043');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 044','9000000044','SYN-DRV-044','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-044');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 045','9000000045','SYN-DRV-045','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-045');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 046','9000000046','SYN-DRV-046','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-046');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 047','9000000047','SYN-DRV-047','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-047');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 048','9000000048','SYN-DRV-048','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-048');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 049','9000000049','SYN-DRV-049','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-049');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 050','9000000050','SYN-DRV-050','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-050');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 051','9000000051','SYN-DRV-051','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-051');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 052','9000000052','SYN-DRV-052','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-052');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 053','9000000053','SYN-DRV-053','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-053');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 054','9000000054','SYN-DRV-054','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-054');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 055','9000000055','SYN-DRV-055','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-055');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 056','9000000056','SYN-DRV-056','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-056');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 057','9000000057','SYN-DRV-057','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-057');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 058','9000000058','SYN-DRV-058','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-058');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 059','9000000059','SYN-DRV-059','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-059');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 060','9000000060','SYN-DRV-060','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-060');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 061','9000000061','SYN-DRV-061','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-061');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 062','9000000062','SYN-DRV-062','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-062');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 063','9000000063','SYN-DRV-063','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-063');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 064','9000000064','SYN-DRV-064','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-064');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 065','9000000065','SYN-DRV-065','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-065');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 066','9000000066','SYN-DRV-066','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-066');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 067','9000000067','SYN-DRV-067','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-067');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 068','9000000068','SYN-DRV-068','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-068');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 069','9000000069','SYN-DRV-069','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-069');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 070','9000000070','SYN-DRV-070','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-070');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 071','9000000071','SYN-DRV-071','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-071');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 072','9000000072','SYN-DRV-072','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-072');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 073','9000000073','SYN-DRV-073','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-073');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 074','9000000074','SYN-DRV-074','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-074');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 075','9000000075','SYN-DRV-075','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-075');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 076','9000000076','SYN-DRV-076','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-076');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 077','9000000077','SYN-DRV-077','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-077');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 078','9000000078','SYN-DRV-078','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-078');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 079','9000000079','SYN-DRV-079','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-079');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 080','9000000080','SYN-DRV-080','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-080');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 081','9000000081','SYN-DRV-081','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-081');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 082','9000000082','SYN-DRV-082','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-082');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 083','9000000083','SYN-DRV-083','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-083');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 084','9000000084','SYN-DRV-084','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-084');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 085','9000000085','SYN-DRV-085','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-085');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 086','9000000086','SYN-DRV-086','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-086');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 087','9000000087','SYN-DRV-087','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-087');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 088','9000000088','SYN-DRV-088','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-088');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 089','9000000089','SYN-DRV-089','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-089');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 090','9000000090','SYN-DRV-090','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-090');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 091','9000000091','SYN-DRV-091','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-091');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 092','9000000092','SYN-DRV-092','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-092');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 093','9000000093','SYN-DRV-093','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-093');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 094','9000000094','SYN-DRV-094','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-094');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 095','9000000095','SYN-DRV-095','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-095');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 096','9000000096','SYN-DRV-096','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-096');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 097','9000000097','SYN-DRV-097','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-097');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 098','9000000098','SYN-DRV-098','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-098');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 099','9000000099','SYN-DRV-099','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-099');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 100','9000000100','SYN-DRV-100','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-100');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 101','9000000101','SYN-DRV-101','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-101');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 102','9000000102','SYN-DRV-102','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-102');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 103','9000000103','SYN-DRV-103','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-103');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 104','9000000104','SYN-DRV-104','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-104');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 105','9000000105','SYN-DRV-105','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-105');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 106','9000000106','SYN-DRV-106','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-106');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 107','9000000107','SYN-DRV-107','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-107');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 108','9000000108','SYN-DRV-108','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-108');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 109','9000000109','SYN-DRV-109','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-109');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 110','9000000110','SYN-DRV-110','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-110');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 111','9000000111','SYN-DRV-111','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-111');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 112','9000000112','SYN-DRV-112','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-112');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 113','9000000113','SYN-DRV-113','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-113');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 114','9000000114','SYN-DRV-114','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-114');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 115','9000000115','SYN-DRV-115','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-115');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 116','9000000116','SYN-DRV-116','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-116');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 117','9000000117','SYN-DRV-117','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-117');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 118','9000000118','SYN-DRV-118','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-118');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 119','9000000119','SYN-DRV-119','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-119');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 120','9000000120','SYN-DRV-120','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-120');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 121','9000000121','SYN-DRV-121','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-121');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 122','9000000122','SYN-DRV-122','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-122');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 123','9000000123','SYN-DRV-123','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-123');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 124','9000000124','SYN-DRV-124','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-124');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 125','9000000125','SYN-DRV-125','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-125');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 126','9000000126','SYN-DRV-126','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-126');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 127','9000000127','SYN-DRV-127','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-127');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 128','9000000128','SYN-DRV-128','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-128');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 129','9000000129','SYN-DRV-129','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-129');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 130','9000000130','SYN-DRV-130','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-130');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 131','9000000131','SYN-DRV-131','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-131');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 132','9000000132','SYN-DRV-132','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-132');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 133','9000000133','SYN-DRV-133','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-133');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 134','9000000134','SYN-DRV-134','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-134');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 135','9000000135','SYN-DRV-135','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-135');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 136','9000000136','SYN-DRV-136','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-136');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 137','9000000137','SYN-DRV-137','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-137');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 138','9000000138','SYN-DRV-138','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-138');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 139','9000000139','SYN-DRV-139','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-139');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 140','9000000140','SYN-DRV-140','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-140');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 141','9000000141','SYN-DRV-141','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-141');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 142','9000000142','SYN-DRV-142','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-142');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 143','9000000143','SYN-DRV-143','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-143');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 144','9000000144','SYN-DRV-144','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-144');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 145','9000000145','SYN-DRV-145','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-145');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 146','9000000146','SYN-DRV-146','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-146');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 147','9000000147','SYN-DRV-147','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-147');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 148','9000000148','SYN-DRV-148','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-148');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 149','9000000149','SYN-DRV-149','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-149');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 150','9000000150','SYN-DRV-150','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-150');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 151','9000000151','SYN-DRV-151','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-151');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 152','9000000152','SYN-DRV-152','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-152');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 153','9000000153','SYN-DRV-153','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-153');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 154','9000000154','SYN-DRV-154','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-154');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 155','9000000155','SYN-DRV-155','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-155');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 156','9000000156','SYN-DRV-156','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-156');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 157','9000000157','SYN-DRV-157','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-157');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 158','9000000158','SYN-DRV-158','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-158');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 159','9000000159','SYN-DRV-159','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-159');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 160','9000000160','SYN-DRV-160','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-160');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 161','9000000161','SYN-DRV-161','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-161');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 162','9000000162','SYN-DRV-162','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-162');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 163','9000000163','SYN-DRV-163','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-163');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 164','9000000164','SYN-DRV-164','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-164');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 165','9000000165','SYN-DRV-165','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-165');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 166','9000000166','SYN-DRV-166','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-166');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 167','9000000167','SYN-DRV-167','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-167');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 168','9000000168','SYN-DRV-168','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-168');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 169','9000000169','SYN-DRV-169','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-169');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 170','9000000170','SYN-DRV-170','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-170');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 171','9000000171','SYN-DRV-171','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-171');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 172','9000000172','SYN-DRV-172','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-172');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 173','9000000173','SYN-DRV-173','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-173');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 174','9000000174','SYN-DRV-174','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-174');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 175','9000000175','SYN-DRV-175','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-175');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 176','9000000176','SYN-DRV-176','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-176');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 177','9000000177','SYN-DRV-177','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-177');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 178','9000000178','SYN-DRV-178','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-178');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 179','9000000179','SYN-DRV-179','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-179');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 180','9000000180','SYN-DRV-180','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-180');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 181','9000000181','SYN-DRV-181','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-181');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 182','9000000182','SYN-DRV-182','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-182');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 183','9000000183','SYN-DRV-183','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-183');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 184','9000000184','SYN-DRV-184','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-184');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 185','9000000185','SYN-DRV-185','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-185');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 186','9000000186','SYN-DRV-186','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-186');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 187','9000000187','SYN-DRV-187','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-187');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 188','9000000188','SYN-DRV-188','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-188');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 189','9000000189','SYN-DRV-189','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-189');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 190','9000000190','SYN-DRV-190','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-190');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 191','9000000191','SYN-DRV-191','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-191');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 192','9000000192','SYN-DRV-192','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-192');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 193','9000000193','SYN-DRV-193','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-193');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 194','9000000194','SYN-DRV-194','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-194');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 195','9000000195','SYN-DRV-195','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-195');
INSERT INTO drivers (driver_name,phone_number,license_number,driver_status)
SELECT 'Synthetic Driver 196','9000000196','SYN-DRV-196','ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM drivers WHERE license_number='SYN-DRV-196');

-- Route-stop sequences: each feeder includes its origin and the campus gate.
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Sriperumbudur Bus Stop' AND s.area='Sriperumbudur'
WHERE r.route_name='SRP-FEEDER-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Sunguvarchatram Bus Stop' AND s.area='Sunguvarchatram'
WHERE r.route_name='SRP-FEEDER-002' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-002' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Irungattukottai Bus Stop' AND s.area='Irungattukottai'
WHERE r.route_name='SRP-FEEDER-003' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-003' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='SIPCOT Bus Stop' AND s.area='SIPCOT'
WHERE r.route_name='SRP-FEEDER-004' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-004' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Pennalur Bus Stop' AND s.area='Pennalur'
WHERE r.route_name='SRP-FEEDER-005' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-005' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Pillaipakkam Bus Stop' AND s.area='Pillaipakkam'
WHERE r.route_name='SRP-FEEDER-006' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-006' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Thandalam Bus Stop' AND s.area='Thandalam'
WHERE r.route_name='SRP-FEEDER-007' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-007' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Chettipedu Bus Stop' AND s.area='Chettipedu'
WHERE r.route_name='SRP-FEEDER-008' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-008' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Queensland Bus Stop' AND s.area='Queensland'
WHERE r.route_name='SRP-FEEDER-009' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-009' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Pappanchatram Bus Stop' AND s.area='Pappanchatram'
WHERE r.route_name='SRP-FEEDER-010' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-010' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Chembarambakkam Bus Stop' AND s.area='Chembarambakkam'
WHERE r.route_name='SRP-FEEDER-011' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-011' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Nazarathpet Bus Stop' AND s.area='Nazarathpet'
WHERE r.route_name='SRP-FEEDER-012' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-012' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Poonamallee Bus Stop' AND s.area='Poonamallee'
WHERE r.route_name='SRP-FEEDER-013' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-013' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kumananchavadi Bus Stop' AND s.area='Kumananchavadi'
WHERE r.route_name='SRP-FEEDER-014' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-014' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kattupakkam Bus Stop' AND s.area='Kattupakkam'
WHERE r.route_name='SRP-FEEDER-015' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-015' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Iyyappanthangal Bus Stop' AND s.area='Iyyappanthangal'
WHERE r.route_name='SRP-FEEDER-016' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-016' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Porur Bus Stop' AND s.area='Porur'
WHERE r.route_name='SRP-FEEDER-017' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-017' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mugalivakkam Bus Stop' AND s.area='Mugalivakkam'
WHERE r.route_name='SRP-FEEDER-018' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-018' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Ramapuram Bus Stop' AND s.area='Ramapuram'
WHERE r.route_name='SRP-FEEDER-019' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-019' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Guindy Bus Stop' AND s.area='Guindy'
WHERE r.route_name='SRP-FEEDER-020' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-020' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kathipara Bus Stop' AND s.area='Kathipara'
WHERE r.route_name='SRP-FEEDER-021' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-021' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vadapalani Bus Stop' AND s.area='Vadapalani'
WHERE r.route_name='SRP-FEEDER-022' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-022' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Valasaravakkam Bus Stop' AND s.area='Valasaravakkam'
WHERE r.route_name='SRP-FEEDER-023' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-023' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kundrathur Bus Stop' AND s.area='Kundrathur'
WHERE r.route_name='SRP-FEEDER-024' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-024' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mangadu Bus Stop' AND s.area='Mangadu'
WHERE r.route_name='SRP-FEEDER-025' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-025' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Somangalam Bus Stop' AND s.area='Somangalam'
WHERE r.route_name='SRP-FEEDER-026' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-026' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Manimangalam Bus Stop' AND s.area='Manimangalam'
WHERE r.route_name='SRP-FEEDER-027' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-027' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mudichur Bus Stop' AND s.area='Mudichur'
WHERE r.route_name='SRP-FEEDER-028' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-028' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Perungalathur Bus Stop' AND s.area='Perungalathur'
WHERE r.route_name='SRP-FEEDER-029' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-029' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Tambaram Bus Stop' AND s.area='Tambaram'
WHERE r.route_name='SRP-FEEDER-030' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-030' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vandalur Bus Stop' AND s.area='Vandalur'
WHERE r.route_name='SRP-FEEDER-031' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-031' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Padappai Bus Stop' AND s.area='Padappai'
WHERE r.route_name='SRP-FEEDER-032' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-032' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mannivakkam Bus Stop' AND s.area='Mannivakkam'
WHERE r.route_name='SRP-FEEDER-033' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-033' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kilambakkam Bus Stop' AND s.area='Kilambakkam'
WHERE r.route_name='SRP-FEEDER-034' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-034' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Urapakkam Bus Stop' AND s.area='Urapakkam'
WHERE r.route_name='SRP-FEEDER-035' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-035' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Guduvancheri Bus Stop' AND s.area='Guduvancheri'
WHERE r.route_name='SRP-FEEDER-036' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-036' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Maraimalai Nagar Bus Stop' AND s.area='Maraimalai Nagar'
WHERE r.route_name='SRP-FEEDER-037' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-037' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Singaperumal Koil Bus Stop' AND s.area='Singaperumal Koil'
WHERE r.route_name='SRP-FEEDER-038' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-038' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Oragadam Bus Stop' AND s.area='Oragadam'
WHERE r.route_name='SRP-FEEDER-039' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-039' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vallam Bus Stop' AND s.area='Vallam'
WHERE r.route_name='SRP-FEEDER-040' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-040' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vallakottai Bus Stop' AND s.area='Vallakottai'
WHERE r.route_name='SRP-FEEDER-041' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-041' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Sengadu Bus Stop' AND s.area='Sengadu'
WHERE r.route_name='SRP-FEEDER-042' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-042' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Thirumangalam Bus Stop' AND s.area='Thirumangalam'
WHERE r.route_name='SRP-FEEDER-043' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-043' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Thodukadu Bus Stop' AND s.area='Thodukadu'
WHERE r.route_name='SRP-FEEDER-044' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-044' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mambakkam Bus Stop' AND s.area='Mambakkam'
WHERE r.route_name='SRP-FEEDER-045' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-045' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Manur Bus Stop' AND s.area='Manur'
WHERE r.route_name='SRP-FEEDER-046' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-046' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Karanthangal Bus Stop' AND s.area='Karanthangal'
WHERE r.route_name='SRP-FEEDER-047' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-047' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Beemanthangal Bus Stop' AND s.area='Beemanthangal'
WHERE r.route_name='SRP-FEEDER-048' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-048' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vadakal Bus Stop' AND s.area='Vadakal'
WHERE r.route_name='SRP-FEEDER-049' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-049' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Sunguvarchatram East Bus Stop' AND s.area='Sunguvarchatram East'
WHERE r.route_name='SRP-FEEDER-050' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-050' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Sriperumbudur Bus Stop' AND s.area='Sriperumbudur'
WHERE r.route_name='SRP-FEEDER-051' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-051' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Sunguvarchatram Bus Stop' AND s.area='Sunguvarchatram'
WHERE r.route_name='SRP-FEEDER-052' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-052' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Irungattukottai Bus Stop' AND s.area='Irungattukottai'
WHERE r.route_name='SRP-FEEDER-053' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-053' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='SIPCOT Bus Stop' AND s.area='SIPCOT'
WHERE r.route_name='SRP-FEEDER-054' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-054' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Pennalur Bus Stop' AND s.area='Pennalur'
WHERE r.route_name='SRP-FEEDER-055' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-055' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Pillaipakkam Bus Stop' AND s.area='Pillaipakkam'
WHERE r.route_name='SRP-FEEDER-056' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-056' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Thandalam Bus Stop' AND s.area='Thandalam'
WHERE r.route_name='SRP-FEEDER-057' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-057' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Chettipedu Bus Stop' AND s.area='Chettipedu'
WHERE r.route_name='SRP-FEEDER-058' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-058' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Queensland Bus Stop' AND s.area='Queensland'
WHERE r.route_name='SRP-FEEDER-059' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-059' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Pappanchatram Bus Stop' AND s.area='Pappanchatram'
WHERE r.route_name='SRP-FEEDER-060' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-060' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Chembarambakkam Bus Stop' AND s.area='Chembarambakkam'
WHERE r.route_name='SRP-FEEDER-061' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-061' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Nazarathpet Bus Stop' AND s.area='Nazarathpet'
WHERE r.route_name='SRP-FEEDER-062' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-062' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Poonamallee Bus Stop' AND s.area='Poonamallee'
WHERE r.route_name='SRP-FEEDER-063' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-063' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kumananchavadi Bus Stop' AND s.area='Kumananchavadi'
WHERE r.route_name='SRP-FEEDER-064' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-064' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kattupakkam Bus Stop' AND s.area='Kattupakkam'
WHERE r.route_name='SRP-FEEDER-065' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-065' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Iyyappanthangal Bus Stop' AND s.area='Iyyappanthangal'
WHERE r.route_name='SRP-FEEDER-066' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-066' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Porur Bus Stop' AND s.area='Porur'
WHERE r.route_name='SRP-FEEDER-067' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-067' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mugalivakkam Bus Stop' AND s.area='Mugalivakkam'
WHERE r.route_name='SRP-FEEDER-068' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-068' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Ramapuram Bus Stop' AND s.area='Ramapuram'
WHERE r.route_name='SRP-FEEDER-069' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-069' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Guindy Bus Stop' AND s.area='Guindy'
WHERE r.route_name='SRP-FEEDER-070' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-070' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kathipara Bus Stop' AND s.area='Kathipara'
WHERE r.route_name='SRP-FEEDER-071' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-071' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vadapalani Bus Stop' AND s.area='Vadapalani'
WHERE r.route_name='SRP-FEEDER-072' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-072' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Valasaravakkam Bus Stop' AND s.area='Valasaravakkam'
WHERE r.route_name='SRP-FEEDER-073' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-073' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kundrathur Bus Stop' AND s.area='Kundrathur'
WHERE r.route_name='SRP-FEEDER-074' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-074' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mangadu Bus Stop' AND s.area='Mangadu'
WHERE r.route_name='SRP-FEEDER-075' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-075' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Somangalam Bus Stop' AND s.area='Somangalam'
WHERE r.route_name='SRP-FEEDER-076' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-076' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Manimangalam Bus Stop' AND s.area='Manimangalam'
WHERE r.route_name='SRP-FEEDER-077' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-077' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mudichur Bus Stop' AND s.area='Mudichur'
WHERE r.route_name='SRP-FEEDER-078' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-078' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Perungalathur Bus Stop' AND s.area='Perungalathur'
WHERE r.route_name='SRP-FEEDER-079' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-079' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Tambaram Bus Stop' AND s.area='Tambaram'
WHERE r.route_name='SRP-FEEDER-080' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-080' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vandalur Bus Stop' AND s.area='Vandalur'
WHERE r.route_name='SRP-FEEDER-081' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-081' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Padappai Bus Stop' AND s.area='Padappai'
WHERE r.route_name='SRP-FEEDER-082' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-082' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mannivakkam Bus Stop' AND s.area='Mannivakkam'
WHERE r.route_name='SRP-FEEDER-083' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-083' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kilambakkam Bus Stop' AND s.area='Kilambakkam'
WHERE r.route_name='SRP-FEEDER-084' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-084' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Urapakkam Bus Stop' AND s.area='Urapakkam'
WHERE r.route_name='SRP-FEEDER-085' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-085' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Guduvancheri Bus Stop' AND s.area='Guduvancheri'
WHERE r.route_name='SRP-FEEDER-086' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-086' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Maraimalai Nagar Bus Stop' AND s.area='Maraimalai Nagar'
WHERE r.route_name='SRP-FEEDER-087' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-087' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Singaperumal Koil Bus Stop' AND s.area='Singaperumal Koil'
WHERE r.route_name='SRP-FEEDER-088' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-088' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Oragadam Bus Stop' AND s.area='Oragadam'
WHERE r.route_name='SRP-FEEDER-089' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-089' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vallam Bus Stop' AND s.area='Vallam'
WHERE r.route_name='SRP-FEEDER-090' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-090' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vallakottai Bus Stop' AND s.area='Vallakottai'
WHERE r.route_name='SRP-FEEDER-091' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-091' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Sengadu Bus Stop' AND s.area='Sengadu'
WHERE r.route_name='SRP-FEEDER-092' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-092' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Thirumangalam Bus Stop' AND s.area='Thirumangalam'
WHERE r.route_name='SRP-FEEDER-093' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-093' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Thodukadu Bus Stop' AND s.area='Thodukadu'
WHERE r.route_name='SRP-FEEDER-094' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-094' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mambakkam Bus Stop' AND s.area='Mambakkam'
WHERE r.route_name='SRP-FEEDER-095' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-095' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Manur Bus Stop' AND s.area='Manur'
WHERE r.route_name='SRP-FEEDER-096' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-096' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Karanthangal Bus Stop' AND s.area='Karanthangal'
WHERE r.route_name='SRP-FEEDER-097' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-097' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Beemanthangal Bus Stop' AND s.area='Beemanthangal'
WHERE r.route_name='SRP-FEEDER-098' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-098' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vadakal Bus Stop' AND s.area='Vadakal'
WHERE r.route_name='SRP-FEEDER-099' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-099' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Sunguvarchatram East Bus Stop' AND s.area='Sunguvarchatram East'
WHERE r.route_name='SRP-FEEDER-100' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-100' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Sriperumbudur Bus Stop' AND s.area='Sriperumbudur'
WHERE r.route_name='SRP-FEEDER-101' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-101' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Sunguvarchatram Bus Stop' AND s.area='Sunguvarchatram'
WHERE r.route_name='SRP-FEEDER-102' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-102' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Irungattukottai Bus Stop' AND s.area='Irungattukottai'
WHERE r.route_name='SRP-FEEDER-103' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-103' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='SIPCOT Bus Stop' AND s.area='SIPCOT'
WHERE r.route_name='SRP-FEEDER-104' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-104' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Pennalur Bus Stop' AND s.area='Pennalur'
WHERE r.route_name='SRP-FEEDER-105' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-105' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Pillaipakkam Bus Stop' AND s.area='Pillaipakkam'
WHERE r.route_name='SRP-FEEDER-106' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-106' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Thandalam Bus Stop' AND s.area='Thandalam'
WHERE r.route_name='SRP-FEEDER-107' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-107' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Chettipedu Bus Stop' AND s.area='Chettipedu'
WHERE r.route_name='SRP-FEEDER-108' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-108' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Queensland Bus Stop' AND s.area='Queensland'
WHERE r.route_name='SRP-FEEDER-109' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-109' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Pappanchatram Bus Stop' AND s.area='Pappanchatram'
WHERE r.route_name='SRP-FEEDER-110' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-110' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Chembarambakkam Bus Stop' AND s.area='Chembarambakkam'
WHERE r.route_name='SRP-FEEDER-111' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-111' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Nazarathpet Bus Stop' AND s.area='Nazarathpet'
WHERE r.route_name='SRP-FEEDER-112' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-112' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Poonamallee Bus Stop' AND s.area='Poonamallee'
WHERE r.route_name='SRP-FEEDER-113' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-113' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kumananchavadi Bus Stop' AND s.area='Kumananchavadi'
WHERE r.route_name='SRP-FEEDER-114' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-114' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kattupakkam Bus Stop' AND s.area='Kattupakkam'
WHERE r.route_name='SRP-FEEDER-115' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-115' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Iyyappanthangal Bus Stop' AND s.area='Iyyappanthangal'
WHERE r.route_name='SRP-FEEDER-116' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-116' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Porur Bus Stop' AND s.area='Porur'
WHERE r.route_name='SRP-FEEDER-117' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-117' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mugalivakkam Bus Stop' AND s.area='Mugalivakkam'
WHERE r.route_name='SRP-FEEDER-118' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-118' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Ramapuram Bus Stop' AND s.area='Ramapuram'
WHERE r.route_name='SRP-FEEDER-119' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-119' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Guindy Bus Stop' AND s.area='Guindy'
WHERE r.route_name='SRP-FEEDER-120' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-120' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kathipara Bus Stop' AND s.area='Kathipara'
WHERE r.route_name='SRP-FEEDER-121' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-121' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vadapalani Bus Stop' AND s.area='Vadapalani'
WHERE r.route_name='SRP-FEEDER-122' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-122' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Valasaravakkam Bus Stop' AND s.area='Valasaravakkam'
WHERE r.route_name='SRP-FEEDER-123' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-123' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kundrathur Bus Stop' AND s.area='Kundrathur'
WHERE r.route_name='SRP-FEEDER-124' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-124' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mangadu Bus Stop' AND s.area='Mangadu'
WHERE r.route_name='SRP-FEEDER-125' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-125' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Somangalam Bus Stop' AND s.area='Somangalam'
WHERE r.route_name='SRP-FEEDER-126' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-126' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Manimangalam Bus Stop' AND s.area='Manimangalam'
WHERE r.route_name='SRP-FEEDER-127' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-127' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mudichur Bus Stop' AND s.area='Mudichur'
WHERE r.route_name='SRP-FEEDER-128' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-128' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Perungalathur Bus Stop' AND s.area='Perungalathur'
WHERE r.route_name='SRP-FEEDER-129' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-129' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Tambaram Bus Stop' AND s.area='Tambaram'
WHERE r.route_name='SRP-FEEDER-130' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-130' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vandalur Bus Stop' AND s.area='Vandalur'
WHERE r.route_name='SRP-FEEDER-131' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-131' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Padappai Bus Stop' AND s.area='Padappai'
WHERE r.route_name='SRP-FEEDER-132' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-132' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mannivakkam Bus Stop' AND s.area='Mannivakkam'
WHERE r.route_name='SRP-FEEDER-133' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-133' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Kilambakkam Bus Stop' AND s.area='Kilambakkam'
WHERE r.route_name='SRP-FEEDER-134' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-134' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Urapakkam Bus Stop' AND s.area='Urapakkam'
WHERE r.route_name='SRP-FEEDER-135' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-135' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Guduvancheri Bus Stop' AND s.area='Guduvancheri'
WHERE r.route_name='SRP-FEEDER-136' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-136' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Maraimalai Nagar Bus Stop' AND s.area='Maraimalai Nagar'
WHERE r.route_name='SRP-FEEDER-137' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-137' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Singaperumal Koil Bus Stop' AND s.area='Singaperumal Koil'
WHERE r.route_name='SRP-FEEDER-138' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-138' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Oragadam Bus Stop' AND s.area='Oragadam'
WHERE r.route_name='SRP-FEEDER-139' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-139' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vallam Bus Stop' AND s.area='Vallam'
WHERE r.route_name='SRP-FEEDER-140' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,20 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-140' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Vallakottai Bus Stop' AND s.area='Vallakottai'
WHERE r.route_name='SRP-FEEDER-141' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,25 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-141' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Sengadu Bus Stop' AND s.area='Sengadu'
WHERE r.route_name='SRP-FEEDER-142' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,30 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-142' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Thirumangalam Bus Stop' AND s.area='Thirumangalam'
WHERE r.route_name='SRP-FEEDER-143' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,35 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-143' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Thodukadu Bus Stop' AND s.area='Thodukadu'
WHERE r.route_name='SRP-FEEDER-144' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,40 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-144' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Mambakkam Bus Stop' AND s.area='Mambakkam'
WHERE r.route_name='SRP-FEEDER-145' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,45 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-145' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Manur Bus Stop' AND s.area='Manur'
WHERE r.route_name='SRP-FEEDER-146' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,50 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate'
WHERE r.route_name='SRP-FEEDER-146' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
-- Main route includes representative corridor pickup points and campus gate.
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,1,0 FROM routes r JOIN bus_stops s ON s.stop_name='Tambaram Bus Stop' AND s.area='Tambaram'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=1);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,2,16 FROM routes r JOIN bus_stops s ON s.stop_name='Perungalathur Bus Stop' AND s.area='Perungalathur'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=2);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,3,20 FROM routes r JOIN bus_stops s ON s.stop_name='Mudichur Bus Stop' AND s.area='Mudichur'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=3);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,4,24 FROM routes r JOIN bus_stops s ON s.stop_name='Manimangalam Bus Stop' AND s.area='Manimangalam'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=4);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,5,28 FROM routes r JOIN bus_stops s ON s.stop_name='Pillaipakkam Bus Stop' AND s.area='Pillaipakkam'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=5);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,6,32 FROM routes r JOIN bus_stops s ON s.stop_name='Porur Bus Stop' AND s.area='Porur'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=6);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,7,36 FROM routes r JOIN bus_stops s ON s.stop_name='Kundrathur Bus Stop' AND s.area='Kundrathur'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=7);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,8,40 FROM routes r JOIN bus_stops s ON s.stop_name='Poonamallee Bus Stop' AND s.area='Poonamallee'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=8);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,9,44 FROM routes r JOIN bus_stops s ON s.stop_name='Nazarathpet Bus Stop' AND s.area='Nazarathpet'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=9);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,10,48 FROM routes r JOIN bus_stops s ON s.stop_name='Chembarambakkam Bus Stop' AND s.area='Chembarambakkam'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=10);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,11,52 FROM routes r JOIN bus_stops s ON s.stop_name='Pappanchatram Bus Stop' AND s.area='Pappanchatram'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=11);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,12,56 FROM routes r JOIN bus_stops s ON s.stop_name='Chettipedu Bus Stop' AND s.area='Chettipedu'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=12);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,13,60 FROM routes r JOIN bus_stops s ON s.stop_name='Thandalam Bus Stop' AND s.area='Thandalam'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=13);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,14,64 FROM routes r JOIN bus_stops s ON s.stop_name='Irungattukottai Bus Stop' AND s.area='Irungattukottai'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=14);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,15,68 FROM routes r JOIN bus_stops s ON s.stop_name='Pennalur Bus Stop' AND s.area='Pennalur'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=15);
INSERT INTO route_stops (route_id,stop_id,stop_sequence,estimated_travel_minutes)
SELECT r.route_id,s.stop_id,16,72 FROM routes r JOIN bus_stops s ON s.stop_name='Synthetic Engineering College Main Gate' AND s.area='Sriperumbudur'
WHERE r.route_name='SRP-MAIN-001' AND NOT EXISTS (SELECT 1 FROM route_stops x WHERE x.route_id=r.route_id AND x.stop_sequence=16);

-- Daily trips for the next 30 days: 146 feeder routes x 3 slots and 50 main-route buses x 2 slots.
INSERT INTO trips (bus_id,route_id,driver_id,travel_date,departure_time,arrival_time,trip_type,trip_status,booking_cutoff_time)
SELECT b.bus_id,r.route_id,d.driver_id,DATE_ADD(CURDATE(),INTERVAL day_offset.n DAY),slot.departure_time,
ADDTIME(slot.departure_time,'01:00:00'),'REGULAR','SCHEDULED',SUBTIME(slot.departure_time,'00:15:00')
FROM (
 SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL SELECT 25 UNION ALL SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL SELECT 30
) day_offset
JOIN buses b ON b.bus_number LIKE 'SYN-BUS-%'
JOIN drivers d ON d.license_number=CONCAT('SYN-DRV-',SUBSTRING(b.bus_number,9))
JOIN routes r ON ((b.bus_number BETWEEN 'SYN-BUS-001' AND 'SYN-BUS-146' AND r.route_name=CONCAT('SRP-FEEDER-',SUBSTRING(b.bus_number,9))) OR (b.bus_number BETWEEN 'SYN-BUS-147' AND 'SYN-BUS-196' AND r.route_name='SRP-MAIN-001'))
JOIN (SELECT '08:00:00' AS departure_time UNION ALL SELECT '15:00:00' UNION ALL SELECT '17:00:00') slot
WHERE b.bus_number BETWEEN 'SYN-BUS-001' AND 'SYN-BUS-146'
AND NOT EXISTS (SELECT 1 FROM trips t WHERE t.bus_id=b.bus_id AND t.route_id=r.route_id AND t.travel_date=DATE_ADD(CURDATE(),INTERVAL day_offset.n DAY) AND t.departure_time=slot.departure_time);

INSERT INTO trips (bus_id,route_id,driver_id,travel_date,departure_time,arrival_time,trip_type,trip_status,booking_cutoff_time)
SELECT b.bus_id,r.route_id,d.driver_id,DATE_ADD(CURDATE(),INTERVAL day_offset.n DAY),slot.departure_time,
ADDTIME(slot.departure_time,'01:15:00'),'REGULAR','SCHEDULED',SUBTIME(slot.departure_time,'00:15:00')
FROM (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL SELECT 25 UNION ALL SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL SELECT 30) day_offset
JOIN buses b ON b.bus_number BETWEEN 'SYN-BUS-147' AND 'SYN-BUS-196'
JOIN drivers d ON d.license_number=CONCAT('SYN-DRV-',SUBSTRING(b.bus_number,9))
JOIN routes r ON r.route_name='SRP-MAIN-001'
JOIN (SELECT '10:00:00' AS departure_time UNION ALL SELECT '12:00:00') slot
WHERE NOT EXISTS (SELECT 1 FROM trips t WHERE t.bus_id=b.bus_id AND t.route_id=r.route_id AND t.travel_date=DATE_ADD(CURDATE(),INTERVAL day_offset.n DAY) AND t.departure_time=slot.departure_time);

-- Verify expected master-data counts (pre-existing non-synthetic rows are excluded).
SELECT COUNT(*) AS synthetic_feeder_routes FROM routes WHERE route_name LIKE 'SRP-FEEDER-%';
SELECT COUNT(*) AS synthetic_main_route_buses FROM buses WHERE bus_number BETWEEN 'SYN-BUS-147' AND 'SYN-BUS-196';
SELECT COUNT(*) AS synthetic_stops FROM bus_stops WHERE stop_name LIKE '%Bus Stop' OR stop_name='Synthetic Engineering College Main Gate';
