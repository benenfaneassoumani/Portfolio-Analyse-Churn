
-- ÉTAPE 3 : ANALYSE EXPLORATOIRE (UNIVARIÉE)
-- Objectif : Comprendre le profil de la base clients


-- 1. PROFIL DÉMOGRAPHIQUE
-- Genre : La parité est quasi parfaite (50/50), ce n'est pas un facteur discriminant.
SELECT gender, COUNT(*) 
FROM clients 
GROUP BY gender;

-- Âge : La base client est majoritairement jeune, avec 16% de seniors.
SELECT SeniorCitizen, COUNT(*) 
FROM clients 
GROUP BY SeniorCitizen;

-- Foyer : Plus de la moitié des clients sont célibataires et 70% n'ont pas de personnes à charge.
SELECT Partner, COUNT(*) FROM clients GROUP BY Partner;
SELECT Dependents, COUNT(*) FROM clients GROUP BY Dependents;


-- 2. SERVICES SOUSCRITS
-- Internet : L'opérateur a un positionnement Premium (Fibre optique majoritaire à 44%).
SELECT InternetService, COUNT(*) 
FROM clients 
GROUP BY InternetService;

-- Options de sécurité et support technique : Sous-souscription massive constatée.
SELECT TechSupport, COUNT(*) FROM clients GROUP BY TechSupport;
SELECT OnlineSecurity, COUNT(*) FROM clients GROUP BY OnlineSecurity;


-- 3. CONTRATS ET FINANCES
-- Engagement : 55% de contrats mensuels (Month-to-month), révélant une base client très instable.
SELECT Contract, COUNT(*) 
FROM clients 
GROUP BY Contract;

-- Paiement : Le chèque électronique (manuel) est leader à 33%, créant un point de friction mensuel.
SELECT PaymentMethod, COUNT(*) 
FROM clients 
GROUP BY PaymentMethod;

-- Statistiques quantitatives (Ancienneté et Revenus)
-- Ancienneté moyenne de 32 mois (2,5 ans) et panier moyen (ARPU) élevé à environ 64,76$.
SELECT 
    MIN(tenure) AS tenure_min,
    ROUND(AVG(tenure), 2) AS tenure_avg,
    MAX(tenure) AS tenure_max
FROM clients;

SELECT 
    ROUND(AVG(MonthlyCharges), 2) AS ARPU_moyen
FROM clients;