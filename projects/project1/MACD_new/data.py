import pandas as pd


def extract_data_texas():
    data = pd.read_csv("texas_roadhouse.csv")
    rows = data.shape[0]
    data = pd.read_csv("texas_roadhouse.csv", skiprows=rows-1301)
    data.columns = ["Date", "Open", "Highest", "Lowest", "Close", "Volume"]
    return data

def extract_data_crocs():
    data = pd.read_csv("crocs.csv")
    rows = data.shape[0]
    data = pd.read_csv("crocs.csv", skiprows=rows-1301)
    data.columns = ["Date", "Open", "Highest", "Lowest", "Close", "Volume"]
    return data

