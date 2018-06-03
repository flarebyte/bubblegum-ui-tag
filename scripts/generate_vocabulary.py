#!/usr/bin/python

import sys
import csv
from string import Template
from generator_helper import camelCase, camelCaseUpper, quoteArray, readCsv
from vocabulary_template import * 

ui_keys_csv = "ui-keys.csv"
ui_range_keys_csv = "ui-range-keys.csv"
ui_constituent_keys_csv = "ui-constituent-keys.csv"


def formatTemplate(template, row):
        nameField, descriptionField, signatureField, extra, examplesField = row
        name = nameField.strip()
        description = descriptionField.strip()
        signature = signatureField.strip()
        namecamel = camelCase(name)
        nameCamel = camelCaseUpper(name)
        rangeRestriction=checkRangeRestriction(extra)
        examples = generateExamples(examplesField, signature)
        entity = "SettingsEntity"
        if isState(row):
            entity = "StateEntity" 
        return Template(template).substitute(
            name=name,
            description=description,
            signature=signature,
            namecamel=namecamel,
            nameCamel=nameCamel,
            rangeRestriction=rangeRestriction,
            examples = examples,
            entity = entity
            )

def formatRangeTemplate(template, row):
        kindField, unitField, descriptionField = row
        kind = kindField.strip()
        unit = unitField.strip()
        entity = "SettingsEntity"
        return Template(template).substitute(
            methodName="get{}{}Range".format(camelCaseUpper(kind),camelCaseUpper(unit)),
            minKey="ui_{}Minimum{}s".format(camelCase(kind),camelCaseUpper(unit)),
            maxKey="ui_{}Maximum{}s".format(camelCase(kind),camelCaseUpper(unit)),
            description=descriptionField.strip(),
            entity = entity
            )
    

def createVocabulary():
    content = readCsv(ui_keys_csv)
    file = open("../src/Bubblegum/Tag/Vocabulary.elm", "w")
    file.write(headerVocabulary)
    for row in content:
        if len(row) > 2 :
            file.write(formatTemplate(templateVocabulary, row))
    content = readCsv(ui_constituent_keys_csv)
    for row in content:
        if len(row) > 2 :
            file.write(formatTemplate(templateVocabulary, row))
    file.close()    

def createKeyDescription():
    content = readCsv(ui_keys_csv)
    file = open("../demo/KeyDescription.elm", "w")
    file.write(headerKeyDescription)
    for row in content:
        if len(row) > 2 :
            file.write(formatTemplate(templateKeyDescription, row))
    content = readCsv(ui_constituent_keys_csv)
    for row in content:
        if len(row) > 2 :
            file.write(formatTemplate(templateKeyDescription, row))
    file.close()    


def createVocabularyHelper():
    content = readCsv(ui_keys_csv)
    rangeContent = readCsv(ui_range_keys_csv)
    constituentContent = readCsv(ui_constituent_keys_csv)
    file = open("../src/Bubblegum/Tag/VocabularyHelper.elm", "w")
    file.write(headerVocabularyHelper)
    for row in content:
        if len(row) > 2 :
            if isBool(row):
                file.write(formatTemplate(templateVocabularyHelperBool, row))
            if isString(row):
                file.write(formatTemplate(templateVocabularyHelperString, row))
            if isListString(row):
                if isCurieList(row):
                    file.write(formatTemplate(templateVocabularyHelperListCurie, row))
                else:
                    file.write(formatTemplate(templateVocabularyHelperListString, row))
    for row in rangeContent:
        if len(row) > 2 :
            file.write(formatRangeTemplate(templateVocabularyHelperIntRange, row))
    for row in constituentContent:
        if len(row) > 2 :
            if isBool(row):
                file.write(formatTemplate(templateVocabularyHelperBoolForId, row))
            if isString(row):
                file.write(formatTemplate(templateVocabularyHelperStringForId, row))
            if isListString(row):
                file.write(formatTemplate(templateVocabularyHelperListStringForId, row))
                
    file.close()    

def createWidgetDocData():
    content = readCsv(ui_keys_csv)
    file = open("../demo/WidgetDocData.elm", "w")
    file.write(headerWidgetDocData)
    withComa = False
    for row in content:        
        if len(row) > 2:
            if isUserSettings(row):
                content = prefixWithComa("createKey", withComa, formatTemplate(templateWidgetDocDataString, row))
                file.write(content)
                withComa = True
    file.write("\n  ]\n  , settings = [\n")     
    content = readCsv(ui_keys_csv)   
    withComa = False
    for row in content:
        if len(row) > 2:
            if isSettings(row):
                content = prefixWithComa("createKey", withComa, formatTemplate(templateWidgetDocDataString, row))
                file.write(content)
                withComa = True
    file.write("\n  ]\n  , stateAttributes = [\n")     
    content = readCsv(ui_keys_csv)   
    withComa = False
    for row in content:
        if len(row) > 2:
            if isState(row):
                content = prefixWithComa("createKey", withComa, formatTemplate(templateWidgetDocDataString, row))
                file.write(content)
                withComa = True

    file.write("        ]\n    }")        
    file.close()    



def createWidgetCreateTests():
    content = readCsv(ui_keys_csv)
    rangeContent = readCsv(ui_range_keys_csv)
    file = open("../tests/WidgetCreateTests.elm", "w")
    file.write(headerWidgetCreateTests)
    withComa = False
    for row in content:
        if len(row) > 2 :
            if isSettings(row):
                content = prefixWithComa("fuzz ", withComa, formatTemplate(templateWidgetCreateTestsSettingsCorrect, row))
                file.write(content)
                if isAttribute(row):
                    file.write(formatTemplate(templateWidgetCreateTestsSettingsWrongAttr, row))
                else:
                    file.write(formatTemplate(templateWidgetCreateTestsSettingsWrong, row))
                withComa = True
            if isUserSettings(row):
                content = prefixWithComa("fuzz ", withComa, formatTemplate(templateWidgetCreateTestsUserSettingsCorrect, row))
                file.write(content)
                if isAttribute(row):
                    file.write(formatTemplate(templateWidgetCreateTestsUserSettingsWrongAttr, row))
                else:
                    file.write(formatTemplate(templateWidgetCreateTestsUserSettingsWrong, row))
                withComa = True
            if isState(row):
                content = prefixWithComa("fuzz ", withComa, formatTemplate(templateWidgetCreateTestsStateCorrect, row))
                file.write(content)
                if isAttribute(row):
                    file.write(formatTemplate(templateWidgetCreateTestsStateWrongAttr, row))
                else:
                    file.write(formatTemplate(templateWidgetCreateTestsStateWrong, row))
                withComa = True
    file.write(footerWidgetCreateTests)            
    file.close()    

## helpers

def isBool(row):
    nameField, descriptionField, signatureField, extraField, examplesField = row
    if  signatureField.strip() == "Bool":
        return True
    else:
        return False

def isString(row):
    nameField, descriptionField, signatureField, extraField, examplesField = row
    if  signatureField.strip() == "String":
        return True
    else:
        return False

def isListString(row):
    nameField, descriptionField, signatureField, extraField, examplesField = row
    if  signatureField.strip() == "List String":
        return True
    else:
        return False       

def isUserSettings(row):
    nameField, descriptionField, signatureField, extraField, examplesField = row
    if "user" in nameField or "user" in extraField:
        return True
    else:
        return False

def isState(row):
    nameField, descriptionField, signatureField, extraField, examplesField = row
    if  "state" in extraField:
        return True
    else:
        return False

def isCurieList(row):
    nameField, descriptionField, signatureField, extraField, examplesField = row
    if  "compactUris" in extraField:
        return True
    else:
        return False

def isAttribute(row):
    nameField, descriptionField, signatureField, extraField, examplesField = row
    if  "attribute" in extraField:
        return True
    else:
        return False

def isSettings(row):
    return not (isUserSettings(row) or isState(row))        

def prefixWithComa(keyword, yes, text):
    if yes:
        return text.replace(keyword, ", "+keyword)
    else:
        return text

def checkRangeRestriction(extra):
    if "small!" in extra:
        return "|> Validation.withinStringCharsRange limitSmallRangeNotEmpty"
    elif "small" in extra:
        return "|> Validation.withinStringCharsRange  limitSmallRange"
    elif "medium!" in extra:
        return "|> Validation.withinStringCharsRange limitMediumRangeNotEmpty"
    elif "medium" in extra:
        return "|> Validation.withinStringCharsRange limitMediumRange"
    elif "very-large!" in extra:
        return "|> Validation.withinStringCharsRange limitVeryLargeRangeNotEmpty"
    elif "very-large" in extra:
        return "|> Validation.withinStringCharsRange limitVeryLargeRange"
    elif "curie!" in extra:
        return "|> Validation.matchCompactUri"
    else:
        return ""

def generateExamples(suggested, signature):
    if (signature == "Bool"):
        return quoteArray(["true", "false", "other"])
    elif (signature == "Int"):
        return quoteArray(["0", "20", "40", "80", "160", "320", "-5"])
    elif (suggested is not None):
        suggestions = suggested.strip().split(";")
        suggestions.append("other")
        return quoteArray(suggestions)
    else:
        return quoteArray(["some text"])

def main(argv):
    createVocabulary()
    createKeyDescription()
    createVocabularyHelper()
    createWidgetDocData()
    createWidgetCreateTests()
    
if __name__ == "__main__":
   main(sys.argv[1:])