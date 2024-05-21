import pandas as pd


def extractDataMy():
    data = pd.read_csv("txrh_us_d.csv")
    rows = data.shape[0]
    data = pd.read_csv("txrh_us_d.csv", skiprows=rows-1501)
    data.columns = ["Data", "Otwarcie", "Najwyzszy","Najnizszy","Zamkniecie","Wolumen"]
    return data


def extractDataSP500():
    data = pd.read_csv("^spx_d.csv")
    rows = data.shape[0]
    data = pd.read_csv("^spx_d.csv", skiprows=rows-1501)
    data.columns = ["Data", "Otwarcie", "Najwyzszy","Najnizszy","Zamkniecie","Wolumen"]
    return data

def extractDataWIG():
    data = pd.read_csv("wig20.csv")
    rows = data.shape[0]
    data = pd.read_csv("wig20.csv", skiprows=rows-1501)
    data.columns = ["Data", "Otwarcie", "Najwyzszy","Najnizszy","Zamkniecie","Wolumen"]
    return data

def extractDataBoeing():
    data = pd.read_csv("ba_us_d.csv")
    rows = data.shape[0]
    data = pd.read_csv("ba_us_d.csv", skiprows=rows-1501)
    data.columns = ["Data", "Otwarcie", "Najwyzszy","Najnizszy","Zamkniecie","Wolumen"]
    return data


def extractDataTencent():
    data = pd.read_csv("tencent.csv")
    rows = data.shape[0]
    data = pd.read_csv("tencent.csv", skiprows=rows-1501)
    data.columns = ["Data", "Otwarcie", "Najwyzszy","Najnizszy","Zamkniecie","Wolumen"]
    return data


def extractDataNestle():
    data = pd.read_csv("nestle.csv")
    rows = data.shape[0]
    data = pd.read_csv("nestle.csv", skiprows=rows-1501)
    data.columns = ["Data", "Otwarcie", "Najwyzszy","Najnizszy","Zamkniecie","Wolumen"]
    return data