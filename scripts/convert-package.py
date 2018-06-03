#!/usr/bin/python

import sys

import json
filename = "../elm-package.json"

def readJson(): 
    with open(filename) as data_file:    
        return json.load(data_file)

def camelCase(st):
    output = ''.join(x for x in st.title() if x.isalpha())
    return output[0].lower() + output[1:]

def convertString(name, content):
    return '{} = "{}"'.format(camelCase(name), content[name])

def convertStringArray(name, content):
    return '{} = {}'.format(camelCase(name), [x.encode('utf-8') for x in content[name]]).replace("'", '"')

def main(argv):
    content = readJson()
    file = open("../demo/WidgetPackageJson.elm", "w") 
    file.write("module WidgetPackageJson exposing (meta)\n\n")
    file.write("import PackageJson\n\n")
    file.write("meta : PackageJson.Model\n")
    file.write("meta=  {\n  ")
    file.write("\n  , ".join([
        convertString("version", content) ,
        convertString("summary", content) ,
        convertString("repository", content) ,
        convertString("license", content) ,
        convertStringArray("exposed-modules", content)]))
    file.write("\n  }\n")
    file.close()

if __name__ == "__main__":
   main(sys.argv[1:])