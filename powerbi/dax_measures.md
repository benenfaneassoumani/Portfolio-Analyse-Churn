# Power BI & DAX

##  CONTEXTE ET OBJECTIF
Bascule des données préparées de la base Oracle SQL vers l'outil de Business Intelligence (Power BI). L'objectif est de créer un tableau de bord de pilotage dynamique utilisant le langage DAX pour quantifier les clients en zone critique et mesurer l'impact financier potentiel du Churn.

---

##  1. EXTRACTION DES DONNÉES (DATA PREP)
Pour garantir un import propre, les données ont été extraites depuis l'invite de commande SQLPlus via la fonction SPOOL.

**Script d'exportation :**
```sql
SET MARKUP CSV ON;
SPOOL C:\Users\benen\Desktop\donnees_churn_modifié.csv;
SELECT * FROM V_TELECOM_CHURN_SEGMENTATION;
SPOOL OFF;
EXIT;


##  2. INDICATEURS GLOBAUX : LES MESURES "MÈRES" (DAX)
Ces mesures définissent la base de référence des clients actifs (Churn='No').

* **Total Clients Actifs** :
    * **Formule** : `Total Clients = DISTINCTCOUNT('donnees_churn_modifié'[CUSTOMERID])`
    * **Logique** : Garantit un comptage unique par ID client.
    * **Insight** : Représente la population exacte à protéger.

* **Revenu Mensuel Total (Enjeu Financier)** :
    * **Formule** : `Total Revenue = SUM('donnees_churn_modifié'[MONTHLYCHARGES])`
    * **Insight** : Définit la masse monétaire totale exposée au risque.

* **Score Moyen Global (Early Warning)** :
    * **Formule** : `Score Moyen = AVERAGE('donnees_churn_modifié'[score_risque])`
    * **Insight** : Sert de thermomètre pour la base client ; une hausse du score moyen alerte sur une fragilisation globale de la base.

---

##  3. INDICATEURS DE CRISE : LES MESURES "FILLES" (FILTRES DE RISQUE)
Utilisation de la fonction **CALCULATE** pour isoler les segments à risque.

* **Clients en Zone Critique (Urgence)** :
    * **Formule** : `Clients Urgence = CALCULATE([Total Clients], score_risque >= 10)`
    * **Insight** : Identifie les  clients en danger immédiat en zone urgence

* **Revenu Mensuel à Risque** :
    * **Formule** : `Revenue At Risk = CALCULATE([Total Revenue], score_risque >= 10)`
    * **Insight** : Transforme l'analyse technique en argument financier : le montant du CA perdu si aucune action n'est menée.

* **Part de la Base en Urgence (%)** :
    * **Formule** : `Part Urgence % = DIVIDE([Clients Urgence], [Total Clients])`
    * **Insight** : Permet de relativiser la gravité de la situation pour le management.

---

##  4. MESURES COMPLÉMENTAIRES : ZONE "ALERTE" (SCORE 7 À 9)
Suivi du segment secondaire présentant une fragilité avérée.

* **Clients Alerte** : 
    `Clients Alerte = CALCULATE([Total Clients], score_risque >= 7 && score_risque <= 9)`

* **Revenu Alerte** : 
    `Revenu Alerte = CALCULATE([Total Revenue], score_risque >= 7 && score_risque <= 9)`