﻿/*
Toate rezolvările se vor face sub forma de cod T-SQL (script T-SQL).

	 Se dă baza de date Universitate :
Orase
	- Id
	- Denumire
Grupa
	- Id
	- Denumire
Student
	- Id
	- Grupa la care aparține
	- Orașul de resedință
	- Nume
	- Prenume
Materie
	- Id
	- Nume
Note
	- Id
	- Student
	- Materia
	- Nota obținută

Coloanele Id sunt de tip identity, încep de la 1 și pasul este de 1.
Coloanele de tip string trebuie să suporte stocarea datelor cu caractere speciale.

*/

-- 1. Să se creeze baza de date "Universitate" cu collate-ul SQL_Romanian_CP1250_CS_AS
CREATE DATABASE universitate COLLATE SQL_Romanian_CP1250_CS_AS;

-- 2. Să se creeze tabelele din baza "Universitate".
-- Rezolvare impreuna cu 3
-- 3. Să se realizeze integritatea bazei de date prin crearea de constrângeri pentru cele 4 relații prezentate.
CREATE TABLE Orase (
    Id INT PRIMARY KEY,
    Denumire VARCHAR(255)
);

CREATE TABLE Grupa (
    Id INT PRIMARY KEY,
    Denumire VARCHAR(255)
);

CREATE TABLE Student (
    Id INT PRIMARY KEY,
    Grupa_Studentului INT,
    Orasul_Studentului INT,
    Nume VARCHAR(255),
    Prenume VARCHAR(255),
    FOREIGN KEY (Grupa_Studentului) REFERENCES Grupa(Id),
    FOREIGN KEY (Orasul_Studentului) REFERENCES Orase(Id)
);

CREATE TABLE Materie (
    Id INT PRIMARY KEY,
    Nume VARCHAR(255)
);

CREATE TABLE Note (
    Id INT PRIMARY KEY,
    Student INT,
    Materia INT,
    Nota INT,
    FOREIGN KEY (Student) REFERENCES Student(Id),
    FOREIGN KEY (Materia) REFERENCES Materie(Id)
);
-- fara alater table
-- 4. Să se introducă în baza de date următoarele informații:

/*
Orașe:
Ploiești 
Pitești 
Constanța
București
Călărași 
Iași 
Slobozia 
Sibiu 
Cluj-Napoca 
Brașov 
Fetești 
Satu-Mare 
Oradea 
Cernavodă 

Grupe:
A
B
C
D


Materii:
Geometrie 
Algebră 
Statistică 
Trigonometrie 
Muzică 
Desen 
Sport 
Filozofie 
Literatură 
Engleză 
Fizică 
Franceză


Studenți și note:
Numele + prenumele, grupa la care aparține, orașul de resedință

		Student															Note								|				
																											|
Popescu	Mihai, grupa A, Ploiești					Chimie	 7			Fizică		4		Franceză	7	|	Fizică 6
Ionescu	Andrei, grupa A, București					Algebră	 5			Statistică	9		Muzică		6	|	Fizică 9, Chimie 10, Sport 8
Ionescu	Andreea, grupa A, Constanța					Sport	 1			Literatură	2		Franceză	9	|	Sport 5, Literatură 4, Literatură 7
Dinu Nicolae, grupa A, Călărași						Chimie	 8			Algebră		9		Statistică	10	|

															 												|
Constantin Ionuț, grupa B, Cernavodă				Algebră	 10			Sport		10		Fizică		8	|
Simion Mihai, grupa B, Iași							Fizică	 8			Algebră		8		Sport		3	|	Sport 3, Sport 1, Sport 1
Constantinescu Ana-Maria, grupa B, Cernavodă		Sport	 5			Fizică		8		Algebră		2	|	Algebră 5
Amăriuței Eugen, grupa B, Iași						Algebră	 6			Sport		10		Franceză	7	|	
Știrbei	Alexandru, grupa B, Sibiu					Chimie	 9			Fizică		2		Sport		1	|	Fizică 2, Fizică 5, Sport 6
															 												|
Dumitru	Angela, grupa C, Brașov						Desen	 9			Filozofie	7		Engleză		9	|
Dumitrache Ion, grupa C, Oradea						Desen	 8			Statistică	2		Filozofie	7	|	Statistică 6
Șerban Maria-Magdalena, grupa C, Oradea				Engleză	 7			Filozofie	4		Desen		8	|	Filozofie 4, Filozofie 4
Chelaru	Violeta, grupa C, Cluj-Napoca 				Franceză 1			Desen		3		Engleză		10	|	Franceză 6, Desen 1
Sandu Daniel, grupa C, Cluj-Napoca 					Desen	 3			Filozofie	9		Franceză	4	|	Desen 8, Franceză 5
															 												|
Marinache Alin, grupa D, Satu-Mare					Desen	 7			Fizică		8		Engleză		5	|
Panait Vasile, grupa D, Satu-Mare 					Sport	 5			Desen		7		Statistică	10	|	Fizică 8, Literatură 6, Filozofie 9
Popa Mirela, grupa D, Fetești						Engleză	 3			Filozofie	6		Desen		6	|	Engleză	6
Dascălu Daniel Ștefan, grupa D, Fetești				Fizică	 4			Franceză	9		Statistică	10	|	Fizică 2, Fizică 1, Fizică 3, Fizică 5
Georgescu Marian, grupa D, Fetești					Franceză 10			Engleză		10		Fizică		8	|
Dumitrașcu Marius, grupa D, Ploiești				Sport	 5			Algebră		6		Chimie		2	|	Chimie 2, Chimie 5	
Dinu Ionela, grupa D, București						Muzică	 9			Literatură	8		Sport		8	|

 ** Notele se introduc în ordinea din listă, ultima înregistrare reprezentând situația curentă la materia respectivă.

*/
INSERT INTO Orase (Id, Denumire)
VALUES (1, 'Ploiești'),
       (2, 'Pitești'),
       (3, 'Constanța'),
       (4, 'București'),
       (5, 'Călărași'),
       (6, 'Iași'),
       (7, 'Slobozia'),
       (8, 'Sibiu'),
       (9, 'Cluj-Napoca'),
       (10, 'Brașov'),
       (11, 'Fetești'),
       (12, 'Satu-Mare'),
       (13, 'Oradea'),
       (14, 'Cernavodă');


INSERT INTO Grupa (Id, Denumire)
VALUES (1, 'A'),
       (2, 'B'),
       (3, 'C'),
       (4, 'D');


INSERT INTO Materie (Id, Nume)
VALUES (1, 'Geometrie'),
       (2, 'Algebră'),
       (3, 'Statistică'),
       (4, 'Trigonometrie'),
       (5, 'Muzică'),
       (6, 'Desen'),
       (7, 'Sport'),
       (8, 'Filozofie'),
       (9, 'Literatură'),
       (10, 'Engleză'),
       (11, 'Fizică'),
       (12, 'Franceză');
	   



INSERT INTO Student (Id, Grupa_Studentului, Orasul_Studentului, Nume, Prenume)
VALUES
    -- Grupa A
    (1, 1, 1, 'Popescu', 'Mihai'),
    (2, 1, 4, 'Ionescu', 'Andrei'),
    (3, 1, 3, 'Ionescu', 'Andreea'),
    (4, 1, 5, 'Dinu', 'Nicolae'),

    -- Grupa B
    (5, 2, 14, 'Constantin', 'Ionuț'),
    (6, 2, 6, 'Simion', 'Mihai'),
    (7, 2, 14, 'Constantinescu', 'Ana-Maria'),
    (8, 2, 6, 'Amăriuței', 'Eugen'),
    (9, 2, 8, 'Știrbei', 'Alexandru'),

    -- Grupa C
    (10, 3, 10, 'Dumitru', 'Angela'),
    (11, 3, 13, 'Dumitrache', 'Ion'),
    (12, 3, 13, 'Șerban', 'Maria-Magdalena'),
    (13, 3, 9, 'Chelaru', 'Violeta'),
    (14, 3, 9, 'Sandu', 'Daniel'),

    -- Groupa D
    (15, 4, 12, 'Marinache', 'Alin'),
    (16, 4, 12, 'Panait', 'Vasile'),
    (17, 4, 11, 'Popa', 'Mirela'),
    (18, 4, 11, 'Dascălu', 'Daniel Ștefan'),
    (19, 4, 11, 'Georgescu', 'Marian'),
    (20, 4, 1, 'Dumitrașcu', 'Marius'),
    (21, 4, 4, 'Dinu', 'Ionela');


INSERT INTO Note (Id, Student, Materia, Nota)
VALUES
    -- Grupa A
    (1, 1, 11, 7), (2, 1, 3, 4), (3, 1, 12, 7),
    (4, 2, 2, 5), (5, 2, 3, 9), (6, 2, 5, 6),
    (7, 3, 7, 1), (8, 3, 9, 2), (9, 3, 12, 9),
    (10, 4, 11, 8), (11, 4, 2, 9), (12, 4, 3, 10),

    -- Grupa B
    (13, 5, 2, 10), (14, 5, 7, 10), (15, 5, 11, 8),
    (16, 6, 11, 8), (17, 6, 2, 8), (18, 6, 7, 3),
    (19, 7, 6, 9), (20, 7, 3, 2), (21, 7, 7, 5),
    (22, 8, 8, 5), (23, 8, 7, 10),
    (24, 9, 1, 9), (25, 9, 9, 6),

    -- Grupa C
    (26, 10, 6, 9), (27, 10, 8, 7), (28, 10, 10, 9),
    (29, 11, 10, 8), (30, 11, 2, 2), (31, 11, 7, 7),
    (32, 12, 9, 3), (33, 12, 3, 9), (34, 12, 12, 4),
    (35, 13, 5, 1), (36, 13, 6, 3), (37, 13, 10, 6),

    -- Grupa D
    (38, 14, 6, 7), (39, 14, 11, 8), (40, 14, 10, 5),
    (41, 15, 7, 5), (42, 15, 8, 8), (43, 15, 5, 6),
    (44, 16, 5, 5), (45, 16, 7, 7), (46, 16, 2, 6),
    (47, 17, 10, 4), (48, 17, 3, 9), (49, 17, 12, 10),
    (50, 18, 11, 8), (51, 18, 11, 1), (52, 18, 11, 3), (53, 18, 11, 5),
    (54, 19, 2, 4), (55, 19, 9, 9), (56, 19, 3, 10),
    (57, 20, 5, 10), (58, 20, 6, 6),
    (59, 21, 10, 5), (60, 21, 4, 8), (61, 21, 7, 2);
	
	


-- 5. Să se afișeze numărul de orașe din provincie.
SELECT COUNT(*) AS NumberOfCitiesNotBucuresti
FROM Orase
WHERE Denumire <> 'București';

-- 6. Să se afișeze numărul de materii la care s-au susținut examene.
SELECT COUNT(DISTINCT Materia) AS NumberOfMaterieEntriesInNote
FROM Note;


-- 7. Să se afișeze studenții în ordine alfabetică.
SELECT Nume, Prenume
FROM Student
ORDER BY Nume, Prenume;


-- 8. Să se afișeze studenții cu 2 prenume (prenumele conține caracterul blanc sau - ( liniuță) ).
SELECT Nume, Prenume
FROM Student
WHERE CHARINDEX(' ', Prenume) > 0 OR CHARINDEX('-', Prenume) > 0;


-- 9. Să se afișeze studenții din provincie.
SELECT S.Nume, S.Prenume
FROM Student S
JOIN Orase O ON S.Orasul_Studentului = O.Id
WHERE O.Denumire <> 'București';


-- 10. Să se afișeze orașele care nu au nici un student încris.
SELECT O.Denumire AS OrasFaraStudenti
FROM Orase O
LEFT JOIN Student S ON O.Id = S.Orasul_Studentului
WHERE S.Id IS NULL;


-- 11. Să se afișeze grupele care au cel puțin 5 studenți.
SELECT G.Denumire AS GroupName, COUNT(S.Id) AS StudentCount
FROM Grupa G
LEFT JOIN Student S ON G.Id = S.Grupa_Studentului
GROUP BY G.Id, G.Denumire
HAVING COUNT(S.Id) >= 5;


-- 12. Să se afișeze numele grupei care are cei mai mulți studenți.
SELECT TOP 1 WITH TIES G.Denumire AS GroupName, COUNT(S.Id) AS StudentCount
FROM Grupa G
LEFT JOIN Student S ON G.Id = S.Grupa_Studentului
GROUP BY G.Id, G.Denumire
ORDER BY StudentCount DESC;

-- 13. Să se afișeze materiile la care nu s-a dat niciodată examen.
SELECT M.Nume AS SubjectName
FROM Materie M
LEFT JOIN Note N ON M.Id = N.Materia
WHERE N.Id IS NULL;

-- 14. Să se afișeze studenții care au urmat și cursuri opționale ( au notă la mai mult de 3 materii ).
SELECT S.Nume, S.Prenume, COUNT(DISTINCT N.Materia) AS NumarMateriiDistincte
FROM Student S
LEFT JOIN Note N ON S.Id = N.Student
GROUP BY S.Id, S.Nume, S.Prenume
HAVING COUNT(DISTINCT N.Materia) > 3;
-- 15. Să se calculeze media generală a fiecărui student ( vezi ** ).
WITH UltimeleNote AS (
    SELECT
        N.Student,
        N.Materia,
        MAX(N.Id) AS IdUltimaNota
    FROM
        Note N
    GROUP BY
        N.Student,
        N.Materia
)

SELECT
    S.Nume,
    S.Prenume,
    AVG(N.Nota) AS Medie
FROM
    Student S
JOIN
	UltimeleNote UL ON S.Id = UL.Student
JOIN
    Note N ON UL.IdUltimaNota = N.Id
GROUP BY
    S.Id, S.Nume, S.Prenume;
-- 16. Să se afișeze grupa care are media generală cea mai mare.
WITH UltimeleNote AS (
    SELECT
        S.Id AS StudentId,
        N.Materia,
        MAX(N.Id) AS UltimaNotaId
    FROM
        Student S
    LEFT JOIN
        Note N ON S.Id = N.Student
    GROUP BY
        S.Id, N.Materia
)

SELECT
    G.Denumire AS GroupName,
    AVG(N.Nota) AS AverageGrade
FROM
    Grupa G
LEFT JOIN
    Student S ON G.Id = S.Grupa_Studentului
LEFT JOIN
    UltimaNota UN ON S.Id = UN.StudentId
LEFT JOIN
    Note N ON UN.UltimaNotaId = N.Id
GROUP BY
    G.Id, G.Denumire
ORDER BY
    AverageGrade DESC
FETCH FIRST 1 ROWS ONLY;
-- 17. Să se afișeze studenții bursieri ( care au media generală cel puțin 8,50 ).
WITH UltimaNota AS (
    SELECT
        S.Id AS StudentId,
        N.Materia,
        MAX(N.Id) AS UltimaNotaId
    FROM
        Student S
    LEFT JOIN
        Note N ON S.Id = N.Student
    GROUP BY
        S.Id, N.Materia
)

SELECT
    S.Nume,
    S.Prenume,
    AVG(N.Nota) AS MedieStudent
FROM
    Student S
JOIN
    UltimaNota UN ON S.Id = UN.StudentId
JOIN
    Note N ON UN.UltimaNotaId = N.Id
GROUP BY
    S.Id, S.Nume, S.Prenume
HAVING
    AVG(N.Nota) > 8.50;
-- 18. Să se afișeze studenții care nu au promovat materia "Chimie" de la prima examinare, dar au promovat ulterior.
WITH PrimaSiUltimaNotaChimie AS (
    SELECT
        S.Id AS StudentId,
        MIN(N.Id) AS IdPrimaNotaChimie,
        MAX(N.Id) AS LastChimieGradeId
    FROM
        Student S
    LEFT JOIN
        Note N ON S.Id = N.Student
    WHERE
        N.Materia = 'Chimie'
    GROUP BY
        S.Id
)

SELECT
    S.Nume,
    S.Prenume
FROM
    Student S
JOIN
    PrimaSiUltimaNotaChimie FLG ON S.Id = FLG.StudentId
JOIN
    Note PrimaNota ON FLG.IdPrimaNotaChimie = PrimaNota.Id
JOIN
    Note UltimaNota ON FLG.IdUltimaNotaChimie = UltimaNota.Id
WHERE
    PrimaNota.Nota < 5 AND UltimaNota.Nota > 5;



-- 19. Să se afișeze studentul care a susținut cele mai multe examinări la aceeași materie.

WITH NumarareExaminari AS (
    SELECT
        S.Id AS StudentId,
        N.Materia,
        COUNT(N.Id) AS NumarExaminari
    FROM
        Student S
    LEFT JOIN
        Note N ON S.Id = N.Student
    GROUP BY
        S.Id, N.Materia
)

SELECT TOP 1 WITH TIES
    S.Nume,
    S.Prenume,
    S.Id AS StudentId,
    NE.Materia,
    NE.NumarExaminari
FROM
    Student S
JOIN
    NumarareExaminari NE ON S.Id = NE.StudentId
ORDER BY
    ROW_NUMBER() OVER (PARTITION BY NE.Materia ORDER BY NE.SubjectGradeCount DESC);



-- 20. Să se afișeze studenții și numărul de examinări la fiecare materie în parte.

SELECT
    S.Nume,
    S.Prenume,
    N.Materia,
    COUNT(N.Id) AS NumarNote
FROM
    Student S
LEFT JOIN
    Note N ON S.Id = N.Student
GROUP BY
    S.Id, S.Nume, S.Prenume, N.Materia
ORDER BY
    S.Id, N.Materia;


-- 21. Să se afișeze studenții repetenți (au picat cel puțin o materie ).


WITH UltimeleNote AS (
    SELECT
        S.Id AS StudentId,
        MAX(N.Id) AS UltimaNotaId
    FROM
        Student S
    LEFT JOIN
        Note N ON S.Id = N.Student
    GROUP BY
        S.Id
)

SELECT
    S.Nume,
    S.Prenume,
    N.Nota AS LastGrade
FROM
    Student S
JOIN
    UltimeleNote UN ON S.Id = UN.StudentId
JOIN
    Note N ON UN.UltimaNotaId = N.Id
WHERE
    N.Nota < 5;

-- 22. Să se mute toți repetenții într-o grupă nouă, grupa E. ( vezi pct. anterior)


WITH UltimeleNote AS (
    SELECT
        S.Id AS StudentId,
        MAX(N.Id) AS IdUltimaNota
    FROM
        Student S
    LEFT JOIN
        Note N ON S.Id = N.Student
    GROUP BY
        S.Id
    HAVING
        MAX(N.Nota) < 5
)


UPDATE Student
SET Grupa_Studentului = 'E'
WHERE Id IN (SELECT StudentId FROM UltimeleNote);


-- 23. Cel mai slab student este exmatriculat. Să se șteargă studentul din baza de date.

WITH UltimaNotaMaterie AS (
    SELECT
        S.Id AS StudentId,
        N.Materia,
        MAX(N.Id) AS IdUltimaNota
    FROM
        Student S
    LEFT JOIN
        Note N ON S.Id = N.Student
    GROUP BY
        S.Id, N.Materia
),
MediiStudenti AS (
    SELECT
        S.Id AS StudentId,
        AVG(N.Nota) AS Medie
    FROM
        Student S
    JOIN
        UltimaNotaMaterie UNM ON S.Id = UNM.StudentId
    JOIN
        Note N ON UNM.IdUltimaNota = N.Id
    GROUP BY
        S.Id
)

DELETE FROM Student
WHERE Id IN (
    SELECT StudentId
    FROM MediiStudenti
    WHERE Medie = (SELECT MIN(Medie) FROM MediiStudenti)
);

-- 24. Să se afișeze toți studenții care fac parte din aceeași familie ( au același nume de familie ), după modelul:
/*
	Nume		Prenume
	Ionescu		Andrei
	Ionescu		Andreea

	Rezultat afișat:

	Familia		Frații
	Ionescu		Andrei, Andreea
	
	
	
*/

SELECT
    S1.Nume AS Familia,
    CONCAT(S1.Prenume, ', ', S2.Prenume) AS Fratii
FROM
    Student S1
JOIN
    Student S2 ON S1.Nume = S2.Nume AND S1.Prenume <> S2.Prenume
ORDER BY
    S1.Nume, S1.Prenume, S2.Prenume;

