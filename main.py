from dotenv import load_dotenv
import os
import streamlit as st
import pandas as pd
from pandasai import SmartDataframe
from pandasai.llm.openai import OpenAI

load_dotenv()

API_KEY = os.getenv('OPENAI_API_KEY')

# Inicializa el componente de OpenAI con la API Key
llm = OpenAI(api_token=API_KEY, model="gpt-3.5-turbo")


# Título de la aplicación de Streamlit
st.title("Test data-driven prompt")
uploaded_file = st.file_uploader("Sube tus archivos para el análisis", type=['csv'])

if uploaded_file is not None:
    df = pd.read_csv(uploaded_file)
    st.write(df.head(5))
    sdf = SmartDataframe(df, config={"llm": llm})  # Asumiendo que SmartDataframe es correcto

    prompt = st.text_area("Introduce tu prompt:")

    if st.button("Generate"):
        if prompt:
            st.write("PandasAI está analizando, por favor espere un momento...")
            response = sdf.chat(prompt)  # Suponiendo que sdf tiene un método .chat()
            st.write(response)
        else:
            st.write("Introduce tu prompt:")
