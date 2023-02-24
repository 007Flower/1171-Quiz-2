DROP TABLE IF EXISTS albums_tracks CASCADE;
DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS tracks;

CREATE TABLE albums(
    album_ID int NOT NULL,
    title text NOT NULL,
    artist Varchar(100) NOT NULL,
    PRIMARY KEY(album_ID )
);

CREATE TABLE tracks(
    track_ID int NOT NULL,
    title text NOT NULL,
    artist Varchar(100) NOT NULL,
    lenght_time TIME NOT NULL,
    PRIMARY KEY( track_ID)
);
--albums table

INSERT INTO albums (album_ID,title,artist)
VALUES
(1,'The Slim Shady LP','Eminem'),
(2,'Her Loss','Drake'),
(3,' Dretox','Dr.Dre'),
(4,'All Eyez on Me','tupac shakur'),
(5,'Greatest Hits','The Notorious B.I.G. '),
(6,'American Gangster','Jay-Z'),
(7,'Starboy','The Weeknd'),
(8,' El Conejo Malo','Bad Bunny '),
(9,'Shockwave','Marshmello'),
(10,'Black Flag','Machine Gun Kelly ');


--Tracks table

INSERT INTO tracks(track_ID,title, artist,lenght_time)
VALUES
(10,'come on everbody','Eminem','00:3:39'),
(9,'guilty conscience','Eminem','00:1:16'),
(8,'broke boys','Drake','00:3:45'),
(7,'all bout u','tupac shakur','00:4:37'),
(6,'notorious thugs','The Notorious B.I.G','00:6:07'),
(5,'sidewalks','The Weeknd','00:3:51'),
(4,'tempestade tropical','Bad Bunny','00:2:51'),
(3,'jardineira','Bad Bunny','00:2:13'),
(2,'back in time','Marshmello','00:2:41'),
(1,'pe$o','Machine Gun Kelly','00:2:30');

--link table
CREATE TABLE albums_tracks(
    id serial PRIMARY KEY,
    album_ID integer REFERENCES albums(album_ID),
    track_ID integer REFERENCES tracks(track_ID)
);

INSERT INTO albums_tracks(album_ID,track_ID)
VALUES
(1,10),
(1,9),
(2,8),
(4,7),
(5,6),
(7,5),
(8,4),
(8,3),
(9,2),
(10,1);

--select from tables
SELECT * FROM albums;
SELECT * FROM tracks;
SELECT * FROM albums_tracks;

--Write an SQL query to see the albums and the tracks that belong to that album.
    SELECT A.title, T.title,T.lenght_time
    FROM albums AS A
    INNER JOIN albums_tracks AS AT
    ON A.album_ID = AT.album_ID
    INNER JOIN tracks AS T
    ON AT.track_ID = T.track_ID;
--Write an SQL query to see the album or albums that each track belongs to.
SELECT T.title AS track_name, T.lenght_time AS track_length, A.title AS albums_title
FROM tracks as T
INNER JOIN albums_tracks AS AT
ON T.track_ID = AT.track_ID
INNER JOIN albums AS A
ON AT.album_ID = A.album_ID;
--Write a query to see the number of songs an album has.
   SELECT A.title AS album_title, COUNT(T.track_ID)
    FROM albums AS A
    FULL JOIN albums_tracks AS AT
    ON A.album_ID = AT.album_ID
    FULL JOIN tracks AS T
    ON AT.track_ID = T.track_ID
    GROUP BY A.album_ID;
--Write a query to see how many albums a particular track is included on.
   SELECT T.title AS tracks_title, COUNT(A.album_ID)
    FROM albums AS A
    FULL JOIN albums_tracks AS AT
    ON A.album_ID = AT.album_ID
    FULL JOIN tracks AS T
    ON AT.track_ID = T.track_ID
    WHERE T.title = 'come on everbody'
    GROUP BY  T.track_ID;