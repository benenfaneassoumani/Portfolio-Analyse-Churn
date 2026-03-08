
-- ÉTAPE 1 : INGESTION DES DONNÉES (ORACLE)


-- Création de la table de réception pour le fichier CSV
CREATE TABLE clients (
    customerID VARCHAR2(50),
    gender VARCHAR2(20),
    SeniorCitizen VARCHAR2(5),
    Partner VARCHAR2(5),
    Dependents VARCHAR2(5),
    tenure NUMBER(5),
    PhoneService VARCHAR2(5),
    MultipleLines VARCHAR2(50),
    InternetService VARCHAR2(50),
    OnlineSecurity VARCHAR2(50),
    OnlineBackup VARCHAR2(50),
    DeviceProtection VARCHAR2(50),
    TechSupport VARCHAR2(50),
    StreamingTV VARCHAR2(50),
    StreamingMovies VARCHAR2(50),
    Contract VARCHAR2(50),
    PaperlessBilling VARCHAR2(50),
    PaymentMethod VARCHAR2(100),
    MonthlyCharges VARCHAR2(255),
    TotalCharges VARCHAR2(50),
    Churn VARCHAR2(10)
);

