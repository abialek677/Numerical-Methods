def sign(val):
    if val > 0:
        return 1
    elif val < 0:
        return -1

def performSimulation(csv, buyDates, sellDates):
    cash = 0
    assets = 1000
    capital = []
    buyIndex  = 0
    sellIndex = 0
    for date in csv['Data']:
        capital.append(cash + (assets * csv.loc[csv['Data'] == date, 'Otwarcie'].values[0]))
        if(buyIndex == sellIndex and sellIndex != len(sellDates)):
            if sellDates[sellIndex] == date:
                cash += assets * csv.loc[csv['Data'] == date, 'Otwarcie'].values[0]
                assets = 0
                sellIndex += 1
        elif(buyIndex != len(buyDates)):
            if buyDates[buyIndex] == date:
                assets = cash // csv.loc[csv['Data'] == date, 'Otwarcie'].values[0]
                cash -= assets*csv.loc[csv['Data'] == date, 'Otwarcie'].values[0]
                buyIndex += 1

    return capital



def getTransactionDates(MACD, Signal, dates, buyDates, sellDates):
    gotSell = False
    for i in range(1, len(MACD)):
        if sign(MACD[i] - Signal[i]) != sign(MACD[i - 1] - Signal[i - 1]):
            if sign(MACD[i] - Signal[i]) == 1 and gotSell:
                buyDates.append(dates[i])
            elif sign(MACD[i] - Signal[i]) == -1:
                sellDates.append(dates[i])
                gotSell = True


def Signal(table):
    tableSignal = []
    for i in reversed(range(len(table))):
        tableSignal.append(calcSignal(table,i))

    tableSignal.reverse()
    return tableSignal


def calcSignal(table, index):
    value = EMA(table,index,9)
    return value



def MACD(table):
    tableMACD = []
    for i in reversed(range(len(table))):
        tableMACD.append(calcMACD_index(table, i))
    tableMACD.reverse()
    return tableMACD


def calcMACD_index(table, index):
    MACD = EMA(table, index, 12) - EMA(table, index, 26)
    return MACD


def EMA(table, index, N):
    count = N + 1
    alpha = 2 / count
    geometricAvg = 0.0
    help = 0.0
    i = 0
    while index - i >= 0 and i < count:
        geometricAvg += (1-alpha) ** i
        help += table[index-i]*(1-alpha)**i
        i += 1
    return help / geometricAvg



