- ==========================================
-- ÉTAPE 3 : ANALYSE EXPLORATOIRE (UNIVARIÉE)
-- Objectif : Comprendre le profil de la base clients
-- ==========================================

-- 1. PROFIL DÉMOGRAPHIQUE
-- Genre : Parité quasi parfaite (50/50).
SELECT gender, COUNT(*) FROM clients GROUP BY gender;

-- Âge : Base client majoritairement jeune (16% de seniors).
SELECT SeniorCitizen, COUNT(*) FROM clients GROUP BY SeniorCitizen;

-- Foyer : Légère majorité de personnes seules (52%).
SELECT Partner, COUNT(*) FROM clients GROUP BY Partner;

-- Personnes à charge : 70% n'ont pas de personnes à charge.
SELECT Dependents, COUNT(*) FROM clients GROUP BY Dependents;


-- 2. SERVICES & ÉQUIPEMENTS
-- Ligne Fixe : 90% des clients sont équipés (service de commodité).
SELECT PhoneService, COUNT(*) FROM clients GROUP BY PhoneService;

-- Lignes Multiples : ~47% des clients téléphone ont plusieurs lignes.
SELECT MultipleLines, COUNT(*) FROM clients GROUP BY MultipleLines;

-- Internet : Positionnement Premium (Fibre optique majoritaire à 44%).
SELECT InternetService, COUNT(*) FROM clients GROUP BY InternetService;

-- Support Technique : Plus de 60% n'ont pas cette option (risque majeur).
SELECT TechSupport, COUNT(*) FROM clients GROUP BY TechSupport;

-- Sécurité, Sauvegarde et Protection : Réponse majoritairement "Non".
SELECT OnlineSecurity, COUNT(*) FROM clients GROUP BY OnlineSecurity;
SELECT OnlineBackup, COUNT(*) FROM clients GROUP BY OnlineBackup;
SELECT DeviceProtection, COUNT(*) FROM clients GROUP BY DeviceProtection;

-- Divertissement : Répartition équilibrée (~50/50 chez les internautes).
SELECT StreamingTV, COUNT(*) FROM clients GROUP BY StreamingTV;
SELECT StreamingMovies, COUNT(*) FROM clients GROUP BY StreamingMovies;


-- 3. CONTRATS ET FINANCES
-- Engagement : 55% de contrats mensuels (Month-to-month).
SELECT Contract, COUNT(*) FROM clients GROUP BY Contract;

-- Facturation dématérialisée : ~60% en facturation digitale.
SELECT PaperlessBilling, COUNT(*) FROM clients GROUP BY PaperlessBilling;

-- Paiement : Le chèque électronique est leader (33%).
SELECT PaymentMethod, COUNT(*) FROM clients GROUP BY PaymentMethod;


-- 4. ANALYSE QUANTITATIVE (COMBIEN ?)
-- Ancienneté (Moyenne de 32 mois)
SELECT MIN(tenure) AS tenure_min, ROUND(AVG(tenure), 2) AS tenure_avg, MAX(tenure) AS tenure_max FROM clients;

-- Revenu Mensuel (  Moyenne de 64.76 $)
SELECT ROUND(AVG(MonthlyCharges), 2) AS revenu_mensuel_moyen FROM clients;

--  (Revenu total généré- Moyenne de 2280 $)
SELECT ROUND(AVG(TO_NUMBER(TotalCharges)), 2) AS Revenu_total_généré_moyen FROM clients;