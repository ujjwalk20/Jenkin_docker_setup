import streamlit as st

# Title of the app
st.title("Simple Streamlit App")

# Input text from the user
user_input = st.text_input("Enter your name:")

# Button to submit the input
if st.button("Submit"):
    # If the user has entered a name, display a welcome message
    if user_input:
        st.write(f"Hello, {user_input}!")
    else:
        st.write("Please enter a name.")
