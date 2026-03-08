
-- ÉTAPE 2 : NETTOYAGE ET TYPAGE DES DONNÉES


-- 1. Nettoyage des valeurs vides et des espaces dans TotalCharges
UPDATE clients 
SET TotalCharges = '0' 
WHERE TotalCharges = ' ' OR TotalCharges IS NULL;

COMMIT;

-- 2. Conversion de TotalCharges de texte (VARCHAR2) vers numérique (NUMBER)
-- A. Création d'une nouvelle colonne temporaire
ALTER TABLE clients ADD TotalCharges_New NUMBER(10,2);

-- B. Copie et conversion des données
UPDATE clients
SET TotalCharges_New = TO_NUMBER(TotalCharges);

COMMIT;

-- C. Suppression de l'ancienne colonne texte
ALTER TABLE clients DROP COLUMN TotalCharges;

-- D. Renommage de la nouvelle colonne pour finaliser la bascule
ALTER TABLE clients RENAME COLUMN TotalCharges_New TO TotalCharges;

-- 3. Sécurisation de la table avec une Clé Primaire
ALTER TABLE clients ADD CONSTRAINT pk_clients PRIMARY KEY (customerID);