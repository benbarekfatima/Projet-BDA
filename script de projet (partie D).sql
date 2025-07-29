-- D- Langage de manipulation de données
-- 8- Les insertions

-- TABLE EXPLOITATIONS
INSERT INTO EXPLOITATIONS VALUES (
  TExploitation(
    1,                              -- idExploitation NUMBER
    'Ferme des Cèdres',             -- nomExploitation
    150,                            -- surfaceExploitation
    'Kabylie',                      -- region
    3,                              -- nbrParcelles
    TSetRefParcelle()               -- nested table initialement vide
  )
);
INSERT INTO EXPLOITATIONS VALUES (TExploitation(2,'Oasis Verte',200,'Biskra',2,TSetRefParcelle()));
INSERT INTO EXPLOITATIONS VALUES (TExploitation(3,'Domaine El-Kheir',300,'Oran',4,TSetRefParcelle()));
INSERT INTO EXPLOITATIONS VALUES (TExploitation(4,'Agro-Sud',180,'Ghardaïa',2,TSetRefParcelle()));
INSERT INTO EXPLOITATIONS VALUES (TExploitation(5,'Bio Champs',120,'Tlemcen',2,TSetRefParcelle()));
INSERT INTO EXPLOITATIONS VALUES (TExploitation(6,'Ferme Saharienne', 250, 'Adrar', 3,TSetRefParcelle()));
INSERT INTO EXPLOITATIONS VALUES (TExploitation(7,'Jardins du Tell', 100, 'Blida', 1,TSetRefParcelle()));
INSERT INTO EXPLOITATIONS VALUES (TExploitation(8,'Coopérative El-Feth', 220, 'Constantine', 3,TSetRefParcelle()));
INSERT INTO EXPLOITATIONS VALUES (TExploitation(9,'Les Vergers', 190, 'Médéa', 2,TSetRefParcelle()));
INSERT INTO EXPLOITATIONS VALUES (TExploitation(10,'TerraNova', 170, 'Skikda', 2,TSetRefParcelle()));

-- TABLE PARCELLES
INSERT INTO PARCELLES VALUES (
  TParcelle(
    1,                              -- idParcelle
    'Nord-1',                       -- nomParcelle
    50,                             -- surfaceParcelle
    'argileux',                     -- typeSol
    (SELECT REF(e) 
       FROM Exploitations e 
      WHERE e.idExploitation = 1),  -- réf. vers Ferme des Cèdres
    TSetRefSemis(),
    TSetRefDetectionMaladie(),
    TSetRefMissionDrone()
  )
);
INSERT INTO PARCELLES VALUES (TParcelle( 2,'Sud-2',40,'calcaire', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 1),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 3,'Est-3', 60, 'sableux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 1),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 4, 'Ouest-1', 90, 'humifère', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 2),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 5, 'Central', 110, 'argileux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 2),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 6, 'Verger-1', 70, 'limoneux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 3),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 7, 'Verger-2', 80, 'sableux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 3),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 8, 'Plaine', 85, 'calcaire', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 3),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 9, 'Hauteur', 65, 'humifère', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 3),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 10, 'Test-1', 100, 'tourbeux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 4),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 11, 'Oasis', 80, 'sableux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 4),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 12, 'Bio-Est', 60, 'argileux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 5),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 13, 'Bio-Ouest', 60, 'humifère', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 5),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 14, 'Sahara-1', 90, 'calcaire', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 6),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 15, 'Sahara-2', 80, 'sableux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 6),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 16, 'Palmeraie', 80, 'tourbeux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 6),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 17, 'Montagne', 100, 'limoneux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 7),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 18, 'El-Feth-1', 80, 'argileux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 8),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 19, 'El-Feth-2', 70, 'humifère', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 8),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 20, 'El-Feth-3', 70, 'sableux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 8),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 21, 'Vergers-Nord', 100, 'limoneux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 9),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 22, 'Vergers-Sud', 90, 'tourbeux', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 9),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 23, 'Terra-1', 90, 'calcaire', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 10),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO PARCELLES VALUES (TParcelle( 24, 'Terra-2', 80, 'humifère', (SELECT REF(e) FROM Exploitations e WHERE e.idExploitation = 10),
                                                                        TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone()));

--  Rattacher les parcelles à leur exploitation (remplir les tables imbriques qui sont initialiser a vide au debut)
UPDATE Exploitations e  SET parcelles = parcelles MULTISET UNION
  CAST( MULTISET( SELECT REF(p) FROM Parcelles p WHERE p.idParcelle IN (1,2,3)) AS TSetRefParcelle) WHERE e.idExploitation = 1;

UPDATE Exploitations e  SET parcelles = parcelles MULTISET UNION
  CAST( MULTISET( SELECT REF(p) FROM Parcelles p WHERE p.idParcelle IN (4,5)) AS TSetRefParcelle) WHERE e.idExploitation = 2;

UPDATE Exploitations e  SET parcelles = parcelles MULTISET UNION
  CAST( MULTISET( SELECT REF(p) FROM Parcelles p WHERE p.idParcelle IN (6,7,8,9)) AS TSetRefParcelle) WHERE e.idExploitation = 3;

UPDATE Exploitations e  SET parcelles = parcelles MULTISET UNION
  CAST( MULTISET( SELECT REF(p) FROM Parcelles p WHERE p.idParcelle IN (10,11)) AS TSetRefParcelle) WHERE e.idExploitation = 4;

UPDATE Exploitations e  SET parcelles = parcelles MULTISET UNION
  CAST( MULTISET( SELECT REF(p) FROM Parcelles p WHERE p.idParcelle IN (12,13)) AS TSetRefParcelle) WHERE e.idExploitation = 5;

UPDATE Exploitations e  SET parcelles = parcelles MULTISET UNION
  CAST( MULTISET( SELECT REF(p) FROM Parcelles p WHERE p.idParcelle IN (14,15,16)) AS TSetRefParcelle) WHERE e.idExploitation = 6;

UPDATE Exploitations e  SET parcelles = parcelles MULTISET UNION
  CAST( MULTISET( SELECT REF(p) FROM Parcelles p WHERE p.idParcelle IN (17)) AS TSetRefParcelle) WHERE e.idExploitation = 7;

UPDATE Exploitations e  SET parcelles = parcelles MULTISET UNION
  CAST( MULTISET( SELECT REF(p) FROM Parcelles p WHERE p.idParcelle IN (18,19,20)) AS TSetRefParcelle) WHERE e.idExploitation = 8;

UPDATE Exploitations e  SET parcelles = parcelles MULTISET UNION
  CAST( MULTISET( SELECT REF(p) FROM Parcelles p WHERE p.idParcelle IN (21,22)) AS TSetRefParcelle) WHERE e.idExploitation = 9;

UPDATE Exploitations e  SET parcelles = parcelles MULTISET UNION
  CAST( MULTISET( SELECT REF(p) FROM Parcelles p WHERE p.idParcelle IN (23,24)) AS TSetRefParcelle) WHERE e.idExploitation = 10;

-- TABLE CULTURES
INSERT INTO CULTURES VALUES (TCulture(1,'Blé','Blé dur'));
INSERT INTO CULTURES VALUES (TCulture(2,'Orge','Orge d hiver'));
INSERT INTO CULTURES VALUES (TCulture(3, 'Tomate', 'Roma'));
INSERT INTO CULTURES VALUES (TCulture(4, 'Pomme de terre', 'Spunta'));
INSERT INTO CULTURES VALUES (TCulture(5, 'Ail', 'Violet de Provence'));
INSERT INTO CULTURES VALUES (TCulture(6, 'Carotte', 'Nantaise'));
INSERT INTO CULTURES VALUES (TCulture(7, 'Olive', 'Chemlal'));
INSERT INTO CULTURES VALUES (TCulture(8, 'Dattier', 'Deglet Nour'));
INSERT INTO CULTURES VALUES (TCulture(9, 'Laitue', 'Batavia'));
INSERT INTO CULTURES VALUES (TCulture(10, 'Pois chiche', 'Kabuli'));

-- TABLE CAMPAGNEAGRICOLES                                                                   
INSERT INTO CampagnesAgricoles VALUES (
  TCampagneAgricole(1,2022,DATE '2022-01-01',DATE '2022-12-31',TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone())
);
INSERT INTO CampagnesAgricoles VALUES (
  TCampagneAgricole(2,2023,DATE '2023-01-01',DATE '2023-12-31',TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone())
);
INSERT INTO CampagnesAgricoles VALUES (
  TCampagneAgricole(3,2024,DATE '2024-01-01',DATE '2024-12-31',TSetRefSemis(),TSetRefDetectionMaladie(),TSetRefMissionDrone())
);


-- TABLE SEMIS
INSERT INTO SEMIS VALUES (
    TSemis(
    1,                             -- idSemis
    DATE '2023-02-15',             -- dateSemis
    120,                           -- quantiteSemis
    (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 1),
    (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 1),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 2)
  )
);
INSERT INTO SEMIS VALUES (TSemis(2,DATE '2023-02-18',100, (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 2), 
                (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 2), (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 2)));
INSERT INTO SEMIS VALUES (TSemis(3,DATE '2023-03-05', 80, (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 4), 
                (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 3), (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 2)));
INSERT INTO SEMIS VALUES (TSemis(4,DATE '2023-02-25', 90, (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 6), 
                (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 7), (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 2)));
INSERT INTO SEMIS VALUES (TSemis(5,DATE '2024-02-10', 110, (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 5), 
                (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 4), (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3)));
INSERT INTO SEMIS VALUES (TSemis(6,DATE '2024-02-20', 130, (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 7), 
                (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 1), (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3)));
INSERT INTO SEMIS VALUES (TSemis(7,DATE '2024-03-01', 95, (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 10), 
                (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 6), (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3)));
INSERT INTO SEMIS VALUES (TSemis(8,DATE '2024-03-10', 70, (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 12), 
                (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 5), (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3)));
INSERT INTO SEMIS VALUES (TSemis(9,DATE '2024-03-15', 85, (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 13), 
                (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 8), (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3)));
INSERT INTO SEMIS VALUES (TSemis(10,DATE '2024-03-20', 90, (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 14), 
                (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 9), (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3)));
INSERT INTO SEMIS VALUES (TSemis(11,DATE '2024-03-22', 75, (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 15), 
                (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 10), (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3)));
INSERT INTO SEMIS VALUES (TSemis(12,DATE '2024-03-25', 95, (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 16), 
                (SELECT REF(c) FROM Cultures c WHERE c.idCulture = 3), (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3)));

-- Peupler les nested tables 'semis' dans parcelles
UPDATE Parcelles p SET semis = semis MULTISET UNION
  CAST( MULTISET (SELECT REF(s) FROM Semis s WHERE s.idSemis IN (1)) AS TSetRefSemis) WHERE p.idParcelle = 1;

UPDATE Parcelles p SET semis = semis MULTISET UNION
  CAST( MULTISET (SELECT REF(s) FROM Semis s WHERE s.idSemis IN (2)) AS TSetRefSemis) WHERE p.idParcelle = 2;

UPDATE Parcelles p SET semis = semis MULTISET UNION
  CAST( MULTISET (SELECT REF(s) FROM Semis s WHERE s.idSemis IN (3)) AS TSetRefSemis) WHERE p.idParcelle = 4;

UPDATE Parcelles p SET semis = semis MULTISET UNION
  CAST( MULTISET (SELECT REF(s) FROM Semis s WHERE s.idSemis IN (4)) AS TSetRefSemis) WHERE p.idParcelle = 6;

UPDATE Parcelles p SET semis = semis MULTISET UNION
  CAST( MULTISET (SELECT REF(s) FROM Semis s WHERE s.idSemis IN (5)) AS TSetRefSemis) WHERE p.idParcelle = 5;

UPDATE Parcelles p SET semis = semis MULTISET UNION
  CAST( MULTISET (SELECT REF(s) FROM Semis s WHERE s.idSemis IN (6)) AS TSetRefSemis) WHERE p.idParcelle = 7;

UPDATE Parcelles p SET semis = semis MULTISET UNION
  CAST( MULTISET (SELECT REF(s) FROM Semis s WHERE s.idSemis IN (8)) AS TSetRefSemis) WHERE p.idParcelle = 12;

UPDATE Parcelles p SET semis = semis MULTISET UNION
  CAST( MULTISET (SELECT REF(s) FROM Semis s WHERE s.idSemis IN (9)) AS TSetRefSemis) WHERE p.idParcelle = 13;
  
UPDATE Parcelles p SET semis = semis MULTISET UNION
  CAST( MULTISET (SELECT REF(s) FROM Semis s WHERE s.idSemis IN (10)) AS TSetRefSemis) WHERE p.idParcelle = 14;

UPDATE Parcelles p SET semis = semis MULTISET UNION
  CAST( MULTISET (SELECT REF(s) FROM Semis s WHERE s.idSemis IN (11)) AS TSetRefSemis) WHERE p.idParcelle = 15;

UPDATE Parcelles p SET semis = semis MULTISET UNION
  CAST( MULTISET (SELECT REF(s) FROM Semis s WHERE s.idSemis IN (12)) AS TSetRefSemis) WHERE p.idParcelle = 16;

-- Peupler les nested tables 'semis' dans CampagnesAgricoles
UPDATE CampagnesAgricoles ca SET semis = semis MULTISET UNION
  CAST( MULTISET(SELECT REF(s) FROM SEMIS s WHERE s.idSemis IN (1,2,3,4))AS TSetRefSemis) WHERE ca.idCampagne = 2;


UPDATE CampagnesAgricoles ca SET semis = semis MULTISET UNION
  CAST( MULTISET(SELECT REF(s) FROM SEMIS s WHERE s.idSemis IN (5,6,7,8,9,10,11,12))AS TSetRefSemis) WHERE ca.idCampagne = 3;


-- TABLE MALADIES
INSERT INTO MALADIES VALUES (TMaladie(1, 'Mildiou', 'fongique',TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO MALADIES VALUES (TMaladie(2, 'Rouille', 'fongique',TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO MALADIES VALUES (TMaladie(3, 'Bactériose', 'bactérienne',TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO MALADIES VALUES (TMaladie(4, 'Virus de la mosaïque', 'virale',TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO MALADIES VALUES (TMaladie(5, 'Nématodes', 'parasitique',TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO MALADIES VALUES (TMaladie(6, 'Carence azotée', 'physiologique',TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO MALADIES VALUES (TMaladie(7, 'Tache brune', 'fongique',TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO MALADIES VALUES (TMaladie(8, 'Flétrissement bactérien', 'bactérienne',TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO MALADIES VALUES (TMaladie(9, 'Virus Y de la pomme de terre', 'virale',TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO MALADIES VALUES (TMaladie(10, 'Chenille mineuse', 'parasitique',TSetRefDetectionMaladie(),TSetRefMissionDrone()));
INSERT INTO MALADIES VALUES (TMaladie(11, 'Stress hydrique', 'physiologique',TSetRefDetectionMaladie(),TSetRefMissionDrone()));

-- TABLE DETECTIONSMALADIE
INSERT INTO DETECTIONSMALADIE VALUES ( TDetectionMaladie(
    1,DATE '2024-04-05','forte',
    (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 1),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3),
    (SELECT REF(m) FROM Maladies m WHERE m.idMaladie = 1)
  ));
INSERT INTO DETECTIONSMALADIE VALUES ( TDetectionMaladie(
    2,DATE '2024-04-06', 'moyenne',
    (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 2),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3),
    (SELECT REF(m) FROM Maladies m WHERE m.idMaladie = 3)
  ));
INSERT INTO DETECTIONSMALADIE VALUES ( TDetectionMaladie(
    3,DATE '2024-04-07', 'faible',
    (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle =5),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3),
    (SELECT REF(m) FROM Maladies m WHERE m.idMaladie = 4)
  ));
INSERT INTO DETECTIONSMALADIE VALUES ( TDetectionMaladie(
    4,DATE '2024-04-08', 'forte',
    (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 10),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3),
    (SELECT REF(m) FROM Maladies m WHERE m.idMaladie = 6)
  ));
INSERT INTO DETECTIONSMALADIE VALUES ( TDetectionMaladie(
    5,DATE '2024-04-09', 'moyenne',
    (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 14),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3),
    (SELECT REF(m) FROM Maladies m WHERE m.idMaladie = 7)
  ));
INSERT INTO DETECTIONSMALADIE VALUES ( TDetectionMaladie(
    6,DATE '2024-04-10', 'forte',
    (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 15),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3),
    (SELECT REF(m) FROM Maladies m WHERE m.idMaladie = 10)
  ));
INSERT INTO DETECTIONSMALADIE VALUES ( TDetectionMaladie(
    7,DATE '2024-04-11', 'faible',
    (SELECT REF(p) FROM Parcelles p WHERE p.idParcelle = 16),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3),
    (SELECT REF(m) FROM Maladies m WHERE m.idMaladie = 11)
  ));

-- Peupler les nested tables 'detections' dans pacerrelles
UPDATE Parcelles p SET detections = detections MULTISET UNION
  CAST( MULTISET(SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection = 1)AS TSetRefDetectionMaladie) WHERE p.idParcelle = 1;

UPDATE Parcelles p SET detections = detections MULTISET UNION
  CAST( MULTISET(SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection = 2)AS TSetRefDetectionMaladie) WHERE p.idParcelle = 2;

UPDATE Parcelles p SET detections = detections MULTISET UNION
  CAST( MULTISET(SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection = 3)AS TSetRefDetectionMaladie) WHERE p.idParcelle = 5;

UPDATE Parcelles p SET detections = detections MULTISET UNION
  CAST( MULTISET(SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection = 4)AS TSetRefDetectionMaladie) WHERE p.idParcelle = 10;

UPDATE Parcelles p SET detections = detections MULTISET UNION
  CAST( MULTISET(SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection = 5)AS TSetRefDetectionMaladie) WHERE p.idParcelle = 14;

UPDATE Parcelles p SET detections = detections MULTISET UNION
  CAST( MULTISET(SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection = 6)AS TSetRefDetectionMaladie) WHERE p.idParcelle = 15;

UPDATE Parcelles p SET detections = detections MULTISET UNION
  CAST( MULTISET(SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection = 7)AS TSetRefDetectionMaladie) WHERE p.idParcelle = 16;


-- Peupler les nested tables 'detections' dans compagnesagricoles
UPDATE CampagnesAgricoles ca SET detections = detections MULTISET UNION
  CAST( MULTISET (SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection IN (1,2,3,4,5,6,7))AS TSetRefDetectionMaladie) WHERE ca.idCampagne = 3;


-- Peupler les nested tables 'detections' dans Maladies
UPDATE Maladies m SET detections = detections MULTISET UNION
  CAST( MULTISET (SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection IN (1))AS TSetRefDetectionMaladie) WHERE m.idMaladie = 1;

UPDATE Maladies m SET detections = detections MULTISET UNION
  CAST( MULTISET (SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection IN (2))AS TSetRefDetectionMaladie) WHERE m.idMaladie = 3;

UPDATE Maladies m SET detections = detections MULTISET UNION
  CAST( MULTISET (SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection IN (3))AS TSetRefDetectionMaladie) WHERE m.idMaladie = 4;

UPDATE Maladies m SET detections = detections MULTISET UNION
  CAST( MULTISET (SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection IN (4))AS TSetRefDetectionMaladie) WHERE m.idMaladie = 6;

UPDATE Maladies m SET detections = detections MULTISET UNION
  CAST( MULTISET (SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection IN (5))AS TSetRefDetectionMaladie) WHERE m.idMaladie = 7;

UPDATE Maladies m SET detections = detections MULTISET UNION
  CAST( MULTISET (SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection IN (6))AS TSetRefDetectionMaladie) WHERE m.idMaladie = 10;

UPDATE Maladies m SET detections = detections MULTISET UNION
  CAST( MULTISET (SELECT REF(d) FROM DetectionsMaladie d WHERE d.idDetection IN (7))AS TSetRefDetectionMaladie) WHERE m.idMaladie = 11;


-- TABLE DRONES
INSERT INTO DRONES VALUES (TDrone(1, 'DJI Agras T30', 'multirotor', 10000, 'Disponible', TSetRefMissionDrone()));
INSERT INTO DRONES VALUES (TDrone(2, 'Parrot Bluegrass', 'ailes fixes', 8000, 'En Maintenance', TSetRefMissionDrone()));
INSERT INTO DRONES VALUES (TDrone(3, 'XAG P100', 'hybride', 12000, 'En Mission', TSetRefMissionDrone()));
INSERT INTO DRONES VALUES (TDrone(4, 'eBee SQ', 'ailes fixes', 9000, 'Disponible', TSetRefMissionDrone()));
INSERT INTO DRONES VALUES (TDrone(5, 'Matrice 300 RTK', 'multirotor', 11000, 'Disponible', TSetRefMissionDrone()));
INSERT INTO DRONES VALUES (TDrone(6, 'SenseFly eBee X', 'ailes fixes', 9500, 'En Mission', TSetRefMissionDrone()));

-- TABLE MISSIONSDRONE
INSERT INTO MISSIONSDRONE VALUES (TMissionDrone(1,DATE '2024-04-06', 'surveillance', 'Aucune anomalie détectée', 
    (SELECT REF(dr) FROM Drones dr WHERE dr.idDrone = 1), (SELECT REF(p)  FROM Parcelles p WHERE p.idParcelle = 1),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3), NULL));
INSERT INTO MISSIONSDRONE VALUES (TMissionDrone(2,DATE '2024-04-07', 'traitement', 'Traitement antifongique appliqué',
    (SELECT REF(dr) FROM Drones dr WHERE dr.idDrone = 3), (SELECT REF(p)  FROM Parcelles p WHERE p.idParcelle = 1),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3), NULL));
INSERT INTO MISSIONSDRONE VALUES (TMissionDrone(3,DATE '2024-04-08', 'cartographie', 'Carte NDVI générée',
    (SELECT REF(dr) FROM Drones dr WHERE dr.idDrone = 4), (SELECT REF(p)  FROM Parcelles p WHERE p.idParcelle = 5),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3), NULL));
INSERT INTO MISSIONSDRONE VALUES (TMissionDrone(4,DATE '2024-04-09', 'analyse thermique', 'Zones de stress thermique détectées',
    (SELECT REF(dr) FROM Drones dr WHERE dr.idDrone = 2), (SELECT REF(p)  FROM Parcelles p WHERE p.idParcelle = 10),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3), NULL));
INSERT INTO MISSIONSDRONE VALUES (TMissionDrone(5,DATE '2024-04-10', 'surveillance', 'Zones suspectes observées',
    (SELECT REF(dr) FROM Drones dr WHERE dr.idDrone = 5), (SELECT REF(p)  FROM Parcelles p WHERE p.idParcelle = 14),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3), NULL));
INSERT INTO MISSIONSDRONE VALUES (TMissionDrone(6,DATE '2024-04-11', 'traitement', 'Insecticide appliqué',
    (SELECT REF(dr) FROM Drones dr WHERE dr.idDrone = 3), (SELECT REF(p)  FROM Parcelles p WHERE p.idParcelle = 15),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3), (SELECT REF(m) FROM Maladies m WHERE m.idMaladie = 10)));
INSERT INTO MISSIONSDRONE VALUES (TMissionDrone(7,DATE '2024-04-12', 'cartographie', 'Carte d irrigation générée',
    (SELECT REF(dr) FROM Drones dr WHERE dr.idDrone = 6), (SELECT REF(p)  FROM Parcelles p WHERE p.idParcelle = 16),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3), NULL));
INSERT INTO MISSIONSDRONE VALUES (TMissionDrone(8,DATE '2024-04-13', 'analyse thermique', 'Température élevée détectée', 
    (SELECT REF(dr) FROM Drones dr WHERE dr.idDrone = 5), (SELECT REF(p)  FROM Parcelles p WHERE p.idParcelle = 13),
    (SELECT REF(ca) FROM CampagnesAgricoles ca WHERE ca.idCampagne = 3), NULL));


-- Peupler les nested tables 'missions' dans Drones  
UPDATE Drones dr SET missions = missions MULTISET UNION
  CAST( MULTISET(SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (1))AS TSetRefMissionDrone) WHERE dr.idDrone = 1;

UPDATE Drones dr SET missions = missions MULTISET UNION
  CAST( MULTISET(SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (4))AS TSetRefMissionDrone) WHERE dr.idDrone = 2;
  
UPDATE Drones dr SET missions = missions MULTISET UNION
  CAST( MULTISET(SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (2,6))AS TSetRefMissionDrone) WHERE dr.idDrone = 3;
  
UPDATE Drones dr SET missions = missions MULTISET UNION
  CAST( MULTISET(SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (3))AS TSetRefMissionDrone) WHERE dr.idDrone = 4;

UPDATE Drones dr SET missions = missions MULTISET UNION
  CAST( MULTISET(SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (5,8))AS TSetRefMissionDrone) WHERE dr.idDrone = 5;
  
UPDATE Drones dr SET missions = missions MULTISET UNION
  CAST( MULTISET(SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (7))AS TSetRefMissionDrone) WHERE dr.idDrone = 6;
 

-- Peupler les nested tables 'missions' dans Parcelles 
UPDATE Parcelles p SET missions = missions MULTISET UNION
  CAST( MULTISET (SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (1,2))AS TSetRefMissionDrone) WHERE p.idParcelle = 1;

UPDATE Parcelles p SET missions = missions MULTISET UNION
  CAST( MULTISET (SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (3))AS TSetRefMissionDrone) WHERE p.idParcelle = 5;

UPDATE Parcelles p SET missions = missions MULTISET UNION
  CAST( MULTISET (SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (4))AS TSetRefMissionDrone) WHERE p.idParcelle = 10;

UPDATE Parcelles p SET missions = missions MULTISET UNION
  CAST( MULTISET (SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (5))AS TSetRefMissionDrone) WHERE p.idParcelle = 14;

UPDATE Parcelles p SET missions = missions MULTISET UNION
  CAST( MULTISET (SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (6))AS TSetRefMissionDrone) WHERE p.idParcelle = 15;

UPDATE Parcelles p SET missions = missions MULTISET UNION
  CAST( MULTISET (SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (7))AS TSetRefMissionDrone) WHERE p.idParcelle = 16;

UPDATE Parcelles p SET missions = missions MULTISET UNION
  CAST( MULTISET (SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (8))AS TSetRefMissionDrone) WHERE p.idParcelle = 13;


-- Peupler les nested tables 'missions' dans CampagnesAgricoles 
UPDATE CampagnesAgricoles ca SET missions = missions MULTISET UNION
  CAST( MULTISET(SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (1,2,3,4,5,6,7,8))AS TSetRefMissionDrone) WHERE ca.idCampagne = 3;


-- Peupler les nested tables 'missions' dans Maladies
UPDATE Maladies m SET missions = missions MULTISET UNION
  CAST( MULTISET(SELECT REF(m) FROM MissionsDrone m WHERE m.idMission IN (6))AS TSetRefMissionDrone) WHERE m.idMaladie = 10;

