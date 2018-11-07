import requests, bs4
import numpy as np
import pandas as pd
import datetime

def getSchedule():

	res = requests.get('http://www.vta.org/routes/rt901') # download the webpage html
	res.raise_for_status() # Line to ensure that the program haults in the event of a bad download
	vtaSoup = bs4.BeautifulSoup(res.text, features = "lxml") # create the beautiful soup object

	# find all the html text that has a table class
	tables = []
	for i in range(2, 8):
		tables.append(vtaSoup.findAll('div', {"class" : "tab" + str(i)}))

	# extract only relevant info: in this case I want the scheduled arrival times of the light rail
	times = []
	for i in range(len(tables)): # loop through each of the tables on the VTA website
		tab = []
		for j in range(len(tables[i][0].findAll('td'))): # loop through each element in each table 
			tab.append(tables[i][0].findAll('td')[j].text) # save each text element in the table to a list
		times.append(tab)

	# Need to concatenate an "M" onto each non empty time value for formatting purposes
	for i in range(len(times)):
		times[i] = np.array([xi + "M" if xi != '--' else None for xi in times[i]])

	# Now we convert the text into datetime objects and replace '--' values with None
	for i in range(len(times)):
		times[i] = [pd.to_datetime(xi, format = '%I:%M%p') if xi != None else None for xi in times[i]]

	# Create pandas dataframe objects for each table the tables for the 901 train are 69 x 14
	dfs = []
	for i in range(len(times)):
		df = pd.DataFrame(np.array(times[i]).reshape(int(len(times[i])/14), 14))
		dfs.append(df)
	
	return(dfs)

#weekday_northbound = getSchedule()[0]
#print("The first train leaves at: ", weekday_northbound[0][0].hour,':', weekday_northbound[0][0].minute)
