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

import nltk

import sentlex

import sentlex.sentanalysis

###############
#set up SWN
###############
SWN = sentlex.SWN3Lexicon()

classifier = sentlex.sentanalysis.BasicDocSentiScore()

###############
#set up file that we write out to
###############
c = csv.writer(open('sent_analysis.csv', mode='a'))
c.writerow(['speaker','date','location','score'])

###############
#read in data
###############
df=pd.read_csv('speeches.csv', sep=',', encoding = "ISO-8859-1")

df_data = pd.DataFrame(df, columns=['speaker','speech','date','location'])

###############
#set up file that we write out to
###############
for index, row in df_data.iterrows():
	
	speech = row['speech']
	
	positive_score = classifier.classify_document(speech, tagged=False, L=SWN, a=True, v=True, n=False, r=False, negation=False, verbose=False)[0]
	neg_score = classifier.classify_document(speech, tagged=False, L=SWN, a=True, v=True, n=False, r=False, negation=False, verbose=False)[1]
	
	pos_vs_neg = (positive_score)/(neg_score)

	print(row['speaker'],pos_vs_neg)

	entry = [row['speaker'],row['date'],row['location'],pos_vs_neg]

	c.writerow(entry)
	
	
	
	
		
