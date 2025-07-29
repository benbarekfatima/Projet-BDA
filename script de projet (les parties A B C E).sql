-- B- Création des TableSpaces et  utilisateur 
-- 1. Création du tablespace permanent
CREATE TABLESPACE SQL3_TBS
  DATAFILE 'sql3_tbs01.dbf' SIZE 100M
  AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

-- 2. Création du tablespace temporaire
CREATE TEMPORARY TABLESPACE SQL3_TempTBS
  TEMPFILE 'sql3_temp_tbs01.dbf' SIZE 50M
  AUTOEXTEND ON NEXT 5M MAXSIZE UNLIMITED;

-- 3. Création de l’utilisateur SQL3
CREATE USER C##SQL3
  IDENTIFIED BY pwd 
  DEFAULT TABLESPACE SQL3_TBS
  TEMPORARY TABLESPACE SQL3_TempTBS
  QUOTA UNLIMITED ON SQL3_TBS;

-- 4. Attribution de tous les privilèges
-- Grant des privilèges de connexion et de création d’objets
GRANT CONNECT, RESOURCE TO C##SQL3;

-- (Optionnel) Pour donner tous les privilèges système :
GRANT DBA TO C##SQL3;

-- Et pour assurer qu’il peut créer des objets sans quotas :
GRANT UNLIMITED TABLESPACE TO C##SQL3;

-- C- Langage de définition de données 
-- 5- En se basant sur le diagramme de classes fait, définir tous les types nécessaires. Prendre en compte toutes les associations qui existent. 
-- 1) Déclarations « forward » pour gérer les références croisées
CREATE TYPE TExploitation;
/
CREATE TYPE TParcelle;
/
CREATE TYPE TCulture;
/
CREATE TYPE TCampagneAgricole;
/
CREATE TYPE TSemis;
/
CREATE TYPE TMaladie;
/
CREATE TYPE TDetectionMaladie;
/
CREATE TYPE TDrone;
/
CREATE TYPE TMissionDrone;
/

-- 2) Types de collections de références (pour les associations 1–N et N–1)
CREATE TYPE TSetRefParcelle           
AS TABLE OF REF TParcelle;
/
CREATE TYPE TSetRefSemis              
AS TABLE OF REF TSemis;
/
CREATE TYPE TSetRefDetectionMaladie   
AS TABLE OF REF TDetectionMaladie;
/
CREATE TYPE TSetRefMissionDrone      
AS TABLE OF REF TMissionDrone;
/
CREATE TYPE TSetRefCampagne           
AS TABLE OF REF TCampagneAgricole;
/
CREATE TYPE TSetRefMaladie            
AS TABLE OF REF TMaladie;
/
CREATE TYPE TSetRefDrone              
AS TABLE OF REF TDrone;
/

-- 3) Définition des types objets complets

CREATE OR REPLACE TYPE TExploitation AS OBJECT (
  idExploitation       NUMBER,
  nomExploitation      VARCHAR2(100),
  surfaceExploitation  FLOAT,
  region               VARCHAR2(50),
  nbrParcelles         NUMBER,
  parcelles            TSetRefParcelle        -- 1..* Parcelles
);
/

CREATE OR REPLACE TYPE TParcelle AS OBJECT (
  idParcelle           NUMBER,
  nomParcelle          VARCHAR2(100),
  surfaceParcelle      FLOAT,
  typeSol              VARCHAR2(20),          -- {argileux, sableux, …}
  exploitation         REF TExploitation,      -- 1 Exploitation
  semis                TSetRefSemis,          -- 0..* Semis
  detections           TSetRefDetectionMaladie, -- 0..* Détections
  missions             TSetRefMissionDrone    -- 0..* Missions
);
/

CREATE OR REPLACE TYPE TCulture AS OBJECT (
  idCulture            NUMBER,
  nomCulture           VARCHAR2(100),
  varieteCulture       VARCHAR2(50)
);
/

CREATE OR REPLACE TYPE TCampagneAgricole AS OBJECT (
  idCampagne           NUMBER,
  annee                NUMBER,
  dateDebut            DATE,
  dateFin              DATE,
  semis                TSetRefSemis,             -- 0..* Semis
  detections           TSetRefDetectionMaladie,   -- 0..* Détections
  missions             TSetRefMissionDrone       -- 0..* Missions
);
/

CREATE OR REPLACE TYPE TSemis AS OBJECT (
  idSemis              NUMBER,
  dateSemis            DATE,
  quantiteSemis        FLOAT,
  parcelle             REF TParcelle,            -- 1 Parcelle
  culture              REF TCulture,             -- 1 Culture
  campagne             REF TCampagneAgricole     -- 1 Campagne
);
/

CREATE OR REPLACE TYPE TMaladie AS OBJECT (
  idMaladie            NUMBER,
  nomMaladie           VARCHAR2(100),
  typeMaladie          VARCHAR2(20),            -- {fongique, bactérienne, …}
  detections           TSetRefDetectionMaladie, -- 0..* Détections
  missions             TSetRefMissionDrone      -- 0..* Missions
);
/

CREATE OR REPLACE TYPE TDetectionMaladie AS OBJECT (
  idDetection          NUMBER,
  dateDetection        DATE,
  gravite              VARCHAR2(10),            -- {faible, moyenne, forte}
  parcelle             REF TParcelle,           -- 1 Parcelle
  campagne             REF TCampagneAgricole,   -- 1 Campagne
  maladie              REF TMaladie             -- 1 Maladie
);
/

CREATE OR REPLACE TYPE TDrone AS OBJECT (
  idDrone              NUMBER,
  modele               VARCHAR2(100),
  typeDrone            VARCHAR2(20),            -- {multirotor, ailes fixes, …}
  capaciteBatterie     FLOAT,
  statutDrone          VARCHAR2(20),            -- {Disponible, En Maintenance, …}
  missions             TSetRefMissionDrone     -- 0..* Missions
);
/

CREATE OR REPLACE TYPE TMissionDrone AS OBJECT (
  idMission            NUMBER,
  dateMission          DATE,
  typeMission          VARCHAR2(20),            -- {surveillance, traitement, …}
  resultats            VARCHAR2(1000),
  drone                REF TDrone,              -- 1 Drone
  parcelle             REF TParcelle,           -- 1 Parcelle
  campagne             REF TCampagneAgricole,   -- 1 Campagne
  maladie              REF TMaladie             -- 1 Maladie
);
/

--6- **************************************************** LES METHODES ****************************************************
-- METHODE 1 : Ajout de la signature dans TExploitation 
ALTER TYPE TExploitation
  ADD MEMBER FUNCTION TotalSurface RETURN NUMBER
  CASCADE;


-- 2) Implémentation de la méthode
CREATE OR REPLACE TYPE BODY TExploitation AS

  MEMBER FUNCTION TotalSurface RETURN NUMBER IS
    somme NUMBER;
  BEGIN
    /* On caste self.parcelles en TSetRefParcelle puis on
       récupère les REF via COLUMN_VALUE */
    SELECT NVL(SUM(DEREF(t.COLUMN_VALUE).surfaceParcelle), 0)
      INTO somme
      FROM TABLE(
             CAST(self.parcelles AS TSetRefParcelle)
           ) t;

    RETURN somme;
  END TotalSurface;

END;
/

-- METHODE 2 : Retourner toutes les cultures semées sur les parcelles de l’exploitation pendant une campagne agricole donnée.  
-- 1) Créer le type de collection pour les références de TCulture
CREATE TYPE TSetRefCulture AS TABLE OF REF TCulture;
/

-- 2) Ajouter la signature de la méthode dans TExploitation
ALTER TYPE TExploitation
  ADD MEMBER FUNCTION CulturesParCampagne (
    p_campagne IN REF TCampagneAgricole
  ) RETURN TSetRefCulture
  CASCADE;


-- 3) Implémentation de la méthode

CREATE OR REPLACE TYPE BODY TExploitation AS

  /* Méthode 1 : TotalSurface */
  MEMBER FUNCTION TotalSurface RETURN NUMBER IS
    somme NUMBER;
  BEGIN
    SELECT NVL(SUM(DEREF(t.COLUMN_VALUE).surfaceParcelle), 0)
      INTO somme
      FROM TABLE(
             CAST(self.parcelles AS TSetRefParcelle)
           ) t;
    RETURN somme;
  END TotalSurface;

  /* Méthode 2 : CulturesParCampagne */
  MEMBER FUNCTION CulturesParCampagne (
    p_campagne IN REF TCampagneAgricole
  ) RETURN TSetRefCulture IS

    l_cultures TSetRefCulture;
  BEGIN
    SELECT CAST(
             MULTISET(
               SELECT DISTINCT DEREF(s.COLUMN_VALUE).culture
                 FROM   TABLE(CAST(self.parcelles AS TSetRefParcelle)) p,
                        TABLE(CAST(DEREF(p.COLUMN_VALUE).semis AS TSetRefSemis)) s
                WHERE  DEREF(s.COLUMN_VALUE).campagne = p_campagne
             )
             AS TSetRefCulture
           )
      INTO l_cultures
      FROM dual;
    RETURN l_cultures;
  END CulturesParCampagne;

END;
/

-- METHODE 3 :Pour chaque parcelle, retourner la liste des cultures présentes sur la parcelle durant une campagne
-- 1) Signature de la méthode dans TParcelle
ALTER TYPE TParcelle
  ADD MEMBER FUNCTION CulturesParCampagne (
    p_campagne IN REF TCampagneAgricole
  ) RETURN TSetRefCulture
  CASCADE;


-- 2) Implémentation dans le TYPE BODY
CREATE OR REPLACE TYPE BODY TParcelle AS

  MEMBER FUNCTION CulturesParCampagne (
    p_campagne IN REF TCampagneAgricole
  ) RETURN TSetRefCulture IS

    l_cultures TSetRefCulture;
  BEGIN
    /*
      On parcourt seulement la collection self.semis : REF TSemis
      - On filtre les semis dont campagne = p_campagne
      - On récupère la REF TCulture de chaque semis
      - DISTINCT via MULTISET pour éviter les doublons
    */
    SELECT CAST(
             MULTISET(
               SELECT DISTINCT DEREF(s.COLUMN_VALUE).culture
                 FROM TABLE(
                        CAST(self.semis AS TSetRefSemis)
                      ) s
                WHERE DEREF(s.COLUMN_VALUE).campagne = p_campagne
             )
             AS TSetRefCulture
           )
      INTO l_cultures
      FROM dual;

    RETURN l_cultures;
  END CulturesParCampagne;

END;
/
-- METHODE 4 :Pour chaque parcelle, retourner uniquement les maladies détectées avec un niveau de gravité forte. 
-- 1) Signature de la nouvelle méthode
ALTER TYPE TParcelle
  ADD MEMBER FUNCTION MaladiesGraves
    RETURN TSetRefMaladie
  CASCADE;


-- 2) Ré-écriture complète du TYPE BODY pour inclure
--    à la fois CulturesParCampagne et MaladiesGraves

CREATE OR REPLACE TYPE BODY TParcelle AS

  /* Méthode existante : liste des cultures pour une campagne */
  MEMBER FUNCTION CulturesParCampagne (
    p_campagne IN REF TCampagneAgricole
  ) RETURN TSetRefCulture IS
    l_cultures TSetRefCulture;
  BEGIN
    SELECT CAST(
             MULTISET(
               SELECT DISTINCT DEREF(s.COLUMN_VALUE).culture
                 FROM TABLE(CAST(self.semis AS TSetRefSemis)) s
                WHERE DEREF(s.COLUMN_VALUE).campagne = p_campagne
             )
             AS TSetRefCulture
           )
      INTO l_cultures
      FROM dual;
    RETURN l_cultures;
  END CulturesParCampagne;


  /* Nouvelle méthode : maladies de gravité 'forte' */
  MEMBER FUNCTION MaladiesGraves RETURN TSetRefMaladie IS
    l_maladies TSetRefMaladie;
  BEGIN
    SELECT CAST(
             MULTISET(
               SELECT DISTINCT DEREF(d.COLUMN_VALUE).maladie
                 FROM TABLE(CAST(self.detections AS TSetRefDetectionMaladie)) d
                WHERE DEREF(d.COLUMN_VALUE).gravite = 'forte'
             )
             AS TSetRefMaladie
           )
      INTO l_maladies
      FROM dual;
    RETURN l_maladies;
  END MaladiesGraves;

END;
/

-- METHODE 5 : pour chaque drone,  donner toutes les missions du drone correspondant à un certain type (ex. : traitement). 
-- 1) Signature de la méthode dans la spécification
ALTER TYPE TDrone
  ADD MEMBER FUNCTION MissionsParType (
    p_type IN VARCHAR2
  ) RETURN TSetRefMissionDrone
  CASCADE;


-- 2) Corps de la méthode
CREATE OR REPLACE TYPE BODY TDrone AS

  MEMBER FUNCTION MissionsParType (
    p_type IN VARCHAR2
  ) RETURN TSetRefMissionDrone IS

    l_missions TSetRefMissionDrone;
  BEGIN
    /*
      On parcourt la collection self.missions : REF TMissionDrone
      - On filtre sur deref(m).typeMission = p_type
      - DISTINCT via MULTISET pour éviter doublons
    */
    SELECT CAST(
             MULTISET(
               SELECT DISTINCT DEREF(m.COLUMN_VALUE)
                 FROM TABLE(
                        CAST(self.missions AS TSetRefMissionDrone)
                      ) m
                WHERE DEREF(m.COLUMN_VALUE).typeMission = p_type
             )
             AS TSetRefMissionDrone
           )
      INTO l_missions
      FROM dual;

    RETURN l_missions;
  END MissionsParType;

END;
/

-- ************************************************7. Définir les tables nécessaires à la base de données.************************************************
-- TABLE EXPLOITATIONS 

CREATE TABLE Exploitations OF TExploitation
(
  CONSTRAINT pk_exploit PRIMARY KEY (idExploitation)
)
  NESTED TABLE parcelles STORE AS Exploitations_Parcelles;

-- TABLE PARCELLES 
CREATE TABLE Parcelles OF TParcelle
(
  CONSTRAINT pk_parcelle PRIMARY KEY (idParcelle),
  CONSTRAINT fk_exploitation FOREIGN KEY (exploitation) REFERENCES Exploitations,
  CONSTRAINT check_type_sol CHECK (typeSol IN ('argileux', 'sableux', 'limoneux', 'calcaire', 'humifère', 'tourbeux'))
)
  NESTED TABLE semis STORE AS Parcelles_Semis,
  NESTED TABLE detections STORE AS Parcelles_Detections,
  NESTED TABLE missions STORE AS Parcelles_Missions;

-- TABLE CULTURES 
CREATE TABLE Cultures OF TCulture
(
  CONSTRAINT pk_culture PRIMARY KEY (idCulture)
);

-- TABLE CampagnesAgricoles
CREATE TABLE CampagnesAgricoles OF TCampagneAgricole
(
  CONSTRAINT pk_campagne PRIMARY KEY (idCampagne)
)
  NESTED TABLE semis STORE AS Campagnes_Semis,
  NESTED TABLE detections STORE AS Campagnes_Detections,
  NESTED TABLE missions STORE AS Campagnes_Missions;

-- TABLE SEMIS 
CREATE TABLE Semis OF TSemis
(
  CONSTRAINT pk_semis PRIMARY KEY (idSemis),
  CONSTRAINT fk_parcelle FOREIGN KEY (parcelle) REFERENCES Parcelles,
  CONSTRAINT fk_culture FOREIGN KEY (culture) REFERENCES Cultures,
  CONSTRAINT fk_campagne FOREIGN KEY (campagne) REFERENCES CampagnesAgricoles
);

-- TABLE MALADIE 
CREATE TABLE Maladies OF TMaladie
(
  CONSTRAINT pk_maladie PRIMARY KEY (idMaladie),
  CONSTRAINT check_type_maladie CHECK (typeMaladie IN ('fongique', 'bactérienne', 'virale', 'parasitique', 'physiologique'))
)
  NESTED TABLE detections STORE AS Maladies_Detections,
  NESTED TABLE missions STORE AS Maladies_Missions;

-- TABLE DETECTION MALADIE
CREATE TABLE DetectionsMaladie OF TDetectionMaladie
(
  CONSTRAINT pk_detection PRIMARY KEY (idDetection),
  CONSTRAINT fk_parcelle_det FOREIGN KEY (parcelle) REFERENCES Parcelles,
  CONSTRAINT fk_campagne_det FOREIGN KEY (campagne) REFERENCES CampagnesAgricoles,
  CONSTRAINT fk_maladie_det FOREIGN KEY (maladie) REFERENCES Maladies,
  CONSTRAINT check_gravite CHECK (gravite IN ('faible', 'moyenne', 'forte'))
);

-- TABLE DRONE 
CREATE TABLE Drones OF TDrone
(
  CONSTRAINT pk_drone PRIMARY KEY (idDrone),
  CONSTRAINT check_type_drone CHECK (typeDrone IN ('multirotor', 'ailes fixes', 'hybride', 'à voilure tournante', 'autonome')),
  CONSTRAINT check_statut_drone CHECK (statutDrone IN ('Disponible', 'En Maintenance', 'En Mission'))
)
  NESTED TABLE missions STORE AS Drones_Missions;

-- TABLE MISSION DRONE 
CREATE TABLE MissionsDrone OF TMissionDrone
(
  CONSTRAINT pk_mission PRIMARY KEY (idMission),
  CONSTRAINT fk_drone FOREIGN KEY (drone) REFERENCES Drones,
  CONSTRAINT fk_parcelle_mis FOREIGN KEY (parcelle) REFERENCES Parcelles,
  CONSTRAINT fk_campagne_mis FOREIGN KEY (campagne) REFERENCES CampagnesAgricoles,
  CONSTRAINT fk_maladie_mis FOREIGN KEY (maladie) REFERENCES Maladies,
  CONSTRAINT check_type_mission CHECK (typeMission IN ('surveillance', 'traitement', 'cartographie', 'analyse thermique'))
);


-- E-  Langage d’interrogation de données 
-- 9. Lister les exploitations et leurs parcelles. 

SELECT 
  e.idExploitation AS "ID Exploitation",
  e.nomExploitation AS "Nom Exploitation",
  DEREF(p.COLUMN_VALUE).idParcelle AS "ID Parcelle",
  DEREF(p.COLUMN_VALUE).nomParcelle AS "Nom Parcelle"
FROM 
  Exploitations e,
  TABLE(e.parcelles) p;

-- 10. Calculer le taux de maladies pour chaque parcelle et pour chaque campagne. 
SELECT 
  d.parcelle.idParcelle        AS "ID Parcelle",
  d.campagne.annee             AS "Année Campagne",
  COUNT(d.idDetection)         AS "Nombre Maladies",
  (COUNT(d.idDetection) * 100.0 / (
    SELECT COUNT(*) 
    FROM DetectionsMaladie dm 
    WHERE dm.campagne.idCampagne = d.campagne.idCampagne
  ))                           AS "Taux (%)"
FROM 
  DetectionsMaladie d
GROUP BY 
  d.parcelle.idParcelle, 
  d.campagne.annee, 
  d.campagne.idCampagne;  -- Ajout de la clé primaire de campagne

  -- 11. Lister les missions de drones de traitement
SELECT 
  m.idMission AS "ID Mission",
  m.dateMission AS "Date Mission",
  DEREF(m.drone).modele AS "Modèle Drone",
  DEREF(m.parcelle).nomParcelle AS "Parcelle"
FROM 
  MissionsDrone m
WHERE 
  m.typeMission = 'traitement';

  -- 12. Historique des cultures semées par parcelle et exploitation
SELECT 
  p.idParcelle AS "ID Parcelle",
  e.nomExploitation AS "Exploitation",
  DEREF(s.COLUMN_VALUE).culture.nomCulture AS "Culture",
  DEREF(s.COLUMN_VALUE).dateSemis AS "Date Semis"
FROM 
  Parcelles p,
  TABLE(p.semis) s,
  Exploitations e
WHERE 
  p.exploitation.idExploitation = e.idExploitation;

-- 13. Drones disponibles pour une mission de surveillance
SELECT 
  d.idDrone AS "ID Drone",
  d.modele AS "Modèle",
  d.typeDrone AS "Type"
FROM 
  Drones d
WHERE 
  d.statutDrone = 'Disponible'
  AND d.idDrone IN (
    SELECT DEREF(m.drone).idDrone
    FROM MissionsDrone m
    WHERE m.typeMission = 'surveillance'
  );

-- 14. Année avec le plus de maladies détectées
SELECT 
  c.annee AS "Année",
  COUNT(d.idDetection) AS "Nombre Maladies"
FROM 
  DetectionsMaladie d,
  CampagnesAgricoles c
WHERE 
  d.campagne.idCampagne = c.idCampagne
GROUP BY 
  c.annee
ORDER BY 
  COUNT(d.idDetection) DESC
FETCH FIRST 1 ROW ONLY;
