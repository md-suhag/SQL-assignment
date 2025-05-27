-- Active: 1747531249872@@127.0.0.1@5432@conservation_db


CREATE DATABASE conservation_db;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(60),
    region VARCHAR(25)
);
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(15)
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id  INT REFERENCES rangers(ranger_id) NOT NULL,
    species_id INT REFERENCES species(species_id) NOT NULL,
    sighting_time TIMESTAMP,
    location VARCHAR(20),
    notes VARCHAR(100)
);

INSERT INTO rangers (ranger_id, name,region)
VALUES
(1,'Alice Green','Northern Hills'),
(2,'Bob White','River Delta'),
(3,'Carol King','Mountain Range');

INSERT INTO species (common_name, scientific_name,discovery_date,conservation_status)
VALUES
('Snow Leopard','Panthera uncia','1775-01-01','Endangered'),
('Bengal Tiger','Panthera tigris tigris','1775-01-01','Endangered'),
('Red Panda','Aliurus fulgens','1825-01-01','Vulnerable'),
('Asiatic Elephant','Elephas maximus indicus','1758-01-01','Endangered');

INSERT INTO sightings (species_id,ranger_id,location,sighting_time, notes)
VALUES
(1,1,'Peak Ridge','2025-05-10 07:45:00','Camera trap image captured'),
(2,2,'Bankwood Area','2025-05-12 16:20:00','Juvenile seen'),
(3,3,'Bamboo Grove East','2025-05-15 09:10:00','Feeding observed'),
(1,2,'Snowfall Pass','2025-05-18 18:30:00',NULL);


-- Problem 1
INSERT INTO rangers (name,region) VALUES('Derek Fox','Coastal Plains');

-- Problem 2
SELECT count(*) AS unique_species_count FROM (SELECT DISTINCT species_id FROM sightings);

-- Problem 3
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- Problem 4
SELECT r.name, count(r.name) AS total_sightings FROM rangers as r JOIN sightings USING(ranger_id) GROUP BY r.name;

-- Problem 5
 select common_name from species where species_id NOT IN (SELECT DISTINCT species_id from sightings);

-- Problem 6
SELECT common_name, sighting_time, name 
from rangers JOIN (SELECT ranger_id, common_name, sighting_time from sightings JOIN species USING(species_id) ORDER BY sighting_time DESC LIMIT 2 ) 
USING(ranger_id);

-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE extract(year from discovery_date) < 1800;

-- Problem 8
SELECT sighting_id,
CASE 
    WHEN extract(hour from sighting_time)<12 THEN  'Morning'
    WHEN extract(hour from sighting_time)<=17 THEN  'Afternoon'
    ELSE  'Evening'
END  AS time_of_day  FROM sightings;

-- Problem 9
DELETE FROM rangers WHERE ranger_id IN (SELECT ranger_id FROM rangers WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id from sightings)) ;