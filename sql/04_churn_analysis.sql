
-- ÉTAPE 4 : ANALYSE BIVARIÉE (FACTEURS DE CHURN)
-- Objectif : Étude des 12 variables clés pour la construction du score de risque


-- 1. LE TYPE DE CONTRAT
-- Analyse : Le contrat mensuel présente un taux de départ très important (42,71%), largement supérieur aux contrats annuels
SELECT contract, COUNT(*), SUM(CASE WHEN CHURN='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN CHURN='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100, 2) AS taux_depart FROM clients GROUP BY contract ORDER BY taux_depart DESC;

-- 2. LE SERVICE INTERNET
-- Analyse : Le taux de départ sur la Fibre optique est très élevé (41,89%) comparé à l'ADSL
SELECT InternetService, COUNT(*), SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2) AS taux_depart FROM clients GROUP BY InternetService ORDER BY taux_depart DESC;

-- 3. LA SÉCURITÉ EN LIGNE (OnlineSecurity)
-- Analyse : L'absence de ce service augmente nettement le risque de départ (41,77%)
SELECT OnlineSecurity, COUNT(*), SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2) AS taux_depart FROM clients GROUP BY OnlineSecurity ORDER BY taux_depart DESC;

-- 4. LA SAUVEGARDE EN LIGNE (OnlineBackup)
-- Analyse : Les clients sans sauvegarde en ligne partent davantage (39,93%)
SELECT OnlineBackup, COUNT(*), SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2) AS taux_depart FROM clients GROUP BY OnlineBackup ORDER BY taux_depart DESC;

-- 5. LA PROTECTION DE L'APPAREIL (DeviceProtection)
-- Analyse : Ne pas avoir cette protection est un facteur de risque avec un taux de départ à 39,13%
SELECT DeviceProtection, COUNT(*), SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2) AS taux_depart FROM clients GROUP BY DeviceProtection ORDER BY taux_depart DESC;

-- 6. LE SUPPORT TECHNIQUE (TechSupport)
-- Analyse : Sans support technique, le taux de départ monte à 41,64%
SELECT TechSupport, COUNT(*), SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2) AS taux_depart FROM clients GROUP BY TechSupport ORDER BY taux_depart DESC;

-- 7. LA FACTURATION DÉMATÉRIALISÉE (PaperlessBilling)
-- Analyse : Les clients avec facture électronique partent plus (33,57%) que ceux avec facture papier (16,33%)
SELECT PaperlessBilling, COUNT(*), SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2) AS taux_depart FROM clients GROUP BY PaperlessBilling ORDER BY taux_depart DESC;

-- 8. LA MÉTHODE DE PAIEMENT (PaymentMethod)
-- Analyse : Le chèque électronique est le moyen de paiement avec le plus haut taux de départ (45,29%)
SELECT PaymentMethod, COUNT(*), SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2) AS taux_depart FROM clients GROUP BY PaymentMethod ORDER BY taux_depart DESC;

-- 9. L'ÂGE (SeniorCitizen)
-- Analyse : Les seniors ont un taux de départ important de 41,68%
SELECT SeniorCitizen, COUNT(*), SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2) AS taux_depart FROM clients GROUP BY SeniorCitizen ORDER BY taux_depart DESC;

-- 10. LE STATUT MARITAL (Partner)
-- Analyse : Les clients célibataires partent plus (32,96%) que ceux en couple
SELECT Partner, COUNT(*), SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2) AS taux_depart FROM clients GROUP BY Partner ORDER BY taux_depart DESC;

-- 11. LES PERSONNES À CHARGE (Dependents)
-- Analyse : Les clients sans personnes à charge partent beaucoup plus (31,28%) que les familles (15,45%)
SELECT Dependents, COUNT(*), SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2) AS taux_depart FROM clients GROUP BY Dependents ORDER BY taux_depart DESC;

-- 12. L'ANCIENNETÉ (Tenure)
-- Analyse : Les départs se concentrent surtout dans les tout premiers mois, avec un pic à près de 62% le premier mois
SELECT tenure, COUNT(*), SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS tot_depart, ROUND(SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2) AS taux_depart FROM clients GROUP BY tenure ORDER BY taux_depart DESC;

-- BONUS : L'IMPACT FINANCIER DU DÉPART
-- Analyse : Les clients qui partent ont en moyenne une facture mensuelle plus chère (74,44 $) que ceux qui restent (61,27 $)
SELECT churn AS statut_depart, COUNT(*) AS nombre_clients, ROUND(AVG(monthlycharges), 2) AS facture_mensuelle_moyenne FROM clients GROUP BY churn;