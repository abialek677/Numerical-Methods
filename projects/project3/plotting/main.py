from functions import *

FILE_LINES = 500
NODE_COUNT = [4, 8, 12, 20]
SOURCE_NAMES = ['rozne_wniesienia', 'tczew_starogard']

plot_lagrange(FILE_LINES, NODE_COUNT, SOURCE_NAMES)
plot_splines(FILE_LINES, NODE_COUNT, SOURCE_NAMES)
plot_chebyshev(FILE_LINES, NODE_COUNT, SOURCE_NAMES)
#plot_original_data(FILE_LINES, SOURCE_NAMES)

