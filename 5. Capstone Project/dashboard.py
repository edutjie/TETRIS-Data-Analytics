import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

plt.style.use("seaborn")
st.set_page_config(
    page_title="Akibat Pandemi, Pekerja Anak di Indonesia Makin Banyak!",
    # layout="wide"
)

pp, name = st.columns([1, 10])
pp.image("data/profile/pp.png", width=60)
name.markdown(
    """
        <style>
            .name {
                margin-top: -15px;
            }
            .sub {
                margin-top: -20px;
            }
            .date {
                margin-top: -20px;
                font-size: 12px;
            }
        </style>
    """,
    unsafe_allow_html=True,
)
name.markdown("<h6 class='name'>Eduardus Tjitrahardja</h6>", unsafe_allow_html=True)
name.markdown("<p class='sub'>TETRIS II: Data Analytics</p>", unsafe_allow_html=True)
name.markdown("<p class='date'>1 Agustus 2022</p>", unsafe_allow_html=True)

"---"

st.title("Akibat Pandemi, Pekerja Anak di Indonesia Makin Banyak!")

st.write(
    """
        Anak bangsa merupakan masa depan dari negara ini dan semua pihak wajib menjamin pemenuhan HAM mereka. Kenyataannya,
        angka pekerja anak di Indonesia hingga kini masih memprihatinkan.
        
        Anak-anak hingga usia 18 tahun memiliki hak bersekolah untuk memperoleh pendidikan.
        Namun, banyak dari mereka terpaksa harus bekerja untuk membantu orang tua atau memenuhi kebutuhan hidupnya.
    """
)
st.info(
    "***UU No. 13 Tahun 2003** tentang Ketenagakerjaan menegaskan bahwa pengusaha dilarang mempekerjakan anak yang berusia kurang dari **18 tahun**.*"
)
st.write(
    """
        Berdasarkan data dari BPS, pada tahun **2020**, penduduk usia **10-17** tahun yang menjadi pekerja di tanah air sebesar **1,17 juta** anak pada 2020,
        naik **320 ribu** anak dibandingkan pada tahun sebelumnya **(⬆️38% dari 2019)**.
    """
)

st.markdown(
    "<h3>Persentase anak usia 10-17 tahun yang bekerja</h3>", unsafe_allow_html=True
)
labor_area, labor_gender = st.tabs(["Berdasarkan Area", "Berdasarkan Jenis Kelamin"])

with labor_area:
    pers_anak_kerja = pd.read_csv("data/child_labor_cleaned/pers_anak_kerja.csv")
    pers_anak_kerja["tahun"] = pd.to_datetime(pers_anak_kerja["tahun"].astype(str))
    pers_anak_kerja.set_index("tahun", inplace=True)
    area = st.selectbox(
        "Pilih Area",
        pers_anak_kerja.columns.unique(),
        index=len(pers_anak_kerja.columns.unique()) - 1,
    )

    fig, ax = plt.subplots(figsize=(10, 5))
    pers_anak_kerja[area].plot(marker="o", ax=ax)
    # create a seperator before and after 2020
    plt.axvline(x="2020", color="red", linestyle="--")
    fill_thresholds_min, fill_thresholds_max = (
        np.min(ax.get_yticks()) - 0.2,
        np.max(ax.get_yticks()) + 0.2,
    )
    ax.fill_between(
        pers_anak_kerja.index[:3],
        fill_thresholds_min,
        fill_thresholds_max,
        color="green",
        alpha=0.2,
    )
    ax.fill_between(
        pers_anak_kerja.index[2:],
        fill_thresholds_min,
        fill_thresholds_max,
        color="red",
        alpha=0.2,
    )
    ax.text("2020", fill_thresholds_max - 0.15, "Pandemi", style="italic")
    ax.text("2019", fill_thresholds_max - 0.15, "Sebelum Pandemi", style="italic")
    for i, value in enumerate(pers_anak_kerja[area]):
        ax.text(pers_anak_kerja.index[i], value + 0.05, value, style="italic")
    plt.ylabel("%")
    plt.annotate(
        "Sumber: Badan Pusat Statistik (BPS)",
        (0, 0),
        (0, -35),
        fontsize=10,
        xycoords="axes fraction",
        textcoords="offset points",
        va="top",
    )
    st.pyplot(fig)

with labor_gender:
    pers_anak_kerja_gender = pd.read_csv(
        "data/child_labor_cleaned/pers_anak_kerja_gender.csv"
    )
    pers_anak_kerja_gender["tahun"] = pd.to_datetime(
        pers_anak_kerja_gender["tahun"].astype(str)
    )
    pers_anak_kerja_gender.set_index("tahun", inplace=True)
    fig, ax = plt.subplots(figsize=(10, 5))
    pers_anak_kerja_gender["Laki-laki"].plot(marker="o", color="b", ax=ax)
    pers_anak_kerja_gender["Perempuan"].plot(marker="o", color="r", ax=ax)
    # create a seperator before and after 2020
    plt.axvline(x="2020", color="red", linestyle="--")
    fill_thresholds_min, fill_thresholds_max = (
        np.min(ax.get_yticks()) - 0.2,
        np.max(ax.get_yticks()) + 0.2,
    )
    ax.fill_between(
        pers_anak_kerja.index[:3],
        fill_thresholds_min,
        fill_thresholds_max,
        color="green",
        alpha=0.2,
    )
    ax.fill_between(
        pers_anak_kerja.index[2:],
        fill_thresholds_min,
        fill_thresholds_max,
        color="red",
        alpha=0.2,
    )
    ax.legend(["Laki-laki", "Perempuan"])
    # create text top left
    ax.text("2020", 3.6, "Pandemi", style="italic")
    ax.text("2019", 3.6, "Sebelum Pandemi", style="italic")
    for i, value in enumerate(pers_anak_kerja_gender["Laki-laki"]):
        ax.text(
            pers_anak_kerja.index[i], value + 0.05, value, style="italic", color="blue"
        )
    for i, value in enumerate(pers_anak_kerja_gender["Perempuan"]):
        ax.text(
            pers_anak_kerja.index[i], value - 0.15, value, style="italic", color="red"
        )
    plt.ylabel("%")
    plt.annotate(
        "Sumber: Badan Pusat Statistik (BPS)",
        (0, 0),
        (0, -35),
        fontsize=10,
        xycoords="axes fraction",
        textcoords="offset points",
        va="top",
    )
    st.pyplot(fig)

st.write(
    """
        Terdapat kenaikan pesat pada tahun **2020** dimana pandemi dimulai.
        Faktor penyebabnya bermacam-macam dan dalam kasus ini,
        diduga pandemi adalah penyebab terbesarnya.
        Pada tahun **2021**, jumlah tersebut sedikit turun dari tahun sebelumnya, dari **1,17 juta** menjadi sebanyak **940 ribu** pekerja anak.
        Masih sedikit lebih tinggi dari tahun-tahun sebelum pandemi. Bahkan jika kita lihat data di **Kalimantan Utara**, angkanya masih **naik** terus hingga **2021**.
    """
)

fig, ax = plt.subplots(figsize=(10, 3))
pers_anak_kerja_rank = pd.read_csv("data/child_labor_cleaned/pers_anak_kerja_rank.csv")
sns.barplot(x="provinsi", y="persentase", data=pers_anak_kerja_rank, palette="Blues_d")
plt.xticks(rotation=90)
plt.title("Peringkat Provinsi Anak Usia 10-17 Tahun Yang Bekerja 2021")
plt.ylabel("%")
for i in ax.containers:
    ax.bar_label(i, fontsize=8)
plt.annotate(
    "Sumber: Badan Pusat Statistik (BPS)",
    (0, 0),
    (0, -150),
    fontsize=10,
    xycoords="axes fraction",
    textcoords="offset points",
    va="top",
)
st.pyplot(fig)

col1, col2 = st.columns([3, 2])
fig, ax = plt.subplots(figsize=(7, 4))
angka_pekerja_anak_2020 = pd.read_csv(
    "data/child_labor_cleaned/angka_pekerja_anak_2020.csv"
)
angka_pekerja_anak_2020.set_index("tahun", inplace=True)
angka_pekerja_anak_2020.plot(kind="bar", ax=ax)
plt.ylabel("%")
for i in ax.containers:
    ax.bar_label(
        i,
    )
plt.annotate(
    "Sumber: Badan Pusat Statistik (BPS)",
    (0, 0),
    (0, -50),
    fontsize=10,
    xycoords="axes fraction",
    textcoords="offset points",
    va="top",
)
col1.pyplot(fig)
col2.markdown(
    "<h5>Kenaikan Angka Pekerja Anak Usia 10-17 Tahun Yang Bekerja Berdasarkan Kelompok Umur</h5>",
    unsafe_allow_html=True,
)
col2.write(
    """
        Kenaikan tertinggi terjadi pada usia **10-12 tahun (⬆️ 97% dari 2019)**.
        Angka pekerja anak pada usia **13-14** juga mengalami kenaikan yang cukup tinggi **(⬆️ 61% dari 2019)**.
        Sedangkan angka pekerja anak pada usia **15-17** mengalami penurunan sedikit **(🔻7.5% dari 2019)**.
    """
)

st.markdown("<h3>Sisi Gelap Pekerja Anak...</h3>", unsafe_allow_html=True)
st.write(
    """
        Pekerja anak berisiko putus sekolah dan masuk dalam situasi-situasi yang membahayakan diri sehingga mengancam tumbuh kembang yang optimal,
        seperti terlibat dalam kekerasan.
    """
)

status_sekolah, kekerasan_anak = st.tabs(["Status Sekolah", "Kekerasan Anak"])
with status_sekolah:
    fig, ax = plt.subplots(figsize=(10, 5))
    pekerja_anak_sekolah = pd.read_csv(
        "data/child_labor_cleaned/pekerja_anak_sekolah.csv"
    )
    pekerja_anak_sekolah.set_index("tahun", inplace=True)
    pekerja_anak_sekolah.plot(kind="bar", ax=ax)
    plt.title("Status Akademis Pekerja Anak")
    plt.ylabel("%")
    for i in ax.containers:
        ax.bar_label(
            i,
        )
    plt.legend(loc="upper center", bbox_to_anchor=(0.5, -0.15), ncol=3)
    plt.annotate(
        "Sumber: Badan Pusat Statistik (BPS)",
        (0, 0),
        (0, -50),
        fontsize=10,
        xycoords="axes fraction",
        textcoords="offset points",
        va="top",
    )
    st.pyplot(fig)
    st.write(
        """
            Status akademis pekerja anak didominasi oleh anak-anak yang sudah tidak bersekolah lagi **(15.83% pada tahun 2020 dan 15.03% pada tahun 2021)**.
            Hal ini membuktikan bahwa pekerja anak cenderung putus sekolah.
        """
    )

with kekerasan_anak:
    fig, ax = plt.subplots(figsize=(10, 5))
    kekerasan_anak_per_tahun = pd.read_csv(
        "data/child_labor_cleaned/kekerasan_anak_per_tahun.csv"
    )
    kekerasan_anak_per_tahun["tahun"] = pd.to_datetime(
        kekerasan_anak_per_tahun["tahun"].astype(str)
    )
    kekerasan_anak_per_tahun.set_index("tahun", inplace=True)
    kekerasan_anak_per_tahun.plot(marker="o", ax=ax)
    plt.title("Kekerasan Anak di Indonesia")
    plt.ylabel("Jumlah Kasus Kekerasan Anak")
    for i, value in enumerate(kekerasan_anak_per_tahun["total"]):
        ax.text(kekerasan_anak_per_tahun.index[i], value + 100, value, style="italic")
    plt.annotate(
        "Komisi Perlindungan Anak Indonesia (KPAI)",
        (0, 0),
        (0, -33),
        fontsize=10,
        xycoords="axes fraction",
        textcoords="offset points",
        va="top",
    )
    st.pyplot(fig)
    kekerasan_desc_col, kekerasan_corr_col = st.columns([4, 1])
    kekerasan_corr = pers_anak_kerja["INDONESIA"].corr(
        kekerasan_anak_per_tahun["total"]
    )

    with kekerasan_desc_col:
        st.write(
            """
                Sama seperti kenaikan pada pekerja anak, Terjadi kenaikan drastis pada kekerasan anak di Indonesia pada tahun **2020** dimana pandemi dimulai.
                Jumlah kasus kekerasan anak **berkorelasi tinggi** dengan persentase angka pekerja anak.
            """
        )
    with kekerasan_corr_col:
        st.metric(
            "Korelasi:",
            f"{kekerasan_corr*100:.2f}%",
        )
