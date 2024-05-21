import matplotlib.pyplot as plt
import pandas as pd

def plot_stock(dataframe, title):
    plt.grid(axis='y')
    plt.plot(dataframe["Date"], dataframe["Close"], linewidth=1)
    x_labels = dataframe["Date"][::100]
    plt.xticks(x_labels, rotation=50)
    plt.xlabel("Date")
    plt.ylabel("$ Value")
    plt.title(title)

    plt.show()


def plot_macd_signal(macd, signal, dates, buy_dates, sell_dates):
    buy_dots = []
    sell_dots = []
    for date in buy_dates:
        index = dates.loc[dates == date].index[0]
        buy_dots.append(signal[index])
    for date in sell_dates:
        index = dates.loc[dates == date].index[0]
        sell_dots.append(signal[index])
    plt.plot(dates, macd, linewidth=1)
    plt.plot(dates, signal, linewidth=1)
    plt.scatter(buy_dates, buy_dots, marker='o', color='green', s=13)
    plt.scatter(sell_dates, sell_dots, marker='o', color='red', s=13)
    plt.legend(['MACD', 'Signal', 'Buy', 'Sell'])
    plt.title('MACD and Signal graph')
    x_labels = dates[::100]
    plt.xticks(x_labels, rotation=50)
    plt.grid(axis='y')
    plt.show()


def plot_capital(dates, capital_table, buy_dates, sell_dates):
    buy_dots = []
    sell_dots = []
    for date in buy_dates:
        index = dates.loc[dates == date].index[0]
        buy_dots.append(capital_table[index])
    for date in sell_dates:
        index = dates.loc[dates == date].index[0]
        sell_dots.append(capital_table[index])


    plt.plot(dates, capital_table, color='green', linewidth=1)
    plt.scatter(buy_dates, buy_dots, marker='o', color='blue', s=17)
    plt.scatter(sell_dates, sell_dots, marker='o', color='red', s=17)
    x_labels = dates[::100]
    plt.grid(axis='y')
    plt.xticks(x_labels, rotation=50)
    plt.title('Buy and sell simulation graph')
    plt.ylabel('Capital in $')
    plt.legend(['Capital', 'Buy', 'Sell'])
    plt.show()

