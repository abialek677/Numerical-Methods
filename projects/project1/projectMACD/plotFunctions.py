import matplotlib.pyplot as plt
from myFunctions import *
def plotStockValues(myData, title):
    axes = plt.axes()
    axes.grid()
    plt.plot(myData["Data"], myData["Otwarcie"])
    labelsX = myData["Data"][::100]
    plt.xticks(labelsX, rotation=50)
    plt.xlabel("Date")
    plt.ylabel("$ Value")
    plt.title(title)

    plt.show()


def plotSimulation(dates, table):
    plt.plot(dates, table, linewidth=1, color='green')
    labelsX = dates[::100]
    plt.xticks(labelsX, rotation=50)
    plt.show()


def plotMACD(MACD, Signal, dates):
    intersectValues = []
    intersectDates = []
    for i in range(1, len(MACD)):
        if(sign(MACD[i] - Signal[i]) != sign(MACD[i-1] - Signal[i-1])):
            intersectValues.append(MACD[i])
            intersectDates.append(dates[i])
    plt.plot(dates, MACD, linewidth=1, color='purple')
    plt.plot(dates, Signal, linewidth=1, color='red')
    plt.scatter(intersectDates, intersectValues, marker='s', color='black', s=20)
    plt.legend(['MACD', 'Signal'])
    plt.title('MACD and Signal graph')
    newDates = dates
    labelsX = newDates[::100]
    plt.xticks(labelsX, rotation=50)

    plt.show()

