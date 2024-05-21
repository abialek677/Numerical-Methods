from data import *
from plot_functions import *
from functions import *


# Texas roadhouse
texas_roadhouse_data = extract_data_texas()
plot_stock(texas_roadhouse_data, "Texas Roadhouse")

texas_macd = macd_calc(texas_roadhouse_data)
texas_signal = signal_calc(texas_macd)
buy_dates = []
sell_dates = []

transaction_dates(texas_macd, texas_signal, texas_roadhouse_data['Date'], buy_dates, sell_dates)

plot_macd_signal(texas_macd, texas_signal, texas_roadhouse_data['Date'], buy_dates, sell_dates)

capital_table = perform_simulation(texas_roadhouse_data, buy_dates, sell_dates)

plot_capital(texas_roadhouse_data['Date'], capital_table, buy_dates, sell_dates)

# Crocs
crocs_data = extract_data_crocs()
plot_stock(crocs_data, "Crocs")

crocs_macd = macd_calc(crocs_data)
crocs_signal = signal_calc(crocs_macd)
buy_dates = []
sell_dates = []

transaction_dates(crocs_macd, crocs_signal, crocs_data['Date'], buy_dates, sell_dates)

plot_macd_signal(crocs_macd, crocs_signal, crocs_data['Date'], buy_dates, sell_dates)

capital_table = perform_simulation(crocs_data, buy_dates, sell_dates)

plot_capital(crocs_data['Date'], capital_table, buy_dates, sell_dates)
