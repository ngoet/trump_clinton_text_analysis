###############
#Niels Goet
#31 Oct. 2016
###############

###############
#libraries
###############
import pandas as pd
import os
import numpy

import csv
import re
import sentlex.sentanalysis

###############
#define function to strip non-utf8 characters
###############
def remove_non_ascii_2(text):

    return ''.join([i if ord(i) < 128 else ' ' for i in text])



###############
#set up file that we write out to
###############
c = csv.writer(open('texts2.csv', mode='a',encoding="utf8"))
c.writerow(['speaker','date','location','speech','source'])

###############
#read in data
###############
df=pd.read_csv('speeches.csv', sep=',', encoding = "ISO-8859-1")

df_data = pd.DataFrame(df, columns=['speaker','speech','date','location','source'])

###############
#set up file that we write out to
###############
for index, row in df_data.iterrows():
	
	speech = remove_non_ascii_2(row['speech']).replace('\n',' ')



	entry = [row['speaker'],row['date'],row['location'],speech,row['source']]

	c.writerow(entry)
	
	
	
	
		
