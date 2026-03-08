
-- FICHIER  SQL*LOADER
-- Objectif : Importer le CSV dans la table Oracle


-- Demande à SQL*Loader d'ignorer la première ligne du fichier CSV (ligne d'en-tête)
OPTIONS (SKIP=1)

-- Indique à SQL*Loader qu'on va charger des données
LOAD DATA

-- Précise le fichier source contenant les données à importer
INFILE 'churn_data.csv'

-- Spécifie la table Oracle dans laquelle les données seront insérées
INTO TABLE clients

-- Indique que les champs du fichier sont séparés par des virgules
FIELDS TERMINATED BY ','

OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges,
    Churn
)