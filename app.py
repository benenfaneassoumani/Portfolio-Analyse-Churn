import streamlit as st
import pandas as pd

# Configuration de la page
st.set_page_config(layout="wide")

# --- CHARGEMENT DES DONNÉES ---
@st.cache_data
def load_data():
    try:
        # Lecture du fichier avec séparateur point-virgule et virgule pour les décimales
        df = pd.read_csv("churn_data.csv", sep=";", decimal=",")
        return df
    except Exception as e:
        st.error(f"Erreur lors du chargement du fichier : {e}")
        return None

df = load_data()

# --- TITRE ET INTRODUCTION ---
st.title("Analyse du risque de churn client")
st.write("Objectif du projet : L’objectif de ce projet est d’analyser le risque de churn dans une base clients d’un opérateur télécom. L’analyse vise à identifier les clients présentant un risque de résiliation, estimer l’impact financier potentiel et proposer des actions de fidélisation basées sur les données.")

if df is not None:
    # --- STRUCTURE DES ONGLETS ---
    tab1, tab2, tab3 = st.tabs([
        "📊 Tableau de Bord Interactif", 
        "🎯 Stratégies de Fidélisation", 
        "📈 Rapport Power BI"
    ])

    # --- ONGLET 1 : 📊 TABLEAU DE BORD INTERACTIF ---
    with tab1:
        # Curseur pour filtrer SCORE_RISQUE
        min_s = int(df["SCORE_RISQUE"].min())
        max_s = int(df["SCORE_RISQUE"].max())
        
        score_range = st.slider(
            "Filtrer par SCORE_RISQUE",
            min_value=min_s,
            max_value=max_s,
            value=(min_s, max_s)
        )
        
        # Filtrage des données
        df_filtered = df[(df["SCORE_RISQUE"] >= score_range[0]) & (df["SCORE_RISQUE"] <= score_range[1])]
        
        # Indicateurs Clés de Performance (KPIs)
        col1, col2, col3 = st.columns(3)
        
        with col1:
            st.metric("Nombre de clients", f"{len(df_filtered)}")
            
        with col2:
            # Conversion de MONTHLYCHARGES en numérique si nécessaire et calcul du revenu total
            total_revenue = df_filtered["MONTHLYCHARGES"].sum()
            st.metric("Revenu total", f"{total_revenue:,.2f} €".replace(",", " ").replace(".", ","))
            
        with col3:
            avg_score = df_filtered["SCORE_RISQUE"].mean()
            st.metric("Score moyen", f"{avg_score:.2f}")
            
        # Affichage du tableau des clients filtrés
        st.dataframe(df_filtered, use_container_width=True)

    # --- ONGLET 2 : 🎯 STRATÉGIES DE FIDÉLISATION ---
    with tab2:
        st.write("Les données suggèrent que les actions suivantes pourraient améliorer la fidélisation et stabiliser le chiffre d'affaires.")
        
        with st.expander("🔴 Urgence (Scores 10 à 12)"):
            st.write("- **Conversion vers un contrat avec engagement** : proposer un passage au contrat d'un an avec remise de 30 pour cent sur les 3 premiers mois.")
            st.write("- **Audit technique premium pour les clients Fibre** : intervention proactive pour optimiser l'installation.")
            st.write("- **Incitation au prélèvement automatique** : crédit de 15 euros pour abandonner le paiement par chèque.")
            st.write("- **Programme d'accompagnement des nouveaux clients** : appels de suivi aux troisième et sixième mois.")

        with st.expander("🟠 Alerte renforcée (Scores 7 à 9)"):
            st.write("5. **Support technique premium** : assistance prioritaire offerte pendant 6 mois.")
            st.write("6. **Pack protection sécurité** : antivirus et sécurité réseau à 1 euro par mois.")
            st.write("7. **Facture interactive** : courrier électronique pédagogique expliquant les services consommés.")
            st.write("8. **Espace de stockage gratuit** : 50 Gigaoctets offerts pour renforcer l'attachement à l'écosystème.")

        with st.expander("🟢 Optimisation du Lien Relationnel (Scores inférieurs à 7)"):
            st.write("9. **Parcours senior dédié** : assistance simplifiée et conseillers spécialisés.")
            st.write("10. **Offre Duo** : réduction sur une seconde ligne mobile pour un proche.")
            st.write("11. **Pack Mobilité** : transfert gratuit de l'abonnement lors d'un déménagement et prêt d'une clé 4G.")

    # --- ONGLET 3 : 📈 RAPPORT POWER BI ---
    with tab3:
        st.subheader("Dashboard décisionnel Power BI ")
        st.write("En complément de cet outil interactif, un tableau de bord décisionnel a été développé avec Power BI afin de suivre les indicateurs financiers liés au churn et de segmenter les clients selon leur niveau de risque.")
        
        # Affichage de l'image
        st.image("capturepowerbi.png", caption="Tableau de bord décisionnel Power BI", use_container_width=True)
