"""Determine the average discharge rate of each station in a data file

Input file format:

2013-03-22 A 127
2013-03-22 B 195
2013-03-21 A 222
2013-03-20 C 24

"""

import fileinput

def get_raw_data():
    """Load data from stdin"""
    data = []
    for line in fileinput.input():
        data.append(line.strip().split())
    return data

def get_avg_discharge_rates(data):
    """Get the average discharge rate for each station"""
    discharge_rates = dict()
    for record in data:
        station = record[1]
        discharge = float(record[2])
        discharge_rates[station] = discharge_rates.get(station, []) + [discharge]
    avg_discharge_rates = dict()
    for station in discharge_rates:
        avg_discharge_rates[station] = sum(discharge_rates[station]) / len(discharge_rates[station])
    return avg_discharge_rates

def main():
    data = get_raw_data()
    avg_discharge_rates = get_avg_discharge_rates(data)
    for station in avg_discharge_rates:
        print(station + ' ' +  str(avg_discharge_rates[station]))

if __name__ == '__main__':
    main()