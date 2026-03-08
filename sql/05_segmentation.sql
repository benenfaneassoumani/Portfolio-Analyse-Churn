
-- ÉTAPE 5 : SEGMENTATION ET SCORING
-- Objectif : Créer une vue avec un score de risque et des segments stratégiques


-- Création d'une vue qui calcule automatiquement le score et le segment pour chaque client actif (Churn = 'No')
CREATE OR REPLACE VIEW V_TELECOM_CHURN_SEGMENTATION AS
SELECT 
    customerid, tenure, contract, monthlycharges, internetservice,
    techsupport, onlinesecurity, onlinebackup, paymentmethod,
    paperlessbilling, seniorcitizen, partner, dependents,

    -- 1. CALCUL DU SCORE DE RISQUE (de 0 à 11)
    -- On ajoute 1 point pour chaque critère de risque validé par le client
    ( 
      (CASE WHEN contract='Month-to-month' THEN 1 ELSE 0 END) +
      (CASE WHEN dependents='No' THEN 1 ELSE 0 END) + 
      (CASE WHEN seniorcitizen=1 THEN 1 ELSE 0 END) + 
      (CASE WHEN Partner='No' THEN 1 ELSE 0 END) + 
      (CASE WHEN tenure IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19,21,22,25,32) THEN 1 ELSE 0 END) +
      (CASE WHEN internetservice='Fiber optic' THEN 1 ELSE 0 END) + 
      (CASE WHEN onlinesecurity='No' THEN 1 ELSE 0 END) +
      (CASE WHEN onlinebackup='No' THEN 1 ELSE 0 END) + 
      (CASE WHEN techsupport='No' THEN 1 ELSE 0 END) +
      (CASE WHEN paperlessbilling='Yes' THEN 1 ELSE 0 END) + 
      (CASE WHEN paymentmethod='Electronic check' THEN 1 ELSE 0 END) 
    ) AS score_risque,
  
    -- 2. DÉFINITION DES SEGMENTS STRATÉGIQUES
    -- En fonction du score obtenu, on classe le client dans une catégorie de plan d'action
    CASE 
        WHEN ( 
               (CASE WHEN contract='Month-to-month' THEN 1 ELSE 0 END) +
               (CASE WHEN dependents='No' THEN 1 ELSE 0 END) + 
               (CASE WHEN seniorcitizen=1 THEN 1 ELSE 0 END) + 
               (CASE WHEN Partner='No' THEN 1 ELSE 0 END) + 
               (CASE WHEN tenure IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19,21,22,25,32) THEN 1 ELSE 0 END) +
               (CASE WHEN internetservice='Fiber optic' THEN 1 ELSE 0 END) + 
               (CASE WHEN onlinesecurity='No' THEN 1 ELSE 0 END) +
               (CASE WHEN onlinebackup='No' THEN 1 ELSE 0 END) + 
               (CASE WHEN techsupport='No' THEN 1 ELSE 0 END) +
               (CASE WHEN paperlessbilling='Yes' THEN 1 ELSE 0 END) + 
               (CASE WHEN paymentmethod='Electronic check' THEN 1 ELSE 0 END) 
             ) >= 10 THEN 'Urgence '

        WHEN ( 
               (CASE WHEN contract='Month-to-month' THEN 1 ELSE 0 END) +
               (CASE WHEN dependents='No' THEN 1 ELSE 0 END) + 
               (CASE WHEN seniorcitizen=1 THEN 1 ELSE 0 END) + 
               (CASE WHEN Partner='No' THEN 1 ELSE 0 END) + 
               (CASE WHEN tenure IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19,21,22,25,32) THEN 1 ELSE 0 END) +
               (CASE WHEN internetservice='Fiber optic' THEN 1 ELSE 0 END) + 
               (CASE WHEN onlinesecurity='No' THEN 1 ELSE 0 END) +
               (CASE WHEN onlinebackup='No' THEN 1 ELSE 0 END) + 
               (CASE WHEN techsupport='No' THEN 1 ELSE 0 END) +
               (CASE WHEN paperlessbilling='Yes' THEN 1 ELSE 0 END) + 
               (CASE WHEN paymentmethod='Electronic check' THEN 1 ELSE 0 END) 
             ) >= 7 THEN 'Alerte Renforcee'

        ELSE 'Surveillance Relationnelle'
    END AS segment_strategique

FROM clients 
-- On cible uniquement les clients qui sont encore dans l'entreprise télécom (Churn = 'No') pour les fidéliser
WHERE churn='No';