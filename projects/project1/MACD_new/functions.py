def macd_calc(dataframe):
    macd_table = []
    ema_12 = ema(dataframe['Close'], 12)
    ema_26 = ema(dataframe['Close'], 26)
    for i in range(len(ema_12)):
        macd_table.append(ema_12[i]-ema_26[i])

    return macd_table


def ema(dataframe, N):
    ema_table = []
    alpha = 2/(N+1)
    for i in range(len(dataframe)):
        numerator = 0
        denominator = 0
        for j in range(N+1):
            numerator += dataframe[i-j]*((1-alpha)**j)
            denominator += (1-alpha)**j
            if i-j == 0:
                break
        ema_table.append(numerator/denominator)

    return ema_table


def signal_calc(dataframe):
    signal_table = ema(dataframe, 9)
    return signal_table


def transaction_dates(macd, signal, dates, buy_dates, sell_dates):
    sold = False
    for i in range(1, len(macd)):
        if macd[i] > signal[i] and macd[i-1] < signal[i-1] and sold:
            buy_dates.append(dates[i])
        elif macd[i] < signal[i] and macd[i - 1] > signal[i - 1]:
            sell_dates.append(dates[i])
            sold = True


def perform_simulation(dataframe, buy_dates, sell_dates):
    cash = 0
    stocks = 1000
    biggest_loss = 0
    loss_start_date = None
    loss_end_date = None
    earn_start_date = None
    earn_end_date = None
    biggest_earn = 0
    prev_val = None
    prev_date = None
    capital_table = []
    initial_value = stocks*dataframe['Close'].values[0]

    for date in dataframe['Date']:
        capital_table.append(cash + stocks*dataframe.loc[dataframe['Date'] == date, 'Close'].values[0])
        if date in sell_dates:
            cash += stocks*dataframe.loc[dataframe['Date'] == date, 'Close'].values[0]
            stocks = 0
            if prev_val is not None:
                if capital_table[len(capital_table)-1] - prev_val < biggest_loss:
                    biggest_loss = capital_table[len(capital_table)-1] - prev_val
                    loss_end_date = date
                    loss_start_date = prev_date
                elif capital_table[len(capital_table)-1] - prev_val > biggest_earn:
                    biggest_earn = capital_table[len(capital_table)-1] - prev_val
                    earn_end_date = date
                    earn_start_date = prev_date
            prev_val = capital_table[len(capital_table)-1]
            prev_date = date

        elif date in buy_dates:
            stocks = cash//dataframe.loc[dataframe['Date'] == date, 'Close'].values[0]
            cash -= stocks*dataframe.loc[dataframe['Date'] == date, 'Close'].values[0]
            if prev_val is not None:
                if capital_table[len(capital_table)-1] - prev_val < biggest_loss:
                    biggest_loss = capital_table[len(capital_table)-1] - prev_val
                    loss_end_date = date
                    loss_start_date = prev_date
            prev_val = capital_table[len(capital_table) - 1]
            prev_date = date

    final_value = cash + stocks*dataframe['Close'].tail(1).values[0]

    print("The biggest loss was made between days: " + loss_start_date + " and " + loss_end_date +
          " and was equal to: " + str(round(biggest_loss, 2)) + "$")

    print("The biggest profit was made between days: " + earn_start_date + " and " + earn_end_date +
          " and was equal to: " + str(round(biggest_earn, 2)) + "$\n")

    print("Over the span of " + str(len(dataframe['Date'])) + " days, capital of $" +
          str(round(initial_value, 2)) + " has changed into $" +
          str(round(final_value, 2)) + " which is " +
          str(round(100 * final_value / initial_value, 2)) + "% of initial value\n\n")
    return capital_table
