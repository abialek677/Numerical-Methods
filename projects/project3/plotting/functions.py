import matplotlib.pyplot as plt


def plot_lagrange(FILE_LINES, NODE_COUNT, SOURCE_NAMES):
    for source_name in SOURCE_NAMES:
        for count in NODE_COUNT:
            with open(f"sources/{source_name}.txt", 'r') as file:
                lines = file.readlines()

            x_values_1 = []
            y_values_1 = []
            for line in lines[:FILE_LINES]:
                x, y = map(float, line.split())
                x_values_1.append(x)
                y_values_1.append(y)

            with open(f"sources/{count}_interpolation_{source_name}.txt", 'r') as file:
                lines = file.readlines()

            x_values_2 = []
            y_values_2 = []
            for line in lines:
                x, y = map(float, line.split())
                x_values_2.append(x)
                y_values_2.append(y)

            with open(f"sources/{count}_nodes_{source_name}.txt", 'r') as file:
                lines = file.readlines()

            x_values_3 = []
            y_values_3 = []
            for line in lines:
                x, y = map(float, line.split())
                x_values_3.append(x)
                y_values_3.append(y)

            # Plot the data from both files
            plt.plot(x_values_1, y_values_1, label='Original data', color='blue')
            plt.plot(x_values_2, y_values_2, label='Interpolation line', color='red')
            plt.scatter(x_values_3, y_values_3, marker='o', label='Interpolation nodes', color='green')
            plt.title(f"Lagrange method for {source_name} for {count} nodes")
            plt.xlabel('Distance [m]')
            plt.ylabel('Elevation [m]')
            plt.legend()
            plt.grid(True)
            plt.show()


def plot_splines(FILE_LINES, NODE_COUNT, SOURCE_NAMES):
    for source_name in SOURCE_NAMES:
        for count in NODE_COUNT:
            with open(f"sources/{source_name}.txt", 'r') as file:
                lines = file.readlines()

            x_values_1 = []
            y_values_1 = []
            for line in lines[:FILE_LINES]:
                x, y = map(float, line.split())
                x_values_1.append(x)
                y_values_1.append(y)

            with open(f"sources/{count}_interpolation_splines_{source_name}.txt", 'r') as file:
                lines = file.readlines()

            x_values_2 = []
            y_values_2 = []
            for line in lines:
                x, y = map(float, line.split())
                x_values_2.append(x)
                y_values_2.append(y)

            with open(f"sources/{count}_nodes_{source_name}.txt", 'r') as file:
                lines = file.readlines()

            x_values_3 = []
            y_values_3 = []
            for line in lines:
                x, y = map(float, line.split())
                x_values_3.append(x)
                y_values_3.append(y)

            # Plot the data from both files
            plt.plot(x_values_1, y_values_1, label='Original data', color='blue')
            plt.plot(x_values_2, y_values_2, label='Interpolation line', color='red')
            plt.scatter(x_values_3, y_values_3, marker='o', label='Interpolation nodes', color='green')
            plt.title(f"Cubic splines method for {source_name} for {count} nodes")
            plt.xlabel('Distance [m]')
            plt.ylabel('Elevation [m]')
            plt.legend()
            plt.grid(True)
            plt.show()


def plot_chebyshev(FILE_LINES, NODE_COUNT, SOURCE_NAMES):
    for source_name in SOURCE_NAMES:
        for count in NODE_COUNT:
            with open(f"sources/{source_name}.txt", 'r') as file:
                lines = file.readlines()

            x_values_1 = []
            y_values_1 = []
            for line in lines[:FILE_LINES]:
                x, y = map(float, line.split())
                x_values_1.append(x)
                y_values_1.append(y)

            with open(f"sources/{count}_interpolation_chebyshev_{source_name}.txt", 'r') as file:
                lines = file.readlines()

            x_values_2 = []
            y_values_2 = []
            for line in lines:
                x, y = map(float, line.split())
                x_values_2.append(x)
                y_values_2.append(y)

            with open(f"sources/{count}_nodes_cheb_{source_name}.txt", 'r') as file:
                lines = file.readlines()

            x_values_3 = []
            y_values_3 = []
            for line in lines:
                x, y = map(float, line.split())
                x_values_3.append(x)
                y_values_3.append(y)

            # Plot the data from both files
            plt.plot(x_values_1, y_values_1, label='Original data', color='blue')
            plt.plot(x_values_2, y_values_2, label='Interpolation line', color='red')
            plt.scatter(x_values_3, y_values_3, marker='o', label='Interpolation nodes', color='green')
            plt.title(f"Lagrange method with chebyshev nodes for {source_name} for {count} nodes")
            plt.xlabel('Distance [m]')
            plt.ylabel('Elevation [m]')
            plt.legend()
            plt.grid(True)
            plt.show()

def plot_original_data(FILE_LINES, SOURCE_NAMES):
    for source_name in SOURCE_NAMES:
        with open(f"sources/{source_name}.txt", 'r') as file:
            lines = file.readlines()

        x_values = []
        y_values = []
        for line in lines[:FILE_LINES]:
            x, y = map(float, line.split())
            x_values.append(x)
            y_values.append(y)

        # Plot the original data
        plt.plot(x_values, y_values, label='Original data', color='blue')
        plt.title(f"Original Data for {source_name}")
        plt.xlabel('Distance [m]')
        plt.ylabel('Elevation [m]')
        plt.legend()
        plt.grid(True)
        plt.show()
