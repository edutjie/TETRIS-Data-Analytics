import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import matplotlib.dates as mdates

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
        Berdasarkan data dari BPS, pada tahun **2020**, penduduk usia **10-17** tahun yang menjadi pekerja di tanah air sebesar **1,17 juta** anak,
        naik **320 ribu** anak dibandingkan pada tahun sebelumnya **(⬆️38% dari 2019)**.
    """
)

st.markdown(
    "<h3>Persentase anak usia 10-17 tahun yang bekerja</h3>", unsafe_allow_html=True
)
labor_area, labor_gender = st.tabs(["Berdasarkan Area", "Berdasarkan Jenis Kelamin"])


def plot_labor_area(area, ax):
    pers_anak_kerja_tmp = pers_anak_kerja[pers_anak_kerja["provinsi"] == area]
    sns.lineplot(x="tahun", y="persentase", data=pers_anak_kerja_tmp, marker="o", ax=ax)
    ax.xaxis.set_major_locator(mdates.YearLocator())
    ax.xaxis.set_ticklabels(
        [""] + sorted(pers_anak_kerja_tmp.tahun.dt.strftime("%Y-%b"))
    )
    # create a seperator before and after 2020
    plt.axvline(x=pd.to_datetime("2020-03-02"), color="red", linestyle="--")
    fill_thresholds_min, fill_thresholds_max = (
        np.min(ax.get_yticks()) - 0.2,
        np.max(ax.get_yticks()) + 0.2,
    )
    ax.fill_between(
        ["2018-12-31", "2020-03-02"],
        fill_thresholds_min,
        fill_thresholds_max,
        color="green",
        alpha=0.2,
    )
    ax.fill_between(
        ["2020-03-02", "2021-12-31"],
        fill_thresholds_min,
        fill_thresholds_max,
        color="red",
        alpha=0.2,
    )
    ax.text(
        pd.to_datetime("2020-04"), fill_thresholds_max - 0.2, "Pandemi", style="italic"
    )
    ax.text(
        pd.to_datetime("2019"),
        fill_thresholds_max - 0.2,
        "Sebelum Pandemi",
        style="italic",
    )
    plt.ylim(fill_thresholds_min, fill_thresholds_max)
    for i, row in pers_anak_kerja_tmp.iterrows():
        ax.text(
            row["tahun"], row["persentase"] + 0.05, row["persentase"], style="italic"
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


with labor_area:
    pers_anak_kerja = pd.read_csv("data/child_labor_cleaned/pers_anak_kerja.csv")
    pers_anak_kerja["tahun"] = pd.to_datetime(pers_anak_kerja["tahun"])
    area = st.selectbox(
        "Pilih Area",
        pers_anak_kerja.provinsi.unique(),
        index=len(pers_anak_kerja.provinsi.unique()) - 1,
    )

    fig, ax = plt.subplots(figsize=(10, 5))
    plot_labor_area(area, ax)
    st.pyplot(fig)

    labor_area_1, labor_area_2 = st.columns(2)
    with labor_area_1:
        fig, ax = plt.subplots(figsize=(10, 5))
        plot_labor_area("SULAWESI TENGGARA", ax)
        plt.title("SULAWESI TENGGARA", fontsize=20)
        st.pyplot(fig)
        fig, ax = plt.subplots(figsize=(10, 5))
        plot_labor_area("SULAWESI BARAT", ax)
        plt.title("SULAWESI BARAT", fontsize=20)
        st.pyplot(fig)
    with labor_area_2:
        fig, ax = plt.subplots(figsize=(10, 5))
        plot_labor_area("KALIMANTAN UTARA", ax)
        plt.title("KALIMANTAN UTARA", fontsize=20)
        st.pyplot(fig)
        fig, ax = plt.subplots(figsize=(10, 5))
        plot_labor_area("SULAWESI UTARA", ax)
        plt.title("SULAWESI UTARA", fontsize=20)
        st.pyplot(fig)

with labor_gender:
    pers_anak_kerja_gender = pd.read_csv(
        "data/child_labor_cleaned/pers_anak_kerja_gender.csv"
    )
    pers_anak_kerja_gender["tahun"] = pd.to_datetime(
        pers_anak_kerja_gender["tahun"].astype(str)
    )
    pers_anak_kerja_laki = pers_anak_kerja_gender[
        pers_anak_kerja_gender["gender"] == "Laki-laki"
    ]
    pers_anak_kerja_perempuan = pers_anak_kerja_gender[
        pers_anak_kerja_gender["gender"] == "Perempuan"
    ]
    fig, ax = plt.subplots(figsize=(10, 5))
    sns.lineplot(
        x="tahun",
        y="persentase",
        data=pers_anak_kerja_laki,
        marker="o",
        color="b",
        ax=ax,
    )
    sns.lineplot(
        x="tahun",
        y="persentase",
        data=pers_anak_kerja_perempuan,
        marker="o",
        color="r",
        ax=ax,
    )
    ax.xaxis.set_major_locator(mdates.YearLocator())
    ax.xaxis.set_ticklabels(
        [""] + sorted(pers_anak_kerja_laki.tahun.dt.strftime("%Y-%b"))
    )
    # create a seperator before and after 2020
    plt.axvline(x=pd.to_datetime("2020-03-02"), color="red", linestyle="--")
    fill_thresholds_min, fill_thresholds_max = (
        np.min(ax.get_yticks()) - 0.5,
        np.max(ax.get_yticks()) + 0.2,
    )
    ax.fill_between(
        ["2018-12-31", "2020-03-02"],
        fill_thresholds_min,
        fill_thresholds_max,
        color="green",
        alpha=0.2,
    )
    ax.fill_between(
        ["2020-03-02", "2021-12-31"],
        fill_thresholds_min,
        fill_thresholds_max,
        color="red",
        alpha=0.2,
    )
    ax.text(
        pd.to_datetime("2020-04"), fill_thresholds_max - 0.2, "Pandemi", style="italic"
    )
    ax.text(
        pd.to_datetime("2019"),
        fill_thresholds_max - 0.2,
        "Sebelum Pandemi",
        style="italic",
    )
    plt.ylim(fill_thresholds_min, fill_thresholds_max)
    plt.legend(["Laki-laki", "Perempuan"])
    for i, row in pers_anak_kerja_laki.iterrows():
        ax.text(
            row["tahun"],
            row["persentase"] + 0.05,
            row["persentase"],
            style="italic",
            color="b",
        )
    for i, row in pers_anak_kerja_perempuan.iterrows():
        ax.text(
            row["tahun"],
            row["persentase"] + 0.05,
            row["persentase"],
            style="italic",
            color="r",
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
        Dalam skala nasional, pada tahun **2021**, memang jumlah tersebut sedikit turun dari tahun sebelumnya, dari **1,17 juta** menjadi sebanyak **940 ribu** pekerja anak, masih sedikit lebih tinggi dari tahun-tahun sebelum pandemi.
        Tetapi jika kita lihat pada beberapa daerah di provinsi-provinsi ini, persentase pekerja anak pada 2021 masih jauh lebih tinggi dibandingkan dengan sebelum pandemi. Bahkan jika kita lihat data di **Kalimantan Utara** dan **Sulawesi Barat**, angkanya masih **naik** terus hingga **2021**.
    """
)

fig, ax = plt.subplots(figsize=(10, 3))
pers_anak_kerja_rank = pd.read_csv("data/child_labor_cleaned/pers_anak_kerja_rank.csv")
sns.barplot(x="provinsi", y="persentase", data=pers_anak_kerja_rank, palette="Blues_d")
plt.xticks(rotation=90)
plt.title("Peringkat Daerah Anak Usia 10-17 Tahun Yang Bekerja 2021")
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

st.write(
    """
            Berdasarkan data peringkat diatas, daerah **Sulawesi Tenggara** memiliki persentase pekerja anak tertinggi di Indonesia.
            4 daerah dari 5 daerah yang memiliki persentase pekerja anak tertinggi merupakan daerah dari provinsi **Sulawesi**.
            Hal ini menunjukkan **Sulawesi** memerlukan perhatian khusus dari pemerintah untuk menurunkan angka pekerja anak.
         """
)

col1, col2 = st.columns([3, 2])
fig, ax = plt.subplots(figsize=(7, 4))
angka_pekerja_anak_2020 = pd.read_csv(
    "data/child_labor_cleaned/angka_pekerja_anak_2020.csv"
)
sns.barplot(data=angka_pekerja_anak_2020, x="kelompok", y="persentase", hue="tahun", palette="Reds_d", ax=ax)
plt.ylabel("%")
for i in ax.containers:
    ax.bar_label(
        i,
    )
plt.legend(loc="upper center", bbox_to_anchor=(0.5, 1.1), ncol=3)
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
    "<h5>Persentase Pekerja Anak Usia 10-17 Tahun Yang Bekerja Berdasarkan Kelompok Umur</h5>",
    unsafe_allow_html=True,
)
col2.write(
    """
        Kenaikan tertinggi terjadi pada usia **10-12 tahun (⬆️ 97% dari 2019)**.
        Angka pekerja anak pada usia **13-14 tahun** juga mengalami kenaikan yang cukup tinggi **(⬆️ 61% dari 2019)**.
        Sedangkan angka pekerja anak pada usia **15-17 tahun** mengalami penurunan sedikit **(🔻7.5% dari 2019)**.
    """
)

st.markdown("<h3>Sisi Gelap Pekerja Anak...</h3>", unsafe_allow_html=True)
st.write(
    """
        Pekerja anak berisiko **putus sekolah** dan masuk dalam situasi-situasi yang membahayakan diri sehingga mengancam mereka bertumbuh secara optimal,
        seperti terlibat dalam **kekerasan**.
    """
)

status_sekolah, kekerasan_anak = st.tabs(["Status Sekolah", "Kekerasan Anak"])
with status_sekolah:
    fig, ax = plt.subplots(figsize=(10, 5))
    pekerja_anak_sekolah = pd.read_csv(
        "data/child_labor_cleaned/pekerja_anak_sekolah.csv"
    )
    sns.barplot(data=pekerja_anak_sekolah, x="status", y="persentase", hue="tahun", palette="Greens_d")
    plt.xticks(rotation=0)
    plt.title("Status Akademis Pekerja Anak")
    plt.ylabel("%")
    for i in ax.containers:
        ax.bar_label(
            i,
        )
    plt.legend(loc="upper center", bbox_to_anchor=(0.5, 1), ncol=3)
    plt.annotate(
        "Sumber: Badan Pusat Statistik (BPS)",
        (0, 0),
        (0, -70),
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
        "Sumber: Komisi Perlindungan Anak Indonesia (KPAI)",
        (0, 0),
        (0, -33),
        fontsize=10,
        xycoords="axes fraction",
        textcoords="offset points",
        va="top",
    )
    st.pyplot(fig)
    kekerasan_desc_col, kekerasan_corr_col = st.columns([4, 1])
    pers_anak_kerja_indo = pers_anak_kerja[
        pers_anak_kerja["provinsi"] == "INDONESIA"
    ].sort_values(by="tahun")
    pers_anak_kerja_indo["tahun"] = pers_anak_kerja_indo.tahun.dt.year
    pers_anak_kerja_indo["tahun"] = pd.to_datetime(
        pers_anak_kerja_indo["tahun"].astype(str)
    )
    pers_anak_kerja_indo.set_index("tahun", inplace=True)
    kekerasan_corr = pers_anak_kerja_indo["persentase"].corr(
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

st.markdown("<h3>Solusi/Saran</h3>", unsafe_allow_html=True)
"""
- Provinsi Sulawesi merupakan provinsi dengan persentase pekerja anak tertinggi. Oleh karena itu, Sulawesi memerlukan perhatian khusus dari Pemerintah.
- Perhatian khusus tersebut bisa dalam bentuk:
	- Beasiswa kepada keluarga-keluarga kurang mampu.
	- Sosialisasi
		- Sekolah itu baik untuk jangka panjang.
		- Mampu memperbaiki nasib keturunan.
"""