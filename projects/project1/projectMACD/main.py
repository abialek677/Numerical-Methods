import data
from plotFunctions import *


#Tencent
tencentData = data.extractDataMy()
plotStockValues(tencentData, "Tencent")

openValues = tencentData["Otwarcie"]
macdData = MACD(openValues)
signalData = Signal(macdData)
plotMACD(macdData, signalData, tencentData["Data"])

buyDates = []
sellDates = []
getTransactionDates(macdData, signalData, tencentData["Data"], buyDates, sellDates)
capitalTable = performSimulation(tencentData, buyDates, sellDates)

plotSimulation(tencentData["Data"], capitalTable)










