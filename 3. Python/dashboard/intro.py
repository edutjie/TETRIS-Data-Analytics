import streamlit as st
import lorem
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from PIL import Image
from numerize import numerize

plt.style.use("seaborn")

st.set_page_config(
    page_title="Streamlit Intro",
    # layout="wide"
)
st.write("Hello World!")

"Ini Hello World tapi pakai magic"

st.markdown("> Nama saya ***Edu***")
st.markdown("---")

st.title("Introduction to Streamlit")
st.subheader(lorem.sentence())
st.write(lorem.paragraph())

st.code("import streamlit as st")

st.text("This is a text")
st.markdown("---")

st.title("Data Frame")
st.subheader("store.csv")
df = pd.read_csv("data/store.csv")
df["Order Date"] = pd.to_datetime(df["Order Date"])
df["Ship Date"] = pd.to_datetime(df["Ship Date"])

st.dataframe(df)

# metrics
st.title("Metrics")
st.metric("Sales", "10M", "156000")
st.metric("Profit", "1M", "15240")

# plotting
st.title("Charts")

met1, met2, met3 = st.columns(3)
with met1:
    total_sales = numerize.numerize(df["Sales"].sum())
    st.metric("Sales", f"$ {total_sales}", "2.5%")
with met2:
    total_profit = numerize.numerize(df["Profit"].sum())
    st.metric("Profit", f"$ {total_profit}", "5%")
with met3:
    total_order = df["Order ID"].count()
    st.metric("Total Order", total_order, "20%")

# sidebar
with st.sidebar:
    st.title("Sidebar")

    freq_col, feature_col = st.columns(2)
    with freq_col:
        freq = st.selectbox("Frequency", ["D", "W", "M", "Q", "Y"])
    with feature_col:
        feature = st.selectbox("Feature", ["Sales", "Profit"])
    
    # expander
    st.title("Expander")
    with st.expander("Expand Me"):
        st.write(lorem.paragraph())
    
desc1, chart1 = st.columns([2,4])
with desc1:
    st.dataframe(df.set_index("Order Date")[feature].resample(freq).sum())
with chart1:
    sales = df.set_index("Order Date")[feature].resample(freq).sum()
    st.line_chart(sales)

fig, ax = plt.subplots(figsize=(10, 5))
sns.scatterplot(x=df["Sales"], y=df["Profit"], ax=ax)
st.pyplot(fig)

# input
st.title("Input")
button = st.button("Click me")
st.write(f"Clicked Status: {button}")

number = st.selectbox("Select a number", [1, 2, 3, 4, 5])
st.write(f"You selected: {number}")

checked = st.checkbox("Check me")
if checked:
    st.write("You checked me")
else:
    st.write("You didn't check me")

name = input_text = st.text_input("Enter your name")
st.write(f"Hello {name}!")

number2 = st.number_input("Enter a number", value=0, step=1)
if number2 % 2 == 0:
    st.success(f"{number2} is an even number")
else:
    st.error(f"{number2} is an odd number")

# image
# tabs
st.title("Tabs")
img1, img2 = st.tabs(["Tabs", "Tab 2"])
with img1:
    img = Image.open("images/1.png")
    st.image(img)
with img2:
    img = Image.open("images/2.png")
    st.image(img)

# columns
st.title("Columns")
col1, col2, col3 = st.columns(3)

with col1:
    st.write(lorem.paragraph())
    
with col2:
    st.write(lorem.paragraph())
    
with col3:
    st.write(lorem.paragraph())
