#!/usr/bin/python

import sys
import csv
from string import Template


def camelCase(st):
    output = ''.join(x for x in st.strip().title() if x.isalpha())
    return output[0].lower() + output[1:]

def camelCaseUpper(st):
    camel = camelCase(st.strip())
    return camel[0].upper() + camel[1:]

def quoteArray(values):
    return ",".join(['"'+x+'"' for x in values])

def readCsv(filename): 
    results = []
    with open(filename) as data_file:    
        csvreader = csv.reader(data_file)
        for row in csvreader:
            results.append(row)
    return results

def readFileAsString(filename):
    with open(filename, 'r') as myfile:
        return myfile.read().replace('\n', '')